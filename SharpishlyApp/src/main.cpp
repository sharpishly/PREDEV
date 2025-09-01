#include "Router.h"
#include "Controller/HomeController.h"

int main() {
    Router router;

    // Static route
    router.addRoute("home/index", [](const std::vector<std::string>& params) {
        HomeController hc;
        return hc.index(params);
    });

    // Dynamic route
    router.addRoute("user/{id}", [](const std::vector<std::string>& params) {
        return "<html><body><h1>User Profile</h1><p>User ID: " + params[0] + "</p></body></html>";
    });

    router.addRoute("post/{category}/{slug}", [](const std::vector<std::string>& params) {
        return "<html><body><h1>Post</h1><p>Category: " + params[0] + "<br>Slug: " + params[1] + "</p></body></html>";
    });

    // TODO: Pass router to HttpServer
}
