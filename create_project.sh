#!/bin/bash

# ============================
# Script: create_project.sh
# Purpose: Scaffold a pure C++ MVC project (no third-party libraries)
# ============================

PROJECT_NAME="SharpishlyApp"
SRC_DIR="$PROJECT_NAME/src"
MODEL_DIR="$SRC_DIR/Model"
VIEW_DIR="$SRC_DIR/View"
CONTROLLER_DIR="$SRC_DIR/Controller"
INCLUDE_DIR="$PROJECT_NAME/include"
CERTS_DIR="$PROJECT_NAME/certs"
BUILD_DIR="$PROJECT_NAME/build"

# --- Step 1: Create directory structure ---
echo "Creating project directories..."
mkdir -p "$MODEL_DIR" "$VIEW_DIR" "$CONTROLLER_DIR" "$INCLUDE_DIR" "$CERTS_DIR" "$BUILD_DIR"

# --- Step 2: Create AppConfig.h ---
CONFIG_H="$INCLUDE_DIR/AppConfig.h"
cat > "$CONFIG_H" << 'EOF'
#pragma once
#include <string>
#include <vector>

struct AppConfig {
    std::string certsDir = "certs";
    std::string crtFile = "certs/sharpishly.dev.crt";
    std::string keyFile = "certs/sharpishly.dev.key";
    std::string domain = "sharpishly.dev";
    std::vector<std::string> hostnames = {
        "sharpishly.dev", "dev.sharpishly.dev",
        "docs.sharpishly.dev", "live.sharpishly.dev",
        "py.sharpishly.dev"
    };
};
EOF

# --- Step 3: Create AppController.h ---
CONTROLLER_H="$INCLUDE_DIR/AppController.h"
cat > "$CONTROLLER_H" << 'EOF'
#pragma once
#include "AppConfig.h"
#include <filesystem>
#include <cstdlib>
#include <fstream>
#include <iostream>

namespace fs = std::filesystem;

class AppController {
public:
    AppController(AppConfig cfg) : config(cfg) {}

    bool generateSSL() {
        if (!fs::exists(config.certsDir)) fs::create_directory(config.certsDir);

        if (fs::exists(config.crtFile) && fs::exists(config.keyFile)) {
            std::cout << "Certificate and key already exist." << std::endl;
            return true;
        }

        std::string cmd = "openssl req -x509 -newkey rsa:4096 "
                          "-keyout " + config.keyFile +
                          " -out " + config.crtFile +
                          "-days 365 -nodes "
                          "-subj \"/C=US/ST=California/L=Mountain View/O=Self-Signed/CN=" + config.domain + "\"";

        return system(cmd.c_str()) == 0;
    }

    void updateHosts() {
        std::ofstream hosts("/etc/hosts", std::ios::app);
        for (auto &h : config.hostnames) {
            hosts << "127.0.0.1 " << h << "\n";
        }
    }

    void runDockerCompose(const std::string& action) {
        system(("docker compose " + action).c_str());
    }

    void printStatus(const std::string& message) {
        std::cout << "[STATUS] " << message << std::endl;
    }

private:
    AppConfig config;
};
EOF

# --- Step 4: Create placeholder Model, View, Controller files ---
cat > "$MODEL_DIR/Model.h" << 'EOF'
#pragma once
#include <string>

class Model {
public:
    Model() = default;
    // Business logic here
};
EOF

cat > "$VIEW_DIR/View.h" << 'EOF'
#pragma once
#include <string>
#include <iostream>

class View {
public:
    View() = default;
    void showMessage(const std::string& msg) {
        std::cout << "[VIEW] " << msg << std::endl;
    }
};
EOF

cat > "$CONTROLLER_DIR/Controller.h" << 'EOF'
#pragma once
#include "Model.h"
#include "View.h"

class Controller {
public:
    Controller(Model& m, View& v) : model(m), view(v) {}
    void run() {
        view.showMessage("Controller is running");
    }
private:
    Model& model;
    View& view;
};
EOF

# --- Step 5: Create main.cpp ---
MAIN_CPP="$SRC_DIR/main.cpp"
cat > "$MAIN_CPP" << 'EOF'
#include "AppController.h"
#include "AppConfig.h"
#include "Model.h"
#include "View.h"
#include "Controller.h"
#include <iostream>

int main() {
    AppConfig config;
    AppController appCtrl(config);

    appCtrl.printStatus("Generating SSL certificate...");
    appCtrl.generateSSL();

    appCtrl.printStatus("Updating hosts...");
    appCtrl.updateHosts();

    Model model;
    View view;
    Controller controller(model, view);
    controller.run();

    appCtrl.printStatus("Starting Docker containers...");
    appCtrl.runDockerCompose("up -d");

    return 0;
}
EOF

# --- Step 6: Create CMakeLists.txt ---
CMAKE_FILE="$PROJECT_NAME/CMakeLists.txt"
cat > "$CMAKE_FILE" << 'EOF'
cmake_minimum_required(VERSION 3.10)
project(SharpishlyApp)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include_directories(include src/Model src/View src/Controller)

file(GLOB SOURCES "src/*.cpp")

add_executable(SharpishlyApp ${SOURCES})
EOF

# --- Step 7: Finish ---
echo "✅ Pure C++ MVC project $PROJECT_NAME created successfully!"
echo ""
echo "Structure:"
tree "$PROJECT_NAME"

echo ""
echo "Next steps:"
echo "1. Build the project:"
echo "   cd $PROJECT_NAME/build"
echo "   cmake .."
echo "   make"
echo "2. Run the project:"
echo "   ./SharpishlyApp"
