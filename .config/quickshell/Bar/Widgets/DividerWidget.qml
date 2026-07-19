import QtQuick
import "../../Services/"

Text {
    text: "│"
    color: Theme.fg
    font.family: Theme.font
    font.pixelSize: Theme.fontSize * 0.8
    font.weight: Font.Bold
    opacity: 0.6
    leftPadding: Theme.dividerSidesPadding
    rightPadding: Theme.dividerSidesPadding
}
