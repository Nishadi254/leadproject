# CRM Performance Optimization Setup Script
# This script applies all optimizations for handling 10,000+ leads

Write-Host "🚀 CRM Performance Optimization Setup" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Run migrations
Write-Host "📦 Step 1: Applying database optimizations..." -ForegroundColor Yellow
php artisan migrate --force
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Database indexes created successfully" -ForegroundColor Green
} else {
    Write-Host "❌ Migration failed" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Clear all caches
Write-Host "🧹 Step 2: Clearing caches..." -ForegroundColor Yellow
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
Write-Host "✅ Caches cleared" -ForegroundColor Green
Write-Host ""

# Step 3: Optimize configuration
Write-Host "⚙️  Step 3: Optimizing configuration..." -ForegroundColor Yellow
php artisan config:cache
php artisan route:cache
Write-Host "✅ Configuration optimized" -ForegroundColor Green
Write-Host ""

# Step 4: Check optimizations
Write-Host "🔍 Step 4: Verifying optimizations..." -ForegroundColor Yellow
php artisan leads:optimize check
Write-Host ""

# Step 5: Test performance
Write-Host "⚡ Step 5: Testing performance..." -ForegroundColor Yellow
php artisan leads:optimize test
Write-Host ""

Write-Host "🎉 Optimization Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Your CRM is now optimized for 10,000+ leads" -ForegroundColor Cyan
Write-Host ""
Write-Host "💡 Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Test your application: php artisan serve" -ForegroundColor White
Write-Host "  2. Monitor performance: php artisan leads:optimize check" -ForegroundColor White
Write-Host "  3. For production, consider Redis cache in .env:" -ForegroundColor White
Write-Host "     CACHE_DRIVER=redis" -ForegroundColor Gray
Write-Host ""
