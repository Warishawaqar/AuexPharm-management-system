#include "medicine.h"
#include <fstream>
#include <iostream>
#include <string>

int Medicine::count = 0;

Medicine::Medicine(string n, string m, string c, int q, double p)
    : name(n), manufacturer(m), category(c), quantity(q), price(p) {
    id = ++count;
}


static void stripCR(string &s) {
    if (!s.empty() && s.back() == '\r')
        s.pop_back();
}

ProductManager::ProductManager(QObject *parent)
    : QObject(parent), list(nullptr), totalCount(0) {}

void ProductManager::clearData() {
    if (list) {
        for (int i = 0; i < totalCount; i++) {
            if (list[i]) delete list[i];
        }
        delete[] list;
        list = nullptr;
    }
    totalCount = 0;
}

void ProductManager::loadInventory() {
    clearData();

    // Open in binary mode so \r\n is preserved exactly — we strip \r manually
    ifstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/xyz.txt", ios::binary);
    if (!file.is_open()) {
        qDebug("loadInventory: could not open xyz.txt — check the path!");
        return;
    }


    string firstLine;
    if (getline(file, firstLine)) {
        stripCR(firstLine);
        try {
            totalCount = stoi(firstLine);
        } catch (...) {
            qDebug("loadInventory: failed to parse count from first line");
            totalCount = 0;
            return;
        }
    }

    qDebug("loadInventory: totalCount = %d", totalCount);

    if (totalCount > 0) {
        list = new Medicine*[totalCount];

        for (int i = 0; i < totalCount; i++) {
            string t_id, t_name, t_cat, t_qty, t_man, t_price;

            getline(file, t_id,    ',');
            getline(file, t_name,  ',');
            getline(file, t_cat,   ',');
            getline(file, t_qty,   ',');
            getline(file, t_man,   ',');
            getline(file, t_price, '\n');

            // Strip \r from every field — critical for Windows \r\n files
            stripCR(t_id);
            stripCR(t_name);
            stripCR(t_cat);
            stripCR(t_qty);
            stripCR(t_man);
            stripCR(t_price);

            try {
                list[i] = new Medicine(t_name, t_man, t_cat, stoi(t_qty), stod(t_price));
                list[i]->id = stoi(t_id);
                qDebug("  Loaded [%d]: %s", list[i]->id, list[i]->name.c_str());
            } catch (...) {
                qDebug("  Failed to parse row %d", i);
                list[i] = nullptr;
            }
        }
    }

    file.close();
    emit inventoryLoaded(); // Triggers QML Connections { onInventoryLoaded }
}
void ProductManager::deleteMedicine(int index){
    if(index<0 || index>= totalCount){
        return;
    }
    delete list[index];
    for (int j=index;j<totalCount-1;j++){
        list[j]=list[j+1];
        list[totalCount - 1] = nullptr;

    }
    totalCount--;
    saveInventory();
    emit inventoryLoaded();


}
void ProductManager::addMedicine(QString name, QString manufacturer, QString category, int quantity, double price) {

    Medicine **newList = new Medicine*[totalCount + 1];
    for (int i = 0; i < totalCount; i++) {
        newList[i] = list[i];
    }
  newList[totalCount] = new Medicine(name.toStdString(), manufacturer.toStdString(),
                                       category.toStdString(), quantity, price);


    delete[] list;
    list = newList;
    totalCount++;

    qDebug() << "Added new medicine:" << name << "| Total:" << totalCount;
    saveInventory();

    emit inventoryLoaded();
}
void ProductManager::editMedicine(int index, QString name, QString manufacturer, QString category, int quantity, double price) {
    int realIndex = isSearching ? filteredIndices[index] : index;
    if (index >= 0 && index < totalCount && list[index]) {
        list[index]->name = name.toStdString();
        list[index]->manufacturer = manufacturer.toStdString();
        list[index]->category = category.toStdString();
        list[index]->quantity = quantity;
        list[index]->price = price;
        saveInventory();
        emit inventoryLoaded(); // Refresh the QML ListView
    }
}
void ProductManager::saveInventory() {
    ofstream file("C:/Users/DC/Desktop/Pharmacy/Pharmacy/xyz.txt", ios::trunc); // Opens and clears the file

    if (file.is_open()) {
        // 1. Write the total count as the first line
        file << totalCount << endl;

        // 2. Loop through the array and write each entry
        for (int i = 0; i < totalCount; i++) {
            if (list[i]) {
                file << list[i]->id << ","
                     << list[i]->name << ","
                     << list[i]->category << ","
                     << list[i]->quantity << ","
                     << list[i]->manufacturer << ","
                     << list[i]->price;

                // Add a newline unless it's the very last entry
                if (i < totalCount - 1) file << endl;
            }
        }
        file.close();
        qDebug() << "Inventory successfully saved to file.";
    } else {
        qDebug() << "Error: Could not open file for saving.";
    }
}
void ProductManager::searchMedicine(QString term) {
    filteredIndices.clear();

    if (term.isEmpty()) {
        isSearching = false;
    } else {
        isSearching = true;
        for (int i = 0; i < totalCount; i++) {
            QString name = QString::fromStdString(list[i]->name);
            // Case-insensitive search
            if (name.contains(term, Qt::CaseInsensitive)) {
                filteredIndices.append(i);
            }
        }
    }
    emit inventoryLoaded(); // Refresh QML
}
int ProductManager::getCount() {
    return isSearching ? filteredIndices.size() : totalCount;
}

// 2. Updated Getters using the Mapping Logic
int ProductManager::getID(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ? list[realIndex]->id : 0;
}

QString ProductManager::getName(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->name) : "";
}

QString ProductManager::getCategory(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->category) : "";
}

QString ProductManager::getManufacturer(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ?
               QString::fromStdString(list[realIndex]->manufacturer) : "";
}

int ProductManager::getQuantity(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ? list[realIndex]->quantity : 0;
}

double ProductManager::getPrice(int i) {
    int realIndex = isSearching ? filteredIndices[i] : i;
    return (realIndex >= 0 && realIndex < totalCount && list[realIndex]) ? list[realIndex]->price : 0.0;
}


ProductManager::~ProductManager() {
    clearData();
}
