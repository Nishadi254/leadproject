# Daily Backup System Setup Script
# This script sets up automated daily backups for your CRM

Write-Host "🔐 CRM Daily Backup System Setup" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# Get current directory
$projectPath = Get-Location

Write-Host "📁 Project Path: $projectPath" -ForegroundColor Yellow
Write-Host ""

# Step 1: Create backup directory
Write-Host "📦 Step 1: Creating backup directory..." -ForegroundColor Yellow
$backupPath = Join-Path $projectPath "storage\app\backups"
if (!(Test-Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
    Write-Host "✅ Backup directory created: $backupPath" -ForegroundColor Green
} else {
    Write-Host "✅ Backup directory already exists" -ForegroundColor Green
}
Write-Host ""

# Step 2: Test backup command
Write-Host "🧪 Step 2: Testing backup command..." -ForegroundColor Yellow
$testResult = php artisan backup:daily --retention=30
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Backup command works!" -ForegroundColor Green
} else {
    Write-Host "❌ Backup command failed. Check the error above." -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 3: Setup Windows Task Scheduler
Write-Host "⏰ Step 3: Setting up Windows Task Scheduler..." -ForegroundColor Yellow
Write-Host ""
Write-Host "To schedule daily backups at 2:00 AM:" -ForegroundColor White
Write-Host ""
Write-Host "1. Open Task Scheduler (taskschd.msc)" -ForegroundColor White
Write-Host "2. Click 'Create Basic Task'" -ForegroundColor White
Write-Host "3. Name: 'CRM Daily Backup'" -ForegroundColor White
Write-Host "4. Trigger: Daily at 2:00 AM" -ForegroundColor White
Write-Host "5. Action: Start a program" -ForegroundColor White
Write-Host "   - Program: php" -ForegroundColor Gray
Write-Host "   - Arguments: artisan backup:daily --retention=30" -ForegroundColor Gray
Write-Host "   - Start in: $projectPath" -ForegroundColor Gray
Write-Host ""

$setupScheduler = Read-Host "Would you like to open Task Scheduler now? (Y/N)"
if ($setupScheduler -eq "Y" -or $setupScheduler -eq "y") {
    Start-Process "taskschd.msc"
    Write-Host "✅ Task Scheduler opened" -ForegroundColor Green
}
Write-Host ""

# Step 4: Show backup statistics
Write-Host "📊 Step 4: Backup Statistics" -ForegroundColor Yellow
$backups = Get-ChildItem -Path $backupPath -Filter "*.zip" -ErrorAction SilentlyContinue
if ($backups) {
    Write-Host "  Total backups: $($backups.Count)" -ForegroundColor White
    $totalSize = ($backups | Measure-Object -Property Length -Sum).Sum
    $totalSizeMB = [math]::Round($totalSize / 1MB, 2)
    Write-Host "  Total size: $totalSizeMB MB" -ForegroundColor White
    Write-Host "  Location: $backupPath" -ForegroundColor White
    Write-Host ""
    Write-Host "  Recent backups:" -ForegroundColor White
    $backups | Sort-Object LastWriteTime -Descending | Select-Object -First 5 | ForEach-Object {
        $sizeMB = [math]::Round($_.Length / 1MB, 2)
        Write-Host "    - $($_.Name) ($sizeMB MB) - $($_.LastWriteTime)" -ForegroundColor Gray
    }
} else {
    Write-Host "  No backups found yet" -ForegroundColor Gray
}
Write-Host ""

# Step 5: Create test backup
Write-Host "🎯 Step 5: Create test backup?" -ForegroundColor Yellow
$createTest = Read-Host "Would you like to create a test backup now? (Y/N)"
if ($createTest -eq "Y" -or $createTest -eq "y") {
    Write-Host "Creating test backup..." -ForegroundColor White
    php artisan backup:daily --retention=30
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Test backup created successfully!" -ForegroundColor Green
    } else {
        Write-Host "❌ Test backup failed" -ForegroundColor Red
    }
}
Write-Host ""

# Summary
Write-Host "✅ Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Summary:" -ForegroundColor Cyan
Write-Host "  ✅ Backup directory created" -ForegroundColor White
Write-Host "  ✅ Backup command tested" -ForegroundColor White
Write-Host "  ⏰ Task Scheduler ready to configure" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Configure Task Scheduler for daily backups" -ForegroundColor White
Write-Host "  2. Access admin panel: http://127.0.0.1:8000/admin/backup-restore" -ForegroundColor White
Write-Host "  3. Test manual backup creation" -ForegroundColor White
Write-Host "  4. Set up offsite backup storage" -ForegroundColor White
Write-Host ""
Write-Host "📚 Documentation: BACKUP_SYSTEM_GUIDE.md" -ForegroundColor Cyan
Write-Host ""
Write-Host "🎉 Your CRM backup system is ready!" -ForegroundColor Green
Write-Host ""
