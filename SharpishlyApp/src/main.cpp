#include "Router.h"
#include "HttpServer.h"
#include "Controller/HomeController.h"
#include <iostream>
#include <vector>
#include <string>

int main() {
    Router router;

    // Register route -> controller
    router.addRoute("/home/index", [](const std::vector<std::string>& params) {
        return HomeController::index();
    });

    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}

