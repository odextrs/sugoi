import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

import qs.config
import qs.widgets

ShellRoot {
    id: root

    WlSessionLock {
        id: lock

        WlSessionLockSurface {
            id: smt
            color: Colour.surface

            Image {
                id: bg
                source: Quickshell.env("HOME") + "/.local/state/quickshell/user/lockscreen.png"
                height: smt.screen.height
                width: smt.screen.width
            }

            MultiEffect {
                anchors.fill: bg
                source: bg
                blur: 0.4
                blurEnabled: true
            }

            ColumnLayout {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                spacing: 36

                SugoiClock {
                    anchors.centerIn: parent
                    size: 84
                }

                TextField {
                    background: SugoiRectangle {
                        color: Qt.rgba(
                            Colour.surface.r,
                            Colour.surface.g,
                            Colour.surface.b,
                            0.7
                        )
                        radius: 8
                    }
                    implicitWidth: 400
                    padding: 8
                    font.pixelSize: 16
                    placeholderText: "Password"
                    echoMode: TextInput.Password

                    onAccepted: {
                        lock.locked = false;
                    }
                }

            }
        }
    }

    IpcHandler {
        target: "lock"
        function lock() {
            lock.locked = true;
        }
    }
}