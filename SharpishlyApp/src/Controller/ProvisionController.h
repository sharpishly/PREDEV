#ifndef PROVISIONCONTROLLER_H
#define PROVISIONCONTROLLER_H

#include <string>

class ProvisionController {
public:
    static std::string local();
    static std::string production();
};

#endif
