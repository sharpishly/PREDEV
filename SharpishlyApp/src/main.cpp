#include "Router.h"
#include "HttpServer.h"
#include <iostream>

int main() {
    Router router;
    HttpServer server("0.0.0.0", 1966, router);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}
