#ifndef HOME_CONTROLLER_H
#define HOME_CONTROLLER_H

#include <string>
#include <vector>

class HomeController {
public:
    std::string dispatch(const std::string& action, const std::vector<std::string>& params);

    // Example methods
    std::string index(const std::vector<std::string>& params);
    std::string about(const std::vector<std::string>& params);
};

#endif // HOME_CONTROLLER_H
