#ifndef ROUTER_H
#define ROUTER_H

#include <string>
#include <vector>

class Router {
public:
    std::string route(const std::string& uri);

private:
    std::vector<std::string> split(const std::string& str, char delimiter);
};

#endif // ROUTER_H
