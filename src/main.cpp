#include <iostream>
#include "controller/AppController.h"

int main() {
    try {
        AppController app;
        app.start();
    } catch (const std::exception &e) {
        std::cerr << "Fatal error: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
