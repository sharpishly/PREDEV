#include "HttpServer.h"
#include <iostream>
#include <thread>
#include <chrono>

HttpServer::HttpServer(int port) : port(port) {}

void HttpServer::addRoute(const std::string& path, Handler handler) {
    routes[path] = handler;
}

void HttpServer::start() {
    std::cout << "📡 Simulated HTTP Server running on port " << port << std::endl;
    std::cout << "Try hitting '/' or '/environments'" << std::endl;

    // Fake loop (replace with real sockets later)
    while (true) {
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << "Server heartbeat..." << std::endl;
    }
}
