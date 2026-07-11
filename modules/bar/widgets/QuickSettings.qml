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
        mainPanelComp,
        mediaPanelComp
    ]

    Component { id: mainPanelComp; MainPanel{} }
    Component { id: mediaPanelComp; MediaPanel{} }

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

        property int slideOffset: toggled ? 10 : ShellStates.flags.bar.barVertical ? -implicitWidth : -implicitHeight

        Behavior on slideOffset {
            NumberAnimation {
                id: slideY
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        anchors {
            bottom: ShellStates.flags.bar.barVertical
            left: ShellStates.flags.bar.barVertical
            top: !ShellStates.flags.bar.barVertical
            right: !ShellStates.flags.bar.barVertical
        }

        margins {
            left: ShellStates.flags.bar.barVertical ? slideOffset : 10
            bottom: 10
            top: ShellStates.flags.bar.barVertical ? 10 : slideOffset
            right: 10
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
                topLeftRadius: 8
                bottomLeftRadius: 8

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
                topRightRadius: 8
                bottomRightRadius: 8
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