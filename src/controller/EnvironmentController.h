
#ifndef ENVIRONMENTCONTROLLER_H
#define ENVIRONMENTCONTROLLER_H
// /**
//  * @file EnvironmentController.h
//  * @brief Handles environment-related HTTP requests
//  */
#include <string>
#include "model/EnvironmentManager.h"

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

