#include "HttpServer.h"
#include "Router.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>

HttpServer::HttpServer(const std::string& addr, int p, Router& r)
    : address(addr), port(p), running(false), router(r) {}

HttpServer::~HttpServer() {
    stop();
}

void HttpServer::start() {
    running = true;
    serverThread = std::thread(&HttpServer::run, this);
}

void HttpServer::stop() {
    running = false;
    if (serverThread.joinable()) {
        serverThread.join();
    }
}

std::string HttpServer::loadFile(const std::string& filepath) {
    std::ifstream file(filepath);
    if (!file.is_open()) {
        return "<html><body><h1>404 Not Found</h1></body></html>";
    }

    std::ostringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

void HttpServer::run() {
    int server_fd, new_socket;
    struct sockaddr_in address_struct;
    int opt = 1;
    int addrlen = sizeof(address_struct);

    // Create socket
    if ((server_fd = socket(AF_INET, SOCK_STREAM, 0)) == 0) {
        perror("socket failed");
        return;
    }

    // Allow address reuse
    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT, &opt, sizeof(opt))) {
        perror("setsockopt");
        close(server_fd);
        return;
    }

    address_struct.sin_family = AF_INET;
    address_struct.sin_addr.s_addr = inet_addr(address.c_str());
    address_struct.sin_port = htons(port);

    // Bind
    if (bind(server_fd, (struct sockaddr *)&address_struct, sizeof(address_struct)) < 0) {
        perror("bind failed");
        close(server_fd);
        return;
    }

    // Listen
    if (listen(server_fd, 10) < 0) {
        perror("listen");
        close(server_fd);
        return;
    }

    std::cout << "[HTTP Server] Listening on " << address << ":" << port << std::endl;

    char buffer[4096];

    while (running) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address_struct, (socklen_t*)&addrlen)) < 0) {
            perror("accept");
            continue;
        }

        memset(buffer, 0, sizeof(buffer));
        read(new_socket, buffer, sizeof(buffer) - 1);

        std::string request(buffer);

        // --- Extract requested path from "GET /path HTTP/1.1" ---
        std::string path = "/";
        std::istringstream reqStream(request);
        std::string method, uri, version;
        reqStream >> method >> uri >> version;

        if (method == "GET") {
            if (uri == "/") {
                uri = "home/index"; // Default route
            } else {
                if (uri[0] == '/') uri = uri.substr(1); // strip leading "/"
            }
            path = uri;
        }

        // --- Route request ---
        std::string body = router.route(path);

        std::string response =
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/html\r\n"
            "Content-Length: " + std::to_string(body.size()) + "\r\n"
            "Connection: close\r\n"
            "\r\n" +
            body;

        send(new_socket, response.c_str(), response.size(), 0);
        close(new_socket);
    }

    close(server_fd);
    std::cout << "[HTTP Server] Stopped." << std::endl;
}
