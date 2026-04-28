#include "authcontroller.h"


AuthController::AuthController(QObject *parent) : QObject(parent)
{
    // Constructor logic (empty for now)
}

bool AuthController::checkCredentials(QString email, QString password)
{
    if (email == "admin@fast.edu" && password == "cs123") {
        emit loginSuccessful();
        return true;
    }
    return false;
}
