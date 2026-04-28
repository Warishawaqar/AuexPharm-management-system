#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QString>
#include <QUrl>
#include <QTimer>
#include <QtWidgets/QApplication>

#include "authcontroller.h"
#include "medicine.h"
#include"manufacturer.h"
#include"marketers.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // 1. Initialize Managers
    AuthController auth;
    ProductManager inventoryManager;
    ManufacturerManager manManager;
    MarketerManager marketerManager;

    // 2. Register Context Properties
    engine.rootContext()->setContextProperty("myAuth", &auth);
    engine.rootContext()->setContextProperty("inventoryManager", &inventoryManager);
    engine.rootContext()->setContextProperty("marketerManager", &marketerManager);
    engine.rootContext()->setContextProperty("manManager", &manManager);



    const QUrl loginUrl(QStringLiteral("file:///C:/Users/DC/Desktop/Pharmacy/Pharmacy/Main.qml"));
    const QUrl dashboardUrl(QStringLiteral("file:///C:/Users/DC/Desktop/Pharmacy/Pharmacy/Management.qml"));


    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);


    QObject::connect(&auth, &AuthController::loginSuccessful, [&]() {


        const QList<QObject*> rootObjects = engine.rootObjects();
        for (QObject* obj : rootObjects)
            obj->deleteLater();


        engine.load(dashboardUrl);


        QTimer::singleShot(100, [&]() {
            inventoryManager.loadInventory();
            manManager.loadManufacturers();
            marketerManager.loadMarketers();
        });
    });


    engine.load(loginUrl);

    return app.exec();
}
