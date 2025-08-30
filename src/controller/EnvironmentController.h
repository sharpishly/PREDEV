#ifndef ENVIRONMENTCONTROLLER_H
#define ENVIRONMENTCONTROLLER_H
#include <string>
#include "model/EnvironmentManager.h"
class EnvironmentController {
public:
    std::string handleRequest(const std::string &route);
private:
    EnvironmentManager envManager_;
};
#endif
