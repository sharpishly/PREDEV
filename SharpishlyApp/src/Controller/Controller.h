#pragma once
#include "Model.h"
#include "View.h"

class Controller {
public:
    Controller(Model& m, View& v) : model(m), view(v) {}
    void run() {
        view.showMessage("Controller is running");
    }
private:
    Model& model;
    View& view;
};
