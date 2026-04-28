#ifndef MANUFACTURER_H
#define MANUFACTURER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <string>
using namespace std;

class Manufacturer {
public:
    int id;
    string name, location, contact, email, type;
    static int count;

    Manufacturer(string n, string l, string c, string e, string t);
};

class ManufacturerManager : public QObject {
    Q_OBJECT

public:
    explicit ManufacturerManager(QObject *parent = nullptr);
    ~ManufacturerManager();

    Manufacturer **list = nullptr;
    int totalCount = 0;
    QVector<int> filteredIndices;
    bool isSearching = false;

    void clearData();

signals:
    void manufacturersLoaded();

public slots:
    Q_INVOKABLE void loadManufacturers();
    Q_INVOKABLE void saveManufacturers();
    Q_INVOKABLE void addManufacturer(QString name, QString loc, QString con, QString mail, QString type);
    Q_INVOKABLE void editManufacturer(int index, QString name, QString loc, QString con, QString mail, QString type);
    Q_INVOKABLE void deleteManufacturer(int index);
    Q_INVOKABLE void searchManufacturer(QString term);

    Q_INVOKABLE int getCount();
    Q_INVOKABLE int getID(int i);
    Q_INVOKABLE QString getName(int i);
    Q_INVOKABLE QString getLocation(int i);
    Q_INVOKABLE QString getContact(int i);
    Q_INVOKABLE QString getEmail(int i);
    Q_INVOKABLE QString getType(int i);
};

#endif
