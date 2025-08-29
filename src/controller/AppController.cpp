#include "AppController.h"
#include <iostream>

std::string AppController::handleRequest(const std::string &route) {
    if (route == "/generate-cert") {
        // TODO: integrate CertManager
        return "✅ (stub) SSL certificate generation triggered\n";
    } else if (route == "/cleanup") {
        // TODO: integrate DockerManager
        return "🧹 (stub) Docker cleanup triggered\n";
    } else if (route == "/status") {
        // TODO: integrate DockerManager
        return "📦 (stub) Docker status requested\n";
    } else if (route == "/update-repo") {
        // TODO: integrate GitManager
        return "📂 (stub) Repo update triggered\n";
    }

    return "❌ Unknown route: " + route + "\n";
}
