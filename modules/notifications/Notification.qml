import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtMultimedia

import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.services
import qs.config

SugoiPanelWindow {
    id: root
    color: "transparent"

    implicitWidth: 350
    implicitHeight: Math.max(0, notifications.height)
    exclusiveZone: 0

    BackgroundEffect.blurRegion: Region { item: notifications; radius: 8 }

    anchors {
        top: true
    }

    margins {
        top: 10
    }

    ColumnLayout {
        id: notifications
        width: parent.width

        Repeater {
            model: SugoiNotifications.getNotifications()

            Loader {

                //required property var modelData

                active: !ShellStates.flags.notifications.doNotDisturb || (modelData.urgency > 1)

                sourceComponent: SugoiRectangle {
                id: notification

                implicitWidth: notifications.width
                implicitHeight: content.height + 16
                radius: 8

                opacity: 0.7

                RowLayout {
                    id: content
                    anchors.centerIn: parent
                    width: parent.width - 12
                    spacing: 8

                    Loader {
                        active: modelData.image
                        sourceComponent: IconImage {
                            source: modelData.image
                            implicitSize: 42
                        }
                    }

                    Column {
                        id: details
                        spacing: 2

                        Layout.fillWidth: true

                        SugoiText {
                            text: modelData.summary?? modelData.title
                            font.pixelSize: 14
                            font.bold: true
                        }

                        SugoiText {
                            width: parent.width
                            text: modelData.body
                            font.pixelSize: 14
                            maximumLineCount: 3
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                        }
                    }

                }

                /*
                Some apps send a "suppress sound" hint
                so we don't play our notification sound since it's already managed by the client.
                https://specifications.freedesktop.org/notification/latest/hints.html
                */
                LazyLoader {
                    active: !modelData.hints["suppress-sound"]

                    MediaPlayer {
                        id: someSound
                        source: "../../assets/audio/notification.wav"
                        autoPlay: true
                        audioOutput: AudioOutput {
                            volume: 1.0
                        }
                    }
                }
            }

            Timer {
                interval: 5000
                running: true
                onTriggered: modelData.tracked = false;
            }

            }
        }

    }
}