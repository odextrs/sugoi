import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    id: panel
    property string namespace: "sugoi"
    WlrLayershell.namespace: namespace
}