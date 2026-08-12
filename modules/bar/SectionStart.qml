import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

import "widgets"

Item {
    id: root
    property alias background: sectionBkg
    property var screen

    Layout.fillHeight: true
    Layout.fillWidth: true

    SugoiRectangle {
        id: sectionBkg
        visible: ShellStates.flags.bar.floatingWidgets
        color: ShellStates.flags.bar.floatingWidgetsBlur ? "transparent" : Colour.surface
        height: grid.height + 6
        width: grid.width + 6
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
            left: ShellStates.flags.bar.barVertical ? undefined : parent.left
            top: ShellStates.flags.bar.barVertical ? parent.top : undefined
            horizontalCenter: ShellStates.flags.bar.barVertical ? parent.horizontalCenter : undefined
            verticalCenter: ShellStates.flags.bar.barVertical ? undefined : parent.verticalCenter
            topMargin: ShellStates.flags.bar.barVertical ? 6 : undefined
            leftMargin: ShellStates.flags.bar.barVertical ? undefined : 8
        }

        Workspace { screen: root.screen }
    }
}