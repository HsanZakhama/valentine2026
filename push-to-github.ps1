# PowerShell script to push Valentine 2026 to GitHub
# Run this in PowerShell: .\push-to-github.ps1

Write-Host "🚀 Preparing to push to GitHub..." -ForegroundColor Green
Write-Host ""

# Check if git is installed
try {
    $gitVersion = git --version
    Write-Host "✓ Git found: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git not found. Please install Git first." -ForegroundColor Red
    Write-Host "Download from: https://git-scm.com/download/win" -ForegroundColor Yellow
    exit 1
}

# Check if we're in a git repo
if (Test-Path .git) {
    Write-Host "✓ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "Initializing git repository..." -ForegroundColor Yellow
    git init
    Write-Host "✓ Repository initialized" -ForegroundColor Green
}

# Check if .gitignore exists
if (Test-Path .gitignore) {
    Write-Host "✓ .gitignore found" -ForegroundColor Green
} else {
    Write-Host "⚠ .gitignore not found - creating one..." -ForegroundColor Yellow
}

# Add all files
Write-Host ""
Write-Host "Adding files to git..." -ForegroundColor Yellow
git add .

# Check if there are changes
$status = git status --porcelain
if ($status) {
    Write-Host "✓ Files staged" -ForegroundColor Green
    
    # Commit
    Write-Host ""
    Write-Host "Committing changes..." -ForegroundColor Yellow
    git commit -m "Initial commit - Valentine 2026 ready for deployment"
    Write-Host "✓ Changes committed" -ForegroundColor Green
} else {
    Write-Host "⚠ No changes to commit" -ForegroundColor Yellow
}

# Check for remote
$remote = git remote -v
if ($remote) {
    Write-Host ""
    Write-Host "✓ Remote repository configured" -ForegroundColor Green
    Write-Host "Remote: $remote" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    git branch -M main
    git push -u origin main
    Write-Host ""
    Write-Host "✅ Successfully pushed to GitHub!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "⚠ No remote repository configured" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Cyan
    Write-Host "1. Create a new repository on GitHub (github.com/new)" -ForegroundColor White
    Write-Host "2. Name it: valentine-2026" -ForegroundColor White
    Write-Host "3. Make it PUBLIC (required for Render free tier)" -ForegroundColor White
    Write-Host "4. Don't initialize with README" -ForegroundColor White
    Write-Host "5. Then run these commands:" -ForegroundColor White
    Write-Host ""
    Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/valentine-2026.git" -ForegroundColor Yellow
    Write-Host "   git branch -M main" -ForegroundColor Yellow
    Write-Host "   git push -u origin main" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "(Replace YOUR_USERNAME with your GitHub username)" -ForegroundColor Gray
}

Write-Host ""
Write-Host "📚 Next: Follow DEPLOY_NOW.md to deploy to Render!" -ForegroundColor Cyan
Write-Host ""

