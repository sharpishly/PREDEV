// src/Model/ProvisionModel.cpp
#include "ProvisionModel.h"
#include <cstdlib>
#include <filesystem>
#include <iostream>

namespace fs = std::filesystem;

bool ProvisionModel::ensureOpenSSL() {
    int ret = system("command -v openssl > /dev/null 2>&1");
    if (ret != 0) {
        std::cerr << "OpenSSL is not installed. Please install manually.\n";
        return false;
    }
    std::cout << "OpenSSL is installed ✅\n";
    return true;
}

bool ProvisionModel::generateSelfSignedCert(const std::string& domain,
                                            const std::string& certDir,
                                            const std::string& crtFile,
                                            const std::string& keyFile) {
    fs::create_directories(certDir);

    if (fs::exists(crtFile) && fs::exists(keyFile)) {
        std::cout << "Certificate and key already exist, skipping.\n";
        return true;
    }

    std::string cmd =
        "openssl req -x509 -newkey rsa:4096 -keyout " + keyFile +
        " -out " + crtFile +
        " -days 365 -nodes -subj \"/C=US/ST=California/L=Mountain View/O=Self-Signed/CN=" + domain + "\"";

    int ret = system(cmd.c_str());
    if (ret == 0) {
        std::cout << "Certificate created at " << crtFile << " and " << keyFile << "\n";
        return true;
    } else {
        std::cerr << "Error creating certificate.\n";
        return false;
    }
}

void ProvisionModel::cleanupDocker() {
    system("docker compose down -v --remove-orphans");
    system("docker ps -q | xargs -r docker stop");
    system("docker ps -aq | xargs -r docker rm -f");
    system("docker images -f \"dangling=true\" -q | xargs -r docker rmi -f");
    system("docker volume ls -q | xargs -r docker volume rm -f");
    system("docker network prune -f");
    std::cout << "Docker cleanup complete ✅\n";
}

void ProvisionModel::rebuildDockerStack() {
    system("docker compose down -v");
    system("docker compose build --no-cache");
    system("docker compose up -d");
    std::cout << "Docker stack rebuilt ✅\n";
}

void ProvisionModel::setupNginxConfig(const std::string& sourceDir,
                                      const std::string& targetDir) {
    std::string cmd = "sudo rm -rf " + targetDir + " && sudo cp -R " + sourceDir + " " + targetDir;
    system(cmd.c_str());
    std::cout << "Nginx config copied ✅\n";
}

void ProvisionModel::setupDockerCompose(const std::string& sourceFile,
                                        const std::string& targetFile) {
    std::string cmd = "sudo cp " + sourceFile + " " + targetFile;
    system(cmd.c_str());
    std::cout << "docker-compose.yml updated ✅\n";
}

void ProvisionModel::setFolderPermissions(const std::string& path,
                                          const std::string& user,
                                          const std::string& group) {
    std::string cmd = "sudo chown -R " + user + ":" + group + " " + path;
    system(cmd.c_str());
    system(("sudo find " + path + " -type d -exec chmod 755 {} \\;").c_str());
    system(("sudo find " + path + " -type f -exec chmod 644 {} \\;").c_str());
    std::cout << "Permissions set ✅\n";
}

void ProvisionModel::allowPorts() {
    system("sudo ufw allow 80");
    system("sudo ufw allow 443");
    system("sudo ufw reload");
    std::cout << "Firewall rules updated ✅\n";
}

void ProvisionModel::addHostnames(const std::vector<std::string>& hostnames,
                                  const std::string& hostsFile) {
    for (const auto& host : hostnames) {
        std::string cmd = "grep -q \"" + host + "\" " + hostsFile +
                          " || echo \"127.0.0.1 " + host + "\" | sudo tee -a " + hostsFile;
        system(cmd.c_str());
    }
    std::cout << "Hostnames updated ✅\n";
}

void ProvisionModel::checkPort80() {
    system("sudo ss -tulnp | grep ':80' || echo \"Port 80 is free ✅\"");
}

void ProvisionModel::dockerStatus() {
    system("docker ps -a");
}
