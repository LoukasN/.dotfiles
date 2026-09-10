import Quickshell.Io
import QtQuick
import QtQuick.Controls
import "../Services/"
import "../Common/"

PopupMenu {
    id: menu

    onVisibleChanged: if (visible) {
        WallpaperService.refreshList();
        focusItem.focusedIndex = 0;
        focusItem.forceActiveFocus();
    }

    Item {
        id: focusItem
        implicitWidth: grid.implicitWidth
        implicitHeight: grid.implicitHeight
        focus: true
        onFocusedIndexChanged: grid.positionViewAtIndex(focusedIndex, GridView.Contain)

        property int focusedIndex: 0
        readonly property int count: WallpaperService.wallpapers.length

        Keys.onEscapePressed: menu.close()
        Keys.onLeftPressed: moveFocus(0, -1)
        Keys.onRightPressed: moveFocus(0, 1)
        Keys.onUpPressed: moveFocus(-1, 0)
        Keys.onDownPressed: moveFocus(1, 0)
        Keys.onReturnPressed: {
            WallpaperService.setWallpaper(WallpaperService.wallpapers[focusedIndex]);
            menu.close();
        }

        function moveFocus(rowPosition, columnPosition) {
            const columnCount = Theme.thumbnailColumns;
            const rowCount = Math.ceil(count / columnCount);
            let row = Math.floor(focusedIndex / columnCount);
            let column = focusedIndex % columnCount;
            row = (row + rowPosition + rowCount) % rowCount;
            column = (column + columnPosition + columnCount) % columnCount;
            let index = row * columnCount + column;
            if (index >= count)
                index = count - 1;
            focusedIndex = index;
        }

        GridView {
            id: grid
            cellWidth: Theme.thumbnailWidth + Theme.gridSpacingWidth
            cellHeight: Theme.thumbnailHeight + Theme.gridSpacingHeight
            implicitWidth: cellWidth * Theme.thumbnailColumns
            implicitHeight: Math.min(cellHeight * Math.ceil(WallpaperService.wallpapers.length / Theme.thumbnailColumns), Theme.maxGridHeight)
            clip: true
            model: WallpaperService.wallpapers
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AsNeeded
            }
            delegate: Item {
                id: cell
                required property var modelData
                required property int index
                width: Theme.thumbnailWidth
                height: Theme.thumbnailHeight

                Image {
                    anchors.fill: parent
                    source: "file://" + WallpaperService.wallpaperDir + modelData
                    fillMode: Image.PreserveAspectCrop
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: 2
                    border.color: {
                        if (cell.index === focusItem.focusedIndex || mouseArea.containsMouse) {
                            return Theme.accent;
                        } else if (cell.modelData === WallpaperService.current) {
                            return Theme.specialAccent;
                        } else {
                            return "transparent";
                        }
                    }
                }
                MouseArea {
                    id: mouseArea
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: {
                        focusItem.focusedIndex = cell.index;
                        WallpaperService.setWallpaper(modelData);
                        menu.close();
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "wallpaperMenu"
        function toggle() {
            if (WallpaperService.wallpapers.length > 0)
                menu.toggle();
        }
    }
}
