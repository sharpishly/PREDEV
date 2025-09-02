#include "HttpServer.h"
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>

HttpServer::HttpServer(const std::string& addr, int p, Router& r)
    : address(addr), port(p), router(r), running(false) {}

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

    while (running) {
        if ((new_socket = accept(server_fd, (struct sockaddr *)&address_struct, (socklen_t*)&addrlen)) < 0) {
            perror("accept");
            continue;
        }

        char buffer[4096] = {0};
        int valread = read(new_socket, buffer, sizeof(buffer));
        if (valread <= 0) {
            close(new_socket);
            continue;
        }

        // Parse GET path
        std::string request(buffer);
        std::string uri = "/";
        size_t methodEnd = request.find(' ');
        if (methodEnd != std::string::npos) {
            size_t uriEnd = request.find(' ', methodEnd + 1);
            if (uriEnd != std::string::npos) {
                uri = request.substr(methodEnd + 1, uriEnd - methodEnd - 1);
            }
        }

        // Determine content type and load file
        std::string body;
        std::string contentType = "text/html";
        std::string filePath;
        // Temp fix /home/joe90/Documents/PREDEV/SharpishlyApp/src/View/www/home/css
        std::string basePath = "/home/joe90/Documents/PREDEV/SharpishlyApp/src/View/www";

        if (uri.find(".css") != std::string::npos) {
            filePath = basePath + uri; // Build file path
            std::cout << "[HTTP Server] CSS requested: " << uri << " -> " << filePath << std::endl;
            body = loadFile(filePath);
            contentType = "text/css";
        } else if (uri.find(".js") != std::string::npos) {
            filePath = basePath + uri;
            std::cout << "[HTTP Server] JS requested: " << uri << " -> " << filePath << std::endl;
            body = loadFile(filePath);
            contentType = "application/javascript";
        } else {
            std::cout << "[HTTP Server] Route requested: " << uri << std::endl;
            // Route HTML dynamically
            body = router.route(uri);
        }

        // Print final response size
        std::cout << "[HTTP Server] Response size: " << body.size() << " bytes" << std::endl;


        std::string response =
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: " + contentType + "\r\n"
            "Content-Length: " + std::to_string(body.size()) + "\r\n"
            "Connection: close\r\n"
            "\r\n" + body;

        send(new_socket, response.c_str(), response.size(), 0);
        close(new_socket);
    }

    close(server_fd);
    std::cout << "[HTTP Server] Stopped." << std::endl;
}
