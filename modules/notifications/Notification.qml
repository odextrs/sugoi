import Quickshell
import Quickshell.Widgets
import QtMultimedia
import Quickshell.Services.Notifications

import QtQuick
import QtQuick.Layouts
import qs.widgets

// This got me thinking.... Should we just make the panel transparent by default?
// Every time we create a panel window, we make it transparent...
SugoiPanelWindow {
    id: root
    color: "transparent"

    implicitWidth: 350
    implicitHeight: Math.max(0, notifications.height)

    anchors {
        top: true
        right: true
    }

    margins {
        top: 12
        right: 12
    }

    ColumnLayout {
        id: notifications
        width: parent.width

        Repeater {
            model: notificationService.trackedNotifications
            SugoiRectangle {
                required property var modelData
                implicitWidth: parent.width
                implicitHeight: content.height + 16
                radius: 8

                opacity: 0.7

                Timer {
                    interval: 5000
                    running: true
                    onTriggered: modelData.tracked = false;
                }

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
                Some apps send a "suppress sound" hint (but somehow my discord doesn't?)
                so we don't play our notification sound since it's already managed by the client.
                https://specifications.freedesktop.org/notification/latest/hints.html
                */
                LazyLoader {
                    active: !modelData.hints["suppress-sound"]

                    MediaPlayer {
                        id: someSound
                        source: "../../assets/audio/47313572-notification-2-269292.mp3" // you tell me if we should rename it to notification.mp3
                        autoPlay: true
                        audioOutput: AudioOutput {
                            volume: 1.0
                        }
                    }
                }
            }
        }

    }

    // We will have to move it somewhere else if we want to add a notifications widget to our bar.
    NotificationServer {
        id: notificationService
        onNotification: notification => notification.tracked = true;
    }
}