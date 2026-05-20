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
    git fetch upstream main 2>&1 | Out-Null

    $changes = git diff --name-status HEAD upstream/main 2>$null

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
