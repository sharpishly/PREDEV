#include <iostream>
#include "controller/AppController.h"
#include "controller/EnvironmentController.h"
#include "view/HttpServer.h"

int main() {
    try {
        // Controllers
        AppController appController;
        EnvironmentController envController;

        // Server
        HttpServer server(8080);

        // Routes
        server.addRoute("/", [&](const std::string& req) {
            return appController.handleRequest(req);
        });

        server.addRoute("/environments", [&](const std::string& req) {
            return envController.handleRequest(req);
        });

        std::cout << "🚀 Server running at http://localhost:8080" << std::endl;

        // Start loop
        server.start();

    } catch (const std::exception& e) {
        std::cerr << "❌ Fatal error: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
