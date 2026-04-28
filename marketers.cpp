#include "marketers.h"
#include <fstream>
#include <iostream>
#include <string>

int Marketer::count = 0;

Marketer::Marketer(string n, string r, string c, string l, double ra)
    : name(n), region(r), contact(c), license(l), rating(ra) {
    id = ++count;
}

// Utility to handle Windows line endings
static void stripCR(string &s) {
    if (!s.empty() && s.back() == '\r')
        s.pop_back();
}

MarketerManager::MarketerManager(QObject *parent)
    : QObject(parent), list(nullptr), totalCount(0) {}

void MarketerManager::clearData() {
    if (list) {
        for (int i = 0; i < totalCount; i++) {
            if (list[i]) delete list[i];
        }
        delete[] list;
        list = nullptr;
    }
    totalCount = 0;
}

void MarketerManager::loadMarketers() {
    clearData();

    ifstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/qrt.txt", ios::binary);
    if (!file.is_open()) {
        qDebug("loadMarketers: could not open marketers.txt!");
        return;
    }

    string firstLine;
    if (getline(file, firstLine)) {
        stripCR(firstLine);
        try {
            totalCount = stoi(firstLine);
        } catch (...) {
            totalCount = 0;
            return;
        }
    }

    if (totalCount > 0) {
        list = new Marketer*[totalCount];
        for (int i = 0; i < totalCount; i++) {
            string t_id, t_name, t_reg, t_con, t_lic, t_rat;

            getline(file, t_id,    ',');
            getline(file, t_name,  ',');
            getline(file, t_reg,   ',');
            getline(file, t_con,   ',');
            getline(file, t_lic,   ',');
            getline(file, t_rat,   '\n');

            stripCR(t_rat);

            try {
                list[i] = new Marketer(t_name, t_reg, t_con, t_lic, stod(t_rat));
                list[i]->id = stoi(t_id);
            } catch (...) {
                list[i] = nullptr;
            }
        }
    }
    file.close();
    emit marketersLoaded();
}

void MarketerManager::saveMarketers() {
    ofstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/qrt.txt", ios::trunc);
    if (file.is_open()) {
        file << totalCount << endl;
        for (int i = 0; i < totalCount; i++) {
            if (list[i]) {
                file << list[i]->id << ","
                     << list[i]->name << ","
                     << list[i]->region << ","
                     << list[i]->contact << ","
                     << list[i]->license << ","
                     << list[i]->rating;
                if (i < totalCount - 1) file << endl;
            }
        }
        file.close();
    }
}

void MarketerManager::addMarketer(QString name, QString region, QString contact, QString license, double rating) {
    Marketer **newList = new Marketer*[totalCount + 1];
    for (int i = 0; i < totalCount; i++) newList[i] = list[i];

    newList[totalCount] = new Marketer(name.toStdString(), region.toStdString(),
                                       contact.toStdString(), license.toStdString(), rating);

    delete[] list;
    list = newList;
    totalCount++;
    saveMarketers();
    emit marketersLoaded();
}

void MarketerManager::editMarketer(int index, QString name, QString region, QString contact, QString license, double rating) {
    int realIndex = isSearching ? filteredIndices[index] : index;
    if (realIndex >= 0 && realIndex < totalCount && list[realIndex]) {
        list[realIndex]->name = name.toStdString();
        list[realIndex]->region = region.toStdString();
        list[realIndex]->contact = contact.toStdString();
        list[realIndex]->license = license.toStdString();
        list[realIndex]->rating = rating;
        saveMarketers();
        emit marketersLoaded();
    }
}

void MarketerManager::deleteMarketer(int index) {
    int realIndex = isSearching ? filteredIndices[index] : index;
    if (realIndex < 0 || realIndex >= totalCount) return;

    delete list[realIndex];
    for (int j = realIndex; j < totalCount - 1; j++) {
        list[j] = list[j + 1];
    }
    totalCount--;
    saveMarketers();
    emit marketersLoaded();
}

void MarketerManager::searchMarketer(QString term) {
    filteredIndices.clear();
    if (term.isEmpty()) {
        isSearching = false;
    } else {
        isSearching = true;
        for (int i = 0; i < totalCount; i++) {
            if (QString::fromStdString(list[i]->name).contains(term, Qt::CaseInsensitive)) {
                filteredIndices.append(i);
            }
        }
    }
    emit marketersLoaded();
}

// Getters
int MarketerManager::getCount() { return isSearching ? filteredIndices.size() : totalCount; }
int MarketerManager::getID(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return list[idx]->id;
}
QString MarketerManager::getName(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return QString::fromStdString(list[idx]->name);
}
QString MarketerManager::getRegion(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return QString::fromStdString(list[idx]->region);
}
QString MarketerManager::getContact(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return QString::fromStdString(list[idx]->contact);
}
QString MarketerManager::getLicense(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return QString::fromStdString(list[idx]->license);
}
double MarketerManager::getRating(int i) {
    int idx = isSearching ? filteredIndices[i] : i;
    return list[idx]->rating;
}

MarketerManager::~MarketerManager() { clearData(); }
