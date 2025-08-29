#include "CertManager.h"
#include <iostream>
#include <cstdlib>
#include <filesystem>

void CertManager::generateCert(const std::string &domain, const std::string &outputDir) {
    namespace fs = std::filesystem;
    fs::create_directories(outputDir);

    std::string crt = outputDir + "/" + domain + ".crt";
    std::string key = outputDir + "/" + domain + ".key";

    if (fs::exists(crt) && fs::exists(key)) {
        std::cout << "Certificate already exists: " << crt << std::endl;
        return;
    }

    std::string cmd =
        "openssl req -x509 -newkey rsa:4096 -keyout " + key +
        " -out " + crt +
        " -days 365 -nodes -subj \"/C=US/ST=CA/L=MountainView/O=SelfSigned/CN=" + domain + "\"";

    int result = std::system(cmd.c_str());
    if (result == 0) {
        std::cout << "✅ SSL certificate generated for " << domain << std::endl;
    } else {
        std::cerr << "❌ Failed to generate SSL certificate" << std::endl;
    }
}

