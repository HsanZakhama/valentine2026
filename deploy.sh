#!/bin/bash

# Valentine 2026 Deployment Script
# Run this script on your production server

set -e

echo "🚀 Starting deployment for Valentine 2026..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}⚠️  .env file not found. Creating from .env.example...${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${YELLOW}⚠️  Please edit .env file with your production settings before continuing!${NC}"
        exit 1
    else
        echo -e "${YELLOW}⚠️  .env.example not found. Please create .env file manually.${NC}"
        exit 1
    fi
fi

# Install/Update dependencies
echo "📦 Installing dependencies..."
composer install --optimize-autoloader --no-dev --no-interaction

# Generate application key if not set
if ! grep -q "APP_KEY=base64:" .env; then
    echo "🔑 Generating application key..."
    php artisan key:generate --force
fi

# Run migrations
echo "🗄️  Running database migrations..."
php artisan migrate --force

# Clear and cache configuration
echo "⚙️  Optimizing configuration..."
php artisan config:clear
php artisan config:cache

# Clear and cache routes
echo "🛣️  Optimizing routes..."
php artisan route:clear
php artisan route:cache

# Clear and cache views
echo "👁️  Optimizing views..."
php artisan view:clear
php artisan view:cache

# Clear application cache
echo "🧹 Clearing application cache..."
php artisan cache:clear

# Optimize autoloader
echo "📚 Optimizing autoloader..."
composer dump-autoload --optimize --no-dev

# Set permissions
echo "🔐 Setting permissions..."
if [ -d storage ]; then
    chmod -R 775 storage
    echo "   ✓ Storage permissions set"
fi

if [ -d bootstrap/cache ]; then
    chmod -R 775 bootstrap/cache
    echo "   ✓ Bootstrap cache permissions set"
fi

# Create storage link if needed
if [ ! -L public/storage ]; then
    echo "🔗 Creating storage symlink..."
    php artisan storage:link
fi

echo ""
echo -e "${GREEN}✅ Deployment complete!${NC}"
echo ""
echo "📋 Post-deployment checklist:"
echo "   [ ] Verify APP_DEBUG=false in .env"
echo "   [ ] Verify APP_URL is set to your domain"
echo "   [ ] Change ADMIN_PASSWORD in .env"
echo "   [ ] Test the application at your domain"
echo "   [ ] Test admin panel: /admin?password=your_password"
echo ""

