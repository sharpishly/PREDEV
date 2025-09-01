#!/bin/bash

# Exit on error
set -e

# Define variables
DOXYGEN_VERSION="1.14.0"
DOXYGEN_TAR="doxygen-${DOXYGEN_VERSION}.src.tar.gz"
DOXYGEN_URL="https://www.doxygen.nl/files/${DOXYGEN_TAR}"
DOC_DIR="$(pwd)/doc"
INSTALL_DIR="${DOC_DIR}/doxygen"

# Check if doc folder exists, create if it doesn't
if [ ! -d "${DOC_DIR}" ]; then
    mkdir -p "${DOC_DIR}"
fi

# Install dependencies
echo "Installing dependencies..."
sudo apt update
sudo apt install -y cmake flex bison

# Create temporary directory for downloading and building
TEMP_DIR=$(mktemp -d)
cd "${TEMP_DIR}"

# Download Doxygen
echo "Downloading Doxygen ${DOXYGEN_VERSION}..."
wget "${DOXYGEN_URL}" || {
    echo "Error: Failed to download Doxygen ${DOXYGEN_VERSION}. Check if the version is correct or the URL is accessible."
    exit 1
}

# Extract the tarball
echo "Extracting Doxygen..."
tar -xzf "${DOXYGEN_TAR}"

# Build and install Doxygen
cd "doxygen-${DOXYGEN_VERSION}"
mkdir build
cd build
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" ..
make
make install

# Clean up
cd "${TEMP_DIR}"
cd ..
rm -rf "${TEMP_DIR}"

echo "Doxygen installed successfully to ${INSTALL_DIR}"