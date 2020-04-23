import QtQuick 2.12
import QtQuick.Window 2.12
import Shot 1.0

Window {
    visible: true
    id: window
    flags: Qt.Window | Qt.WindowStaysOnTopHint | Qt.WindowTitleHint
           | Qt.WindowMinMaxButtonsHint | Qt.WindowCloseButtonHint | Qt.WindowSystemMenuHint
    width: 200
    height: 200
    color: "#00000000"
    title: qsTr("老段二维码撕裂者")
    Shot {
        id: shotClass
    }
    function scan() {
        var s = shotClass.shot(shot.mapToGlobal(0, 0).x,
                               shot.mapToGlobal(0, 0).y, shot.width,
                               shot.height)
        if (s == "")
            textEdit.text = "识别失败!"
        else {
            textEdit.text = s
        }
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
        focus: true
        Keys.enabled: true
        Keys.onPressed: {
            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                scan()
            }
            event.accepted = true
        }
        Rectangle {
            id: btn_shot
            width: 30
            height: 30
            color: btn_mouse.pressed ? "#0078d7" : "#b2fcfc"
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
                id: btn_mouse
                anchors.fill: parent
                propagateComposedEvents: true
                onDoubleClicked: legendView.visible = false
                onClicked: {
                    mouse.accepted = true
                    scan()
                }
            }
        }

        TextEdit {
            id: textEdit
            width: parent.width - 30
            text: "扫描上方的二维码"
            readOnly: true
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
    MouseArea {
        id: dragRegion
        anchors.fill: parent
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        property point prePoint: Qt.point(0, 0)
        property int datX: 0
        property int datY: 0
        onPressed: {
            prePoint = Qt.point(mouseX, mouseY)
        }
        onPositionChanged: {
            if (pressed && !(datX == -1 * (mouseX - prePoint.x)
                             && datY == -1 * (mouseY - prePoint.y))) {
                datX = mouseX - prePoint.x
                datY = mouseY - prePoint.y
                window.x += datX
                window.y += datY
            }
        }
    }
}
