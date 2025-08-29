#!/bin/bash

# inside project root
sudo mkdir build && cd build
cmake ..
make
./sharpishly
