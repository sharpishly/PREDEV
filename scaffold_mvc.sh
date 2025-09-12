#!/bin/bash
# ==========================================================
# Scaffold Controller + Model + View for SharpishlyApp
# Usage: ./scaffold_mvc.sh Penetration
# Creates/overwrites Controller, Model, and View files,
# updates CMake, and adds include + route to main.cpp.
# ==========================================================

# ==========================================================
# Clear terminal
# ==========================================================
echo ">>> Clear terminal"
clear

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
<nav>
    <a href="/home/index">Home</a>
    <a href="/about/index">About</a>
    <a href="/docs/index">Docs</a>
    <a href="#">Contact</a>
</nav>

<main>
<p>${NAME} Page</p>
<p>Welcome to the ${NAME}Controller view.</p>
</main>
EOF

cat > "$VIEW_DIR/css/style.css" <<EOF
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
}

body {
    font-family: Arial, sans-serif;
    background: #f7f9fc;
    color: #333;
    line-height: 1.6;
    display: flex;
    flex-direction: column;
    min-height: 100vh;
}

header {
    background-color: #4CAF50;
    color: white;
    padding: 1rem;
    text-align: center;
}

nav {
    display: flex;
    justify-content: center;
    background-color: #2e7d32;
}

nav a {
    color: white;
    text-decoration: none;
    padding: 0.75rem 1.5rem;
    display: block;
    transition: background 0.3s;
}

nav a:hover {
    background-color: #1b5e20;
}

main {
    flex: 1;
    padding: 2rem;
    max-width: 960px;
    margin: auto;
}

h1 {
    text-align: center;
    margin-bottom: 1rem;
}

p {
    text-align: center;
    font-size: 1.1rem;
}

footer {
    text-align: center;
    padding: 1rem;
    background-color: #4CAF50;
    color: white;
    margin-top: auto;
}

/* Responsive layout */
@media (max-width: 600px) {
    nav {
        flex-direction: column;
    }

    nav a {
        padding: 0.5rem 1rem;
    }

    main {
        padding: 1rem;
    }
}
EOF

cat > "$VIEW_DIR/js/app.js" <<EOF
console.log("${NAME} view loaded");
EOF

cat > "$VIEW_DIR/partials/header.html" <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Grants Page with HTML, CSS, and JavaScript">
    <title>SharpishlyApp::${NAME}</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
    * {
        box-sizing: border-box;
        margin: 0;
        padding: 0;
    }

    body {
        font-family: Arial, sans-serif;
        background: #f7f9fc;
        color: #333;
        line-height: 1.6;
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    header {
        background-color: #4CAF50;
        color: white;
        padding: 1rem;
        text-align: center;
    }

    nav {
        display: flex;
        justify-content: center;
        background-color: #2e7d32;
    }

    nav a {
        color: white;
        text-decoration: none;
        padding: 0.75rem 1.5rem;
        display: block;
        transition: background 0.3s;
    }

    nav a:hover {
        background-color: #1b5e20;
    }

    main {
        flex: 1;
        padding: 2rem;
        max-width: 960px;
        margin: auto;
    }

    h1 {
        text-align: center;
        margin-bottom: 1rem;
    }

    p {
        text-align: center;
        font-size: 1.1rem;
    }

    footer {
        text-align: center;
        padding: 1rem;
        background-color: #4CAF50;
        color: white;
        margin-top: auto;
    }

    /* Responsive layout */
    @media (max-width: 600px) {
        nav {
            flex-direction: column;
        }

        nav a {
            padding: 0.5rem 1rem;
        }

        main {
            padding: 1rem;
        }
    }
    </style>
</head>
<body>
    <header>
    <h1>${NAME} Page</h1>
    <p>Welcome to the ${NAME}Controller view.</p>
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
