import QtQuick
import Quickshell
import Quickshell.Io
import "../../Services/"
import "../../Common/"

Row {
    id: root
    required property PanelWindow parentWindow

    Text {
        id: output
        text: AudioService.outputIcon + " " + AudioService.outputVolume + "%"
        color: AudioService.outputMuted ? Theme.warning : Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold
        property real scrollAccum: 0

        MouseArea {
            z: 1
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onWheel: wheel => {
                output.scrollAccum += wheel.angleDelta.y;
                if (Math.abs(output.scrollAccum) >= 120) {
                    const delta = wheel.angleDelta.y > 0 ? 0.01 : -0.01;
                    const newVolume = Math.max(0, Math.min(1.5, AudioService.outputVolume / 100 + delta));
                    AudioService.setVolume(newVolume);
                    output.scrollAccum = 0;
                }
            }
            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    if (!pavuProc.running)
                        pavuProc.running = true;
                } else {
                    AudioService.toggleOutputMute();
                }
            }
        }

        InfoPopup {
            anchors.fill: parent
            parentWindow: root.parentWindow
            text: AudioService.sinkName
            enabled: true
        }
    }
    Text {
        id: input
        text: " " + (AudioService.inputMuted ? "" : "")
        color: AudioService.inputMuted ? Theme.warning : Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold

        MouseArea {
            z: 1
            cursorShape: Qt.PointingHandCursor
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton
            onClicked: mouse => {
                if (mouse.button === Qt.LeftButton) {
                    if (!pavuInputProc.running)
                        pavuInputProc.running = true;
                } else {
                    AudioService.toggleInputMute();
                }
            }
        }

        InfoPopup {
            anchors.fill: parent
            parentWindow: root.parentWindow
            text: AudioService.sourceName
            enabled: true
        }
    }

    Process {
        id: pavuProc
        command: ["pavucontrol", "-t", "3"]
    }

    Process {
        id: pavuInputProc
        command: ["pavucontrol", "-t", "4"]
    }
}
