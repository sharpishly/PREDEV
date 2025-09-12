#!/bin/bash
# ==========================================================
# Scaffold Controller + Model + View for SharpishlyApp
# Usage: ./scaffold_mvc.sh Penetration
# Creates/overwrites Controller, Model, and View files,
# updates CMake, and adds include + route to main.cpp.
# ==========================================================

set -e

if [ -z "$1" ]; then
  echo "❌ Usage: $0 <Name> (e.g., Penetration)"
  exit 1
fi

NAME="$1"
NAME_LOWER=$(echo "$NAME" | tr '[:upper:]' '[:lower:]')
PROJECT_ROOT="$(dirname "$(realpath "$0")")/SharpishlyApp"

SRC_DIR="$PROJECT_ROOT/src"
CONTROLLER_DIR="$SRC_DIR/Controller"
MODEL_DIR="$SRC_DIR/Model"
VIEW_DIR="$SRC_DIR/View/www/$NAME_LOWER"
MAIN_CPP="$SRC_DIR/main.cpp"
CMAKE_FILE="$PROJECT_ROOT/CMakeLists.txt"

# --- 1. Create/overwrite Controller files ---
CONTROLLER_H="$CONTROLLER_DIR/${NAME}Controller.h"
CONTROLLER_CPP="$CONTROLLER_DIR/${NAME}Controller.cpp"

cat > "$CONTROLLER_H" <<EOF
#pragma once
#include <string>
#include "../Model/${NAME}Model.h"

class ${NAME}Controller {
public:
    static std::string index();
};
EOF
echo "✅ Wrote $CONTROLLER_H"

cat > "$CONTROLLER_CPP" <<EOF
#include "${NAME}Controller.h"
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

std::string ${NAME}Controller::index() {
    const std::string basePath = "../src/View/www/${NAME_LOWER}/";

    std::string header = readFile(basePath + "partials/header.html");
    std::string body   = readFile(basePath + "index.html");
    std::string footer = readFile(basePath + "partials/footer.html");

    return header + body + footer;
}
EOF
echo "✅ Wrote $CONTROLLER_CPP"

# --- 2. Create/overwrite Model files ---
MODEL_H="$MODEL_DIR/${NAME}Model.h"
MODEL_CPP="$MODEL_DIR/${NAME}Model.cpp"

cat > "$MODEL_H" <<EOF
#pragma once
#include <string>

class ${NAME}Model {
public:
    static std::string info();
};
EOF
echo "✅ Wrote $MODEL_H"

cat > "$MODEL_CPP" <<EOF
#include "${NAME}Model.h"

std::string ${NAME}Model::info() {
    return "<!-- ${NAME} Model active -->";
}
EOF
echo "✅ Wrote $MODEL_CPP"

# --- 3. Create basic View structure ---
mkdir -p "$VIEW_DIR/css" "$VIEW_DIR/js" "$VIEW_DIR/partials"

cat > "$VIEW_DIR/index.html" <<EOF
<h1>${NAME} Page</h1>
<p>Welcome to the ${NAME}Controller view.</p>
EOF

cat > "$VIEW_DIR/css/style.css" <<EOF
body { font-family: Arial, sans-serif; margin: 20px; }
h1 { color: darkred; }
EOF

cat > "$VIEW_DIR/js/app.js" <<EOF
console.log("${NAME} view loaded");
EOF

cat > "$VIEW_DIR/partials/header.html" <<EOF
<!DOCTYPE html>
<html>
<head>
    <title>${NAME} - SharpishlyApp</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<header>
    <h2>${NAME} Module</h2>
</header>
EOF

cat > "$VIEW_DIR/partials/footer.html" <<EOF
<footer>
    <p>&copy; 2025 SharpishlyApp</p>
</footer>
</body>
</html>
EOF

echo "✅ Created View structure in $VIEW_DIR"

# --- 4. Ensure Controller.cpp + Model.cpp are in CMakeLists.txt ---
if ! grep -q "src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"; then
  sed -i "/add_executable(SharpishlyApp/a\    src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"
  echo "✅ Updated $CMAKE_FILE with ${NAME}Controller.cpp"
fi

if ! grep -q "src/Model/${NAME}Model.cpp" "$CMAKE_FILE"; then
  sed -i "/add_executable(SharpishlyApp/a\    src/Model/${NAME}Model.cpp" "$CMAKE_FILE"
  echo "✅ Updated $CMAKE_FILE with ${NAME}Model.cpp"
fi

# --- 5. Ensure include in main.cpp ---
if ! grep -q "#include \"${NAME}Controller.h\"" "$MAIN_CPP"; then
  sed -i "/#include/a #include \"${NAME}Controller.h\"" "$MAIN_CPP"
  echo "✅ Added include for ${NAME}Controller.h to main.cpp"
fi

# --- 6. Add route to main.cpp ---
if ! grep -q "/${NAME_LOWER}/index" "$MAIN_CPP"; then
  sed -i "/router.addRoute/a\    router.addRoute(\"/${NAME_LOWER}/index\", [](const std::vector<std::string>& params) { return ${NAME}Controller::index(); });" "$MAIN_CPP"
  echo "✅ Added route '/${NAME_LOWER}/index' to main.cpp"
fi

echo "🎉 Controller + Model + View scaffold for $NAME complete!"
