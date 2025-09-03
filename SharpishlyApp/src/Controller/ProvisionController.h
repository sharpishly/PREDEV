#ifndef PROVISIONCONTROLLER_H
#define PROVISIONCONTROLLER_H

#include <string>

class ProvisionController {
public:
    static std::string local();        // /provision/local
    static std::string production();   // /provision/production
};

#endif
