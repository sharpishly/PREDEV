#include "AppController.h"
#include "../view/HttpServer.h"
#include <iostream>

void AppController::start() {
    std::cout << "[AppController] Starting application..." << std::endl;

    HttpServer server;
    server.start(8080); // bind to localhost:8080
}
