pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.widgets
import qs.config


Scope {
    id: root
    property bool toggled: false

    function toggle() {
        toggled = !toggled
        console.log ("power menu toggle")
    }

    //wtf? why does this make the toggle() function not work????
    //WlrLayershell.layer: WlrLayer.Overlay

    SugoiPanelWindow {
        id: bkg
        implicitHeight: 200
        implicitWidth: 365
        //color: "transparent"
        visible: toggled
        exclusiveZone: 0

        //BackgroundEffect.blurRegion: Region { item: row }

        property int slideOffset: toggled ? 0 : -implicitHeight

        Behavior on slideOffset {
            NumberAnimation {
                id: slideY
                duration: 250
                easing.type: Easing.OutCubic
            }
        }

        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
    }
}