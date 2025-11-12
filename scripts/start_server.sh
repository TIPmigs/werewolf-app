#!/bin/bash
set -e

echo "🚀 Starting werewolf backend..."

cd /home/ec2-user/werewolf-app/backend

# Ensure pm2 is installed globally
if ! command -v pm2 &> /dev/null; then
  echo "Installing PM2 globally..."
  sudo npm install -g pm2
fi

# Load environment variables from persistent .env file
if [ -f /home/ec2-user/.env ]; then
  echo "Loading environment variables..."
  export $(grep -v '^#' /home/ec2-user/.env | xargs)
else
  echo "⚠️  Warning: /home/ec2-user/.env not found! Server may not connect to DB."
fi

# Stop any previous PM2 process with the same name
pm2 delete werewolf-server || true

# Install dependencies (in case not yet installed)
npm ci --only=production || npm install --production

# Start backend with PM2
pm2 start server.js --name "werewolf-server"

# Save PM2 process list so it auto-restarts on reboot
pm2 save

echo "✅ werewolf backend started successfully."
