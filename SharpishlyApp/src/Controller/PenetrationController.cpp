#include "PenetrationController.h"
#include <fstream>
#include <sstream>
#include <iostream>
#include "../Model/PenetrationModel.h"

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
    std::string body;

    // Example: call the model to produce a basic report for localhost
    std::string report = PenetrationModel::basicReport("127.0.0.1");
    // You can embed the report in a preformatted block
    std::ostringstream oss;
    oss << "<h1>Penetration Report</h1>\n";
    oss << "<pre style='white-space:pre-wrap; background:#111; color:#eee; padding:12px; border-radius:6px;'>";
    oss << report;
    oss << "</pre>\n";
    body = oss.str();

    std::string footer = readFile(basePath + "partials/footer.html");
    return header + body + footer;
}
