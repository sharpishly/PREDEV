#ifndef APPCONTROLLER_H
#define APPCONTROLLER_H

#include <string>

class AppController {
public:
    // Handle a request (route) and return response as string
    std::string handleRequest(const std::string &route);
};

#endif
