#pragma once
#include <string>
#include <map>
#include <functional>

class HttpServer {
public:
    using Handler = std::function<std::string(const std::string&)>;

    explicit HttpServer(int port);
    void addRoute(const std::string& path, Handler handler);
    void start();

private:
    int port;
    std::map<std::string, Handler> routes;
};
