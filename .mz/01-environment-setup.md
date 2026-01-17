# Environment Setup Guide

## 🎯 Goal
Have a fully working Cal.com development environment **at least 1 day before** the interview.

## Prerequisites

### Required Software
```bash
# Check versions
node --version  # Should be 18.x
npm --version   # Should be 7+
yarn --version  # Should be 3.4.1
docker --version # Should be 24+
```

### Installation Steps

#### 1. Node.js (via nvm - recommended)
```bash
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install Node 18
nvm install 18
nvm use 18
nvm alias default 18
```

#### 2. Yarn
```bash
npm install -g yarn
yarn --version # Verify 3.4.1
```

#### 3. Docker
- **Mac**: [Docker Desktop](https://www.docker.com/products/docker-desktop)
- **Linux**: `sudo apt-get install docker docker-compose`
- **Windows**: Use WSL2 + Docker Desktop

## Repository Setup

### 1. Clone Repository
```bash
# Clone with shallow history for faster download
git clone --depth 1 https://github.com/calcom/cal.com.git
cd cal.com
```

### 2. Install Dependencies
```bash
yarn
```

**Expected time**: 5-10 minutes depending on connection

### 3. Environment Configuration

#### Create .env file
```bash
cp .env.example .env
```

#### Generate required secrets
```bash
# Generate NEXTAUTH_SECRET (32 bytes)
openssl rand -base64 32

# Generate CALENDSO_ENCRYPTION_KEY (24 bytes)
openssl rand -base64 24
```

#### Minimal .env configuration
Add these to your `.env` file:
```env
NEXTAUTH_SECRET="<generated-32-byte-secret>"
CALENDSO_ENCRYPTION_KEY="<generated-24-byte-secret>"
NEXTAUTH_URL="http://localhost:3000"
DATABASE_URL="postgresql://postgres:@localhost:5450/calendso"
```

### 4. Start Development Server
```bash
yarn dx
```

This command will:
- Start PostgreSQL in Docker
- Run database migrations
- Seed the database with test data
- Start the Next.js dev server

**Expected time**: 2-5 minutes on first run

### 5. Verify Setup

#### Access the app
Open: http://127.0.0.1:3000

#### Login with test account
- Email: `pro@example.com`
- Password: `pro`

#### Test hot reload
1. Open `apps/web/pages/index.tsx`
2. Make a small change (add a space)
3. Save and verify page updates

## Troubleshooting

### Port Already in Use
```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9

# Or use different port
PORT=3001 yarn dev
```

### Database Connection Issues
```bash
# Check Docker containers
docker ps

# Restart database
docker-compose restart postgres

# Reset database
yarn workspace @calcom/prisma db-reset
```

### Yarn Install Failures
```bash
# Clear cache and reinstall
rm -rf node_modules .yarn/cache
yarn cache clean
yarn
```

### Build Errors
```bash
# Regenerate Prisma types
yarn prisma generate

# Clear Next.js cache
rm -rf apps/web/.next
```

## Windows Users (WSL Setup)

### 1. Install WSL
```powershell
# Run in PowerShell as Administrator
wsl --install
```

### 2. Install Ubuntu
```powershell
wsl --install -d Ubuntu-22.04
```

### 3. Configure Cursor for WSL
1. Install "Remote - WSL" extension in Cursor
2. Open Cursor and press `Ctrl+Shift+P`
3. Select "WSL: Connect to WSL"
4. Open the cal.com folder from within WSL

### 4. Install tools in WSL
```bash
# Update package list
sudo apt update

# Install dependencies
sudo apt install build-essential curl git

# Install nvm, node, yarn, docker as above
```

## Post-Setup Verification Checklist

Run through this checklist to ensure everything works:

- [ ] `yarn dx` starts without errors
- [ ] Can access http://127.0.0.1:3000
- [ ] Can login with `pro@example.com` / `pro`
- [ ] Dashboard loads and shows event types
- [ ] Hot reload works (edit a file and see changes)
- [ ] Can create a new event type
- [ ] Can view booking page
- [ ] TypeScript types are working in IDE
- [ ] No console errors in browser

## Quick Test - Create Your First Change

### Test the workflow:
1. Open `apps/web/modules/shell/navigation/Navigation.tsx`
2. Find a text string (e.g., "Event Types")
3. Change it slightly (e.g., "My Event Types")
4. Save and check browser - should update automatically
5. Revert the change

### Test AI assistance:
1. Open any `.tsx` file
2. Ask AI: "Explain what this component does"
3. Ask AI: "Add a TypeScript type for this props object"
4. Practice reviewing the AI's response

## Interview Day Pre-Flight

### 30 minutes before interview:

```bash
# Pull latest changes
git pull origin main

# Update dependencies (if needed)
yarn

# Start dev server
yarn dx

# Verify login works
# Open http://127.0.0.1:3000 and login
```

### Have these ready:
- Terminal with `yarn dx` running
- Browser tab with Cal.com dashboard open
- IDE (Cursor) with project loaded
- AI assistant enabled and tested

## Additional Setup (Optional but Recommended)

### Enable useful VS Code extensions:
- ESLint
- Prettier
- Tailwind CSS IntelliSense
- Prisma

### Set up aliases (add to ~/.bashrc or ~/.zshrc):
```bash
alias cal='cd ~/path/to/cal.com'
alias cal-start='yarn dx'
alias cal-check='yarn type-check:ci --force'
```

---

**Next**: Read [02-codebase-navigation.md](./02-codebase-navigation.md) to learn how to navigate the Cal.com codebase efficiently.
