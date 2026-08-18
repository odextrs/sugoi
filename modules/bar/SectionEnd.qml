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
            right: ShellStates.flags.bar.barVertical ? undefined : parent.right
            bottom: ShellStates.flags.bar.barVertical ? parent.bottom : undefined
            horizontalCenter: ShellStates.flags.bar.barVertical ? parent.horizontalCenter : undefined
            verticalCenter: ShellStates.flags.bar.barVertical ? undefined : parent.verticalCenter
            bottomMargin: ShellStates.flags.bar.barVertical? 6 : undefined
            rightMargin: ShellStates.flags.bar.barVertical? undefined : 8
        }

        spacing: ShellStates.flags.bar.barVertical? 4 : 8

        // -- modules
        BarSystemTray {}
        //Clock {}
        SugoiClock {
            isVertical: ShellStates.flags.bar.barVertical
        }

        // -- quick settings button
        SugoiButton {
            message: ""
            messageSize: 16
            messageColor: Colour.primary
            buttonBackground: "transparent"

            onLeftClicked: {
                QuickSettings.toggle()
            }
        }   
    }
}