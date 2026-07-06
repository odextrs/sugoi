import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.config

PanelWindow {
    id: panel
    property string namespace: "sugoi"
    WlrLayershell.namespace: namespace

    color: Colour.surface

    Behavior on color {
        ColorAnimation {
            duration: 500
            easing.type: Easing.BezierSpline
        }
    }
}