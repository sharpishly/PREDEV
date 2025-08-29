#!/bin/bash

# Debian/Ubuntu
sudo apt-get update
sudo apt-get install -y cmake build-essential

# Fedora
#sudo dnf install cmake make gcc-c++

# Arch
#sudo pacman -S cmake base-devel


# inside project root
sudo mkdir build && cd build
cmake ..
make
./sharpishly
