// Management.qml
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
import QtCharts

Window {
    id:root
    width: 1200
    height: 800
    visible: true
    color: "#E1EBF1"
    title: "Pharmacy Management Dashboard"
    property int currentMenuIndex:0

FontLoader { id: fa_solid; source: "file:///C:/Users/DC/Desktop/Pharmacy/Pharmacy/Font Awesome 7 Free-Solid-900.otf" }

RowLayout {
        anchors.fill: parent
        spacing: 0
Rectangle{
            id:sidebar
            width:250
            height:800

            color: "#31505E"



        ColumnLayout{
            anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
            spacing:35
        Text{
            text:"AuexPharm."
            font.bold:true
            color:"white"
            font.pixelSize: 30
            Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 30
                    Layout.bottomMargin: 60// Moves it down from the top edge
}
        Repeater{
            model: ListModel{
                ListElement{
                    name: "Home"; icon:"\uf015"
                }
                ListElement{
                    name:"Product"; icon:"\ue131"
                }
                ListElement{
                    name: "Supplier"; icon:"\uf0d1"
                }
                ListElement{
                    name:"Manufacturer" ; icon:"\uf1ad"
                    }

            }
            delegate: Item{
                Layout.fillWidth: true
                Layout.preferredHeight: 40
                Layout.leftMargin: 20

                Rectangle{
                id:menuButton


                width: parent.width + 15
                height: parent.height
                Layout.leftMargin: 20
                Layout.bottomMargin: 10
                Layout.alignment: Qt.AlignHCenter
                radius: 25

                color: root.currentMenuIndex === index ? "#E1EBF1" : "transparent"
                RowLayout{
                spacing: 10

                Layout.alignment: Qt.AlignHCenter
                Layout.leftMargin: 20



                    Text{
                        Layout.leftMargin: 20
                        id:box1
                        text:icon
                        font.pixelSize: 25
                         color: root.currentMenuIndex === index ? "#31505E" :"white"
                        font.bold: true
                    }
                    Text{
                        id:box
                        text:name
                        font.pixelSize: 20
                         color: root.currentMenuIndex === index ?"#31505E"  : "white"
                        font.bold:true
                    }

                }
                MouseArea {
                         anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                    onClicked: {
                            root.currentMenuIndex = index

                                }
            }
                }
        }
        }
        }



        }
        StackLayout {
                    id: contentStack
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    currentIndex: root.currentMenuIndex
                    // ── 0. HOME DASHBOARD ────────────────────────────────────
                    // ── 0. HOME DASHBOARD ────────────────────────────────────
                    Rectangle {
                        color: "transparent"

                        property int lowStockCount: 0

                        Connections {
                            target: inventoryManager
                            function onInventoryLoaded() {
                                productCountText.text = inventoryManager.getCount()
                                var c = 0
                                for (var i = 0; i < inventoryManager.getCount(); i++)
                                    if (inventoryManager.getQuantity(i) < 50) c++
                                parent.lowStockCount = c
                                alertsRepeater.model = 0
                                alertsRepeater.model = inventoryManager.getCount()
                            }
                        }
                        Connections {
                            target: marketerManager
                            function onMarketersLoaded() {
                                marketerCountText.text = marketerManager.getCount()
                            }
                        }
                        Connections {
                            target: manManager
                            function onManufacturersLoaded() {
                                manCountText.text = manManager.getCount()
                            }
                        }

                        ScrollView {
                            anchors.fill: parent
                            contentWidth: availableWidth
                            clip: true

                            Column {
                                width: parent.width
                                topPadding: 28
                                leftPadding: 28
                                rightPadding: 28
                                bottomPadding: 28
                                spacing: 20

                                // ── STAT CARDS ROW ────────────────────────────────────
                                Row {
                                    width: parent.width - 56
                                    spacing: 14

                                    // Products card
                                    Rectangle {
                                        width: (parent.width - 28) / 3
                                        height: 90; color: "white"; radius: 12
                                        border.color: "#e0e0e0"; border.width: 1
                                        Row {
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left; anchors.leftMargin: 18
                                            spacing: 14
                                            Rectangle {
                                                width: 44; height: 44; radius: 10; color: "#E6F1FB"
                                                anchors.verticalCenter: parent.verticalCenter
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "\uf0fe"; font.family: fa_solid.name
                                                    font.pixelSize: 20; color: "#185FA5"
                                                }
                                            }
                                            Column {
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 4
                                                Text { text: "Total Products"; font.pixelSize: 12; color: "#888" }
                                                Text {
                                                    id: productCountText
                                                    text: "0"
                                                    font.pixelSize: 28; font.bold: true; color: "#31505E"
                                                }
                                            }
                                        }
                                    }

                                    // Marketers card
                                    Rectangle {
                                        width: (parent.width - 28) / 3
                                        height: 90; color: "white"; radius: 12
                                        border.color: "#e0e0e0"; border.width: 1
                                        Row {
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left; anchors.leftMargin: 18
                                            spacing: 14
                                            Rectangle {
                                                width: 44; height: 44; radius: 10; color: "#E1F5EE"
                                                anchors.verticalCenter: parent.verticalCenter
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "\uf0d1"; font.family: fa_solid.name
                                                    font.pixelSize: 20; color: "#0F6E56"
                                                }
                                            }
                                            Column {
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 4
                                                Text { text: "Marketers"; font.pixelSize: 12; color: "#888" }
                                                Text {
                                                    id: marketerCountText
                                                    text: "0"
                                                    font.pixelSize: 28; font.bold: true; color: "#31505E"
                                                }
                                            }
                                        }
                                    }

                                    // Manufacturers card
                                    Rectangle {
                                        width: (parent.width - 28) / 3
                                        height: 90; color: "white"; radius: 12
                                        border.color: "#e0e0e0"; border.width: 1
                                        Row {
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.left: parent.left; anchors.leftMargin: 18
                                            spacing: 14
                                            Rectangle {
                                                width: 44; height: 44; radius: 10; color: "#FAEEDA"
                                                anchors.verticalCenter: parent.verticalCenter
                                                Text {
                                                    anchors.centerIn: parent
                                                    text: "\uf1ad"; font.family: fa_solid.name
                                                    font.pixelSize: 20; color: "#854F0B"
                                                }
                                            }
                                            Column {
                                                anchors.verticalCenter: parent.verticalCenter
                                                spacing: 4
                                                Text { text: "Manufacturers"; font.pixelSize: 12; color: "#888" }
                                                Text {
                                                    id: manCountText
                                                    text: "0"
                                                    font.pixelSize: 28; font.bold: true; color: "#31505E"
                                                }
                                            }
                                        }
                                    }
                                }

                                // ── LOW STOCK ALERTS ──────────────────────────────────
                                Rectangle {
                                    width: parent.width - 56
                                    height: alertsColumn.implicitHeight + 36
                                    color: "white"; radius: 12
                                    border.color: "#e0e0e0"; border.width: 1

                                    Column {
                                        id: alertsColumn
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.margins: 18
                                        spacing: 0

                                        // Header
                                        Row {
                                            width: parent.width
                                            height: 40
                                            spacing: 10

                                            Text {
                                                text: "LOW STOCK ALERTS"
                                                font.pixelSize: 11; font.bold: true; color: "#888"
                                                anchors.verticalCenter: parent.verticalCenter
                                            }
                                            Rectangle {
                                                width: badgeText.width + 16; height: 22; radius: 11
                                                color: "#FCEBEB"
                                                anchors.verticalCenter: parent.verticalCenter
                                                Text {
                                                    id: badgeText
                                                    anchors.centerIn: parent
                                                    text: parent.parent.parent.parent.parent.lowStockCount + " warnings"
                                                    font.pixelSize: 11; font.bold: true; color: "#A32D2D"
                                                }
                                            }
                                        }

                                        // Alert rows
                                        Repeater {
                                            id: alertsRepeater
                                            model: 0

                                            delegate: Loader {
                                                active: inventoryManager.getQuantity(index) < 50
                                                width: alertsColumn.width

                                                sourceComponent: Rectangle {
                                                    width: alertsColumn.width
                                                    height: 46
                                                    color: "transparent"

                                                    Rectangle {
                                                        width: parent.width; height: 1
                                                        color: "#f0f0f0"
                                                        anchors.top: parent.top
                                                    }
                                                    Row {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        anchors.left: parent.left
                                                        spacing: 14

                                                        Rectangle {
                                                            width: 8; height: 8; radius: 4
                                                            color: "#E24B4A"
                                                            anchors.verticalCenter: parent.verticalCenter
                                                        }
                                                        Text {
                                                            text: inventoryManager.getName(index)
                                                            font.pixelSize: 14; font.bold: true; color: "#31505E"
                                                            width: 200
                                                            anchors.verticalCenter: parent.verticalCenter
                                                        }
                                                        Text {
                                                            text: inventoryManager.getCategory(index)
                                                            font.pixelSize: 12; color: "#999"
                                                            width: 120
                                                            anchors.verticalCenter: parent.verticalCenter
                                                        }
                                                        Rectangle {
                                                            width: qtyText.width + 16; height: 22; radius: 11
                                                            color: "#FCEBEB"
                                                            anchors.verticalCenter: parent.verticalCenter
                                                            Text {
                                                                id: qtyText
                                                                anchors.centerIn: parent
                                                                text: "Qty: " + inventoryManager.getQuantity(index)
                                                                font.pixelSize: 12; font.bold: true; color: "#A32D2D"
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }


                    Rectangle {
                        color: "transparent"

                        Rectangle{
                          id: rec1
                          anchors.centerIn: parent
                          height: parent.height * 0.7
                          width: parent.width * 0.9
                          color:"white"
                          radius: 15
                          anchors.verticalCenterOffset: -45

                          Text{
                              text: "Product Dashboard"
                              font.pixelSize: 25
                              font.bold: true
                              anchors.top: parent.top
                              anchors.left: parent.left
                               anchors.topMargin: 25
                               anchors.leftMargin: 25

                          }

                          RowLayout {
                              id: tabRow
                              spacing: 20
                              anchors.top: parent.top
                              anchors.left: parent.left
                              anchors.right: parent.right // Must anchor to the right for the search bar to move there
                              anchors.topMargin: 100
                              anchors.leftMargin: 20
                              anchors.rightMargin: 20 // Margin for the right corner

                              // 1. Products Button
                              Button {
                                  id: productsBtn
                                  Layout.preferredWidth: 100
                                  Layout.preferredHeight: 40
                                  Layout.alignment: Qt.AlignBottom // Keeps it level from the bottom

                                  contentItem: Text {
                                      text: "Products"
                                      font.pixelSize: 15
                                      font.bold: true
                                      color: "#31505E"
                                      horizontalAlignment: Text.AlignHCenter
                                      verticalAlignment: Text.AlignVCenter
                                  }
                                  background: Rectangle {
                                      radius: 8
                                      border.width: 1
                                      border.color: "#31505E"
                                      color: productsBtn.hovered ? "#E1E8EB" : "transparent"
                                  }
                              }

                              // 2. Add Product Button
                              Button {
                                  id: addProductBtn
                                  Layout.preferredWidth: 120
                                  Layout.preferredHeight: 40
                                  Layout.alignment: Qt.AlignBottom // Keeps it level from the bottom

                                  contentItem: Text {
                                      text: "Add Product"
                                      font.pixelSize: 15
                                      font.bold: true
                                      color: "white"
                                      horizontalAlignment: Text.AlignHCenter
                                      verticalAlignment: Text.AlignVCenter
                                  }
                                  background: Rectangle {
                                      radius: 8
                                      color: "#31505E"
                                      opacity: addProductBtn.hovered ? 0.9 : 1.0
                                  }
                                  onClicked: addProductDialog.open()
                              }

                              // 3. THE SPACER: This pushes the search bar to the right corner
                              Item {
                                  Layout.fillWidth: true
                              }

                              // 4. Search Bar
                              TextField {
                                  id: searchBar
                                  placeholderText: "Search medicine name..."
                                  Layout.preferredWidth: 300
                                  Layout.preferredHeight: 40 // Matches the height of the buttons
                                  Layout.alignment: Qt.AlignBottom // Aligns the bottom edges

                                  verticalAlignment: TextInput.AlignVCenter
                                  leftPadding: 15

                                  onTextChanged: {
                                      inventoryManager.searchMedicine(text)
                                  }

                                  background: Rectangle {
                                      radius: 20
                                      border.color: "#31505E"
                                      color: "white"
                                  }
                              }
                          }





                        Column{
                            anchors.top: tabRow.bottom // Logic: Start exactly below the buttons
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 25
                                    spacing: 10

                            Row{
                                width: parent.width
                                height:40
                                Text { text: "ID"; width: 50; font.bold: true; color: "#7f8c8d" ;font.pixelSize: 15}
                                Text { text: "Product Name"; width: 200; font.bold: true; color: "#7f8c8d";font.pixelSize: 15 }
                                Text { text: "Category"; width: 120; font.bold: true; color: "#7f8c8d";font.pixelSize: 15}
                                Text { text: "Manufacturer"; width: 150; font.bold: true; color: "#7f8c8d";font.pixelSize: 15 }
                                Text { text: "Stock"; width: 80; font.bold: true; color: "#7f8c8d";font.pixelSize: 15 }
                                Text { text: "Price"; width: 80; font.bold: true; color: "#7f8c8d";font.pixelSize: 15 }
                                    }
                            ListView {
                                id: medicineList
                                width: parent.width
                                height: parent.height - 50
                                clip: true

                                // Initial model is the count
                                model: inventoryManager.getCount()

                                // THE FIX: Listen for the signal from C++
                                Connections {
                                    target: inventoryManager
                                    function onInventoryLoaded() {

                                        medicineList.model = 0;
                                        medicineList.model = inventoryManager.getCount();
                                    }
                                }

                                delegate: Rectangle {
                                    width: medicineList.width
                                    height: 50
                                    color: index % 2 === 0 ? "white" : "#f4f4f4"

                                    Row {
                                        spacing: 20
                                        anchors.verticalCenter: parent.verticalCenter
                                        leftPadding: 10

                                        Text { text: inventoryManager.getID(index); width: 50 }
                                        Text { text: inventoryManager.getName(index); width: 150; font.bold: true }
                                        Text { text: inventoryManager.getCategory(index); width: 100 }
                                        Text { text: inventoryManager.getManufacturer(index); width: 150 }
                                        Text { text: "Qty: " + inventoryManager.getQuantity(index); width: 80 }
                                        Text { text: "Rs. " + inventoryManager.getPrice(index); color: "green" }
                                        // Inside your Row in the ListView delegate
                                        Button {
                                            text: "Edit"
                                            // Styling to match your blue sidebar theme
                                            contentItem: Text { text: "Edit"; color: "#31505E"; font.bold: true; horizontalAlignment: Text.AlignHCenter }

                                            onClicked: {
                                                // Step 1: Tell the dialog which index we are on
                                                editDialog.targetIndex = index

                                                // Step 2: "Pull" current values from C++ using your existing getters
                                                editName.text = inventoryManager.getName(index)
                                                editCat.text = inventoryManager.getCategory(index)
                                                editMan.text = inventoryManager.getManufacturer(index)
                                                editQty.text = inventoryManager.getQuantity(index).toString()
                                                editPrice.text = inventoryManager.getPrice(index).toString()

                                                // Step 3: Open the dialog
                                                editDialog.open()
                                            }

                                        }
                                        // Inside your Row in the ListView delegate
                                        Button {
                                            text: "Delete"
                                            // Red text styling to indicate a destructive action
                                            contentItem: Text {
                                                text: "Delete"
                                                color: "red"
                                                font.bold: true
                                                horizontalAlignment: Text.AlignHCenter
                                            }

                                            onClicked: {
                                                    // Step 1: Save the index of this row
                                                    confirmDeleteDialog.indexToDelete = index

                                                    // Step 2: Open the confirmation pop-up
                                                    confirmDeleteDialog.open()
                                                }
                                        }
                                    }


                                }
                            }
                            }

                        }
        }





                    Rectangle {
                        color: "transparent"

                        Rectangle {
                            id: marketerMainRec
                            anchors.centerIn: parent
                            height: parent.height * 0.7
                            width: parent.width * 0.9
                            color: "white"
                            radius: 15
                            anchors.verticalCenterOffset: -45

                            Text {
                                text: "Marketer Dashboard"
                                font.pixelSize: 25
                                font.bold: true
                                anchors { top: parent.top; left: parent.left; topMargin: 25; leftMargin: 25 }
                            }

                            RowLayout {
                                id: marketerTabRow
                                spacing: 20
                                anchors {
                                    top: parent.top; left: parent.left; right: parent.right;
                                    topMargin: 100; leftMargin: 20; rightMargin: 20
                                }

                                // 1. Static Label
                                Button {
                                    id: markListBtn
                                    Layout.preferredWidth: 120
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    contentItem: Text {
                                        text: "Marketers"
                                        font.pixelSize: 15; font.bold: true; color: "#31505E"
                                        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        radius: 8; border.width: 1; border.color: "#31505E"
                                        color: markListBtn.hovered ? "#E1E8EB" : "transparent"
                                    }
                                }

                                // 2. Add Marketer Button
                                Button {
                                    id: addMarketerBtn
                                    Layout.preferredWidth: 150
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    contentItem: Text {
                                        text: "Add Marketer"
                                        font.pixelSize: 15; font.bold: true; color: "white"
                                        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        radius: 8; color: "#31505E"
                                        opacity: addMarketerBtn.hovered ? 0.9 : 1.0
                                    }
                                    onClicked: addMarketerDialog.open()
                                }

                                Item { Layout.fillWidth: true } // Spacer to push search to the right

                                // 3. Search Bar
                                TextField {
                                    id: marketerSearchBar
                                    placeholderText: "Search marketer name..."
                                    Layout.preferredWidth: 300
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    verticalAlignment: TextInput.AlignVCenter
                                    leftPadding: 15
                                    onTextChanged: marketerManager.searchMarketer(text)

                                    background: Rectangle {
                                        radius: 20; border.color: "#31505E"; color: "white"
                                    }
                                }
                            }

                            Column {
                                anchors {
                                    top: marketerTabRow.bottom; left: parent.left; right: parent.right;
                                    bottom: parent.bottom; margins: 25
                                }
                                spacing: 10

                                // Table Headers
                                Row {
                                    width: parent.width; height: 40
                                    Text { text: "ID"; width: 50; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Company Name"; width: 200; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Region"; width: 150; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Contact"; width: 150; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "License No."; width: 120; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                }

                                ListView {
                                    id: marketerListView
                                    width: parent.width; height: parent.height - 50; clip: true
                                    model: marketerManager.getCount()

                                    Connections {
                                        target: marketerManager
                                        function onMarketersLoaded() {
                                            marketerListView.model = 0;
                                            marketerListView.model = marketerManager.getCount();
                                        }
                                    }

                                    delegate: Rectangle {
                                        width: marketerListView.width; height: 50
                                        color: index % 2 === 0 ? "white" : "#f4f4f4"

                                        Row {
                                            spacing: 20; anchors.verticalCenter: parent.verticalCenter; leftPadding: 10

                                            Text { text: marketerManager.getID(index); width: 50 }
                                            Text { text: marketerManager.getName(index); width: 180; font.bold: true }
                                            Text { text: marketerManager.getRegion(index); width: 130 }
                                            Text { text: marketerManager.getContact(index); width: 130 }
                                            Text { text: marketerManager.getLicense(index); width: 100 }

                                            // Edit Button
                                            Button {
                                                text: "Edit"
                                                contentItem: Text { text: "Edit"; color: "#31505E"; font.bold: true }
                                                onClicked: {
                                                    editMarketerIndex = index
                                                    editMarkName.text = marketerManager.getName(index)
                                                    editMarkRegion.text = marketerManager.getRegion(index)
                                                    editMarkCon.text = marketerManager.getContact(index)
                                                    editMarkLic.text = marketerManager.getLicense(index)
                                                    editMarkRating.text = marketerManager.getRating(index).toString()
                                                    editMarketerDialog.open()
                                                }
                                            }

                                            // Delete Button
                                            Button {
                                                text: "Delete"
                                                contentItem: Text { text: "Delete"; color: "red"; font.bold: true }
                                                onClicked: {
                                                    confirmDeleteMarkDialog.indexToDelete = index
                                                    confirmDeleteMarkDialog.open()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }


                    Rectangle {
                        color: "transparent"

                        Rectangle {
                            id: manufacturerMainRec
                            anchors.centerIn: parent
                            height: parent.height * 0.7
                            width: parent.width * 0.9
                            color: "white"
                            radius: 15
                            anchors.verticalCenterOffset: -45

                            Text {
                                text: "Manufacturer Dashboard"
                                font.pixelSize: 25
                                font.bold: true
                                anchors { top: parent.top; left: parent.left; topMargin: 25; leftMargin: 25 }
                            }

                            RowLayout {
                                id: manTabRow
                                spacing: 20
                                anchors {
                                    top: parent.top; left: parent.left; right: parent.right;
                                    topMargin: 100; leftMargin: 20; rightMargin: 20
                                }

                                // 1. Label/Indicator
                                Button {
                                    id: manListBtn
                                    Layout.preferredWidth: 120
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    contentItem: Text {
                                        text: "Manufacturers"
                                        font.pixelSize: 15; font.bold: true; color: "#31505E"
                                        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        radius: 8; border.width: 1; border.color: "#31505E"
                                        color: manListBtn.hovered ? "#E1E8EB" : "transparent"
                                    }
                                }

                                // 2. Add Manufacturer Button
                                Button {
                                    id: addManBtn
                                    Layout.preferredWidth: 150
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    contentItem: Text {
                                        text: "Add Manufacturer"
                                        font.pixelSize: 15; font.bold: true; color: "white"
                                        horizontalAlignment: Text.AlignHCenter; verticalAlignment: Text.AlignVCenter
                                    }
                                    background: Rectangle {
                                        radius: 8; color: "#31505E"
                                        opacity: addManBtn.hovered ? 0.9 : 1.0
                                    }
                                    onClicked: addManDialog.open() // Ensure you create this Dialog
                                }

                                Item { Layout.fillWidth: true } // Spacer

                                // 3. Search Bar for Manufacturers
                                TextField {
                                    id: manSearchBar
                                    placeholderText: "Search manufacturer name..."
                                    Layout.preferredWidth: 300
                                    Layout.preferredHeight: 40
                                    Layout.alignment: Qt.AlignBottom
                                    verticalAlignment: TextInput.AlignVCenter
                                    leftPadding: 15
                                    onTextChanged: manManager.searchManufacturer(text)

                                    background: Rectangle {
                                        radius: 20; border.color: "#31505E"; color: "white"
                                    }
                                }
                            }

                            Column {
                                anchors {
                                    top: manTabRow.bottom; left: parent.left; right: parent.right;
                                    bottom: parent.bottom; margins: 25
                                }
                                spacing: 10

                                // Table Headers
                                Row {
                                    width: parent.width; height: 40
                                    Text { text: "ID"; width: 50; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Company Name"; width: 200; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Location"; width: 150; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Contact"; width: 150; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                    Text { text: "Type"; width: 100; font.bold: true; color: "#7f8c8d"; font.pixelSize: 15 }
                                }

                                ListView {
                                    id: manListView
                                    width: parent.width; height: parent.height - 50; clip: true
                                    model: manManager.getCount()

                                    Connections {
                                        target: manManager
                                        function onManufacturersLoaded() {
                                            manListView.model = 0;
                                            manListView.model = manManager.getCount();
                                        }
                                    }

                                    delegate: Rectangle {
                                        width: manListView.width; height: 50
                                        color: index % 2 === 0 ? "white" : "#f4f4f4"

                                        Row {
                                            spacing: 20; anchors.verticalCenter: parent.verticalCenter; leftPadding: 10

                                            Text { text: manManager.getID(index); width: 50 }
                                            Text { text: manManager.getName(index); width: 180; font.bold: true }
                                            Text { text: manManager.getLocation(index); width: 130 }
                                            Text { text: manManager.getContact(index); width: 130 }
                                            Text { text: manManager.getType(index); width: 80 }

                                            // Edit Button
                                            Button {
                                                text: "Edit"
                                                contentItem: Text { text: "Edit"; color: "#31505E"; font.bold: true }
                                                onClicked: {
                                                    // Logic to fill your Edit Dialog fields
                                                    editingManIndex = index
                                                    editManName.text = manManager.getName(index)
                                                    editManLoc.text = manManager.getLocation(index)
                                                    editManCon.text = manManager.getContact(index)
                                                    editManEmail.text = manManager.getEmail(index)
                                                    editManType.text = manManager.getType(index)
                                                    editManDialog.open()
                                                }
                                            }

                                            // Delete Button
                                            Button {
                                                text: "Delete"
                                                contentItem: Text { text: "Delete"; color: "red"; font.bold: true }
                                                onClicked: {
                                                    // Logic for delete confirmation
                                                    confirmDeleteManDialog.indexToDelete = index
                                                    confirmDeleteManDialog.open()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }


                    Rectangle {
                        color: "transparent"
                        Text { anchors.centerIn: parent; text: "Generate Receipt"; font.pixelSize: 32; color: "#31505E" }
                    }
                }


// --- Add Marketer Dialog ---
Dialog {
    id: addMarketerDialog
    title: "Register New Marketer"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 450; modal: true

    contentItem: ColumnLayout {
        spacing: 15; anchors.margins: 20
        Text { text: "Add Marketer/Distributor"; font.pixelSize: 22; font.bold: true; color: "#31505E"; Layout.alignment: Qt.AlignHCenter }

        TextField { id: newMarkName; placeholderText: "Marketer Name"; Layout.fillWidth: true }
        TextField { id: newMarkReg; placeholderText: "Region"; Layout.fillWidth: true }
        TextField { id: newMarkCon; placeholderText: "Contact"; Layout.fillWidth: true }
        TextField { id: newMarkLic; placeholderText: "License Number"; Layout.fillWidth: true }
        TextField { id: newMarkRat; placeholderText: "Rating (e.g. 4.5)"; Layout.fillWidth: true }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button { text: "Cancel"; onClicked: addMarketerDialog.close() }
            Button {
                text: "Save Marketer"; highlighted: true
                onClicked: {
                    marketerManager.addMarketer(newMarkName.text, newMarkReg.text, newMarkCon.text, newMarkLic.text, parseFloat(newMarkRat.text))
                    addMarketerDialog.close()
                }
            }
        }
    }
}

// --- Edit Marketer Dialog ---
Dialog {
    id: editMarketerDialog
    title: "Update Marketer"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 450; modal: true
    property int targetIndex: -1

    contentItem: ColumnLayout {
        spacing: 15; anchors.margins: 20
        Text { text: "Edit Marketer Details"; font.pixelSize: 22; font.bold: true; color: "#31505E"; Layout.alignment: Qt.AlignHCenter }

        TextField { id: editMarkName; placeholderText: "Name"; Layout.fillWidth: true }
        TextField { id: editMarkReg; placeholderText: "Region"; Layout.fillWidth: true }
        TextField { id: editMarkCon; placeholderText: "Contact"; Layout.fillWidth: true }
        TextField { id: editMarkLic; placeholderText: "License"; Layout.fillWidth: true }
        TextField { id: editMarkRat; placeholderText: "Rating"; Layout.fillWidth: true }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button { text: "Cancel"; onClicked: editMarketerDialog.close() }
            Button {
                text: "Update"; highlighted: true
                onClicked: {
                    marketerManager.editMarketer(editMarketerDialog.targetIndex, editMarkName.text, editMarkReg.text, editMarkCon.text, editMarkLic.text, parseFloat(editMarkRat.text))
                    editMarketerDialog.close()
                }
            }
        }
    }
}
Dialog {
    id: confirmDeleteMarkDialog
    title: "Confirm Deletion"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 350
    modal: true

    property int indexToDelete: -1

    contentItem: ColumnLayout {
        spacing: 20
        anchors.margins: 20
        Text {
            text: "Are you sure you want to delete this Marketer? This action cannot be undone."
            wrapMode: Text.WordWrap
            font.pixelSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    footer: DialogButtonBox {
        Button {
            text: "Yes, Delete"
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            palette.buttonText: "red"
        }
        Button {
            text: "Cancel"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
        onAccepted: {
            // Calls the marketer manager delete function
            marketerManager.deleteMarketer(confirmDeleteMarkDialog.indexToDelete)
        }
    }
}
Dialog {
    id: editDialog
    title: "Update Medicine Information"

    // This ensures it stays centered inside your 1200x800 dashboard
    parent: Overlay.overlay
    anchors.centerIn: parent

    width: 450
    height: 500
    modal: true // This creates the dark "dimmed" effect on the dashboard behind it
    focus: true

    // Property to track which medicine is being edited
    property int targetIndex: -1

    background: Rectangle {
        color: "white"
        radius: 10
        border.color: "#31505E"
        border.width: 1
    }

    contentItem: ColumnLayout {
        spacing: 20
        anchors.margins: 20

        Text {
            text: "Modify Product Details"
            font.pixelSize: 22
            font.bold: true
            color: "#31505E"
            Layout.alignment: Qt.AlignHCenter
        }

        // Form Fields
        TextField { id: editName; placeholderText: "Medicine Name"; Layout.fillWidth: true }
        TextField { id: editCat; placeholderText: "Category"; Layout.fillWidth: true }
        TextField { id: editMan; placeholderText: "Manufacturer"; Layout.fillWidth: true }
        TextField { id: editQty; placeholderText: "Quantity"; Layout.fillWidth: true; inputMethodHints: Qt.ImhDigitsOnly }
        TextField { id: editPrice; placeholderText: "Price"; Layout.fillWidth: true; inputMethodHints: Qt.ImhFormattedNumbersOnly }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            spacing: 10
            Button {
                text: "Cancel"
                onClicked: editDialog.close()
            }
            Button {
                text: "Update Entry"
                highlighted: true
                onClicked: {
                    // This triggers the C++ slot we discussed
                    inventoryManager.editMedicine(
                        editDialog.targetIndex,
                        editName.text,
                        editMan.text,
                        editCat.text,
                        parseInt(editQty.text),
                        parseFloat(editPrice.text)
                    );
                    editDialog.close();
                }
            }
        }
    }
}
// --- Add Manufacturer Dialog ---
Dialog {
    id: addManDialog
    title: "Register New Manufacturer"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 450; modal: true

    contentItem: ColumnLayout {
        spacing: 15; anchors.margins: 20
        Text { text: "Add Manufacturer"; font.pixelSize: 22; font.bold: true; color: "#31505E"; Layout.alignment: Qt.AlignHCenter }

        TextField { id: newManName; placeholderText: "Company Name"; Layout.fillWidth: true }
        TextField { id: newManLoc; placeholderText: "Location (e.g. Karachi)"; Layout.fillWidth: true }
        TextField { id: newManCon; placeholderText: "Contact Number"; Layout.fillWidth: true }
        TextField { id: newManEmail; placeholderText: "Email Address"; Layout.fillWidth: true }
        TextField { id: newManType; placeholderText: "Type (National/Multinational)"; Layout.fillWidth: true }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button { text: "Cancel"; onClicked: addManDialog.close() }
            Button {
                text: "Save Manufacturer"; highlighted: true
                onClicked: {
                    manManager.addManufacturer(newManName.text, newManLoc.text, newManCon.text, newManEmail.text, newManType.text)
                    addManDialog.close()
                    // Optional: clear text fields here
                }
            }
        }
    }
}

// --- Edit Manufacturer Dialog ---
Dialog {
    id: editManDialog
    title: "Update Manufacturer"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 450; modal: true
    property int targetIndex: -1

    contentItem: ColumnLayout {
        spacing: 15; anchors.margins: 20
        Text { text: "Edit Manufacturer Details"; font.pixelSize: 22; font.bold: true; color: "#31505E"; Layout.alignment: Qt.AlignHCenter }

        TextField { id: editManName; placeholderText: "Company Name"; Layout.fillWidth: true }
        TextField { id: editManLoc; placeholderText: "Location"; Layout.fillWidth: true }
        TextField { id: editManCon; placeholderText: "Contact"; Layout.fillWidth: true }
        TextField { id: editManEmail; placeholderText: "Email"; Layout.fillWidth: true }
        TextField { id: editManType; placeholderText: "Type"; Layout.fillWidth: true }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button { text: "Cancel"; onClicked: editManDialog.close() }
            Button {
                text: "Update"; highlighted: true
                onClicked: {
                    manManager.editManufacturer(editManDialog.targetIndex, editManName.text, editManLoc.text, editManCon.text, editManEmail.text, editManType.text)
                    editManDialog.close()
                }
            }
        }
    }
}
}
Dialog {
    id: confirmDeleteDialog
    title: "Confirm Deletion"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 350
    modal: true

    // We need to store the index temporarily so we know WHICH one to delete
    property int indexToDelete: -1

    contentItem: ColumnLayout {
        spacing: 20
        anchors.margins: 20
        Text {
            text: "Are you sure you want to delete? This action cannot be undone."
            wrapMode: Text.WordWrap
            font.pixelSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    footer: DialogButtonBox {
        Button {
            text: "Yes, Delete"
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            palette.buttonText: "red"
        }
        Button {
            text: "Cancel"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
        onAccepted: {
            inventoryManager.deleteMedicine(confirmDeleteDialog.indexToDelete)
        }
    }
}
Dialog {
    id: confirmDeleteManDialog
    title: "Confirm Deletion"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 350
    modal: true

    property int indexToDelete: -1

    contentItem: ColumnLayout {
        spacing: 20
        anchors.margins: 20
        Text {
            text: "Are you sure you want to delete this Manufacturer? This action cannot be undone."
            wrapMode: Text.WordWrap
            font.pixelSize: 16
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    footer: DialogButtonBox {
        Button {
            text: "Yes, Delete"
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
            palette.buttonText: "red"
        }
        Button {
            text: "Cancel"
            DialogButtonBox.buttonRole: DialogButtonBox.RejectRole
        }
        onAccepted: {
            // Calls the manufacturer manager delete function
            manManager.deleteManufacturer(confirmDeleteManDialog.indexToDelete)
        }
    }
}
Dialog {
    id: addProductDialog
    title: "Add New Product"
    parent: Overlay.overlay
    anchors.centerIn: parent
    width: 450
    modal: true

    background: Rectangle {
        radius: 10
        border.color: "#31505E"
        border.width: 1
    }

    contentItem: ColumnLayout {
        spacing: 15
        anchors.margins: 20

        Text { text: "Enter Product Details"; font.bold: true; font.pixelSize: 20; color: "#31505E" }

        TextField { id: newName; placeholderText: "Medicine Name"; Layout.fillWidth: true }
        TextField { id: newCat; placeholderText: "Category (e.g. Tablet, Syrup)"; Layout.fillWidth: true }
        TextField { id: newMan; placeholderText: "Manufacturer"; Layout.fillWidth: true }
        TextField { id: newQty; placeholderText: "Initial Stock"; Layout.fillWidth: true; inputMethodHints: Qt.ImhDigitsOnly }
        TextField { id: newPrice; placeholderText: "Price (Rs.)"; Layout.fillWidth: true; inputMethodHints: Qt.ImhFormattedNumbersOnly }

        RowLayout {
            Layout.alignment: Qt.AlignRight
            Button { text: "Cancel"; onClicked: addProductDialog.close() }
            Button {
                text: "Save Product"
                highlighted: true
                onClicked: {
                    inventoryManager.addMedicine(
                        newName.text,
                        newMan.text,
                        newCat.text,
                        parseInt(newQty.text),
                        parseFloat(newPrice.text)
                    );

                    // Clear fields for next time
                    newName.text = ""; newMan.text = ""; newCat.text = "";
                    newQty.text = ""; newPrice.text = "";

                    addProductDialog.close();
                }
            }
        }
    }
}
// Tracks which index we are currently modifying





}





