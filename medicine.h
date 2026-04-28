#ifndef MEDICINE_H
#define MEDICINE_H

#include <QObject>
#include <QString>
#include <QDebug>
#include <string>

using namespace std;

// Stores data for a single medicine entry
class Medicine {
public:
    int id;
    string name, manufacturer, category;
    int quantity;
    double price;
    static int count;

    Medicine(string n, string m, string c, int q, double p);
};

// Manages the medicine array and exposes data to QML
class ProductManager : public QObject {
    Q_OBJECT

public:
    explicit ProductManager(QObject *parent = nullptr);
    ~ProductManager();

    Medicine **list = nullptr;
    int totalCount   = 0;

    void clearData();
    QVector<int> filteredIndices;
    bool isSearching = false;

signals:
    void inventoryLoaded();

public slots:
    Q_INVOKABLE void searchMedicine(QString term);

    void saveInventory();
    Q_INVOKABLE void addMedicine(QString name, QString manufacturer, QString category, int quantity, double price);
    Q_INVOKABLE void editMedicine(int index, QString name, QString manufacturer, QString category, int quantity, double price);
    Q_INVOKABLE void deleteMedicine(int index);
    Q_INVOKABLE void    loadInventory();
    Q_INVOKABLE int     getID(int i);
    Q_INVOKABLE QString getName(int i);
    Q_INVOKABLE QString getCategory(int i);
    Q_INVOKABLE QString getManufacturer(int i);
    Q_INVOKABLE int     getQuantity(int i);
    Q_INVOKABLE double  getPrice(int i);
    Q_INVOKABLE int     getCount();
};

#endif // MEDICINE_H
