#include "PenetrationController.h"
#include <fstream>
#include <sstream>
#include <iostream>

static std::string readFile(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) {
        return "<!-- Missing: " + path + " -->";
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

std::string PenetrationController::index() {
    const std::string basePath = "../src/View/www/penetration/";

    std::string header = readFile(basePath + "partials/header.html");
    std::string body   = readFile(basePath + "index.html");
    std::string footer = readFile(basePath + "partials/footer.html");

    return header + body + footer;
}
