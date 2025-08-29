#ifndef CERTMANAGER_H
#define CERTMANAGER_H

#include <string>

class CertManager {
public:
    static void generateCert(const std::string &domain, const std::string &outputDir);
};

#endif
