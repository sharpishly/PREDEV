#include "HomeController.h"

std::string HomeController::dispatch(const std::string& action, const std::vector<std::string>& params) {
    if (action == "index") return index(params);
    if (action == "about") return about(params);

    return "<html><body><h1>404 Action Not Found</h1><p>No action: " + action + "</p></body></html>";
}

std::string HomeController::index(const std::vector<std::string>& params) {
    std::string response = "<html><body><h1>HomeController::index()</h1>";
    response += "<p>Parameters:</p><ul>";
    for (auto &p : params) {
        response += "<li>" + p + "</li>";
    }
    response += "</ul></body></html>";
    return response;
}

std::string HomeController::about(const std::vector<std::string>& params) {
    return "<html><body><h1>About SharpishlyApp</h1><p>This is the about page.</p></body></html>";
}
