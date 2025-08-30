
#!/bin/bash
# /**
#  * @file run.sh
#  * @brief Script to build and run the Sharpishly project
#  */
mkdir -p build || { echo "❌ Failed to create build directory"; exit 1; }
cd build || { echo "❌ Failed to enter build directory"; exit 1; }
cmake .. || { echo "❌ CMake configuration failed"; exit 1; }
make -j$(nproc) || { echo "❌ Build failed"; exit 1; }
./sharpishly || { echo "❌ Execution failed"; exit 1; }

