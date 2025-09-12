#!/bin/bash
# ==========================================================
# Delete Scaffolded MVC components for SharpishlyApp
# Usage: ./delete_scaffold_mvc.sh Penetration
# Removes Controller, Model, View, and references in CMake & main.cpp
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

# --- 1. Delete Controller files ---
rm -f "$CONTROLLER_DIR/${NAME}Controller.h" "$CONTROLLER_DIR/${NAME}Controller.cpp"
echo "🗑️ Deleted Controller files for $NAME"

# --- 2. Delete Model files ---
rm -f "$MODEL_DIR/${NAME}Model.h" "$MODEL_DIR/${NAME}Model.cpp"
echo "🗑️ Deleted Model files for $NAME"

# --- 3. Delete View directory ---
if [ -d "$VIEW_DIR" ]; then
  rm -rf "$VIEW_DIR"
  echo "🗑️ Deleted View directory $VIEW_DIR"
else
  echo "ℹ️ No view directory found for $NAME"
fi

# --- 4. Remove references from CMakeLists.txt ---
sed -i "/src\/Controller\/${NAME}Controller.cpp/d" "$CMAKE_FILE"
sed -i "/src\/Model\/${NAME}Model.cpp/d" "$CMAKE_FILE"
echo "🗑️ Removed CMake references for $NAME"

# --- 5. Remove include from main.cpp ---
sed -i "/#include \"${NAME}Controller.h\"/d" "$MAIN_CPP"
echo "🗑️ Removed include from main.cpp"

# --- 6. Remove route from main.cpp ---
sed -i "/router.addRoute(\"\/${NAME_LOWER}\/index\"/d" "$MAIN_CPP"
echo "🗑️ Removed route '/${NAME_LOWER}/index' from main.cpp"

echo "✅ Deletion of MVC for $NAME complete!"
