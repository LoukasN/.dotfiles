pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../Services/"
import "./Widgets/"

Scope {
    id: scope
    property bool barVisible: true
    required property var networkMenu
    required property var bluetoothMenu

    IpcHandler {
        target: "bar"
        function toggle() {
            scope.barVisible = !scope.barVisible;
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: panelWindow
            required property var modelData
            screen: modelData

            visible: scope.barVisible

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: Theme.topMargin
                left: Theme.leftMargin
                right: Theme.rightMargin
            }

            implicitHeight: Theme.barHeight
            color: Theme.barBg

            RowLayout {
                anchors.fill: parent

                Rectangle {
                    implicitHeight: Theme.barHeight
                    implicitWidth: leftRow.implicitWidth + Theme.barPadding
                    color: Theme.bg
                    radius: Theme.radius

                    RowLayout {
                        id: leftRow
                        anchors.centerIn: parent

                        WorskpacesWidget {
                            screen: panelWindow.modelData
                        }

                        WindowTitleWidget {
                            id: windowTitle
                            Layout.leftMargin: windowTitle.text === "" ? 0 : 8
                            Layout.rightMargin: windowTitle.text === "" ? 0 : 8
                            Layout.maximumWidth: 800
                        }
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    color: Theme.bg
                    radius: Theme.radius
                    implicitHeight: Theme.barHeight
                    implicitWidth: rightRow.implicitWidth + Theme.barPadding * 2

                    RowLayout {
                        id: rightRow
                        anchors.centerIn: parent
                        spacing: Theme.widgetSpacing

                        BacklightWidget {}

                        DividerWidget {}

                        AudioWidget {
                            parentWindow: panelWindow
                        }

                        DividerWidget {}

                        NetworkWidget {
                            parentWindow: panelWindow
                            networkMenu: scope.networkMenu
                        }

                        DividerWidget {}

                        BluetoothWidget {
                            parentWindow: panelWindow
                            bluetoothMenu: scope.bluetoothMenu
                        }

                        DividerWidget {}

                        BatteryWidget {
                            parentWindow: panelWindow
                        }

                        DividerWidget {}

                        ClockWidget {
                            parentWindow: panelWindow
                        }

                        DividerWidget {}

                        LanguageWidget {}

                        DividerWidget {}

                        IdleInhibitor {
                            id: idleInhibitor
                            window: panelWindow
                        }

                        IdleInhibitorWidget {
                            id: inhibitorWidget
                            active: idleInhibitor.enabled
                            onToggled: {
                                idleInhibitor.enabled = !idleInhibitor.enabled;
                            }
                        }

                        DividerWidget {
                            visible: trayWidget.count > 0
                        }

                        SystemTrayWidget {
                            id: trayWidget
                            parentWindow: panelWindow
                        }
                    }
                }
            }
        }
    }
}
