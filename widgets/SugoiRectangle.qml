import QtQuick
import qs.config

Rectangle {
    id: root

    color: Colour.surface //surfaceContainer

    Behavior on color {
        ColorAnimation {
            duration: 500
            easing.type: Easing.BezierSpline
        }
    }
}