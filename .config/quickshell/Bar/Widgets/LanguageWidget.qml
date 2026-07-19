import QtQuick
import "../../Services/"

Text {
    text: {
        const lang = HyprlandService.keyboardLayout.toLowerCase();
        if (lang.includes("english"))
            return "EN";
        if (lang.includes("greek"))
            return "GR";
        return "";
    }
    color: Theme.fg
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    font.weight: Font.Bold
}
