#include "PenetrationController.h"
#include "Model/PenetrationModel.h"
#include "View/PenetrationView.h"

std::string PenetrationController::index() {
    auto results = PenetrationModel::getAvailableTools();
    return PenetrationView::renderIndex(results);
}
