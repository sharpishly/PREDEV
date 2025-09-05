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

    std::string output = runCommand("cd ../app && sudo chmod +x build.sh && ./build.sh");
    response << "<h1>Local Provisioning</h1><pre>" << output << "</pre>";

    return response.str();
}

// Route: /provision/production
std::string ProvisionController::production() {
    std::stringstream response;

    std::string output = runCommand("cd ../app && sudo chmod +x build.sh && ./build.sh");
    response << "<h1>Local Provisioning</h1><pre>" << output << "</pre>";

    return response.str();
}

