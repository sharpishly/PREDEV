#pragma once
#include <string>
#include <vector>
#include <functional>
#include <unordered_map>

class Router {
public:
    using Handler = std::function<std::string(const std::vector<std::string>&)>;

    void addRoute(const std::string& pattern, Handler handler);
    std::string route(const std::string& uri);

private:
    std::vector<std::pair<std::string, Handler>> routes;

    std::vector<std::string> split(const std::string& str, char delimiter);
    bool match(const std::string& pattern, const std::string& uri, std::vector<std::string>& params);
};
