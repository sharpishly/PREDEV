cmake_minimum_required(VERSION 3.10)
project(SharpishlyDevManager)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Add all source files
file(GLOB_RECURSE SRC_FILES
    src/*.cpp
    src/controller/*.cpp
    src/model/*.cpp
    src/view/*.cpp
)

add_executable(sharpishly ${SRC_FILES})

# Include directories
target_include_directories(sharpishly PRIVATE
    src
    src/controller
    src/model
    src/view
)
