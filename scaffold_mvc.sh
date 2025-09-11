#!/bin/bash
# ==========================================================
# Scaffold Controller for SharpishlyApp
# Usage: ./scaffold_controller.sh Penetration
# Creates/overwrites Controller files, updates CMake,
# and adds include + route to main.cpp.
# ==========================================================

set -e

if [ -z "$1" ]; then
  echo "❌ Usage: $0 <Name> (e.g., Penetration)"
  exit 1
fi

NAME="$1"
PROJECT_ROOT="$(dirname "$(realpath "$0")")/SharpishlyApp"

SRC_DIR="$PROJECT_ROOT/src"
CONTROLLER_DIR="$SRC_DIR/Controller"
MAIN_CPP="$SRC_DIR/main.cpp"
CMAKE_FILE="$PROJECT_ROOT/CMakeLists.txt"

# --- 1. Create/overwrite Controller files ---
CONTROLLER_H="$CONTROLLER_DIR/${NAME}Controller.h"
CONTROLLER_CPP="$CONTROLLER_DIR/${NAME}Controller.cpp"

cat > "$CONTROLLER_H" <<EOF
#pragma once
#include <string>

class ${NAME}Controller {
public:
    static std::string index();
};
EOF
echo "✅ Wrote $CONTROLLER_H"

cat > "$CONTROLLER_CPP" <<EOF
#include "${NAME}Controller.h"

std::string ${NAME}Controller::index() {
    return "<html><body><h1>${NAME} Controller active!</h1></body></html>";
}
EOF
echo "✅ Wrote $CONTROLLER_CPP"

# --- 2. Ensure Controller.cpp is in CMakeLists.txt ---
if ! grep -q "src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"; then
  sed -i "/add_executable(SharpishlyApp/a\    src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"
  echo "✅ Updated $CMAKE_FILE with ${NAME}Controller.cpp"
else
  echo "ℹ️ $CMAKE_FILE already includes ${NAME}Controller.cpp"
fi

# --- 3. Ensure include in main.cpp ---
if ! grep -q "#include \"${NAME}Controller.h\"" "$MAIN_CPP"; then
  sed -i "/#include/a #include \"${NAME}Controller.h\"" "$MAIN_CPP"
  echo "✅ Added include for ${NAME}Controller.h to main.cpp"
else
  echo "ℹ️ main.cpp already includes ${NAME}Controller.h"
fi

# --- 4. Add route to main.cpp ---
if ! grep -q "/${NAME,,}/index" "$MAIN_CPP"; then
  sed -i "/router.addRoute/a\    router.addRoute(\"/${NAME,,}/index\", [](const std::vector<std::string>& params) { return ${NAME}Controller::index(); });" "$MAIN_CPP"
  echo "✅ Added route '/${NAME,,}/index' to main.cpp"
else
  echo "ℹ️ main.cpp already has route '/${NAME,,}/index'"
fi

echo "🎉 Controller scaffold for $NAME complete (overwritten)!"
