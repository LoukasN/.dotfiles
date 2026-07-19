import QtQuick
import "../../Services/"

Item {
    id: root
    implicitWidth: Theme.buttonWidth
    implicitHeight: Theme.barHeight

    property bool active: false
    signal toggled

    Text {
        anchors.centerIn: parent
        text: root.active ? "" : ""
        color: Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        onClicked: root.toggled()
    }
}
