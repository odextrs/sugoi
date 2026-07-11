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

    readonly property var activePlayer: Mpris.activePlayer
    readonly property bool hasMedia: activePlayer !== null
    readonly property string trackArtist: hasMedia ? activePlayer.trackArtist : ""
    readonly property string trackTitle: hasMedia ? activePlayer.trackTitle : ""
    readonly property url artUrl: hasMedia ? activePlayer.trackArtUrl : ""

    GridLayout {
        columns: 2
        //rows: 4
        anchors.centerIn: parent

        QsButton {
            message: trackArtist
        }

        QsButton {
            message: trackTitle
        }

        QsButton {
            message: "wewe"
        }

        QsButton {
            message: "wewew"
        }

        QsButton {
            message: "wewewe"
        }

        QsButton {
            message: "wewewew"
        }
    }
}