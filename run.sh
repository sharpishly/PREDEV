#!/bin/bash
set -e

# Go to project root (directory of this script)
cd "$(dirname "$0")"

# Create build directory if it doesn’t exist
mkdir -p build
cd build

# Run cmake pointing explicitly to project root (one level up from build)
cmake ..

# Compile
make -j$(nproc)

# Run
./sharpishly
