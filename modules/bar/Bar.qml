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
            
            BackgroundEffect.blurRegion: Region {
                Region {
                    item: ShellStates.flags.bar.floatingWidgets ? null: panel
                }
                Region {
                    item: ShellStates.flags.bar.floatingWidgetsBlur ? center.background : null
                    radius: ShellStates.flags.bar.floatingWidgetsBlur ? 8 : 0
                }
                Region {
                    item: ShellStates.flags.bar.floatingWidgetsBlur ? start.background : null
                    radius: ShellStates.flags.bar.floatingWidgetsBlur ? 8 : 0
                }
                Region {
                    item: ShellStates.flags.bar.floatingWidgetsBlur ? end.background : null
                    radius: ShellStates.flags.bar.floatingWidgetsBlur ? 8 : 0
                }
            }

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

            implicitWidth: ShellStates.flags.bar.barVertical ? ShellStates.flags.bar.barSize : modelData.width
            implicitHeight: !ShellStates.flags.bar.barVertical ? ShellStates.flags.bar.barSize : modelData.height

            GridLayout {
                anchors.fill: parent
                columns: ShellStates.flags.bar.barVertical ? 1 : 3
                rows: ShellStates.flags.bar.barVertical ? 3 : 1

                columnSpacing: 0
                rowSpacing: 0

                SectionStart { id: start; screen: modelData; }
                SectionCenter { id: center }
                SectionEnd { id: end }
            }
        }
    }
}
