#include "manufacturer.h"
#include <fstream>
#include <iostream>
#include <string>

int Manufacturer::count = 0;

Manufacturer::Manufacturer(string n, string l, string c, string e, string t)
    : name(n), location(l), contact(c), email(e), type(t) {
    id = ++count;
}

static void stripCR(string &s) {
    if (!s.empty() && s.back() == '\r') s.pop_back();
}

ManufacturerManager::ManufacturerManager(QObject *parent) : QObject(parent) {}

void ManufacturerManager::clearData() {
    if (list) {
        for (int i = 0; i < totalCount; i++) if (list[i]) delete list[i];
        delete[] list;
        list = nullptr;
    }
    totalCount = 0;
}

void ManufacturerManager::loadManufacturers() {
    clearData();
    ifstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/abc.txt", ios::binary);
    if (!file.is_open()) return;

    string line;
    if (getline(file, line)) {
        stripCR(line);
        try { totalCount = stoi(line); } catch (...) { totalCount = 0; }
    }

    if (totalCount > 0) {
        list = new Manufacturer*[totalCount];
        for (int i = 0; i < totalCount; i++) {
            string t_id, t_name, t_loc, t_con, t_email, t_type;
            getline(file, t_id, ','); getline(file, t_name, ',');
            getline(file, t_loc, ','); getline(file, t_con, ',');
            getline(file, t_email, ','); getline(file, t_type, '\n');

            stripCR(t_type);
            list[i] = new Manufacturer(t_name, t_loc, t_con, t_email, t_type);
            list[i]->id = stoi(t_id);
        }
    }
    file.close();
    emit manufacturersLoaded();
}

void ManufacturerManager::saveManufacturers() {
    ofstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/abc.txt", ios::trunc);
    if (!file.is_open()) return;
    file << totalCount << endl;
    for (int i = 0; i < totalCount; i++) {
        file << list[i]->id << "," << list[i]->name << "," << list[i]->location << ","
             << list[i]->contact << "," << list[i]->email << "," << list[i]->type << endl;
    }
    file.close();
}

void ManufacturerManager::addManufacturer(QString name, QString loc, QString con, QString mail, QString type) {
    Manufacturer **newList = new Manufacturer*[totalCount + 1];
    for (int i = 0; i < totalCount; i++) newList[i] = list[i];

    newList[totalCount] = new Manufacturer(name.toStdString(), loc.toStdString(),
                                           con.toStdString(), mail.toStdString(), type.toStdString());
    delete[] list;
    list = newList;
    totalCount++;
    saveManufacturers();
    emit manufacturersLoaded();
}

void ManufacturerManager::editManufacturer(int index, QString name, QString loc, QString con, QString mail, QString type) {
    int realIndex = isSearching ? filteredIndices[index] : index;
    if (realIndex >= 0 && realIndex < totalCount) {
        list[realIndex]->name = name.toStdString();
        list[realIndex]->location = loc.toStdString();
        list[realIndex]->contact = con.toStdString();
        list[realIndex]->email = mail.toStdString();
        list[realIndex]->type = type.toStdString();
        saveManufacturers();
        emit manufacturersLoaded();
    }
}

void ManufacturerManager::deleteManufacturer(int index) {
    int realIndex = isSearching ? filteredIndices[index] : index;
    delete list[realIndex];
    for (int i = realIndex; i < totalCount - 1; i++) list[i] = list[i+1];
    totalCount--;
    saveManufacturers();
    emit manufacturersLoaded();
}

void ManufacturerManager::searchManufacturer(QString term) {
    filteredIndices.clear();
    if (term.isEmpty()) isSearching = false;
    else {
        isSearching = true;
        for (int i = 0; i < totalCount; i++) {
            if (QString::fromStdString(list[i]->name).contains(term, Qt::CaseInsensitive))
                filteredIndices.append(i);
        }
    }
    emit manufacturersLoaded();
}

// Returns the count based on whether the user is currently searching
int ManufacturerManager::getCount() {
    return isSearching ? filteredIndices.size() : totalCount;
}

// Retrieves the ID for the manufacturer at the given UI index
int ManufacturerManager::getID(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ? list[realIndex]->id : 0;
}

// Retrieves the Company Name
QString ManufacturerManager::getName(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->name) : "";
}

// Retrieves the Location/Headquarters
QString ManufacturerManager::getLocation(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->location) : "";
}

// Retrieves the Contact Number
QString ManufacturerManager::getContact(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->contact) : "";
}

// Retrieves the Email Address
QString ManufacturerManager::getEmail(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->email) : "";
}

// Retrieves the Category (e.g., National, Multinational)
QString ManufacturerManager::getType(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->type) : "";
}

ManufacturerManager::~ManufacturerManager() { clearData(); }
