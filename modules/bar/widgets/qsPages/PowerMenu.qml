pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

import qs.widgets
import qs.config

Scope {
    id: root
    property bool toggled: false
    property bool isEnabled: false

    Timer {
        id: hideTimer
        interval: 210
        repeat: false
        onTriggered: root.isEnabled = false
    }

    function toggle() {
        if (toggled) {
            toggled = false
            hideTimer.restart()
        } else {
            hideTimer.stop()
            isEnabled = true
            toggled = true
        }
    }

    SugoiPanelWindow {
        id: bkg
        implicitHeight: 200
        implicitWidth: 70
        color: "transparent"
        visible: isEnabled

        BackgroundEffect.blurRegion: Region { item: rect }
        
        property real slideOffset: toggled ? 385 : ShellStates.flags.bar.barVertical ? -implicitWidth : implicitHeight - 250

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

        SugoiRectangle {
            id: rect
            implicitWidth: 70
            implicitHeight: bkg.height
            color: Qt.rgba ( Colour.surface.r, Colour.surface.g, Colour.surface.b, 0.7 )
            radius: 8

            Column {
                anchors.centerIn: parent
                spacing: 5

                QsButton {
                    implicitWidth: 60
                    message: "󰐥"
                    messageSize: 26
                    onLeftClicked: shutdownProcess.running = true
                }
                QsButton {
                    implicitWidth: 60
                    message: "󰤄"
                    messageSize: 20
                    onLeftClicked: sleepProcess.running = true
                }
                QsButton {
                    implicitWidth: 60
                    message: "󰜉"
                    messageSize: 24
                    onLeftClicked: rebootProcess.running = true
                }
            }
        }

        Process {
            id: rebootProcess
            command: ["systemctl", "reboot"]
        }
        Process {
            id: shutdownProcess
            command: ["systemctl", "poweroff"]
        }
        Process {
            id: sleepProcess
            command: ["systemctl", "suspend"]
        }
    }
}