import QtQuick
import "../../Services/"
Text {
    id: root
    text: " " + BacklightService.percent + "%"
    color: Theme.fg
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    font.weight: Font.Bold
    property real scrollAccum: 0
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onWheel: wheel => {
            root.scrollAccum += wheel.angleDelta.y;
            if (Math.abs(root.scrollAccum) >= 120) {
                const delta = wheel.angleDelta.y > 0 ? 1 : -1;
                BacklightService.setBrightness(BacklightService.percent + delta);
                root.scrollAccum = 0;
            }
        }
    }
}
