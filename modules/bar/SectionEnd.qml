import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.config
import qs.widgets

import "widgets"

Item {
    Layout.fillHeight: true
    Layout.fillWidth: true

    SugoiRectangle {
        visible: ShellStates.flags.bar.barFloating
        color: "blue" // temp for dev
        anchors.fill: parent
    }

    Grid {
        columns: ShellStates.flags.bar.barVertical
        rows: !ShellStates.flags.bar.barVertical
        horizontalItemAlignment: Grid.AlignHCenter
        verticalItemAlignment: Grid.AlignVCenter

        anchors {
            right: ShellStates.flags.bar.barVertical ? undefined : parent.right
            bottom: ShellStates.flags.bar.barVertical ? parent.bottom : undefined
            horizontalCenter: ShellStates.flags.bar.barVertical ? parent.horizontalCenter : undefined
            verticalCenter: ShellStates.flags.bar.barVertical ? undefined : parent.verticalCenter
            bottomMargin: ShellStates.flags.bar.barVertical? 6 : undefined
        }

        spacing: 4

        BarSystemTray {}
        Clock {}
        QuickSettings {}
    }
}