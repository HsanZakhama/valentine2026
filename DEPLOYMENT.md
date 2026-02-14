# Deployment Guide for Valentine 2026

This guide will help you deploy your Laravel Valentine application to production.

## Prerequisites

- PHP 7.3 or higher (8.0+ recommended)
- Composer
- MySQL/MariaDB database
- Web server (Apache/Nginx)
- SSL certificate (recommended for production)

## Deployment Steps

### 1. Server Setup

#### Option A: Shared Hosting (cPanel, etc.)

1. Upload all files to your hosting account via FTP/SFTP
2. Ensure the `public` folder is your document root
3. Set up your database via cPanel
4. Configure your `.env` file (see below)

#### Option B: VPS/Cloud Server

1. SSH into your server
2. Install PHP, Composer, MySQL, and a web server
3. Clone or upload your project files
4. Set up your database
5. Configure your `.env` file

### 2. Environment Configuration

1. Copy `.env.example` to `.env`:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` file with your production settings:
   ```env
   APP_NAME="Valentine 2026"
   APP_ENV=production
   APP_KEY=                    # Generate with: php artisan key:generate
   APP_DEBUG=false
   APP_URL=https://yourdomain.com

   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=your_database_name
   DB_USERNAME=your_database_user
   DB_PASSWORD=your_database_password

   ADMIN_PASSWORD=your_secure_admin_password
   ```

3. Generate application key:
   ```bash
   php artisan key:generate
   ```

### 3. Install Dependencies

```bash
composer install --optimize-autoloader --no-dev
```

### 4. Database Setup

```bash
# Run migrations
php artisan migrate --force

# Optional: If you need to reset the database
# php artisan migrate:fresh --force
```

### 5. Optimize for Production

```bash
# Cache configuration
php artisan config:cache

# Cache routes
php artisan route:cache

# Cache views
php artisan view:cache

# Optimize autoloader
composer dump-autoload --optimize
```

### 6. Set Permissions

```bash
# Set storage and cache permissions
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

### 7. Web Server Configuration

#### Apache (.htaccess)

The `.htaccess` file in the `public` folder should already be configured. Ensure `mod_rewrite` is enabled.

#### Nginx Configuration

```nginx
server {
    listen 80;
    server_name yourdomain.com;
    root /path/to/valentine-site/public;

    add_header X-Frame-Options "SAMEORIGIN";
    add_header X-Content-Type-Options "nosniff";

    index index.php;

    charset utf-8;

    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    location ~ \.php$ {
        fastcgi_pass unix:/var/run/php/php8.0-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.(?!well-known).* {
        deny all;
    }
}
```

### 8. SSL Certificate (Recommended)

Use Let's Encrypt or your hosting provider's SSL certificate:
```bash
# Let's Encrypt example
certbot --nginx -d yourdomain.com
```

### 9. Verify Deployment

1. Visit your domain: `https://yourdomain.com`
2. Test the form submission
3. Access admin panel: `https://yourdomain.com/admin?password=your_admin_password`
4. Check stats endpoint: `https://yourdomain.com/stats`

## Quick Deployment Script

Save this as `deploy.sh` and run it on your server:

```bash
#!/bin/bash
echo "Starting deployment..."

# Install dependencies
composer install --optimize-autoloader --no-dev

# Generate key if needed
php artisan key:generate --force

# Run migrations
php artisan migrate --force

# Cache everything
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
chmod -R 775 storage bootstrap/cache

echo "Deployment complete!"
```

## Platform-Specific Guides

### Heroku

1. Install Heroku CLI
2. Create `Procfile`:
   ```
   web: vendor/bin/heroku-php-apache2 public/
   ```
3. Deploy:
   ```bash
   heroku create your-app-name
   heroku config:set APP_KEY=$(php artisan key:generate --show)
   git push heroku main
   heroku run php artisan migrate
   ```

### DigitalOcean App Platform

1. Connect your GitHub repository
2. Set build command: `composer install --optimize-autoloader --no-dev`
3. Set run command: `php artisan serve`
4. Configure environment variables in the dashboard
5. Add database addon

### Laravel Forge

1. Connect your server
2. Create a new site
3. Point to your repository
4. Configure environment variables
5. Deploy

## Post-Deployment Checklist

- [ ] `.env` file configured with production values
- [ ] `APP_DEBUG=false` in production
- [ ] Database migrations run successfully
- [ ] Admin password changed from default
- [ ] SSL certificate installed
- [ ] File permissions set correctly
- [ ] Caching enabled (config, routes, views)
- [ ] Application accessible via domain
- [ ] Form submissions working
- [ ] Admin panel accessible

## Troubleshooting

### 500 Error
- Check file permissions
- Verify `.env` file exists and is configured
- Check `storage/logs/laravel.log` for errors
- Ensure `APP_KEY` is set

### Database Connection Error
- Verify database credentials in `.env`
- Check database server is running
- Ensure database user has proper permissions

### Permission Denied
```bash
chmod -R 775 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

### Clear All Caches
```bash
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear
```

## Security Notes

1. **Change the admin password** in `.env` file (ADMIN_PASSWORD)
2. **Never commit `.env` file** to version control
3. **Use HTTPS** in production
4. **Keep dependencies updated**: `composer update`
5. **Regular backups** of your database

## Support

For issues, check:
- Laravel logs: `storage/logs/laravel.log`
- Web server error logs
- Database connection status

