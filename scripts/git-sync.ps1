# Git Sync Script
cd D:\\AIWorkspace

Write-Host "Syncing workspace..." -ForegroundColor Cyan

# Pull latest
git pull

# Check for changes
$changes = git status --porcelain
if ($changes) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm"
    git add .
    git commit -m "Auto-sync: $timestamp"
    git push
    Write-Host "? Changes pushed" -ForegroundColor Green
} else {
    Write-Host "? No changes to sync" -ForegroundColor Green
}
