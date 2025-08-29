#include <iostream>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include "AppController.h"

int main() {
    int server_fd = socket(AF_INET, SOCK_STREAM, 0);
    sockaddr_in addr {AF_INET, htons(8080), INADDR_ANY};
    bind(server_fd, (sockaddr*)&addr, sizeof(addr));
    listen(server_fd, 10);

    std::cout << "Server running on http://localhost:8080\n";

    while (true) {
        int client = accept(server_fd, nullptr, nullptr);
        char buffer[1024] = {0};
        read(client, buffer, 1024);

        std::string req(buffer);
        std::string route = req.find("POST /") != std::string::npos
                          ? req.substr(req.find("POST /")+5, req.find(" HTTP")-req.find("POST /")-5)
                          : "index.html";

        AppController controller;
        std::string response;

        if (route == "index.html" || route == "/") {
            response = "<html><body><h1>Sharpishly Dev</h1></body></html>";
        } else {
            response = controller.handleRequest("/" + route);
        }

        std::string http = "HTTP/1.1 200 OK\r\nContent-Length: " + std::to_string(response.size()) + "\r\n\r\n" + response;
        send(client, http.c_str(), http.size(), 0);
        close(client);
    }
}
