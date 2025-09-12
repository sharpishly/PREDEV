#!/bin/bash
# ==========================================================
# Scaffold Controller + Model for SharpishlyApp
# Usage: ./scaffold_mvc.sh Penetration
# Creates/overwrites Controller and Model files, updates CMake,
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
MODEL_DIR="$SRC_DIR/Model"
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

std::string ${NAME}Controller::index() {
    return ${NAME}Model::info();
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
    return "<html><body><h1>${NAME} Model active!</h1></body></html>";
}
EOF
echo "✅ Wrote $MODEL_CPP"

# --- 3. Ensure Controller.cpp + Model.cpp are in CMakeLists.txt ---
if ! grep -q "src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"; then
  sed -i "/add_executable(SharpishlyApp/a\    src/Controller/${NAME}Controller.cpp" "$CMAKE_FILE"
  echo "✅ Updated $CMAKE_FILE with ${NAME}Controller.cpp"
else
  echo "ℹ️ $CMAKE_FILE already includes ${NAME}Controller.cpp"
fi

if ! grep -q "src/Model/${NAME}Model.cpp" "$CMAKE_FILE"; then
  sed -i "/add_executable(SharpishlyApp/a\    src/Model/${NAME}Model.cpp" "$CMAKE_FILE"
  echo "✅ Updated $CMAKE_FILE with ${NAME}Model.cpp"
else
  echo "ℹ️ $CMAKE_FILE already includes ${NAME}Model.cpp"
fi

# --- 4. Ensure include in main.cpp ---
if ! grep -q "#include \"${NAME}Controller.h\"" "$MAIN_CPP"; then
  sed -i "/#include/a #include \"${NAME}Controller.h\"" "$MAIN_CPP"
  echo "✅ Added include for ${NAME}Controller.h to main.cpp"
else
  echo "ℹ️ main.cpp already includes ${NAME}Controller.h"
fi

# --- 5. Add route to main.cpp ---
if ! grep -q "/${NAME,,}/index" "$MAIN_CPP"; then
  sed -i "/router.addRoute/a\    router.addRoute(\"/${NAME,,}/index\", [](const std::vector<std::string>& params) { return ${NAME}Controller::index(); });" "$MAIN_CPP"
  echo "✅ Added route '/${NAME,,}/index' to main.cpp"
else
  echo "ℹ️ main.cpp already has route '/${NAME,,}/index'"
fi

echo "🎉 Controller + Model scaffold for $NAME complete!"
