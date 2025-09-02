#include "Router.h"
#include "HttpServer.h"
#include "Controller/HomeController.h"
#include <iostream>

int main() {
    Router router;

    // Register route -> controller
    router.addRoute("/home/index", []() {
        return HomeController::index();
    });

    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}
