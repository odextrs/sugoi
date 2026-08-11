pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Networking
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import qs.widgets
import qs.config
import qs.services
import ".."

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
            SugoiNetwork.toggled = false
        } else {
            hideTimer.stop()
            isEnabled = true
            toggled = true
            SugoiNetwork.toggled = true
            SugoiNetwork.scan
        }
    }

    SugoiPanelWindow {
        id: bkg
        implicitHeight: 400
        implicitWidth: 365
        color: "transparent"
        visible: isEnabled

        BackgroundEffect.blurRegion: Region { item: rect; radius: rect.radius }
        
        property real slideOffset: toggled ? 10 : ShellStates.flags.bar.barVertical ? -implicitWidth : -implicitHeight + 40

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
            bottom: ShellStates.flags.bar.barVertical ? 220 : 10
            top: !ShellStates.flags.bar.barVertical ? 220 : 10
            right: ShellStates.flags.bar.barVertical ? 10 : slideOffset
        }

        SugoiRectangle {
            id: rect
            implicitWidth: 365
            implicitHeight: bkg.height
            color: Qt.rgba ( Colour.surface.r, Colour.surface.g, Colour.surface.b, 0.7 )
            radius: 8

            ScrollView {
                anchors.fill: parent

                Column {
                    id: col
                    width: parent.width
                    spacing: 8

                    Repeater {
                        model: SugoiNetwork.availableWifi

                        delegate: QsButton {
                            required property var modelData
                            width: 360
                            implicitHeight: 40
                            message: modelData.ssid
                            messageSize: 15
                            onLeftClicked: {
                                SugoiNetwork.connect(modelData.ssid)
                            }
                        }
                    }
                }
            }
        }
    }
}