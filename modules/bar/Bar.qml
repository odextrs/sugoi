import Quickshell
import Quickshell.Wayland
import QtQuick
import "widgets"
import qs.widgets
import qs.config

import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens

        SugoiPanelWindow {
            color: '#71020514'

            anchors {
                top: true
                left: true
                bottom: ShellStates.flags.bar.barVertical
                right: !ShellStates.flags.bar.barVertical
            }

            implicitWidth: 36

            Grid {
                anchors {
                    right: ShellStates.flags.bar.barVertical ? undefined : parent.right
                    bottom: ShellStates.flags.bar.barVertical ? parent.bottom : undefined
                    horizontalCenter: ShellStates.flags.bar.barVertical ? parent.horizontalCenter : undefined
                    verticalCenter: ShellStates.flags.bar.barVertical ? undefined : parent.verticalCenter
                }

                columns: ShellStates.flags.bar.barVertical
                rows: !ShellStates.flags.bar.barVertical
                spacing: 4

                BarSystemTray {}
                Clock {}
            }
        }
    }
}
