#ifndef AUTHCONTROLLER_H
#define AUTHCONTROLLER_H

#include <QObject>
#include <QString>
class AuthController : public QObject
{
    Q_OBJECT
public:
    explicit AuthController(QObject *parent = nullptr);
Q_INVOKABLE bool checkCredentials(QString email, QString password);
signals:
void loginSuccessful();
};

#endif // AUTHCONTROLLER_H
