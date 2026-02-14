# Quick Deployment Guide

## For Shared Hosting (cPanel, etc.)

1. **Upload files** via FTP/SFTP to your hosting account
2. **Set document root** to the `public` folder
3. **Create database** via cPanel MySQL
4. **Configure `.env`** file:
   - Copy `.env.example` to `.env`
   - Update database credentials
   - Set `APP_URL` to your domain
   - Set `APP_DEBUG=false`
   - Generate key: `php artisan key:generate`
5. **Run migrations**: `php artisan migrate --force`
6. **Set permissions**: `chmod -R 775 storage bootstrap/cache`

## For VPS/Cloud Server (Linux)

```bash
# 1. Clone/upload your project
cd /var/www
git clone your-repo-url valentine-site
cd valentine-site

# 2. Install dependencies
composer install --optimize-autoloader --no-dev

# 3. Configure environment
cp .env.example .env
nano .env  # Edit with your settings

# 4. Generate key and run migrations
php artisan key:generate
php artisan migrate --force

# 5. Optimize
php artisan config:cache
php artisan route:cache
php artisan view:cache

# 6. Set permissions
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

## For Windows Server

```batch
REM Run deploy.bat in the project directory
deploy.bat
```

## For Heroku

```bash
# 1. Install Heroku CLI
# 2. Login
heroku login

# 3. Create app
heroku create your-app-name

# 4. Set environment variables
heroku config:set APP_KEY=$(php artisan key:generate --show)
heroku config:set APP_ENV=production
heroku config:set APP_DEBUG=false
heroku config:set APP_URL=https://your-app-name.herokuapp.com
heroku config:set ADMIN_PASSWORD=your_secure_password

# 5. Add database (JawsDB, ClearDB, etc.)
heroku addons:create jawsdb:kitefin

# 6. Deploy
git push heroku main

# 7. Run migrations
heroku run php artisan migrate
```

## Environment Variables to Set

```env
APP_NAME="Valentine 2026"
APP_ENV=production
APP_KEY=                    # Generate with: php artisan key:generate
APP_DEBUG=false
APP_URL=https://yourdomain.com

DB_CONNECTION=mysql
DB_HOST=your_db_host
DB_PORT=3306
DB_DATABASE=your_database
DB_USERNAME=your_username
DB_PASSWORD=your_password

ADMIN_PASSWORD=your_secure_password
```

## Post-Deployment

1. Visit your site: `https://yourdomain.com`
2. Test form submission
3. Access admin: `https://yourdomain.com/admin?password=your_password`
4. Check stats: `https://yourdomain.com/stats`

## Troubleshooting

- **500 Error**: Check `storage/logs/laravel.log`
- **Database Error**: Verify credentials in `.env`
- **Permission Error**: Run `chmod -R 775 storage bootstrap/cache`

