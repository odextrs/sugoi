import Quickshell
import Quickshell.Widgets
import QtQuick

import qs.widgets
import qs.config

import Quickshell.Services.SystemTray

SugoiRectangle {
    implicitWidth: content.width
    implicitHeight: content.height

    Grid {
        id: content
        anchors.centerIn: parent
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        spacing: 4

        Repeater {
            model: SystemTray.items

            Item {
                implicitWidth: appIcon.width
                implicitHeight: appIcon.height

                IconImage {
                    id: appIcon
                    source: modelData.icon
                    implicitSize: 18
                }

                LazyLoader {
                    id: appMenu
                    active: false

                    // experiment
                    PopupWindow {
                        anchor.item: appIcon
                        color: 'red'
                        implicitWidth: 200
                        implicitHeight: 200
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: () => {
                        console.log("beep");
                    }
                }

            }
        }
    }
}