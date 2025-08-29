#include "DockerManager.h"
#include <iostream>

void DockerManager::cleanup() {
    std::cout << "🧹 (stub) Cleaning up Docker resources..." << std::endl;
}

std::string DockerManager::status() {
    return "📦 (stub) Docker status OK\n";
}
