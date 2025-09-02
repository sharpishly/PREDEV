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
        std::cerr << "[HTTP Server] File not found: " << filepath << std::endl;
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

        // Handle static files and dynamic routes
        std::string body;
        std::string contentType = "text/html";
        std::string responseStatus = "HTTP/1.1 200 OK";

        // Base paths for static files (relative to project root, since executable runs from build/)
        const std::string wwwBasePath = "../src/View/www";
        const std::string appBasePath = "../src/View/home";

        if (uri == "/" || uri == "/index.html") {
            // Serve index.html from www/ for root path
            body = loadFile(wwwBasePath + "/index.html");
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else if (uri.find("/app/") == 0) {
            // Serve static files from src/View/home/ (e.g., /app/css/style.css, /app/index.html)
            std::string filepath = appBasePath + uri.substr(4); // Remove "/app" prefix
            if (uri.find(".css") != std::string::npos) {
                contentType = "text/css";
                body = loadFile(filepath);
            } else if (uri.find(".js") != std::string::npos) {
                contentType = "application/javascript";
                body = loadFile(filepath);
            } else if (uri == "/app" || uri == "/app/index.html") {
                body = loadFile(appBasePath + "/index.html");
            } else {
                body = "<html><body><h1>404 Not Found</h1></body></html>";
                responseStatus = "HTTP/1.1 404 Not Found";
            }
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else if (uri.find("/home/") == 0) {
            // Serve static files from src/View/www/home/ (e.g., /home/css/style.css, /home/index.html)
            std::string filepath = wwwBasePath + uri; // Keep "/home" in path
            if (uri.find(".css") != std::string::npos) {
                contentType = "text/css";
                body = loadFile(filepath);
            } else if (uri.find(".js") != std::string::npos) {
                contentType = "application/javascript";
                body = loadFile(filepath);
            } else if (uri == "/home" || uri == "/home/index.html") {
                body = loadFile(wwwBasePath + "/home/index.html");
            } else {
                body = "<html><body><h1>404 Not Found</h1></body></html>";
                responseStatus = "HTTP/1.1 404 Not Found";
            }
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else if (uri.find("/test/") == 0) {
            // Serve static files from src/View/www/test/ (e.g., /test/css/style.css, /test/index.html)
            std::string filepath = wwwBasePath + uri; // Keep "/test" in path
            if (uri.find(".css") != std::string::npos) {
                contentType = "text/css";
                body = loadFile(filepath);
            } else if (uri.find(".js") != std::string::npos) {
                contentType = "application/javascript";
                body = loadFile(filepath);
            } else if (uri == "/test" || uri == "/test/index.html") {
                body = loadFile(wwwBasePath + "/test/index.html");
            } else {
                body = "<html><body><h1>404 Not Found</h1></body></html>";
                responseStatus = "HTTP/1.1 404 Not Found";
            }
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else if (uri.find(".css") != std::string::npos) {
            // Serve CSS files from www/
            std::string filepath = wwwBasePath + uri;
            body = loadFile(filepath);
            contentType = "text/css";
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else if (uri.find(".js") != std::string::npos) {
            // Serve JS files from www/
            std::string filepath = wwwBasePath + uri;
            body = loadFile(filepath);
            contentType = "application/javascript";
            if (body.find("<html><body><h1>404 Not Found</h1></body></html>") != std::string::npos) {
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        } else {
            // Handle dynamic routes
            body = router.route(uri);
            if (body.empty()) {
                body = "<html><body><h1>404 Not Found</h1></body></html>";
                responseStatus = "HTTP/1.1 404 Not Found";
            }
        }

        // Construct HTTP response
        std::string response =
            responseStatus + "\r\n"
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