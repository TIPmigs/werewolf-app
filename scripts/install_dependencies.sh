#!/bin/bash
set -e

cd /home/ec2-user/werewolf-app/backend
npm install

cd ../frontend
npm install
npm run build
