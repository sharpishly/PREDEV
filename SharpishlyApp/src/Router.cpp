#include "Router.h"
#include "Controller/HomeController.h"
#include <sstream>
#include <algorithm>

std::vector<std::string> Router::split(const std::string& str, char delimiter) {
    std::vector<std::string> tokens;
    std::stringstream ss(str);
    std::string item;
    while (std::getline(ss, item, delimiter)) {
        if (!item.empty()) tokens.push_back(item);
    }
    return tokens;
}

std::string Router::route(const std::string& uri) {
    // Example: /home/index/123
    auto parts = split(uri, '/');

    if (parts.empty()) {
        return "<html><body><h1>Welcome</h1><p>Default route</p></body></html>";
    }

    std::string controller = parts.size() > 0 ? parts[0] : "home";
    std::string action     = parts.size() > 1 ? parts[1] : "index";
    std::vector<std::string> params(parts.begin() + 2, parts.end());

    if (controller == "home") {
        HomeController hc;
        return hc.dispatch(action, params);
    }

    return "<html><body><h1>404 Not Found</h1><p>No controller found for: " + controller + "</p></body></html>";
}
