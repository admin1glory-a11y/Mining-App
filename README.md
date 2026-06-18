# Mining App - Real-time Data Processing & AI Integration

A full-stack application for real-time data mining with GitHub OAuth authentication, AI-powered insights, and secure deployment via Cloudflare Tunnel.

## 🎯 Features

- **GitHub OAuth Authentication**: Secure login with GitHub
- **Real-time Data Processing**: Stream and process mining data in real-time
- **AI-Powered Analytics**: Leverage AI APIs for intelligent insights
- **Secure Backend**: JWT-based authentication and authorization
- **Database**: PostgreSQL for persistent storage
- **Caching**: Redis for high-performance caching
- **Docker Deployment**: Containerized for easy deployment
- **Cloudflare Integration**: Secure tunneling and access control

## 📋 Prerequisites

- Docker & Docker Compose
- Node.js 18+ (for local development)
- GitHub OAuth App credentials
- AI API key (OpenAI or similar)
- Cloudflare account (for Tunnel)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/admin1glory-a11y/Mining-App.git
cd Mining-App
```

### 2. Setup Environment Variables

```bash
cp .env.example .env
# Edit .env with your actual credentials
```

### 3. Deploy with Docker Compose

```bash
docker-compose up -d
```

The app will be available at:
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:5000
- **Database**: localhost:5432
- **Cache**: localhost:6379

## 🔧 Development

### Backend Development

```bash
cd backend
npm install
npm run dev
```

### Frontend Development

```bash
cd frontend
npm install
npm start
```

## 📚 API Endpoints

### Authentication
- `GET /auth/github` - Initiate GitHub OAuth login
- `GET /auth/github/callback` - GitHub OAuth callback
- `POST /auth/logout` - Logout user
- `GET /auth/user` - Get current user info

### Mining Operations
- `GET /api/mining/status` - Get mining status
- `POST /api/mining/start` - Start mining operation
- `POST /api/mining/stop` - Stop mining operation
- `GET /api/mining/results` - Get mining results

### AI Analytics
- `POST /api/ai/analyze` - Analyze mining data with AI
- `GET /api/ai/insights` - Get AI-generated insights

## 🔒 Security

- Environment variables are never committed
- JWT tokens for API authentication
- HTTPS enforcement via Cloudflare Tunnel
- PostgreSQL with encrypted connections
- Rate limiting on API endpoints
- CORS properly configured

## 🐳 Docker Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f backend

# Stop services
docker-compose down

# Rebuild containers
docker-compose build --no-cache

# Run migrations
docker-compose exec backend npm run migrate
```

## 🌐 Cloudflare Tunnel Setup

```bash
# Install Cloudflare CLI
npm install -g @cloudflare/wrangler

# Authenticate
wrangler login

# Create tunnel
wrangler tunnel create mining-app

# Deploy
docker-compose up -d && wrangler tunnel route dns mining-app your-domain.com
```

## 📊 Database Migrations

```bash
# Create migration
docker-compose exec backend npm run migrate:create

# Run migrations
docker-compose exec backend npm run migrate

# Rollback
docker-compose exec backend npm run migrate:rollback
```

## 🧪 Testing

```bash
# Backend tests
cd backend
npm test

# Frontend tests
cd frontend
npm test
```

## 📝 License

Apache License 2.0

## 👨‍💻 Author

admin1glory-a11y

## 🤝 Contributing

Contributions are welcome! Please submit pull requests to improve the project.
