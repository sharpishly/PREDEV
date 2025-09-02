#ifndef PREFLIGHT_CONTROLLER_H
#define PREFLIGHT_CONTROLLER_H

#include <string>

class PreflightController {
public:
    PreflightController();
    bool setupDocker();

private:
    bool checkDockerInstalled();
    bool checkDockerComposeInstalled();
    bool checkFileExists(const std::string& filePath);
};

#endif // PREFLIGHT_CONTROLLER_H