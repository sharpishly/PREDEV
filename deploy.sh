#!/bin/bash

# ------------------------------
# This deployment file will be replace by GitHub Actions
# -----------------------------
echo ">>> This deployment file will be replace by GitHub Actions..."

# ------------------------------
# Clear terminal
# -----------------------------
echo ">>> Clear terminal..."
clear

# ------------------------------
# Stash previous changes
# -----------------------------
echo ">>> Stash previous changes..."
git stash

# ------------------------------
# Pull the latest changes
# -----------------------------
echo ">>> Pull the latest changes..."
git pull

# ------------------------------
# Compile and run application
# -----------------------------
echo ">>> Compile and run application..."
./run.sh