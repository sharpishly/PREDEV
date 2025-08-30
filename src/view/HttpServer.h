#ifndef HTTPSERVER_H
#define HTTPSERVER_H
// /**
//  * @file HttpServer.h
//  * @brief HTTP server interface for handling requests in the Sharpishly project
//  * @details Provides a simple HTTP server class to handle environment management
//  *          requests by delegating to the EnvironmentController.
//  * @author Grok (xAI)
//  * @date 2025-08-30
//  */
#include <string>
#include "controller/EnvironmentController.h"

/**
 * @class HttpServer
 * @brief Simple HTTP server to handle environment management requests
 */
class HttpServer {
public:
    /**
     * @brief Constructs an HTTP server
     * @param port Port to listen on
     */
    HttpServer(int port);

    /**
     * @brief Starts the HTTP server
     */
    void start();

    /**
     * @brief Stops the HTTP server
     */
    void stop();

private:
    int port_; ///< Server port
    EnvironmentController envController_; ///< Environment controller instance
};
#endif
