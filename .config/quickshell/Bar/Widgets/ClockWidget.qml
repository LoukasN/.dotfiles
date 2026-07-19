import QtQuick
import Quickshell
import "../../Common/"
import "../../Services/"

Item {
    id: root
    implicitWidth: timeText.width
    implicitHeight: timeText.height

    required property PanelWindow parentWindow

    Text {
        id: timeText
        text: TimeService.time
        color: Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold
    }

    InfoPopup {
        anchors.fill: parent
        parentWindow: root.parentWindow
        text: TimeService.date
    }
}
