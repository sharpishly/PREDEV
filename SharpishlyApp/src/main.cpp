#include "HttpServer.h"
#include "Router.h"
#include "Controller/HomeController.h"

int main() {
    Router router;

    // Example routes
    router.addRoute("home/index", [](const std::vector<std::string>& params) {
        HomeController hc;
        return hc.index(params);
    });

    router.addRoute("user/{id}", [](const std::vector<std::string>& params) {
        return "<h1>User Profile</h1><p>User ID: " + params[0] + "</p>";
    });

    router.addRoute("post/{category}/{slug}", [](const std::vector<std::string>& params) {
        return "<h1>Post</h1><p>Category: " + params[0] + "<br>Slug: " + params[1] + "</p>";
    });

    HttpServer server("127.0.0.1", 1966, router);
    server.start();

    std::cin.get(); // Keep running until Enter is pressed
    server.stop();
}
