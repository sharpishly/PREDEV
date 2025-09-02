#include "Router.h"
#include "HttpServer.h"
#include "Controller/AboutController.h"
#include "Controller/HomeController.h"
#include "Controller/DocsController.h"
#include <iostream>
#include <vector>
#include <string>

int main() {
    Router router;
    router.addRoute("/", [](const std::vector<std::string>& params) { return HomeController::index(); });
    router.addRoute("/home/index", [](const std::vector<std::string>& params) { return HomeController::index(); });
    router.addRoute("/about/index", [](const std::vector<std::string>& params) { return AboutController::index(); });
    router.addRoute("/docs/index", [](const std::vector<std::string>& params) { return DocsController::index(); });

    HttpServer server("0.0.0.0", 1966, router);
    server.start();
    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();
    server.stop();
    return 0;
}