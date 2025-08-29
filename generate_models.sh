#!/bin/bash
set -e

MODEL_DIR="src/model"

mkdir -p "$MODEL_DIR"

# --- CertManager ---
cat > "$MODEL_DIR/CertManager.h" <<'EOF'
#ifndef CERTMANAGER_H
#define CERTMANAGER_H

#include <string>

class CertManager {
public:
    static void generateCert(const std::string &domain, const std::string &outputDir);
};

#endif
EOF

cat > "$MODEL_DIR/CertManager.cpp" <<'EOF'
#include "CertManager.h"
#include <iostream>

void CertManager::generateCert(const std::string &domain, const std::string &outputDir) {
    std::cout << "🔒 (stub) Generate certificate for " << domain
              << " into " << outputDir << std::endl;
}
EOF

# --- DockerManager ---
cat > "$MODEL_DIR/DockerManager.h" <<'EOF'
#ifndef DOCKERMANAGER_H
#define DOCKERMANAGER_H

#include <string>

class DockerManager {
public:
    static void cleanup();
    static std::string status();
};

#endif
EOF

cat > "$MODEL_DIR/DockerManager.cpp" <<'EOF'
#include "DockerManager.h"
#include <iostream>

void DockerManager::cleanup() {
    std::cout << "🧹 (stub) Cleaning up Docker resources..." << std::endl;
}

std::string DockerManager::status() {
    return "📦 (stub) Docker status OK\n";
}
EOF

# --- GitManager ---
cat > "$MODEL_DIR/GitManager.h" <<'EOF'
#ifndef GITMANAGER_H
#define GITMANAGER_H

class GitManager {
public:
    static void updateRepo();
};

#endif
EOF

cat > "$MODEL_DIR/GitManager.cpp" <<'EOF'
#include "GitManager.h"
#include <iostream>

void GitManager::updateRepo() {
    std::cout << "📂 (stub) Updating repository..." << std::endl;
}
EOF

echo "✅ Stub model classes generated in $MODEL_DIR"
