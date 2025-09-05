#include "Core/Router.h"
#include "Core/HttpServer.h"
#include "Controller/AboutController.h"
#include "Controller/HomeController.h"
#include "Controller/DocsController.h"
#include "Controller/ProvisionController.h"
#include <iostream>
#include <vector>
#include <string>

// New helper function to register all routes in one place
void registerRoutes(Router& router) {
    std::vector<std::pair<std::string, Router::Handler>> routes = {
        {"/", [](const std::vector<std::string>& params) { return HomeController::index(); }},
        {"/home/index", [](const std::vector<std::string>& params) { return HomeController::index(); }},
        {"/about/index", [](const std::vector<std::string>& params) { return AboutController::index(); }},
        {"/docs/index", [](const std::vector<std::string>& params) { return DocsController::index(); }},
        {"/provision/local", [](const std::vector<std::string>& params) { return ProvisionController::local(); }},
        {"/provision/production", [](const std::vector<std::string>& params) { return ProvisionController::production(); }}
    };

    for (auto& [path, handler] : routes) {
        router.addRoute(path, handler);
    }
}

int main() {
    Router router;
    registerRoutes(router);

    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}
