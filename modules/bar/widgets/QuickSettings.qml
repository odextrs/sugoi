pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.widgets
import qs.config

import "qsPages"
import "qsPages/miscPanels"

Scope {
    id: root
    property bool toggled: false
    property bool isEnabled: true
    property int currentPage: 0
    readonly property var pageComponents: [
        mainPanelComp,
        mediaPanelComp
    ]

    Component { id: mainPanelComp; MainPanel{} }
    Component { id: mediaPanelComp; MediaPanel{} }

    Timer {
        id: hideTimer
        interval: 210
        repeat: false
        onTriggered: root.isEnabled = false
    }

    function toggle() {
        if ( toggled ) {
            toggled = false
            hideTimer.restart()
            if ( PowerMenu.toggled === true ) { PowerMenu.toggle() }
            if ( NetworkPanel.toggled === true ) { NetworkPanel.toggle() }
        } else {
            hideTimer.stop()
            isEnabled = true
            toggled = true
        }
    }

    SugoiPanelWindow {
        id: bkg
        implicitHeight: 200
        implicitWidth: 365
        color: "transparent"
        visible: isEnabled
        exclusiveZone: 0

        BackgroundEffect.blurRegion: Region { item: ShellStates.flags.bar.floatingWidgets ? null : blurArea; radius: blurArea.radius }

        Rectangle { id: blurArea; anchors.fill: parent; color: ShellStates.flags.bar.floatingWidgets ? Colour.surface : "transparent"; radius: 8}

        property real slideOffset: toggled ? 10 : ShellStates.flags.bar.barVertical ? -implicitWidth : -implicitHeight - 160

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
            top: 10
            right: ShellStates.flags.bar.barVertical ? 10 : slideOffset
        }

        Row {
            id: row
            spacing: 0

            SugoiRectangle {
                implicitWidth: 50
                implicitHeight: bkg.height
                color: Qt.rgba ( Colour.surface.r, Colour.surface.g, Colour.surface.b, 0.7 )
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
                            messageSize: 16

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
                color: Qt.rgba ( Colour.surface.r, Colour.surface.g, Colour.surface.b, 0.7 )

                Loader {
                    id: pageLoader
                    anchors.fill: parent
                    sourceComponent: root.pageComponents[root.currentPage]
                }
            }
        }
    }
}