#include <iostream>
#include "controller/AppController.h"
#include "controller/EnvironmentController.h"
#include "view/HttpServer.h"

int main() {
    try {
        // Create controllers
        AppController appController;
        EnvironmentController envController;

        // Create HTTP server
        HttpServer server(8080);

        // Register routes
        server.addRoute("/", [&](const std::string& req) {
            return appController.handleRequest(req);
        });

        server.addRoute("/environments", [&](const std::string& req) {
            return envController.handleRequest(req);
        });

        std::cout << "🚀 Server running on http://localhost:8080" << std::endl;

        // Start server loop
        server.start();

    } catch (const std::exception& e) {
        std::cerr << "❌ Fatal error: " << e.what() << std::endl;
        return 1;
    }

    return 0;
}
