#include "Router.h"
#include <sstream>
#include <regex>
#include <iostream>

std::vector<std::string> Router::split(const std::string& str, char delimiter) {
    std::vector<std::string> tokens;
    std::stringstream ss(str);
    std::string item;
    while (std::getline(ss, item, delimiter)) {
        if (!item.empty()) tokens.push_back(item);
    }
    return tokens;
}

void Router::addRoute(const std::string& pattern, Handler handler) {
    routes.push_back({pattern, handler});
}

bool Router::match(const std::string& pattern, const std::string& uri, std::vector<std::string>& params) {
    // Special case for root
    if (pattern == "/" && (uri == "/" || uri.empty())) {
        params.clear();
        return true;
    }

    auto pParts = split(pattern, '/');
    auto uParts = split(uri, '/');

    if (pParts.size() != uParts.size()) {
        return false;
    }

    params.clear();
    for (size_t i = 0; i < pParts.size(); i++) {
        if (!pParts[i].empty() && pParts[i][0] == '{' && pParts[i].back() == '}') {
            // Dynamic param
            params.push_back(uParts[i]);
        } else if (pParts[i] != uParts[i]) {
            return false;
        }
    }
    return true;
}

std::string Router::route(const std::string& uri) {
    for (auto& [pattern, handler] : routes) {
        std::vector<std::string> params;
        if (match(pattern, uri, params)) {
            return handler(params);
        }
    }
    return "<html><body><h1>404 Not Found</h1><p>No route for: " + uri + "</p></body></html>";
}
