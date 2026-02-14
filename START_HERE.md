# 🎯 START HERE - Deploy Your Valentine App (FREE!)

## ✅ Everything is Ready!

Your app is configured for **FREE deployment on Render**. Follow these simple steps:

## 🚀 3 Steps to Go Live

### Step 1: Push to GitHub (5 minutes)

**Option A: Use the helper script (Easiest!)**
```powershell
# In PowerShell, navigate to your project:
cd C:\Users\Lenovo\Desktop\valentine2026\valentine-site

# Run the helper script:
.\push-to-github.ps1
```

**Option B: Manual**
1. Create a GitHub account at [github.com](https://github.com) (if you don't have one)
2. Create a new repository:
   - Go to [github.com/new](https://github.com/new)
   - Name: `valentine-2026`
   - Make it **PUBLIC** (required for free tier)
   - Don't check any boxes
   - Click "Create repository"
3. Push your code:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/valentine-2026.git
   git push -u origin main
   ```

### Step 2: Sign Up to Render (2 minutes)

1. Go to [render.com](https://render.com)
2. Click **"Get Started for Free"**
3. **Sign up with GitHub** (click the GitHub button)
4. Authorize Render to access your repositories

### Step 3: Deploy (3 minutes)

1. In Render dashboard, click **"New +"**
2. Select **"Blueprint"**
3. Connect your GitHub account (if not already)
4. Select **"valentine-2026"** repository
5. Render will automatically detect `render.yaml`
6. Click **"Apply"**
7. Wait 3-5 minutes for deployment
8. **Set your admin password**:
   - Go to your web service → **Environment** tab
   - Add: `ADMIN_PASSWORD` = `your_secure_password`
   - Save (auto-redeploys)
9. **Run migrations**:
   - Click **"Shell"** tab
   - Run: `php artisan migrate --force`
10. **Done!** Visit your URL (shown at the top of the service)

## 🎉 You're Live!

Your app will be available at: `https://valentine-2026.onrender.com`

- **Homepage**: `https://valentine-2026.onrender.com`
- **Admin Panel**: `https://valentine-2026.onrender.com/admin?password=your_password`
- **Stats API**: `https://valentine-2026.onrender.com/stats`

## 📚 Need More Help?

- **Quick Guide**: See [`DEPLOY_NOW.md`](DEPLOY_NOW.md)
- **Detailed Guide**: See [`RENDER_DEPLOY.md`](RENDER_DEPLOY.md)
- **Other Platforms**: See [`DEPLOYMENT.md`](DEPLOYMENT.md)

## ⚠️ Important Notes

1. **Free Tier**: App sleeps after 15 min of inactivity (wakes on first request)
2. **Database**: Uses PostgreSQL (free tier included)
3. **HTTPS**: Automatically included
4. **Admin Password**: Change the default in Environment Variables!

## 🆘 Troubleshooting

**500 Error?**
- Check **Logs** tab in Render
- Verify `APP_KEY` is set (auto-generated)
- Check database connection

**Database Error?**
- Wait for database to fully provision (green status)
- Verify `DB_CONNECTION=pgsql` in Environment Variables

**Can't access?**
- Free tier apps sleep - wait 30 seconds on first request
- Check the service status (should be "Live")

---

**That's it! Your Valentine app is ready to go live! 💝**

Need help? Check the detailed guides or Render's documentation at [render.com/docs](https://render.com/docs)

