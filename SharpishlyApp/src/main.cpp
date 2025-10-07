#include "Core/Router.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "Core/HttpServer.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "Controller/AboutController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "Controller/HomeController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "Controller/DocsController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "Controller/ProvisionController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include <iostream>
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include <vector>
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include <string>
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"
#include "PenetrationController.h"
#include "responsiveController.h"
#include "GameController.h"
#include "responsiveController.h"

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
    router.addRoute("/responsive/index", [](const std::vector<std::string>& params) { return responsiveController::index(); });
        router.addRoute("/game/index", [](const std::vector<std::string>& params) { return GameController::index(); });
    router.addRoute("/responsive/index", [](const std::vector<std::string>& params) { return responsiveController::index(); });
        router.addRoute("/penetration/index", [](const std::vector<std::string>& params) { return PenetrationController::index(); });
    router.addRoute("/responsive/index", [](const std::vector<std::string>& params) { return responsiveController::index(); });
        // Testing async call end point
        router.addRoute("/game/test", [](const std::vector<std::string>& params) { return GameController::test(); });
    router.addRoute("/responsive/index", [](const std::vector<std::string>& params) { return responsiveController::index(); });
    }
}

int main() {
    //@TODO: Add loop within function
    Router router;
    registerRoutes(router);

    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}
