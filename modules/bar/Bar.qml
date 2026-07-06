import Quickshell
import Quickshell.Wayland
import QtQuick
//import "widgets"
import qs.widgets
import qs.config

Scope {
    Variants {
        model: Quickshell.screens

        SugoiPanelWindow {
            // BarSystemTray {}
        }
        anchors {
            top: true
            left: true
            bottom: ShellStates.flags.bar.barVertical
            right: ShellStates.flags.bar.barVertical
        }
    }
}
