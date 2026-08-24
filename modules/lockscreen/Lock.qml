import Quickshell
import Quickshell.Io
import Quickshell.Services.Pam
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.NoButton

                onPositionChanged: {
                    smt.restartBurnInTimer()
                }
            }

            Keys.onPressed: {
                smt.restartBurnInTimer()
            }

            Timer {
                id: idleTimerBurnIn
                interval: 180000
                repeat: false
                running: true
                onTriggered: {
                    if (!smt.unlockInProgress)
                        monitorOff.running = true
                }
            }

            function restartBurnInTimer() {
                monitorOn.running = true
                idleTimerBurnIn.stop()
                idleTimerBurnIn.start()
            }

            Process {
                id: monitorOff
                command: ["niri", "msg", "action", "power-off-monitors"]
            }

            Process {
                id: monitorOn
                command: ["niri", "msg", "action", "power-on-monitors"]
            }

            Image {
                id: bg
                //source: Quickshell.env("HOME") + "/.local/state/quickshell/user/lockscreen.png"
                fillMode: Image.PreserveAspectCrop
                anchors.fill: parent
            }

            FileView {
                id: wpPath
                path: Quickshell.env("HOME") + "/.local/state/quickshell/user/generated/wallpaper/path.txt"
                watchChanges: true
                onLoaded: {
                    bg.source = text().trim()
                }
            }

            MultiEffect {
                anchors.fill: bg
                source: bg
                blur: 0.4
                blurEnabled: true
            }

            SugoiClock {
                anchors.centerIn: parent
                size: 84
            }

            Item {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 20
                implicitWidth: 320
                implicitHeight: 40

                MultiEffect {
                    anchors.fill: psArea
                    source: psBkg
                    blur: 0.4
                    blurEnabled: true
                    opacity: psArea.opacity
                }

                TextField {
                    id: psArea
                    property real bkgOpacity: ShellStates.flags.bar.floatingWidgets ? 1.0 : 0.7
                    anchors.centerIn: parent
                    background: SugoiRectangle {
                        id: psBkg
                        color: Qt.rgba(
                            Colour.surfaceContainerLow.r,
                            Colour.surfaceContainerLow.g,
                            Colour.surfaceContainerLow.b,
                            psArea.bkgOpacity
                        )
                        radius: 8
                    }
                    implicitHeight: 40
                    implicitWidth: 160
                    padding: 8
                    font.pixelSize: 12
                    color: Colour.primary
                    placeholderText: smt.showFailure ? "Wrong Password" : "Password.."
                    placeholderTextColor: Colour.primary
                    echoMode: TextInput.Password
                    focus: true
                    horizontalAlignment: TextInput.AlignHCenter
                    opacity: 0
                    cursorDelegate: Rectangle { width: 0; height: 0 }

                    Component.onCompleted: smt.revealInput()

                    onAccepted: {
                        smt.revealInput()
                        smt.tryUnlock()
                    }

                    onTextChanged: {
                        smt.currentText = text
                        smt.revealInput()
                    }

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 850
                            easing.type: Easing.OutCubic
                        }
                    }

                    Timer {
                        id: idleTimer
                        interval: 3000
                        repeat: false
                        onTriggered: {
                            if (!smt.unlockInProgress && psArea.text === "" && !psArea.hovered)
                                psArea.opacity = 0;
                        }
                    }

                    HoverHandler {
                        id: psHover
                        onHoveredChanged: {
                            if (hovered) {
                                smt.revealInput()
                            } else if (psArea.text === "") {
                                idleTimer.restart()
                            }
                        }
                    }
                }
            }

            property string currentText: ""
            property bool unlockInProgress: false
            property bool showFailure: false

            signal failed
            signal unlocked

            onCurrentTextChanged: showFailure = false

            function revealInput() {
                psArea.opacity = 1;
                idleTimer.restart();
            }

            function reset() {
                currentText = "";
                unlockInProgress = false;
                showFailure = false;
            }

            function tryUnlock() {
                smt.unlockInProgress = true
                pam.start()
            }

            PamContext {
                id: pam
                configDirectory: "pam"
                config: "password.conf"

                onPamMessage: {
                    if (this.responseRequired)
                        this.respond(smt.currentText)
                }

                onCompleted: result => {
                    smt.unlockInProgress = false

                    if (result === PamResult.Success) {
                        smt.reset()
                        lock.locked = false
                        smt.unlocked()
                    } else {
                        smt.currentText = ""
                        smt.showFailure = true
                        smt.failed()
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