cmake_minimum_required(VERSION 3.10)
project(SharpishlyApp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include src/Model src/View src/Controller)

file(GLOB SOURCES "src/*.cpp")

add_executable(SharpishlyApp ${SOURCES})
