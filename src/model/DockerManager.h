#ifndef DOCKERMANAGER_H
#define DOCKERMANAGER_H

#include <string>

class DockerManager {
public:
    static void cleanup();
    static std::string status();
};

#endif
