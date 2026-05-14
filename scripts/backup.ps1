# Daily Backup Script
$timestamp = Get-Date -Format "yyyyMMdd"
$backupPath = "D:\Backups\AIWorkspace_$timestamp"

Write-Host "Starting backup..." -ForegroundColor Cyan
robocopy C:\AIWorkspace $backupPath /E /XD node_modules .git logs /XF *.log /R:3 /W:5

if ($LASTEXITCODE -le 7) {
    Write-Host "✅ Backup complete: $backupPath" -ForegroundColor Green
} else {
    Write-Host "❌ Backup failed" -ForegroundColor Red
}
