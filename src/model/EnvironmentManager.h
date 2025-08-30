
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

