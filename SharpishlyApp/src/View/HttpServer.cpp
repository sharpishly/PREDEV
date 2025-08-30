#include "HttpServer.h"
#include <iostream>
#include <cstring>
#include <unistd.h>
#include <netinet/in.h>
#include <arpa/inet.h>

HttpServer::HttpServer(const std::string& addr, int p)
    : address(addr), port(p), running(false) {}

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

        // Minimal HTTP response
        const char* response =
            "HTTP/1.1 200 OK\r\n"
            "Content-Type: text/plain\r\n"
            "Content-Length: 21\r\n"
            "\r\n"
            "Hello from C++ MVC!\n";

        send(new_socket, response, strlen(response), 0);
        close(new_socket);
    }

    close(server_fd);
    std::cout << "[HTTP Server] Stopped." << std::endl;
}
