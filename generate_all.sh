#!/bin/bash

# /**
#  * @file setup_project.sh
#  * @brief Shell script to set up the Sharpishly project structure and generate necessary files
#  * @details Creates directories, CMake configuration, and source files for a C++ project
#  *          with web dashboard for environment management. Includes error handling and
#  *          file existence checks to prevent overwriting.
#  * @author Grok (xAI)
#  * @date 2025-08-30
#  */

set -e

# /**
#  * @brief Creates a directory if it doesn't exist
#  * @param dir_path Directory path to create
#  * @return 0 on success, 1 if directory creation fails
#  */
create_dir() {
    local dir_path="$1"
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path" || { echo "❌ Failed to create directory: $dir_path"; exit 1; }
        echo "✅ Created directory: $dir_path"
    fi
}

# /**
#  * @brief Writes content to a file if it doesn't exist or prompts for overwrite
#  * @param file_path Path to the file
#  * @param content Content to write to the file
#  * @return 0 on success, 1 on failure or if user declines overwrite
#  */
write_file() {
    local file_path="$1"
    local content="$2"
    if [ -f "$file_path" ]; then
        read -p "⚠️ File $file_path already exists. Overwrite? [y/N] " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "ℹ️ Skipping $file_path"
            return 1
        fi
    fi
    echo "$content" > "$file_path" || { echo "❌ Failed to write to $file_path"; exit 1; }
    echo "✅ Created/Updated file: $file_path"
}

# /**
#  * @brief Main function to set up the project
#  */
main() {
    # Define directories
    local ROOT_DIR=$(pwd)
    local SRC_DIR="$ROOT_DIR/src"
    local MODEL_DIR="$SRC_DIR/model"
    local CONTROLLER_DIR="$SRC_DIR/controller"
    local WWW_DIR="$ROOT_DIR/www"

    # Create directories
    create_dir "$SRC_DIR"
    create_dir "$MODEL_DIR"
    create_dir "$CONTROLLER_DIR"
    create_dir "$WWW_DIR"

    # CMakeLists.txt
    write_file "$ROOT_DIR/CMakeLists.txt" "
# /**
#  * @file CMakeLists.txt
#  * @brief CMake configuration for the Sharpishly project
#  */
cmake_minimum_required(VERSION 3.10)
project(sharpishly)
set(CMAKE_CXX_STANDARD 17)
file(GLOB_RECURSE SOURCES src/*.cpp)
add_executable(sharpishly \${SOURCES})
target_include_directories(sharpishly PRIVATE src src/controller src/model)
"

    # run.sh
    write_file "$ROOT_DIR/run.sh" "
#!/bin/bash
# /**
#  * @file run.sh
#  * @brief Script to build and run the Sharpishly project
#  */
mkdir -p build || { echo \"❌ Failed to create build directory\"; exit 1; }
cd build || { echo \"❌ Failed to enter build directory\"; exit 1; }
cmake .. || { echo \"❌ CMake configuration failed\"; exit 1; }
make -j\$(nproc) || { echo \"❌ Build failed\"; exit 1; }
./sharpishly || { echo \"❌ Execution failed\"; exit 1; }
"
    chmod +x "$ROOT_DIR/run.sh" || { echo "❌ Failed to make run.sh executable"; exit 1; }

    # execCommand.h
    write_file "$MODEL_DIR/execCommand.h" "
#ifndef EXECCOMMAND_H
#define EXECCOMMAND_H
// /**
//  * @file execCommand.h
//  * @brief Utility function to execute shell commands
//  */
#include <string>
#include <array>
#include <memory>
#include <stdexcept>
#include <cstdio>

/**
 * @brief Executes a shell command and returns its output
 * @param cmd The command to execute
 * @return The command's output as a string
 * @throws std::runtime_error if popen() fails
 */
inline std::string execCommand(const std::string& cmd) {
    std::array<char,128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd.c_str(),\"r\"),pclose);
    if(!pipe) throw std::runtime_error(\"popen() failed!\");
    while(fgets(buffer.data(),buffer.size(),pipe.get())!=nullptr) result+=buffer.data();
    return result;
}
#endif
"

    # EnvironmentManager.h
    write_file "$MODEL_DIR/EnvironmentManager.h" "
#ifndef ENVIRONMENTMANAGER_H
#define ENVIRONMENTMANAGER_H
// /**
//  * @file EnvironmentManager.h
//  * @brief Manages environment configurations and deployments
//  */
#include <string>
#include <vector>

/**
 * @struct Environment
 * @brief Represents an environment configuration
 */
struct Environment {
    std::string name;           ///< Environment name
    std::string branch;         ///< Git branch
    std::string dockerComposeFile; ///< Docker compose file path
    int webPort;               ///< Web server port
    int apiPort;               ///< API server port
};

/**
 * @class EnvironmentManager
 * @brief Manages environment lifecycle operations
 */
class EnvironmentManager {
public:
    /**
     * @brief Constructs an EnvironmentManager with default environments
     */
    EnvironmentManager();

    /**
     * @brief Lists all configured environments
     * @return Vector of Environment objects
     */
    std::vector<Environment> listEnvironments();

    /**
     * @brief Adds a new environment
     * @param env Environment to add
     * @return Success message
     */
    std::string addEnvironment(const Environment &env);

    /**
     * @brief Removes an environment by name
     * @param name Environment name to remove
     * @return Success message
     */
    std::string removeEnvironment(const std::string &name);

    /**
     * @brief Updates an existing environment
     * @param env Environment with updated configuration
     * @return Success or error message
     */
    std::string updateEnvironment(const Environment &env);

    /**
     * @brief Deploys an environment
     * @param name Environment name to deploy
     * @return Deployment status message
     */
    std::string deployEnvironment(const std::string &name);

private:
    std::vector<Environment> environments_; ///< Stored environments
};
#endif
"

    # EnvironmentManager.cpp
    write_file "$MODEL_DIR/EnvironmentManager.cpp" "
#include \"EnvironmentManager.h\"
#include \"execCommand.h\"
#include <algorithm>
#include <sstream>

/**
 * @brief Constructs EnvironmentManager with default environments
 */
EnvironmentManager::EnvironmentManager() {
    environments_ = {{\"local\",\"feature\",\"docker-compose.override.yml\",8080,3000},
                     {\"development\",\"develop\",\"docker-compose.dev.yml\",8081,3001},
                     {\"staging\",\"staging\",\"docker-compose.staging.yml\",8082,3002},
                     {\"production\",\"main\",\"docker-compose.prod.yml\",80,443}};
}

/**
 * @brief Returns all environments
 * @return Vector of Environment objects
 */
std::vector<Environment> EnvironmentManager::listEnvironments() {
    return environments_;
}

/**
 * @brief Adds a new environment to the list
 * @param e Environment to add
 * @return Success message
 */
std::string EnvironmentManager::addEnvironment(const Environment &e) {
    environments_.push_back(e);
    return \"✅ Added \" + e.name + \"\\n\";
}

/**
 * @brief Removes an environment by name
 * @param n Name of environment to remove
 * @return Success message
 */
std::string EnvironmentManager::removeEnvironment(const std::string &n) {
    environments_.erase(std::remove_if(environments_.begin(), environments_.end(),
        [&](const Environment &e) { return e.name == n; }), environments_.end());
    return \"✅ Removed \" + n + \"\\n\";
}

/**
 * @brief Updates an existing environment
 * @param e Environment with updated configuration
 * @return Success or error message
 */
std::string EnvironmentManager::updateEnvironment(const Environment &e) {
    for (auto &env : environments_) {
        if (env.name == e.name) {
            env = e;
            return \"✅ Updated \" + e.name + \"\\n\";
        }
    }
    return \"❌ Not found \" + e.name + \"\\n\";
}

/**
 * @brief Deploys an environment by executing docker-compose commands
 * @param name Name of environment to deploy
 * @return Deployment status message
 */
std::string EnvironmentManager::deployEnvironment(const std::string &name) {
    auto it = std::find_if(environments_.begin(), environments_.end(),
        [&](const Environment &e) { return e.name == name; });
    if (it == environments_.end()) return \"❌ Not found: \" + name + \"\\n\";
    
    Environment &env = *it;
    std::stringstream out;
    
    // Check port availability
    auto checkPort = [&](int port) {
        return execCommand(\"lsof -i:\" + std::to_string(port) + \" | grep LISTEN\").empty();
    };
    
    if (!checkPort(env.webPort)) return \"❌ Web port \" + std::to_string(env.webPort) + \" in use\\n\";
    if (!checkPort(env.apiPort)) return \"❌ API port \" + std::to_string(env.apiPort) + \" in use\\n\";
    
    out << \"✅ Ports free, deploying \" << env.name << \"\\n\";
    out << execCommand(\"git checkout \" + env.branch) << \"\\n\";
    out << execCommand(\"git pull\") << \"\\n\";
    std::string cmd = \"docker-compose -f \" + env.dockerComposeFile + \" down && \"
                    + \"docker-compose -f \" + env.dockerComposeFile + \" build --no-cache && \"
                    + \"docker-compose -f \" + env.dockerComposeFile + \" up -d\";
    out << execCommand(cmd) << \"\\n\";
    return out.str();
}
"

    # EnvironmentController.h
    write_file "$CONTROLLER_DIR/EnvironmentController.h" "
#ifndef ENVIRONMENTCONTROLLER_H
#define ENVIRONMENTCONTROLLER_H
// /**
//  * @file EnvironmentController.h
//  * @brief Handles environment-related HTTP requests
//  */
#include <string>
#include \"model/EnvironmentManager.h\"

/**
 * @class EnvironmentController
 * @brief Processes HTTP requests for environment management
 */
class EnvironmentController {
public:
    /**
     * @brief Handles incoming HTTP requests
     * @param route The request route with parameters
     * @return Response string
     */
    std::string handleRequest(const std::string &route);

private:
    EnvironmentManager envManager_; ///< Environment manager instance
};
#endif
"

    # EnvironmentController.cpp
    write_file "$CONTROLLER_DIR/EnvironmentController.cpp" "
#include \"EnvironmentController.h\"
#include <sstream>

/**
 * @brief Processes HTTP requests and delegates to EnvironmentManager
 * @param route The request route with parameters
 * @return Response string
 */
std::string EnvironmentController::handleRequest(const std::string &route) {
    if (route.find(\"/environments/deploy\") == 0) {
        size_t pos = route.find(\"name=\");
        if (pos == std::string::npos) return \"❌ Missing name\\n\";
        return envManager_.deployEnvironment(route.substr(pos + 5));
    }
    if (route.find(\"/environments/add\") == 0) {
        std::string name, branch, compose;
        int web = 0, api = 0;
        size_t pos;
        pos = route.find(\"name=\"); if (pos != std::string::npos) name = route.substr(pos + 5);
        pos = route.find(\"branch=\"); if (pos != std::string::npos) branch = route.substr(pos + 7);
        pos = route.find(\"compose=\"); if (pos != std::string::npos) compose = route.substr(pos + 8);
        pos = route.find(\"webPort=\"); if (pos != std::string::npos) web = std::stoi(route.substr(pos + 8));
        pos = route.find(\"apiPort=\"); if (pos != std::string::npos) api = std::stoi(route.substr(pos + 8));
        return envManager_.addEnvironment({name, branch, compose, web, api});
    }
    if (route.find(\"/environments/remove\") == 0) {
        size_t pos = route.find(\"name=\");
        if (pos == std::string::npos) return \"❌ Missing name\\n\";
        return envManager_.removeEnvironment(route.substr(pos + 5));
    }
    if (route.find(\"/environments/update\") == 0) {
        std::string name, branch, compose;
        int web = 0, api = 0;
        size_t pos;
        pos = route.find(\"name=\"); if (pos != std::string::npos) name = route.substr(pos + 5);
        pos = route.find(\"branch=\"); if (pos != std::string::npos) branch = route.substr(pos + 7);
        pos = route.find(\"compose=\"); if (pos != std::string::npos) compose = route.substr(pos + 8);
        pos = route.find(\"webPort=\"); if (pos != std::string::npos) web = std::stoi(route.substr(pos + 8));
        pos = route.find(\"apiPort=\"); if (pos != std::string::npos) api = std::stoi(route.substr(pos + 8));
        return envManager_.updateEnvironment({name, branch, compose, web, api});
    }
    if (route == \"/environments/list\") {
        auto envs = envManager_.listEnvironments();
        std::stringstream ss;
        for (auto &e : envs) {
            ss << \"Name: \" << e.name << \", Branch: \" << e.branch 
               << \", Compose: \" << e.dockerComposeFile 
               << \", WebPort: \" << e.webPort 
               << \", API: \" << e.apiPort << \"\\n\";
        }
        return ss.str();
    }
    return \"❌ Unknown route: \" + route + \"\\n\";
}
"

    # index.html
    write_file "$WWW_DIR/index.html" "
<!DOCTYPE html>
<html>
<head>
    <title>Sharpishly Dev Dashboard</title>
    <link rel=\"stylesheet\" href=\"style.css\">
</head>
<body>
    <h1>Sharpishly Dev Dashboard</h1>
    <div class=\"buttons\">
        <button onclick=\"callApi('/generate-cert')\">Generate Cert</button>
        <button onclick=\"callApi('/cleanup')\">Cleanup</button>
        <button onclick=\"callApi('/update-repo')\">Update Repo</button>
        <button onclick=\"callApi('/status')\">Docker Status</button>
        <button onclick=\"callApi('/update-hosts')\">Update Hosts</button>
    </div>
    <h2>Environments</h2>
    <form id=\"env-form\">
        Name: <input type=\"text\" id=\"env-name\" required>
        Branch: <input type=\"text\" id=\"env-branch\" required>
        Compose: <input type=\"text\" id=\"env-compose\" required>
        Web Port: <input type=\"number\" id=\"env-webPort\" required>
        API Port: <input type=\"number\" id=\"env-apiPort\" required>
        <button type=\"button\" onclick=\"addEnvironment()\">Add / Update</button>
    </form>
    <div id=\"env-list\"></div>
    <pre id=\"output\"></pre>
    <script src=\"script.js\"></script>
    <script>
        /**
         * @brief Lists all environments in the dashboard
         */
        async function listEnvironments() {
            const outputEl = document.getElementById('env-list');
            outputEl.innerHTML = '';
            try {
                const res = await fetch('/environments/list', { method: 'POST' });
                const text = await res.text();
                text.split('\\n').forEach(line => {
                    if (line.trim() !== '') {
                        const div = document.createElement('div');
                        div.textContent = line;
                        const envName = line.split(',')[0].split(':')[1].trim();
                        const btnDeploy = document.createElement('button');
                        btnDeploy.textContent = 'Deploy';
                        btnDeploy.onclick = () => deployEnvironment(envName);
                        const btnRemove = document.createElement('button');
                        btnRemove.textContent = 'Remove';
                        btnRemove.onclick = () => removeEnvironment(envName);
                        div.appendChild(btnDeploy);
                        div.appendChild(btnRemove);
                        outputEl.appendChild(div);
                    }
                });
            } catch (error) {
                document.getElementById('output').textContent = '❌ Error listing environments: ' + error.message;
            }
        }

        /**
         * @brief Deploys an environment and streams output
         * @param name Environment name to deploy
         */
        async function deployEnvironment(name) {
            const outputEl = document.getElementById('output');
            outputEl.textContent = '';
            try {
                const res = await fetch('/environments/deploy?name=' + encodeURIComponent(name), { method: 'POST' });
                const reader = res.body.getReader();
                const decoder = new TextDecoder();
                while (true) {
                    const { done, value } = await reader.read();
                    if (done) break;
                    outputEl.textContent += decoder.decode(value);
                    outputEl.scrollTop = outputEl.scrollHeight;
                }
            } catch (error) {
                outputEl.textContent = '❌ Error deploying environment: ' + error.message;
            }
        }

        /**
         * @brief Removes an environment and refreshes the list
         * @param name Environment name to remove
         */
        async function removeEnvironment(name) {
            const outputEl = document.getElementById('output');
            try {
                const res = await fetch('/environments/remove?name=' + encodeURIComponent(name), { method: 'POST' });
                outputEl.textContent = await res.text();
                listEnvironments();
            } catch (error) {
                outputEl.textContent = '❌ Error removing environment: ' + error.message;
            }
        }

        /**
         * @brief Adds or updates an environment
         */
        async function addEnvironment() {
            const name = document.getElementById('env-name').value;
            const branch = document.getElementById('env-branch').value;
            const compose = document.getElementById('env-compose').value;
            const web = document.getElementById('env-webPort').value;
            const api = document.getElementById('env-apiPort').value;
            const path = `/environments/add?name=${encodeURIComponent(name)}&branch=${encodeURIComponent(branch)}&compose=${encodeURIComponent(compose)}&webPort=${web}&apiPort=${api}`;
            const outputEl = document.getElementById('output');
            try {
                const res = await fetch(path, { method: 'POST' });
                outputEl.textContent = await res.text();
                listEnvironments();
            } catch (error) {
                outputEl.textContent = '❌ Error adding environment: ' + error.message;
            }
        }

        // Initialize environment list
        listEnvironments();
    </script>
</body>
</html>
"

    # style.css
    write_file "$WWW_DIR/style.css" "
/**
 * @file style.css
 * @brief Styles for the Sharpishly Dev Dashboard
 */
body {
    font-family: monospace;
    padding: 20px;
    background: #f2f2f2;
}
.buttons button {
    margin: 5px;
    padding: 10px 20px;
}
pre {
    background: #000;
    color: #0f0;
    padding: 10px;
    height: 400px;
    overflow: auto;
}
#env-list div {
    margin: 5px 0;
}
#env-list button {
    margin-left: 10px;
    padding: 3px 8px;
}
"

    # script.js
    write_file "$WWW_DIR/script.js" "
/**
 * @file script.js
 * @brief JavaScript utilities for API calls in the Sharpishly Dev Dashboard
 */

/**
 * @brief Makes an API call and streams the response
 * @param path API endpoint path
 */
async function callApi(path) {
    const outputEl = document.getElementById('output');
    outputEl.textContent = '';
    try {
        const res = await fetch(path, { method: 'POST' });
        const reader = res.body.getReader();
        const decoder = new TextDecoder();
        while (true) {
            const { done, value } = await reader.read();
            if (done) break;
            outputEl.textContent += decoder.decode(value);
            outputEl.scrollTop = outputEl.scrollHeight;
        }
    } catch (error) {
        outputEl.textContent = '❌ Error calling API: ' + error.message;
    }
}
"

    echo "✅ Full project generated with integrated Environment Management (add/update/remove/deploy) in dashboard."
    echo "ℹ️ To build and run, execute './run.sh'"
}

# Execute main function
main