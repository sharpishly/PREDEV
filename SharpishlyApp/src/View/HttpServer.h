#pragma once
#include <string>
#include <thread>
#include <atomic>

class HttpServer {
public:
    HttpServer(const std::string& address = "127.0.0.1", int port = 1966);
    ~HttpServer();

    // Start the server in a separate thread
    void start();

    // Stop the server
    void stop();

private:
    void run(); // server loop

    std::string address;
    int port;
    std::atomic<bool> running;
    std::thread serverThread;
};
