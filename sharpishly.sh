#!/bin/bash

line='----------'

echo "$line Changing to PREDEV directory"
cd ~/Documents/PREDEV || { echo "❌ Failed to enter PREDEV directory"; exit 1; }

echo "$line Starting PREDEV containers in detached mode"
docker-compose up -d || { echo "❌ PREDEV containers failed to start"; exit 1; }

echo "$line Changing to SharpishlyApp/app directory"
cd ~/Documents/PREDEV/SharpishlyApp/app || { echo "❌ Failed to enter SharpishlyApp/app directory"; exit 1; }

echo "$line Starting SharpishlyApp containers in detached mode"
docker-compose up -d || { echo "❌ SharpishlyApp containers failed to start"; exit 1; }

echo "$line ✅ All containers are now running!"
