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
            required property var modelData //IMPORTANT!!
            screen: modelData
            color: "transparent"
            
            BackgroundEffect.blurRegion: Region { item: panel }

            SugoiRectangle {
                id: panel
                anchors.fill: parent
                opacity: 0.7
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

                SectionStart {}
                SectionCenter {}
                SectionEnd {}
            }
        }
    }
}
