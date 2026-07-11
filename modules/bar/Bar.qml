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

            implicitWidth: 40 //36

            GridLayout {
                anchors.fill: parent
                columns: ShellStates.flags.bar.barVertical
                rows: !ShellStates.flags.bar.barVertical

                columnSpacing: 0
                rowSpacing: 0

                SectionStart {}
                SectionCenter {}
                SectionEnd {}
            }
        }
    }
}
