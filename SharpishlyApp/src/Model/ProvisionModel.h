#include "ProvisionModel.h"


bool ProvisionModel::generateCertificate(const std::string& domain,
                                         const std::string& certsDir) {
    namespace fs = std::filesystem;

    fs::create_directories(certsDir);
    std::string crtFile = certsDir + "/" + domain + ".crt";
    std::string keyFile = certsDir + "/" + domain + ".key";

    if (fs::exists(crtFile) && fs::exists(keyFile)) {
        std::cout << "[✔] Certificate already exists: " << crtFile << ", " << keyFile << "\n";
        return true;
    }

    std::string cmd =
        "openssl req -x509 -newkey rsa:4096 "
        "-keyout " + keyFile +
        " -out " + crtFile +
        " -days 365 -nodes "
        "-subj \"/C=US/ST=California/L=Mountain View/O=Self-Signed/CN=" + domain + "\"";

    std::cout << "[…] Generating SSL certificate for " << domain << "\n";
    int result = std::system(cmd.c_str());

    if (result == 0) {
        std::cout << "[✔] Certificate generated: " << crtFile << ", " << keyFile << "\n";
        return true;
    } else {
        std::cerr << "[✘] Failed to generate certificate for " << domain << "\n";
        return false;
    }
}

bool ProvisionModel::addHostnames(const std::vector<std::string>& hostnames,
                                  const std::string& hostsFile) {
    for (const auto& host : hostnames) {
        std::string checkCmd = "grep -q \"127.0.0.1 " + host + "\" " + hostsFile;
        if (std::system(checkCmd.c_str()) == 0) {
            std::cout << "[✔] Host already present: " << host << "\n";
        } else {
            std::string cmd = "echo \"127.0.0.1 " + host + "\" | sudo tee -a " + hostsFile + " > /dev/null";
            std::cout << "[…] Adding host: " << host << "\n";
            if (std::system(cmd.c_str()) == 0) {
                std::cout << "[✔] Added host: " << host << "\n";
            } else {
                std::cerr << "[✘] Failed to add host: " << host << "\n";
                return false;
            }
        }
    }
    return true;
}

bool ProvisionModel::dockerCleanup() {
    std::cout << "[…] Cleaning Docker resources\n";

    std::vector<std::string> cmds = {
        "docker compose down -v --remove-orphans",
        "docker ps -q | xargs -r docker stop",
        "docker ps -aq | xargs -r docker rm -f",
        "docker images -f \"dangling=true\" -q | xargs -r docker rmi -f",
        "docker volume ls -q | xargs -r docker volume rm -f",
        "docker network prune -f"
    };

    for (const auto& cmd : cmds) {
        std::cout << "   -> Running: " << cmd << "\n";
        if (std::system(cmd.c_str()) != 0) {
            std::cerr << "[✘] Command failed: " << cmd << "\n";
            return false;
        }
    }

    std::cout << "[✔] Docker cleanup complete\n";
    return true;
}

bool ProvisionModel::setupLocalConfigs() {
    std::cout << "[…] Setting up local configs\n";

    std::vector<std::string> cmds = {
        "sudo rm -rf nginx && sudo cp -R local-nginx/ nginx && sudo chown -R $USER:$USER nginx",
        "sudo rm -f docker-compose.yml && sudo cp local-docker-compose.yml docker-compose.yml && sudo chown $USER:$USER docker-compose.yml"
    };

    for (const auto& cmd : cmds) {
        std::cout << "   -> Running: " << cmd << "\n";
        if (std::system(cmd.c_str()) != 0) {
            std::cerr << "[✘] Command failed: " << cmd << "\n";
            return false;
        }
    }

    std::cout << "[✔] Local configs set up\n";
    return true;
}
