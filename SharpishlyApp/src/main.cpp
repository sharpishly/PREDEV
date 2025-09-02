#include "Router.h"
#include "HttpServer.h"
#include "Controller/HomeController.h"
#include "Controller/AboutController.h"
#include <iostream>
#include <vector>
#include <string>

int main() {
    Router router;

    // Register route -> controller
    router.addRoute("/home/index", [](const std::vector<std::string>& params) {
        return HomeController::index();
    });

    // Register route -> controller
    router.addRoute("/about/index", [](const std::vector<std::string>& params) {
        return AboutController::index();
    });

    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}

