# Senior Library upstream sync (monthly)
# Usage: ~/.claude/senior-library/_sync.ps1

$ErrorActionPreference = "Stop"
$RepoDir = Join-Path $env:USERPROFILE ".claude\senior-library"

if (-not (Test-Path $RepoDir)) {
    Write-Host "[ERROR] Senior library not found at $RepoDir" -ForegroundColor Red
    exit 1
}

Push-Location $RepoDir
try {
    $upstream = git remote 2>$null | Where-Object { $_ -eq "upstream" }
    if (-not $upstream) {
        Write-Host "[INFO] Adding upstream remote..." -ForegroundColor Cyan
        git remote add upstream https://github.com/msitarzewski/agency-agents.git
    }

    Write-Host "[INFO] Fetching upstream..." -ForegroundColor Cyan
    # PowerShell converts git's normal stderr (e.g. "From https://...") to errors.
    # Temporarily suppress with SilentlyContinue + redirect all streams.
    $ErrorActionPreference = "SilentlyContinue"
    git fetch upstream main *> $null
    $ErrorActionPreference = "Stop"

    $changes = git diff --name-status HEAD upstream/main 2>$null

    # Sanity check: INDEX.md vs actual file count drift detection
    $depts = @('academic','design','engineering','finance','marketing','paid-media','product','project-management','sales','specialized','strategy','support','testing')
    $actualCount = 0
    foreach ($d in $depts) {
        if (Test-Path $d) {
            $actualCount += (Get-ChildItem -Path $d -Recurse -Filter "*.md" | Measure-Object).Count
        }
    }
    $indexEntries = 0
    if (Test-Path "INDEX.md") {
        # case-insensitive — Strategy Meta has EXECUTIVE-BRIEF / QUICKSTART uppercase
        $indexEntries = (Select-String -Path "INDEX.md" -Pattern "^- ``[A-Za-z0-9-]+``" | Measure-Object).Count
    }

    Write-Host "[SANITY] Drift check:" -ForegroundColor Cyan
    Write-Host "   Actual .md files (13 depts incl. strategy subs): $actualCount"
    Write-Host "   INDEX.md entries:                                  $indexEntries"
    if ($actualCount -ne $indexEntries) {
        $diff = $actualCount - $indexEntries
        Write-Host "   [DRIFT] $diff files differ from INDEX." -ForegroundColor Yellow
        Write-Host "   Note: 16 strategy/{coordination,playbooks,runbooks} 는 INDEX 의 Strategy Resources 섹션 별도 카운트."
        Write-Host "   Expected: actual = INDEX + strategy_sub_already_counted. Run regeneration if real drift."
    } else {
        Write-Host "   [OK] No drift detected." -ForegroundColor Green
    }
    Write-Host ""

    if (-not $changes) {
        Write-Host "[OK] Senior library is up to date (no upstream changes)" -ForegroundColor Green
        exit 0
    }

    $added = @()
    $modified = @()
    $deleted = @()

    foreach ($line in $changes) {
        $parts = $line -split "`t", 2
        $status = $parts[0]
        $file = $parts[1]
        if ($file -match "^(spatial-computing|game-development)/") { continue }
        switch -Regex ($status) {
            "^A"  { $added += $file }
            "^M"  { $modified += $file }
            "^D"  { $deleted += $file }
        }
    }

    Write-Host ""
    Write-Host "[CHANGES] Upstream diff detected:" -ForegroundColor Yellow
    Write-Host "   Added:    $($added.Count) files" -ForegroundColor Green
    Write-Host "   Modified: $($modified.Count) files" -ForegroundColor Yellow
    Write-Host "   Deleted:  $($deleted.Count) files" -ForegroundColor Red
    Write-Host ""

    if ($added.Count -gt 0) {
        Write-Host "-- New seniors (add to INDEX.md) --" -ForegroundColor Green
        $added | Where-Object { $_ -match "\.md$" } | ForEach-Object { Write-Host "  + $_" }
        Write-Host ""
    }

    if ($modified.Count -gt 0) {
        Write-Host "-- Modified (review needed) --" -ForegroundColor Yellow
        $modified | Where-Object { $_ -match "\.md$" } | Select-Object -First 10 | ForEach-Object { Write-Host "  ~ $_" }
        if ($modified.Count -gt 10) { Write-Host "  ... ($($modified.Count - 10) more)" }
        Write-Host ""
    }

    if ($deleted.Count -gt 0) {
        Write-Host "-- Deleted (clean INDEX.md) --" -ForegroundColor Red
        $deleted | Where-Object { $_ -match "\.md$" } | ForEach-Object { Write-Host "  - $_" }
        Write-Host ""
    }

    Write-Host "[NEXT STEPS]" -ForegroundColor Cyan
    Write-Host "   - Auto merge all:           git merge upstream/main"
    Write-Host "   - Cherry-pick specific:     git checkout upstream/main -- {file}"
    Write-Host "   - Update INDEX.md in CC:    '/senior sync update INDEX' in Claude Code"
    Write-Host ""
}
finally {
    Pop-Location
}
