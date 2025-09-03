#pragma once
#include <string>
#include <thread>
#include "Router.h"

class HttpServer {
public:
    HttpServer(const std::string& addr, int p, Router& r);
    ~HttpServer();

    void start();
    void stop();

private:
    void run();
    std::string loadFile(const std::string& filepath);

    std::string address;
    int port;
    bool running;
    std::thread serverThread;
    Router& router;
};
