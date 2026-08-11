import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import "widgets"
import qs.widgets
import qs.config

Scope {
    Variants {
        model: Quickshell.screens

        SugoiPanelWindow {
            required property var modelData
            screen: modelData
            color: "transparent"
            
            BackgroundEffect.blurRegion: Region { item: ShellStates.flags.bar.floatingWidgets ? null : panel; radius: panel.radius }

            SugoiRectangle {
                id: panel
                anchors.fill: parent
                //color: Colour.surfaceContainer
                opacity: 0.7
                visible: !ShellStates.flags.bar.floatingWidgets
            }

            anchors {
                top: true
                left: true
                bottom: ShellStates.flags.bar.barVertical
                right: !ShellStates.flags.bar.barVertical
            }

            implicitWidth: ShellStates.flags.bar.barVertical ? ShellStates.flags.bar.barSize : undefined
            implicitHeight: !ShellStates.flags.bar.barVertical ? ShellStates.flags.bar.barSize : undefined

            GridLayout {
                anchors.fill: parent
                columns: ShellStates.flags.bar.barVertical ? 1 : 3
                rows: ShellStates.flags.bar.barVertical ? 3 : 1

                columnSpacing: 0
                rowSpacing: 0

                SectionStart { screen: modelData; }
                SectionCenter {}
                SectionEnd {}
            }
        }
    }
}
