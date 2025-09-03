#ifndef PROVISIONCONTROLLER_H
#define PROVISIONCONTROLLER_H

#include <string>

class ProvisionController {
public:
    ProvisionController();

    // Preflight checks
    bool checkDockerInstalled();
    bool checkDockerComposeInstalled();
    bool checkFileExists(const std::string& filePath);

    // Setup methods
    bool setupDocker();
    bool switchToProduction();
};

#endif // PROVISIONCONTROLLER_H
