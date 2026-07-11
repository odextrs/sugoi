import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import qs.widgets
import qs.config

//wip
Item {
    id: mediaQsPage

    Layout.fillWidth: true
    Layout.fillHeight: true

    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values
    property MprisPlayer activePlayer: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null
    readonly property url artUrl: activePlayer?.metadata["xesam:url"] ?? ""

    //fallback to get directly from youtube, since firefox doesn't expose Mpris.artUrl
    //chromium gives a super low res image via Mpris.artUrl, and doesn't expose xesam.url so it's not possible to do the same workaround.
    function youtubeThumbnail(url) {
        const id = url?.match(/[?&]v=([^&]+)/)?.[1];
        return id ? `https://i.ytimg.com/vi/${id}/hqdefault.jpg` : "";
    }

    GridLayout {
        columns: 2
        //rows: 3
        anchors.centerIn: parent

        GridLayout {
            Layout.rowSpan: 2
            Layout.columnSpan: 2
            columns: 2
            rows: 3

            SugoiRectangle {
                Layout.preferredWidth: 264//305
                Layout.preferredHeight: 125
                Layout.rowSpan: 3
                //Layout.columnSpan: 2

                Image {
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop
                    source: activePlayer.trackArtUrl || youtubeThumbnail(activePlayer?.metadata["xesam:url"])
                    cache: false
                    asynchronous: true
                }
            }

            QsButton {
                message: "󰼨"
                buttonBackground: "transparent"
                onLeftClicked: { activePlayer.previous() }
                implicitHeight: 36
                implicitWidth: 36
            }

            QsButton {
                message: activePlayer.isPlaying? "󰏤" : "󰐊"
                onLeftClicked: { activePlayer.togglePlaying() }
                implicitHeight: 36
                implicitWidth: 36
            }

            QsButton {
                message: "󰼧"
                buttonBackground: "transparent"
                onLeftClicked: { activePlayer.next() }
                implicitHeight: 36
                implicitWidth: 36
            }
        }

        GridLayout {
            Layout.columnSpan: 2
            columns: 1
        
            /*QsButton {
                message: trackTitle
                onLeftClicked: {
                    onLeftClicked: {
                        console.log("URL:", artUrl)
                        console.log("MPRIS:", activePlayer.trackArtUrl)
                        console.log("YT:", youtubeThumbnail(artUrl))
                    }
                }
            }*/

            SugoiText {
                text: activePlayer?.trackTitle
                elide: Text.ElideRight
                isMonospace: false
                Layout.preferredWidth: 300
                Layout.maximumWidth: 300
            }

            SugoiSlider {
                maxValue: activePlayer?.length ?? 0
                value: activePlayer?.position ?? 0
                width: 300

                onValueModified: value => {
                    if (activePlayer)
                        activePlayer.seek((value - activePlayer.position))
                }
            }

            SugoiText {
                Layout.preferredWidth: 300
                Layout.maximumWidth: 300
                text: activePlayer?.trackArtist
                elide: Text.ElideRight
                font.pixelSize: 10
                isMonospace: false
            }
        }
    }
}