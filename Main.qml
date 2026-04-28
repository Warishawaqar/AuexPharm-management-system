import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls
Window {
    width: 800
    height: 480
    visible: true
    title: qsTr("Hello World")
    color:"#f2f2f0"


Rectangle{
    id:rect
    anchors.centerIn: parent
    width: 800
    height:480
    radius: 0
    clip: true
    color: "#ffffff"

    RowLayout{
    width: parent.width
    height: parent.height

    Rectangle{
        id:rec1
        color: "steelblue"
        radius: rect.radius
        clip:true
        gradient: Gradient {
                orientation: Gradient.Vertical

                GradientStop {
                    id: topStop
                    position: 0.0
                    color: "#4A90D9"

                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { to: "#23325A"; duration: 2000; easing.type: Easing.InOutQuad }
                        ColorAnimation { to: "#4A90D9"; duration: 2000; easing.type: Easing.InOutQuad }
                    }
                }
                GradientStop {
                            id: bottomStop
                            position: 1.0
                            color: "#23325A"

                            SequentialAnimation on color {
                                loops: Animation.Infinite
                                ColorAnimation { to: "#4A90D9"; duration: 2000; easing.type: Easing.InOutQuad }
                                ColorAnimation { to: "#23325A"; duration: 2000; easing.type: Easing.InOutQuad }
                            }
                        }
                    }




        Layout.fillWidth: true
        Layout.fillHeight: true


    Text{
        id:helloText
      text: "Hello,"
      anchors.horizontalCenter: parent.horizontalCenter
              anchors.verticalCenter: parent.verticalCenter
              anchors.verticalCenterOffset: -25
              anchors.horizontalCenterOffset: -25

      font.pixelSize:  45
      color:"white"


    }
    Text{
        text:"welcome"
        font.pixelSize: 45
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 10
        anchors.top: helloText.bottom

        color:"white"
        font.bold:true
        anchors.topMargin: -8
    }
    }

    Rectangle{
        id:rec2
        radius: rect.radius
        Layout.fillWidth: true
        Layout.fillHeight: true

        color: "#ffffff"


        ColumnLayout{
            width: parent.width
            height:parent.height
            spacing:0
            Text{
                text: "Log In"
                font.bold: true
                font.pixelSize: 35
                Layout.alignment: Qt.AlignHCenter
            }
            Text{
                text:"Welcome back to the system.\n Please login to continue"
                font.pixelSize: 20
                color: "#a6a6a6"
                 Layout.alignment: Qt.AlignHCenter


            }
            TextField{
                id: emailinput
                placeholderText: "Email"
                Layout.preferredWidth: parent.width*0.8
                Layout.alignment: Qt.AlignHCenter
                background:Rectangle{
                    implicitHeight: 45
                    radius: 8
                    border.color: emailinput.activeFocus?"#3498db":"#e0e0e0"
                    border.width: emailinput.activeFocus?2:1

                }
            }
            TextField{
                id:passwordInput
                placeholderText: "Password"
                Layout.preferredWidth: parent.width*0.8
                Layout.alignment: Qt.AlignHCenter
                background: Rectangle{
                    implicitHeight: 45
                    radius:8
                    border.color: passwordInput.activeFocus ? "#3498db" : "#e0e0e0"
                    border.width: passwordInput.activeFocus ? 2 : 1
                }
            }
            Button{
                text: "Sign in"
                id:loginButton
                Layout.preferredWidth: parent.width * 0.8
                Layout.preferredHeight: 50
                Layout.alignment: Qt.AlignHCenter
                contentItem: Text {
                        text: loginButton.text
                        font.pixelSize: 18
                        font.bold: true
                        color: "white" // White text on blue background
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                background: Rectangle {
                        color: loginButton.down ? "#357abd" : "#4A90D9" // Darker blue when pressed
                        radius: 10

                        layer.enabled: true

                    }
                onClicked: {

                    if (myAuth.checkCredentials(emailinput.text, passwordInput.text)) {
                      console.log("Success!")
                      errorMessage.visible = false


                    }
                    else{
                        errorMessage.visible = true

                    }
                    }
                    }



            Text{
                id:errorMessage
                text: "Invalid email or password. Please try again."
                color: "red"
                font.pixelSize: 14
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
            }


    }
    }
}
}
}
