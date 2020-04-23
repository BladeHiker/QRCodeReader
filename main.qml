import QtQuick 2.12
import QtQuick.Window 2.12
import Shot 1.0

Window {
    visible: true
    id: window
    flags: Qt.Window
    width: 200
    height: 200
    color: "#00000000"
    title: qsTr("老段二维码撕裂者")
    Shot {
        id: shotClass
    }

    Rectangle {
        id: shot
        color: "#00000000"
        anchors.top: parent.top
        anchors.topMargin: 0
        width: parent.width
        height: parent.height - 30
        border.width: 2
        anchors.left: parent.left
        anchors.leftMargin: 0
    }
    Rectangle {
        id: rectangle
        height: 30
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Rectangle {
            id: btn_shot
            width: 30
            height: 30
            color: "#b2fcfc"
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            Text {
                text: qsTr("Scan")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
            }
            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onDoubleClicked: legendView.visible = false
                onClicked: {
                    mouse.accepted = true
                    var s = shotClass.shot(shot.mapToGlobal(0, 0).x,
                                           shot.mapToGlobal(0, 0).y,
                                           shot.width, shot.height)
                    if (s == "")
                        textEdit.text = "识别失败!"
                    else {
                        textEdit.text = s
                    }
                }
            }
        }

        TextEdit {
            id: textEdit
            width: parent.width - 30
            text: "扫描上方的二维码"
            height: 30
            clip: true
            leftPadding: 5
            padding: 2
            selectByMouse: true
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 15
        }
    }
}