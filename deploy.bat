@echo off
REM Valentine 2026 Deployment Script for Windows
REM Run this script on your Windows server or local machine

echo Starting deployment for Valentine 2026...

REM Check if .env exists
if not exist .env (
    echo WARNING: .env file not found. Creating from .env.example...
    if exist .env.example (
        copy .env.example .env
        echo WARNING: Please edit .env file with your production settings before continuing!
        pause
        exit /b 1
    ) else (
        echo WARNING: .env.example not found. Please create .env file manually.
        pause
        exit /b 1
    )
)

REM Install/Update dependencies
echo Installing dependencies...
call composer install --optimize-autoloader --no-dev --no-interaction

REM Generate application key if needed
echo Generating application key...
php artisan key:generate --force

REM Run migrations
echo Running database migrations...
php artisan migrate --force

REM Clear and cache configuration
echo Optimizing configuration...
php artisan config:clear
php artisan config:cache

REM Clear and cache routes
echo Optimizing routes...
php artisan route:clear
php artisan route:cache

REM Clear and cache views
echo Optimizing views...
php artisan view:clear
php artisan view:cache

REM Clear application cache
echo Clearing application cache...
php artisan cache:clear

REM Optimize autoloader
echo Optimizing autoloader...
call composer dump-autoload --optimize --no-dev

REM Create storage link if needed
echo Creating storage symlink...
php artisan storage:link

echo.
echo Deployment complete!
echo.
echo Post-deployment checklist:
echo    [ ] Verify APP_DEBUG=false in .env
echo    [ ] Verify APP_URL is set to your domain
echo    [ ] Change ADMIN_PASSWORD in .env
echo    [ ] Test the application at your domain
echo    [ ] Test admin panel: /admin?password=your_password
echo.
pause

