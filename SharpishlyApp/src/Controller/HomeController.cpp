#include "HomeController.h"
#include <fstream>
#include <sstream>
#include <iostream>

std::string HomeController::index() {
    std::ifstream file("src/View/home/index.html");
    if (!file.is_open()) {
        return "<html><body><h1>500 Internal Server Error</h1><p>Could not open view: home/index.html</p></body></html>";
    }

    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}
