#include "PostgresController.h"
#include <fstream>
#include <sstream>
#include <iostream>

// Utility: read HTML files
static std::string readFile(const std::string& path) {
    std::ifstream file(path);
    if (!file.is_open()) {
        return "<!-- Missing: " + path + " -->";
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}

// Route: /postgres/index
std::string PostgresController::index() {
    const std::string basePath = "../src/View/www/postgres/";

    std::string header = readFile(basePath + "partials/header.html");
    std::string body   = readFile(basePath + "index.html");
    std::string footer = readFile(basePath + "partials/footer.html");

    return header + body + footer;
}

// Route: /postgres/create
std::string PostgresController::create() {
    return "<h1>Postgres Create</h1><p>Stub for creating records.</p>";
}

// Route: /postgres/read
std::string PostgresController::read() {
    return "<h1>Postgres Read</h1><p>Stub for reading records.</p>";
}

// Route: /postgres/update
std::string PostgresController::update() {
    return "<h1>Postgres Update</h1><p>Stub for updating records.</p>";
}

// Route: /postgres/remove
std::string PostgresController::remove() {
    return "<h1>Postgres Delete</h1><p>Stub for deleting records.</p>";
}
