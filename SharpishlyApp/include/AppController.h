#pragma once
#include "AppConfig.h"
#include <filesystem>
#include <cstdlib>
#include <fstream>
#include <iostream>

namespace fs = std::filesystem;

class AppController {
public:
    AppController(AppConfig cfg) : config(cfg) {}

    bool generateSSL() {
        if (!fs::exists(config.certsDir)) fs::create_directory(config.certsDir);

        if (fs::exists(config.crtFile) && fs::exists(config.keyFile)) {
            std::cout << "Certificate and key already exist." << std::endl;
            return true;
        }

        std::string cmd = "openssl req -x509 -newkey rsa:4096 "
                          "-keyout " + config.keyFile +
                          " -out " + config.crtFile +
                          "-days 365 -nodes "
                          "-subj \"/C=US/ST=California/L=Mountain View/O=Self-Signed/CN=" + config.domain + "\"";

        return system(cmd.c_str()) == 0;
    }

    void updateHosts() {
        std::ofstream hosts("/etc/hosts", std::ios::app);
        for (auto &h : config.hostnames) {
            hosts << "127.0.0.1 " << h << "\n";
        }
    }

    void runDockerCompose(const std::string& action) {
        system(("docker compose " + action).c_str());
    }

    void printStatus(const std::string& message) {
        std::cout << "[STATUS] " << message << std::endl;
    }

private:
    AppConfig config;
};
