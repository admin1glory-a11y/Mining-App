# Deploying Mining App Online - Complete Guide

## 🚀 Quick Deployment Options

Your Mining App is ready to deploy online! Choose from the options below:

---

## ✅ RECOMMENDED: Railway.app (Fastest & Easiest)

### Setup Time: 5 minutes
### Cost: Free tier available ($5/month paid plan)

**Why Railway?**
- ✅ One-click deployment from GitHub
- ✅ Automatic HTTPS
- ✅ Free tier available
- ✅ PostgreSQL & Redis included
- ✅ Environment variables support
- ✅ Docker-native support

### Deployment Steps:

1. **Go to Railway**: https://railway.app
2. **Sign in with GitHub**
3. **Click "New Project"**
4. **Select "Deploy from GitHub repo"**
5. **Search for "admin1glory-a11y/Mining-App"** and connect
6. **Add Environment Variables** in Railway dashboard:
   ```
   GITHUB_CLIENT_ID=your-github-oauth-client-id
   GITHUB_CLIENT_SECRET=your-github-oauth-client-secret
   JWT_SECRET=your-secret-jwt-key-min-32-characters
   AI_API_URL=https://api.openai.com/v1
   AI_API_KEY=your-optional-api-key
   ```
7. **Click "Deploy"**

### Your URL Will Be:
```
https://mining-app-production-[random-id].up.railway.app
```

### After Deployment:
- Frontend available at: `https://mining-app-production-[id].up.railway.app`
- Backend API at: `https://mining-app-production-[id].up.railway.app:5000`

---

## Alternative Option 2: Render.com

### Setup Time: 5 minutes
### Cost: Free tier available

1. Go to https://render.com
2. Sign up with GitHub
3. Click "New +" > "Web Service"
4. Connect admin1glory-a11y/Mining-App
5. Configure:
   - Name: mining-app
   - Environment: Docker
   - Region: Select closest to you
6. Add environment variables (same as above)
7. Click "Create Web Service"

### Your URL Will Be:
```
https://mining-app.onrender.com
```

---

## Alternative Option 3: Fly.io

### Setup Time: 10 minutes
### Cost: Free tier available

```bash
# 1. Install Fly CLI
curl -L https://fly.io/install.sh | sh

# 2. Sign up
fly auth signup

# 3. Launch from repository
cd Mining-App
fly launch

# 4. Deploy
fly deploy

# 5. Set secrets
fly secrets set GITHUB_CLIENT_ID=your-id
fly secrets set GITHUB_CLIENT_SECRET=your-secret
fly secrets set JWT_SECRET=your-secret
```

### Your URL Will Be:
```
https://mining-app.fly.dev
```

---

## Alternative Option 4: Google Cloud Run

### Setup Time: 15 minutes
### Cost: Free tier (limited hours)

```bash
# 1. Install Google Cloud SDK
# https://cloud.google.com/sdk

# 2. Authenticate
gcloud auth login
gcloud config set project YOUR_PROJECT_ID

# 3. Build and push to Container Registry
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/mining-app

# 4. Deploy to Cloud Run
gcloud run deploy mining-app \
  --image gcr.io/YOUR_PROJECT_ID/mining-app \
  --platform managed \
  --region us-east1 \
  --allow-unauthenticated \
  --set-env-vars GITHUB_CLIENT_ID=your-id,GITHUB_CLIENT_SECRET=your-secret
```

### Your URL Will Be:
```
https://mining-app-[random-id]-uc.a.run.app
```

---

## 🛠️ MANUAL SETUP: Using Deployment Script

We've included an automated deployment script:

```bash
# Make script executable
chmod +x deploy.sh

# Run script
./deploy.sh
```

The script will:
1. Check prerequisites (Docker, Docker Compose, Git)
2. Ask you to choose a platform
3. Provide step-by-step instructions
4. Start local testing if you choose option 5

---

## 📝 GitHub OAuth Setup (Required for All Options)

Before deploying, you need GitHub OAuth credentials:

### Step 1: Create GitHub OAuth App
1. Go to https://github.com/settings/developers
2. Click "New OAuth App"
3. Fill in:
   - **Application name**: Mining App
   - **Homepage URL**: https://your-deployed-url (you'll update this later)
   - **Authorization callback URL**: https://your-deployed-url/auth/github/callback

### Step 2: Get Credentials
1. Click your new app
2. Copy **Client ID** and **Client Secret**
3. Use these in your deployment environment variables

### Step 3: Update Callback URL
After deployment, update the GitHub OAuth app with your actual URL

---

## ✨ COMPARISON TABLE

| Platform | Setup Time | Cost | Free Tier | HTTPS | GitHub Integration |
|----------|-----------|------|-----------|-------|------------------|
| **Railway** | 5 min | Free/$5+ | ✅ Yes | ✅ Yes | ✅ Direct |
| **Render** | 5 min | Free/$7+ | ✅ Yes | ✅ Yes | ✅ Direct |
| **Fly.io** | 10 min | Free/$5+ | ✅ Yes | ✅ Yes | ✅ Direct |
| **Cloud Run** | 15 min | Free/$0+ | ✅ Limited | ✅ Yes | ✅ SDK |

**Recommendation**: Start with **Railway.app** - it's the easiest!

---

## 🔍 VERIFY DEPLOYMENT

After deploying to any platform:

### Check Backend Health
```bash
curl https://your-deployed-url/health
```

Expected response:
```json
{
  "status": "OK",
  "timestamp": "2026-06-18T..."
}
```

### Test GitHub Login
1. Visit: https://your-deployed-url
2. Click "Sign in with GitHub"
3. Authorize the app
4. You should see the dashboard

### Test Mining API
```bash
# Get status
curl -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  https://your-deployed-url/api/mining/status
```

---

## 🚨 Troubleshooting

### "502 Bad Gateway"
- Wait 2-3 minutes for deployment to complete
- Check environment variables are set
- View logs in platform dashboard

### "GitHub OAuth Failed"
- Verify Client ID and Client Secret are correct
- Check callback URL matches your deployment URL
- Update GitHub OAuth app settings

### "Database Connection Error"
- Database service may still be starting
- Wait 2-3 minutes
- Check DATABASE_URL environment variable

### "Cannot connect to backend"
- Verify backend service is running
- Check CORS configuration
- Verify API endpoints in browser console

---

## 📊 After Deployment

### Monitor Your App
- Railway: https://railway.app/dashboard
- Render: https://dashboard.render.com
- Fly.io: https://fly.io/dashboard
- Google Cloud: https://console.cloud.google.com

### View Logs
- Each platform has a logs section
- Watch for errors and warnings
- Check database connections

### Scale Resources
- Most platforms offer easy scaling
- Add more CPU/RAM as needed
- Database upgrades available

---

## 💾 Domain Names

### Add Custom Domain
All platforms support custom domains:

1. Buy domain from Namecheap, GoDaddy, etc.
2. Get platform's CNAME record
3. Update DNS settings
4. Wait for propagation (24-48 hours)

### Example
```
CNAME: mining-app.yourdomain.com → your-platform-url.app
```

---

## 🔐 Security Checklist

- [ ] GitHub OAuth credentials set correctly
- [ ] JWT_SECRET is strong and unique
- [ ] Database password changed
- [ ] Environment variables not exposed
- [ ] HTTPS is enabled (automatic on all platforms)
- [ ] Database backups configured
- [ ] Monitoring enabled

---

## 📞 Support & Help

If deployment fails:

1. **Check logs** in platform dashboard
2. **Review error messages** carefully
3. **Verify environment variables** are set
4. **Test locally** with: `docker-compose up -d`
5. **Check GitHub Issues**: https://github.com/admin1glory-a11y/Mining-App/issues

---

## 🎯 NEXT STEPS

1. Choose a platform from above
2. Follow the setup steps
3. Deploy your app
4. Share your URL!

**Deployed URL format**: https://mining-app-[id].[platform].com

---

## 📚 Additional Resources

- Repository: https://github.com/admin1glory-a11y/Mining-App
- README: https://github.com/admin1glory-a11y/Mining-App/blob/main/README.md
- Deployment Script: `./deploy.sh`
- Docker Docs: https://docs.docker.com

---

**Version**: 1.0.0 | **Status**: ✅ Ready to Deploy
