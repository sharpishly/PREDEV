
# /**
#  * @file CMakeLists.txt
#  * @brief CMake configuration for the Sharpishly project
#  */
cmake_minimum_required(VERSION 3.10)
project(sharpishly)
set(CMAKE_CXX_STANDARD 17)
file(GLOB_RECURSE SOURCES src/*.cpp)
add_executable(sharpishly ${SOURCES})
target_include_directories(sharpishly PRIVATE src src/controller src/model)

