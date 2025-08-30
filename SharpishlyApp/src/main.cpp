#include <iostream>           // <-- Add this
#include "View/HttpServer.h"

int main() {
    HttpServer server("127.0.0.1", 1966);
    server.start();

    std::cout << "Press Enter to stop server..." << std::endl;
    std::cin.get();

    server.stop();
    return 0;
}
