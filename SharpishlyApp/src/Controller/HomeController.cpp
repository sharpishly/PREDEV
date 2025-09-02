#include "HomeController.h"
#include <fstream>
#include <sstream>
#include <iostream>

static std::string loadFile(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) {
        return "<!-- Missing: " + path + " -->";
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

std::string HomeController::index() {
    std::string header = loadFile("src/View/home/partials/header.html");
    std::string content = loadFile("src/View/home/index.html");
    std::string footer = loadFile("src/View/home/partials/footer.html");

    return header + content + footer;
}
