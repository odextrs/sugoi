pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.widgets
import qs.config

import "qsPages"

// todo: quick settings panel

Scope {
    id: root
    property bool toggled: false
    property int currentPage: 0
    readonly property var pageComponents: [
        mainPanelComp
    ]

    Component { id: mainPanelComp; MainPanel{} }

    function toggle() {
        toggled = !toggled
        console.log ("qs toggle")
    }

    SugoiPanelWindow {
        id: bkg
        implicitHeight: 200
        implicitWidth: 365
        color: "transparent"
        visible: toggled
        exclusiveZone: 0

        /*Behavior on visible {
            NumberAnimation {
                //duration: 500
                //easing.type: Easing.BezierSpline
            }
        }*/

        anchors {
            bottom: ShellStates.flags.bar.barVertical
            left: ShellStates.flags.bar.barVertical
            top: !ShellStates.flags.bar.barVertical
            right: !ShellStates.flags.bar.barVertical
        }

        Row {
            spacing: 0

            SugoiRectangle {
                implicitWidth: 50
                implicitHeight: bkg.height
                color: Qt.rgba (
                    Colour.surface.r,
                    Colour.surface.g,
                    Colour.surface.b,
                    0.7
                )

                Column {
                    anchors.centerIn: parent
                    spacing: 16
                    Repeater {
                        model: [
                            { label: "", page: 0 },
                            { label: "󰲸", page: 1 },
                            { label: "󰍡", page: 2 }
                        ]

                        delegate: SugoiButton {
                            id: button
                            required property string label
                            required property int page
                            message: label
                            messageSize: 20

                            buttonBackground: root.currentPage === page ? Colour.primary : button.hovered ? Colour.secondary : "transparent"
                            messageColor: root.currentPage === page ? Colour.secondaryOn : button.hovered ? Colour.secondaryOn : Colour.primary

                            onLeftClicked: {
                                root.currentPage = page
                            }
                        }
                    }
                }
            }

            SugoiRectangle {
                topRightRadius: 4
                implicitWidth: bkg.width - 50
                implicitHeight: bkg.height
                color: Qt.rgba (
                    Colour.surface.r,
                    Colour.surface.g,
                    Colour.surface.b,
                    0.7
                )

                Loader {
                    id: pageLoader
                    anchors.fill: parent
                    sourceComponent: root.pageComponents[root.currentPage]
                }
            }
        }
    }
}