
#include "EnvironmentManager.h"
#include "execCommand.h"
#include <algorithm>
#include <sstream>

/**
 * @brief Constructs EnvironmentManager with default environments
 */
EnvironmentManager::EnvironmentManager() {
    environments_ = {{"local","feature","docker-compose.override.yml",8080,3000},
                     {"development","develop","docker-compose.dev.yml",8081,3001},
                     {"staging","staging","docker-compose.staging.yml",8082,3002},
                     {"production","main","docker-compose.prod.yml",80,443}};
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
    return "✅ Added " + e.name + "\n";
}

/**
 * @brief Removes an environment by name
 * @param n Name of environment to remove
 * @return Success message
 */
std::string EnvironmentManager::removeEnvironment(const std::string &n) {
    environments_.erase(std::remove_if(environments_.begin(), environments_.end(),
        [&](const Environment &e) { return e.name == n; }), environments_.end());
    return "✅ Removed " + n + "\n";
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
            return "✅ Updated " + e.name + "\n";
        }
    }
    return "❌ Not found " + e.name + "\n";
}

/**
 * @brief Deploys an environment by executing docker-compose commands
 * @param name Name of environment to deploy
 * @return Deployment status message
 */
std::string EnvironmentManager::deployEnvironment(const std::string &name) {
    auto it = std::find_if(environments_.begin(), environments_.end(),
        [&](const Environment &e) { return e.name == name; });
    if (it == environments_.end()) return "❌ Not found: " + name + "\n";
    
    Environment &env = *it;
    std::stringstream out;
    
    // Check port availability
    auto checkPort = [&](int port) {
        return execCommand("lsof -i:" + std::to_string(port) + " | grep LISTEN").empty();
    };
    
    if (!checkPort(env.webPort)) return "❌ Web port " + std::to_string(env.webPort) + " in use\n";
    if (!checkPort(env.apiPort)) return "❌ API port " + std::to_string(env.apiPort) + " in use\n";
    
    out << "✅ Ports free, deploying " << env.name << "\n";
    out << execCommand("git checkout " + env.branch) << "\n";
    out << execCommand("git pull") << "\n";
    std::string cmd = "docker-compose -f " + env.dockerComposeFile + " down && "
                    + "docker-compose -f " + env.dockerComposeFile + " build --no-cache && "
                    + "docker-compose -f " + env.dockerComposeFile + " up -d";
    out << execCommand(cmd) << "\n";
    return out.str();
}

