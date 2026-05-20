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

    # Cross-ref check: _osc-mapping.md senior labels must exist in INDEX.md
    if ((Test-Path "_osc-mapping.md") -and (Test-Path "INDEX.md")) {
        $modules = @('blog','shortform','proposals','quotes','contracts','briefs','clients','keyword-seo','deal-pipeline','cafe-viral','sns-publish','link-in-bio','tax-invoice','commerce-launch','weekly-mgmt','capcut-auto')
        $mappingContent = Get-Content "_osc-mapping.md" -Raw
        $mappingRefs = [regex]::Matches($mappingContent, '`([a-z][a-z0-9-]+)`') |
            ForEach-Object { $_.Groups[1].Value } |
            Sort-Object -Unique |
            Where-Object { $_ -notin $modules -and -not ($_ -match '^docs') }

        $indexContent = Get-Content "INDEX.md" -Raw
        $indexLabels = [regex]::Matches($indexContent, '(?m)^- `([A-Za-z0-9-]+)`') |
            ForEach-Object { $_.Groups[1].Value }

        # External global skills mentioned in "우리 글로벌 21 agents 와의 관계" section — not seniors
        $externalSkills = @('commit-push-pr','team-orchestrator','ux-designer','frontend-design','code-review','image-prompt','video-prompt','blueprint','session-wrap','verification-engine','vibe-cofounder','architect','code-reviewer','planner','tdd-guide','security-reviewer')

        $candidates = @($mappingRefs | Where-Object { $_ -notin $indexLabels -and $_ -notin $externalSkills })

        # Suffix match resolve: short alias (e.g. "backend-architect" -> "engineering-backend-architect")
        $resolved = @()
        $reallyStale = @()
        foreach ($c in $candidates) {
            $suffixMatch = @($indexLabels | Where-Object { $_ -match "-$([regex]::Escape($c))$" })
            if ($suffixMatch.Count -gt 0) {
                $resolved += "$c -> $($suffixMatch -join ',')"
            } else {
                $reallyStale += $c
            }
        }

        Write-Host "[CROSS-REF] _osc-mapping.md -> INDEX.md:" -ForegroundColor Cyan
        Write-Host "   _osc-mapping refs: $($mappingRefs.Count) (excluding modules)"
        Write-Host "   INDEX labels:      $($indexLabels.Count)"
        if ($resolved.Count -gt 0) {
            Write-Host "   [ALIAS] $($resolved.Count) short aliases auto-resolved to full kebab:" -ForegroundColor DarkGray
            $resolved | Select-Object -First 5 | ForEach-Object { Write-Host "     ~ $_" }
        }
        if ($reallyStale.Count -gt 0) {
            Write-Host "   [STALE] $($reallyStale.Count) refs in _osc-mapping.md not in INDEX:" -ForegroundColor Yellow
            $reallyStale | Select-Object -First 10 | ForEach-Object { Write-Host "     - $_" }
            if ($reallyStale.Count -gt 10) { Write-Host "     ... ($($reallyStale.Count - 10) more)" }
            Write-Host "   Action: update _osc-mapping.md to match INDEX, or add missing seniors to INDEX."
        } else {
            Write-Host "   [OK] All cross-refs valid (after alias/external resolution)." -ForegroundColor Green
        }
        Write-Host ""
    }

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
