#include "ProvisionController.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <cstdlib>
#include <cstdio>

// Copy file utility
bool ProvisionController::copyFile(const std::string& src, const std::string& dest) {
    std::ifstream in(src, std::ios::binary);
    if (!in.is_open()) {
        return false;
    }

    std::ofstream out(dest, std::ios::binary);
    if (!out.is_open()) {
        return false;
    }

    out << in.rdbuf();
    return true;
}

// Run shell command and capture output
std::string ProvisionController::runCommand(const std::string& cmd) {
    std::array<char, 128> buffer{};
    std::string result;

    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "Error: Failed to run command.";

    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) {
        result += buffer.data();
    }

    pclose(pipe);
    return result;
}

// Provision local Docker environment
std::string ProvisionController::provisionLocal() {
    std::stringstream response;

    if (!copyFile("docker/local-docker-compose.yml", "docker-compose.yml")) {
        return "<h1>Error:</h1><p>Failed to copy local-docker-compose.yml</p>";
    }

    if (!copyFile("docker/local-Dockerfile", "Dockerfile")) {
        return "<h1>Error:</h1><p>Failed to copy local-Dockerfile</p>";
    }

    if (!copyFile("docker/local-index.html", "index.html")) {
        return "<h1>Error:</h1><p>Failed to copy local-index.html</p>";
    }

    std::string output = runCommand("docker-compose up -d");
    response << "<h1>Local Provisioning</h1><pre>" << output << "</pre>";

    return response.str();
}

// Provision production Docker environment
std::string ProvisionController::provisionProduction() {
    std::stringstream response;

    if (!copyFile("docker/prod-docker-compose.yml", "docker-compose.yml")) {
        return "<h1>Error:</h1><p>Failed to copy prod-docker-compose.yml</p>";
    }

    if (!copyFile("docker/prod-Dockerfile", "Dockerfile")) {
        return "<h1>Error:</h1><p>Failed to copy prod-Dockerfile</p>";
    }

    if (!copyFile("docker/prod-index.html", "index.html")) {
        return "<h1>Error:</h1><p>Failed to copy prod-index.html</p>";
    }

    std::string output = runCommand("docker-compose up -d");
    response << "<h1>Production Provisioning</h1><pre>" << output << "</pre>";

    return response.str();
}
