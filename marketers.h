#ifndef MARKETER_H
#define MARKETER_H

#include <QObject>
#include <QString>
#include <QVector>
#include <string>

using namespace std;

class Marketer {
public:
    int id;
    string name, region, contact, license;
    double rating;
    static int count;

    Marketer(string n, string r, string c, string l, double ra);
};

class MarketerManager : public QObject {
    Q_OBJECT

public:
    explicit MarketerManager(QObject *parent = nullptr);
    ~MarketerManager();

    Marketer **list = nullptr;
    int totalCount = 0;
    QVector<int> filteredIndices;
    bool isSearching = false;

    void clearData();

signals:
    void marketersLoaded();

public slots:
    Q_INVOKABLE void loadMarketers();
    void saveMarketers();
    Q_INVOKABLE void addMarketer(QString name, QString region, QString contact, QString license, double rating);
    Q_INVOKABLE void editMarketer(int index, QString name, QString region, QString contact, QString license, double rating);
    Q_INVOKABLE void deleteMarketer(int index);
    Q_INVOKABLE void searchMarketer(QString term);

    Q_INVOKABLE int getCount();
    Q_INVOKABLE int getID(int i);
    Q_INVOKABLE QString getName(int i);
    Q_INVOKABLE QString getRegion(int i);
    Q_INVOKABLE QString getContact(int i);
    Q_INVOKABLE QString getLicense(int i);
    Q_INVOKABLE double getRating(int i);
};

#endif
