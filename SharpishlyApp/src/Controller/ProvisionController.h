#ifndef PROVISIONCONTROLLER_H
#define PROVISIONCONTROLLER_H

#include <string>

class ProvisionController {
public:
    ProvisionController();

    // Utility functions
    bool copyFile(const std::string& src, const std::string& dest);
    std::string runCommand(const std::string& cmd);

    // Provisioning methods
    std::string provisionLocal();
    std::string provisionProduction();
};

#endif // PROVISIONCONTROLLER_H
