import QtQuick
import Quickshell
import Quickshell.Wayland

import qs.config
import qs.widgets

//todo
Scope {
    id: root
    property bool toggled: false

    SugoiPanelWindow {

        focusable: ShellStates.flags.quickSettings.isFocusable

        Shortcut {
            sequence: "Escape"
            onActivated: toggle()
        }
    }
}