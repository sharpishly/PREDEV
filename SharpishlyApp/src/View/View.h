#pragma once
#include <string>
#include <iostream>

class View {
public:
    View() = default;
    void showMessage(const std::string& msg) {
        std::cout << "[VIEW] " << msg << std::endl;
    }
};
