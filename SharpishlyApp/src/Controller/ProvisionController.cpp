#include "ProvisionController.h"
#include <fstream>
#include <iostream>
#include <sstream>
#include <cstdlib>
#include <filesystem>

namespace fs = std::filesystem;

bool ProvisionController::copyFile(const std::string& src, const std::string& dest) {
    try {
        fs::copy_file(src, dest, fs::copy_options::overwrite_existing);
        return true;
    } catch (const fs::filesystem_error& e) {
        std::cerr << "Error copying file from " << src << " to " << dest
                  << ": " << e.what() << std::endl;
        return false;
    }
}

std::string ProvisionController::runCommand(const std::string& cmd) {
    std::array<char, 128> buffer;
    std::string result;
    FILE* pipe = popen(cmd.c_str(), "r");
    if (!pipe) return "Failed to run command: " + cmd;

    while (fgets(buffer.data(), buffer.size(), pipe) != nullptr) {
        result += buffer.data();
    }
    pclose(pipe);
    return result;
}

std::string ProvisionController::provisionLocal() {
    std::ostringstream log;

    log << "<html><body><h1>Provisioning Local Environment</h1><pre>";

    if (!copyFile("docker/local-docker-compose.yml", "docker-compose.yml"))
        return "<html><body><h1>Error</h1><p>Failed to copy local-docker-compose.yml</p></body></html>";

    if (!copyFile("docker/local-Dockerfile", "Dockerfile"))
        return "<html><body><h1>Error</h1><p>Failed to copy local-Dockerfile</p></body></html>";

    if (!copyFile("docker/index.html", "index.html"))
        return "<html><body><h1>Error</h1><p>Failed to copy local index.html</p></body></html>";

    log << "Running docker-compose up -d...\n";
    log << runCommand("docker-compose up -d");

    log << "</pre><p>✅ Local environment provisioned successfully.</p></body></html>";
    return log.str();
}

std::string ProvisionController::provisionProduction() {
    std::ostringstream log;

    log << "<html><body><h1>Provisioning Production Environment</h1><pre>";

    if (!copyFile("docker/production-docker-compose.yml", "docker-compose.yml"))
        return "<html><body><h1>Error</h1><p>Failed to copy production-docker-compose.yml</p></body></html>";

    if (!copyFile("docker/production-Dockerfile", "Dockerfile"))
        return "<html><body><h1>Error</h1><p>Failed to copy production-Dockerfile</p></body></html>";

    log << "Running docker-compose up -d...\n";
    log << runCommand("docker-compose up -d");

    log << "</pre><p>✅ Production environment provisioned successfully.</p></body></html>";
    return log.str();
}
