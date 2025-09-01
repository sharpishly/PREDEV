#include "HomeController.h"

std::string HomeController::index() {
    return "<html><body><h1>Welcome to SharpishlyApp</h1><p>This is the home page.</p></body></html>";
}

std::string HomeController::about() {
    return "<html><body><h1>About</h1><p>SharpishlyApp is a minimal C++ MVC framework.</p></body></html>";
}

std::string HomeController::contact() {
    return "<html><body><h1>Contact</h1><p>Email: support@sharpishly.dev</p></body></html>";
}
