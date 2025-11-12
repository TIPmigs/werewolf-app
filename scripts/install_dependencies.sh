#!/bin/bash
set -e

echo "🚀 Starting dependency installation..."

# Ensure we're in the right directory
cd /home/ec2-user/werewolf-app

# Install Node.js if missing
if ! command -v node &> /dev/null; then
  echo "Node.js not found. Installing Node.js 18..."
  curl -fsSL https://rpm.nodesource.com/setup_18.x | sudo bash -
  sudo yum install -y nodejs
fi

# Install PM2 globally (if not already installed)
if ! command -v pm2 &> /dev/null; then
  echo "Installing PM2..."
  sudo npm install -g pm2
fi

# Backend setup
echo "Installing backend dependencies..."
cd backend
npm install --production

# Frontend setup
echo "Building frontend..."
cd ../frontend
npm install
npm run build

echo "✅ Dependencies installed and frontend built successfully."
