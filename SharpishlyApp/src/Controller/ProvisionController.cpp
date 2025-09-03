#include "ProvisionController.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include <cstdlib>
#include <cstdio>
#include <array>

// Utility to copy files
static bool copyFile(const std::string& src, const std::string& dest) {
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

// Utility to run shell commands
static std::string runCommand(const std::string& cmd) {
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

// Route: /provision/local
std::string ProvisionController::local() {
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

// Route: /provision/production
std::string ProvisionController::production() {
    std::stringstream response;

    if (!copyFile("docker/production-docker-compose.yml", "docker-compose.yml")) {
        return "<h1>Error:</h1><p>Failed to copy production-docker-compose.yml</p>";
    }

    if (!copyFile("docker/production-Dockerfile", "Dockerfile")) {
        return "<h1>Error:</h1><p>Failed to copy production-Dockerfile</p>";
    }

    if (!copyFile("docker/production-index.html", "index.html")) {
        return "<h1>Error:</h1><p>Failed to copy production-index.html</p>";
    }

    std::string output = runCommand("docker-compose up -d");
    response << "<h1>Production Provisioning</h1><pre>" << output << "</pre>";

    return response.str();
}
