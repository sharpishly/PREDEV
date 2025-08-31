#ifndef HTTPSERVER_H
#define HTTPSERVER_H

#include <string>
#include <thread>
#include <atomic>

class HttpServer {
public:
    HttpServer(const std::string& addr, int port);
    ~HttpServer();

    void start();
    void stop();

private:
    void run();
    std::string loadFile(const std::string& filepath);

    std::string address;
    int port;
    std::atomic<bool> running;
    std::thread serverThread;
};

#endif
