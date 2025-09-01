#pragma once
#include <string>
#include <thread>
#include "../Router.h"

class HttpServer {
public:
    HttpServer(const std::string& addr, int p, Router& r);
    ~HttpServer();

    void start();
    void stop();

private:
    std::string address;
    int port;
    bool running;
    std::thread serverThread;
    Router& router;

    void run();
    std::string loadFile(const std::string& filepath);
};
