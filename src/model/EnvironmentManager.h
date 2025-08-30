#ifndef ENVIRONMENTMANAGER_H
#define ENVIRONMENTMANAGER_H
#include <string>
#include <vector>
struct Environment {
    std::string name, branch, dockerComposeFile;
    int webPort, apiPort;
};
class EnvironmentManager {
public:
    EnvironmentManager();
    std::vector<Environment> listEnvironments();
    std::string addEnvironment(const Environment &env);
    std::string removeEnvironment(const std::string &name);
    std::string updateEnvironment(const Environment &env);
    std::string deployEnvironment(const std::string &name);
private:
    std::vector<Environment> environments_;
};
#endif
