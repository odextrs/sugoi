import Quickshell
import Quickshell.Widgets
import QtQuick

import qs.widgets
import qs.config

import Quickshell.Services.SystemTray

SugoiRectangle {
    property var activePopup: null
    implicitWidth: content.width
    implicitHeight: content.height
    color: "transparent"

    Grid {
        id: content
        anchors.centerIn: parent
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        spacing: 4

        Repeater {
            model: SystemTray.items

            Item {
                id: trayItem
                implicitWidth: appIcon.width
                implicitHeight: appIcon.height

                IconImage {
                    id: appIcon
                    source: modelData.icon
                    implicitSize: 18
                }

                QsMenuOpener {
                    id: menuOpener
                    menu: modelData.hasMenu? modelData.menu : null
                }

                //this works but optimization..?
                SugoiPopup {
                    id: trayPopup

                    _trayItem: trayItem
                    _menuOpener: menuOpener
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: () => {
                        console.log("beep");
                        if (modelData.hasMenu) {
                            if (activePopup) activePopup.visible = false;
                            trayPopup.visible = !trayPopup.visible
                            activePopup = trayPopup.visible ? trayPopup : null
                        }
                    }
                }
            }
        }
    }
}