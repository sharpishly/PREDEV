#include "HttpServer.h"
#include <external/httplib.h>   // single header HTTP library (cpp-httplib)
#include <iostream>

void HttpServer::start(int port) {
    httplib::Server svr;

    // Simple route
    svr.Get("/", [](const httplib::Request&, httplib::Response& res) {
        res.set_content("Hello from sharpishly!", "text/plain");
    });

    std::cout << "[HttpServer] Listening on port " << port << std::endl;

    // Block here until process is stopped
    svr.listen("0.0.0.0", port);
}
