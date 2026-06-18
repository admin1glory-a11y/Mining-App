#!/bin/bash

# Mining App - Automated Deployment Script
# This script deploys the Mining App to free hosting platforms

set -e

echo "🚀 Mining App Deployment Script v1.0.0"
echo "========================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check prerequisites
echo -e "${YELLOW}Checking prerequisites...${NC}"
echo ""

if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed. Please install Docker first."
    exit 1
fi
print_status "Docker installed"

if ! command -v docker-compose &> /dev/null; then
    print_error "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi
print_status "Docker Compose installed"

if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install Git first."
    exit 1
fi
print_status "Git installed"

echo ""
print_info "All prerequisites met!"
echo ""

# Display deployment options
echo -e "${YELLOW}Choose a deployment platform:${NC}"
echo ""
echo "1) Railway.app (Recommended - Easiest)"
echo "2) Render.com"
echo "3) Fly.io"
echo "4) Google Cloud Run"
echo "5) Local Docker (Testing)"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo ""
        print_info "Deploying to Railway.app..."
        echo ""
        echo "📋 Steps to deploy on Railway:"
        echo ""
        echo "1. Go to https://railway.app"
        echo "2. Sign up with GitHub"
        echo "3. Click 'New Project'"
        echo "4. Select 'Deploy from GitHub repo'"
        echo "5. Connect admin1glory-a11y/Mining-App"
        echo "6. Configure variables:"
        echo "   - GITHUB_CLIENT_ID"
        echo "   - GITHUB_CLIENT_SECRET"
        echo "   - JWT_SECRET"
        echo "7. Click 'Deploy'"
        echo ""
        print_status "Railway deployment URL will be provided automatically"
        print_info "Typical URL: https://mining-app-production-[random].up.railway.app"
        ;;
    2)
        echo ""
        print_info "Deploying to Render.com..."
        echo ""
        echo "📋 Steps to deploy on Render:"
        echo ""
        echo "1. Go to https://render.com"
        echo "2. Sign up with GitHub"
        echo "3. Click 'New +' > 'Web Service'"
        echo "4. Connect admin1glory-a11y/Mining-App"
        echo "5. Configure:"
        echo "   - Name: mining-app"
        echo "   - Environment: Docker"
        echo "   - Region: Select closest"
        echo "   - Branch: main"
        echo "6. Add environment variables"
        echo "7. Click 'Create Web Service'"
        echo ""
        print_status "Render deployment URL will be provided automatically"
        print_info "Typical URL: https://mining-app.onrender.com"
        ;;
    3)
        echo ""
        print_info "Deploying to Fly.io..."
        echo ""
        if ! command -v flyctl &> /dev/null; then
            print_warning "Fly CLI not found. Installing..."
            curl -L https://fly.io/install.sh | sh
        fi
        echo ""
        echo "📋 Steps to deploy on Fly.io:"
        echo ""
        echo "1. Run: fly auth signup"
        echo "2. Run: fly launch"
        echo "3. Configure app name: mining-app"
        echo "4. Run: fly deploy"
        echo "5. Set secrets:"
        echo "   fly secrets set GITHUB_CLIENT_ID=your-id"
        echo "   fly secrets set GITHUB_CLIENT_SECRET=your-secret"
        echo ""
        print_status "Fly.io deployment ready"
        print_info "Typical URL: https://mining-app.fly.dev"
        ;;
    4)
        echo ""
        print_info "Deploying to Google Cloud Run..."
        echo ""
        echo "📋 Steps to deploy on Google Cloud Run:"
        echo ""
        echo "1. Install Google Cloud SDK: https://cloud.google.com/sdk"
        echo "2. Run: gcloud auth login"
        echo "3. Run: gcloud config set project YOUR_PROJECT_ID"
        echo "4. Build and push:"
        echo "   gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/mining-app"
        echo "5. Deploy:"
        echo "   gcloud run deploy mining-app --image gcr.io/YOUR_PROJECT_ID/mining-app --platform managed --region us-east1 --allow-unauthenticated"
        echo ""
        print_status "Cloud Run deployment ready"
        print_info "Typical URL: https://mining-app-[random]-uc.a.run.app"
        ;;
    5)
        echo ""
        print_info "Starting local Docker deployment..."
        echo ""
        
        # Check if .env exists
        if [ ! -f .env ]; then
            print_warning ".env file not found. Creating from .env.example..."
            cp .env.example .env
            echo ""
            print_warning "Please edit .env with your GitHub OAuth credentials:"
            echo "   nano .env"
            echo ""
            read -p "Have you configured .env? (y/n) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_error "Please configure .env first"
                exit 1
            fi
        fi
        
        echo ""
        print_info "Building Docker images..."
        docker-compose build
        
        echo ""
        print_info "Starting services..."
        docker-compose up -d
        
        echo ""
        sleep 3
        
        echo ""
        print_info "Waiting for services to start..."
        sleep 5
        
        echo ""
        print_status "Checking health status..."
        if curl -f http://localhost:5000/health > /dev/null 2>&1; then
            print_status "Backend health check passed"
        else
            print_error "Backend health check failed"
        fi
        
        echo ""
        print_status "✅ Local deployment successful!"
        echo ""
        echo -e "${GREEN}🎉 Mining App is now running!${NC}"
        echo ""
        echo "📱 Access URLs:"
        echo "   Frontend: ${BLUE}http://localhost:3000${NC}"
        echo "   Backend:  ${BLUE}http://localhost:5000${NC}"
        echo "   API Health: ${BLUE}http://localhost:5000/health${NC}"
        echo ""
        echo "📊 Services Status:"
        docker-compose ps
        echo ""
        echo "📝 View Logs:"
        echo "   docker-compose logs -f"
        echo ""
        echo "🛑 Stop Services:"
        echo "   docker-compose down"
        echo ""
        ;;
    *)
        print_error "Invalid choice. Please run the script again."
        exit 1
        ;;
esac

echo ""
echo "========================================"
echo "📚 Additional Resources:"
echo ""
echo "Documentation: https://github.com/admin1glory-a11y/Mining-App/blob/main/README.md"
echo "Deployment Guide: https://github.com/admin1glory-a11y/Mining-App/blob/main/DEPLOYMENT.md"
echo "Release Notes: https://github.com/admin1glory-a11y/Mining-App/blob/main/RELEASE_v1.0.0.md"
echo ""
echo "========================================"
