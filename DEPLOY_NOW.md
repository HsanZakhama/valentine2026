# 🚀 Quick Start: Deploy to Render (FREE) in 10 Minutes

## Why Render?
- ✅ **100% FREE** - No credit card needed
- ✅ **Free database** included
- ✅ **HTTPS/SSL** included
- ✅ **Auto-deploy** from GitHub
- ✅ **Perfect for Laravel**

## 3 Simple Steps

### Step 1: Push to GitHub (5 min)

```bash
# Open PowerShell in your project folder
cd C:\Users\Lenovo\Desktop\valentine2026\valentine-site

# Initialize git (if not already)
git init

# Add all files
git add .

# Commit
git commit -m "Ready for deployment"

# Create repo on GitHub first, then:
git remote add origin https://github.com/YOUR_USERNAME/valentine-2026.git
git branch -M main
git push -u origin main
```

**Don't have GitHub?**
1. Go to [github.com](https://github.com) and sign up (free)
2. Click **"New repository"**
3. Name it: `valentine-2026`
4. Make it **Public**
5. Don't check any boxes
6. Click **"Create repository"**
7. Copy the commands GitHub shows you

### Step 2: Sign Up to Render (2 min)

1. Go to [render.com](https://render.com)
2. Click **"Get Started for Free"**
3. **Sign up with GitHub** (click GitHub button)
4. Authorize Render

### Step 3: Deploy (3 min)

#### Option A: Using Blueprint (Easiest!)

1. In Render dashboard, click **"New +"**
2. Select **"Blueprint"**
3. Connect your GitHub account if needed
4. Select **"valentine-2026"** repository
5. Render will detect `render.yaml` automatically
6. Click **"Apply"**
7. Render creates everything automatically!
8. Wait 3-5 minutes for deployment
9. **Set ADMIN_PASSWORD**:
   - Go to your web service
   - Click **"Environment"** tab
   - Add: `ADMIN_PASSWORD` = `your_secure_password`
   - Save (auto-redeploys)
10. **Run migrations**:
    - Click **"Shell"** tab
    - Run: `php artisan migrate --force`
11. **Done!** Visit your URL

#### Option B: Manual Setup

1. **Create Database**:
   - Click **"New +"** → **"PostgreSQL"**
   - Name: `valentine-db`
   - Plan: **Free**
   - Click **"Create"**
   - Wait for it to be ready

2. **Create Web Service**:
   - Click **"New +"** → **"Web Service"**
   - Connect GitHub → Select `valentine-2026`
   - Configure:
     - **Name**: `valentine-2026`
     - **Environment**: **PHP**
     - **Build Command**: `composer install --optimize-autoloader --no-dev`
     - **Start Command**: `php -S 0.0.0.0:$PORT -t public`
   
3. **Add Environment Variables**:
   - Click **"Advanced"** → **"Add Environment Variable"**
   - Add these:
     ```
     APP_ENV=production
     APP_DEBUG=false
     LOG_CHANNEL=errorlog
     DB_CONNECTION=pgsql
     ADMIN_PASSWORD=your_secure_password
     ```
   - For database vars, use the **Internal Database URL** from your database service
   - Parse it like this:
     ```
     postgresql://user:pass@host:port/dbname
     ```
     - `DB_HOST` = host part
     - `DB_PORT` = 5432
     - `DB_DATABASE` = dbname
     - `DB_USERNAME` = user
     - `DB_PASSWORD` = pass

4. **Click "Create Web Service"**

5. **Generate APP_KEY**:
   - Wait for first deployment
   - Go to **"Shell"** tab
   - Run: `php artisan key:generate --show`
   - Copy the key
   - Go to **"Environment"** tab
   - Add: `APP_KEY` = (paste the key)
   - Save

6. **Run Migrations**:
   - Go to **"Shell"** tab
   - Run: `php artisan migrate --force`

7. **Get Your URL**:
   - Your app URL is shown at the top
   - Update `APP_URL` in Environment Variables
   - Save (auto-redeploys)

## ✅ You're Live!

Visit: `https://valentine-2026.onrender.com`

- **Home**: `https://valentine-2026.onrender.com`
- **Admin**: `https://valentine-2026.onrender.com/admin?password=your_password`
- **Stats**: `https://valentine-2026.onrender.com/stats`

## 🆘 Need Help?

- **500 Error?** Check **Logs** tab
- **Database Error?** Verify DB credentials
- **Can't connect?** Wait 30 seconds (free tier sleeps after 15 min)

## 📚 Full Guide

See `RENDER_DEPLOY.md` for detailed instructions.

---

**That's it! Your app is live and free! 🎉**

