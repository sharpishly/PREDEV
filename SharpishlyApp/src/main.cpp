#include "AppController.h"
#include "AppConfig.h"
#include "Model.h"
#include "View.h"
#include "Controller.h"
#include <iostream>

int main() {
    AppConfig config;
    AppController appCtrl(config);

    appCtrl.printStatus("Generating SSL certificate...");
    appCtrl.generateSSL();

    appCtrl.printStatus("Updating hosts...");
    appCtrl.updateHosts();

    Model model;
    View view;
    Controller controller(model, view);
    controller.run();

    appCtrl.printStatus("Starting Docker containers...");
    appCtrl.runDockerCompose("up -d");

    return 0;
}
