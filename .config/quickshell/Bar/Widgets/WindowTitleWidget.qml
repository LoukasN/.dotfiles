import QtQuick
import "../../Services/"

Text {
    visible: HyprlandService.activeWindowTitle !== "";
    text: HyprlandService.activeWindowTitle
    color: Theme.fg
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    font.weight: Font.Bold
    elide: Text.ElideRight
    maximumLineCount: 1
}
