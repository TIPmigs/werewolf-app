#!/bin/bash
set -e

cd /home/ec2-user/werewolf-app/backend

# Ensure pm2 is installed globally
sudo npm install -g pm2

# Stop any previous process
pm2 delete werewolf-server || true

# Start backend
pm2 start server.js --name "werewolf-server"
pm2 save
