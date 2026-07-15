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

    function toggle() {
        toggled = !toggled
        console.log ("power menu toggle")
    }

    LazyLoader {
        active: toggled

        SugoiPanelWindow {
            anchors.left: true
            anchors.right: true
            anchors.top: true
            anchors.bottom: true
            color: "transparent"
            visible: toggled
            exclusiveZone: 0

            focusable: true

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                hoverEnabled: true

                onClicked: (mouse) => {
                    switch (mouse.button) {
                        case Qt.LeftButton:
                            toggled = false
                            break;
                        case Qt.RightButton:
                            toggled = false
                            break;
                        case Qt.MiddleButton:
                            toggled = false
                            break;
                    }
                }
            }

            property int slideOffset: toggled ? 0 : -implicitHeight

            Behavior on slideOffset {
                NumberAnimation {
                    id: slideY
                    duration: 250
                    easing.type: Easing.OutCubic
                }
            }

            Shortcut {
                sequence: "Escape"
                onActivated: toggled = false
            }

            SugoiRectangle {
                radius: 16
                implicitHeight: 190
                implicitWidth: 540
                anchors.centerIn: parent

                GridLayout {
                    anchors.centerIn: parent
                    SugoiButton {
                        message: "󰜉"
                        messageSize: 86
                        implicitHeight: 170
                        implicitWidth: 170
                        radius: 16
                        onLeftClicked: rebootProcess.running = true
                    }
                    SugoiButton {
                        message: "󰐥"
                        messageSize: 90
                        implicitHeight: 170
                        implicitWidth: 170
                        radius: 16
                        onLeftClicked: shutdownProcess.running = true
                    }
                    SugoiButton {
                        message: "󰤄"
                        messageSize: 80
                        implicitHeight: 170
                        implicitWidth: 170
                        radius: 16
                        onLeftClicked: sleepProcess.running = true
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
}