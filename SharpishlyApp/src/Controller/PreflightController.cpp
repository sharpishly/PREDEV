#include "PreflightController.h"
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <string>

PreflightController::PreflightController() {}

bool PreflightController::checkDockerInstalled() {
    // Check if Docker is installed by running 'docker --version'
    int result = std::system("docker --version > /dev/null 2>&1");
    if (result != 0) {
        std::cerr << "Error: Docker is not installed or not in PATH." << std::endl;
        return false;
    }
    return true;
}

bool PreflightController::checkDockerComposeInstalled() {
    // Check if Docker Compose is installed by running 'docker-compose --version'
    int result = std::system("docker-compose --version > /dev/null 2>&1");
    if (result != 0) {
        std::cerr << "Error: Docker Compose is not installed or not in PATH." << std::endl;
        return false;
    }
    return true;
}

bool PreflightController::checkFileExists(const std::string& filePath) {
    // Check if a file exists
    std::ifstream file(filePath);
    bool exists = file.good();
    if (!exists) {
        std::cerr << "Error: File " << filePath << " does not exist." << std::endl;
    }
    return exists;
}

bool PreflightController::setupDocker() {
    // Step 1: Verify prerequisites
    if (!checkDockerInstalled() || !checkDockerComposeInstalled()) {
        std::cerr << "Preflight check failed: Ensure Docker and Docker Compose are installed." << std::endl;
        return false;
    }

    // Step 2: Verify local Docker files
    const std::string dockerfilePath = "docker/local-Dockerfile";
    const std::string composeFilePath = "docker/local-docker-compose.yml";

    if (!checkFileExists(dockerfilePath) || !checkFileExists(composeFilePath)) {
        std::cerr << "Preflight check failed: Missing local Docker files." << std::endl;
        return false;
    }

    // Step 3: Build Docker image using local-Dockerfile
    std::cout << "Building Docker image from " << dockerfilePath << "..." << std::endl;
    std::string buildCommand = "docker build -f " + dockerfilePath + " -t sharpishlyapp-local .";
    int buildResult = std::system(buildCommand.c_str());
    if (buildResult != 0) {
        std::cerr << "Error: Failed to build Docker image." << std::endl;
        return false;
    }

    // Step 4: Start Docker containers using local-docker-compose.yml
    std::cout << "Starting Docker containers with " << composeFilePath << "..." << std::endl;
    std::string composeCommand = "docker-compose -f " + composeFilePath + " up -d";
    int composeResult = std::system(composeCommand.c_str());
    if (composeResult != 0) {
        std::cerr << "Error: Failed to start Docker containers." << std::endl;
        return false;
    }

    std::cout << "Docker setup completed successfully. Containers are running." << std::endl;
    return true;
}