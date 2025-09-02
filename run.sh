#!/bin/bash

# ------------------------------
# Allow port 1966
# -----------------------------
echo ">>> Allow port 1966..."
sudo ufw allow 1966

# ------------------------------
# Port status
# -----------------------------
echo ">>> Port status..."
sudo ufw status

# ------------------------------
# Set permissions
# -----------------------------
echo ">>> Set permissions..."
sudo chmod -R u+rwX SharpishlyApp/src/View

# ------------------------------
# Stop Nginx
# -----------------------------
echo ">>> Stop Nginx..."
sudo systemctl stop nginx
sudo service nginx stop

# ------------------------------
# List www directory
# -----------------------------
echo ">>> List www directory..."
ls -l SharpishlyApp/src/View/www

# ------------------------------
# Change to build directory
# -----------------------------
echo ">>> Change to build directory..."
cd SharpishlyApp/build

# ------------------------------
# Compile and build
# -----------------------------
echo ">>> Compile and build..."
cmake ..
make

# ------------------------------
# Run application
# -----------------------------
echo ">>> Run application..."
./SharpishlyApp
