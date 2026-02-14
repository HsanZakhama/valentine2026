# 🚀 Deploy to Render (FREE) - Step by Step Guide

Render offers a **free tier** perfect for your Valentine app! Here's how to deploy:

## Why Render?
- ✅ **100% Free** for small apps
- ✅ **Free MySQL database** included
- ✅ **Automatic deployments** from GitHub
- ✅ **HTTPS/SSL** included
- ✅ **No credit card required** for free tier
- ✅ **Easy setup** - just connect GitHub

## Prerequisites
1. GitHub account (free)
2. Render account (free) - sign up at [render.com](https://render.com)

## Step 1: Push to GitHub

1. **Create a new GitHub repository**
   - Go to [github.com/new](https://github.com/new)
   - Name it: `valentine-2026`
   - Make it **Public** (required for free tier)
   - Don't initialize with README

2. **Push your code to GitHub**
   ```bash
   cd C:\Users\Lenovo\Desktop\valentine2026\valentine-site
   git init
   git add .
   git commit -m "Initial commit - Valentine 2026"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/valentine-2026.git
   git push -u origin main
   ```

   Replace `YOUR_USERNAME` with your GitHub username.

## Step 2: Create Render Account

1. Go to [render.com](https://render.com)
2. Click **"Get Started for Free"**
3. Sign up with GitHub (easiest way)
4. Authorize Render to access your repositories

## Step 3: Create Database

1. In Render dashboard, click **"New +"**
2. Select **"PostgreSQL"** (free tier available)
   - **Note**: Render's free tier uses PostgreSQL, not MySQL. That's fine - Laravel supports both!
3. Configure:
   - **Name**: `valentine-db`
   - **Database**: `valentine`
   - **User**: `valentine_user`
   - **Region**: Choose closest to you
   - **Plan**: **Free**
4. Click **"Create Database"**
5. **Wait for it to provision** (takes 1-2 minutes)
6. **Copy the Internal Database URL** - you'll need this!

## Step 4: Deploy Web Service

1. In Render dashboard, click **"New +"**
2. Select **"Web Service"**
3. Connect your GitHub repository:
   - Click **"Connect account"** if not connected
   - Select **"valentine-2026"** repository
   - Click **"Connect"**

4. Configure the service:
   - **Name**: `valentine-2026`
   - **Environment**: **PHP**
   - **Region**: Same as database
   - **Branch**: `main`
   - **Root Directory**: Leave empty (or `valentine-site` if you pushed the whole folder)
   - **Build Command**: 
     ```
     composer install --optimize-autoloader --no-dev
     ```
   - **Start Command**: 
     ```
     php -S 0.0.0.0:$PORT -t public
     ```

5. **Environment Variables** - Click **"Advanced"** → **"Add Environment Variable"**:
   
   Add these one by one:
   ```
   APP_ENV=production
   APP_DEBUG=false
   APP_KEY=                    (we'll generate this)
   APP_URL=                    (leave empty for now, Render will set it)
   LOG_CHANNEL=errorlog
   
   DB_CONNECTION=pgsql
   DB_HOST=                    (from database Internal URL)
   DB_PORT=5432
   DB_DATABASE=valentine
   DB_USERNAME=valentine_user
   DB_PASSWORD=                (from database Internal URL)
   
   ADMIN_PASSWORD=your_secure_password_here
   ```

   **How to get database values from Internal URL:**
   ```
   postgresql://valentine_user:password@dpg-xxxxx-a/valentine
   ```
   - `DB_HOST`: `dpg-xxxxx-a` (the host part)
   - `DB_USERNAME`: `valentine_user`
   - `DB_PASSWORD`: `password` (the password part)
   - `DB_DATABASE`: `valentine`

6. **Generate APP_KEY**:
   - After service is created, go to **Shell** tab
   - Run: `php artisan key:generate --show`
   - Copy the key
   - Go to **Environment** tab
   - Update `APP_KEY` with the generated value

7. Click **"Create Web Service"**

## Step 5: Update Database Config for PostgreSQL

Since Render uses PostgreSQL, we need to update the database config. The `render.yaml` file handles this, but if deploying manually:

1. Go to your service **Environment** tab
2. Set `DB_CONNECTION=pgsql` (already done above)

## Step 6: Run Migrations

1. Go to your web service
2. Click **"Shell"** tab
3. Run:
   ```bash
   php artisan migrate --force
   ```

## Step 7: Get Your URL

1. Once deployed, Render gives you a URL like:
   `https://valentine-2026.onrender.com`

2. Update `APP_URL` in Environment Variables:
   - Go to **Environment** tab
   - Set `APP_URL=https://valentine-2026.onrender.com`

3. **Redeploy** (Render auto-redeploys when env vars change)

## Step 8: Test Your App

1. Visit: `https://valentine-2026.onrender.com`
2. Test the form submission
3. Access admin: `https://valentine-2026.onrender.com/admin?password=your_password`
4. Check stats: `https://valentine-2026.onrender.com/stats`

## Troubleshooting

### App shows 500 error
1. Check **Logs** tab in Render dashboard
2. Check if `APP_KEY` is set
3. Verify database connection string

### Database connection error
1. Verify `DB_CONNECTION=pgsql`
2. Check database credentials in Environment Variables
3. Ensure database is fully provisioned (green status)

### Migrations fail
1. Check database is accessible
2. Run migrations via Shell: `php artisan migrate --force`
3. Check logs for specific error

### App goes to sleep (free tier)
- Free tier apps sleep after 15 minutes of inactivity
- First request after sleep takes ~30 seconds to wake up
- This is normal for free tier - upgrade to paid for always-on

## Using render.yaml (Alternative - Easier!)

If you pushed the `render.yaml` file, you can use it:

1. In Render dashboard, click **"New +"**
2. Select **"Blueprint"**
3. Connect your repository
4. Render will auto-detect `render.yaml`
5. Review and click **"Apply"**
6. Render creates both database and web service automatically!

## Free Tier Limits

- ✅ **750 hours/month** (enough for always-on if you're the only user)
- ✅ **512 MB RAM**
- ✅ **Free SSL/HTTPS**
- ⚠️ **Sleeps after 15 min inactivity** (wakes on first request)
- ⚠️ **Limited to 1 free web service**

## Next Steps

1. **Custom Domain** (optional):
   - Go to service → **Settings** → **Custom Domain**
   - Add your domain
   - Update DNS records as instructed

2. **Monitor**:
   - Check **Logs** tab regularly
   - Monitor **Metrics** for usage

3. **Backup**:
   - Export database regularly
   - Render provides backups on paid plans

## 🎉 You're Live!

Your Valentine app is now deployed and accessible worldwide!

Need help? Check Render's docs: [render.com/docs](https://render.com/docs)

