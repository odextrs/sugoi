import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

import "widgets"

Item {
    property alias background: sectionBkg
    Layout.fillHeight: true
    Layout.fillWidth: true
    visible: ShellStates.flags.bar.widgets.centerSection

    SugoiRectangle {
        id: sectionBkg
        visible: ShellStates.flags.bar.floatingWidgets
        color: ShellStates.flags.bar.floatingWidgetsBlur ? "transparent" : Colour.surface
        height: grid.height + 12
        width: grid.width + 12
        radius: 8
        anchors.centerIn: grid
    }

    Grid {
        id: grid
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter
        anchors {
            centerIn: parent
        }

        WindowTitle {}
    }
}