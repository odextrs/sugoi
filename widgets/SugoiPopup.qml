import Quickshell
import Quickshell.Widgets
import QtQuick
import qs.config
import qs.widgets

//TODO: open on the side of the bar instead of on top
//TODO: sliding animation
//TODO: click outside the window / Press ESC to close the Popup
PopupWindow {
    id: trayPopup
    required property Item _trayItem
    required property var _menuOpener

    visible: false
    anchor.item: _trayItem
    implicitWidth: 200
    implicitHeight: {
        const items = _menuOpener.children.values
        const vis = items.filter((e, i) => !(e.isSeparator && (i === 0 || i === items.length - 1)))
        return vis.reduce((sum, e) => sum + (e.isSeparator ? 9 : 32), 0 + Math.max(0, vis.length - 1) * 2 + 8)
    }

    color: "transparent"

    SugoiRectangle { //background
        id: menuRectangle
        anchors.fill: parent
        radius: 4
        Column {
            anchors.fill: parent
            anchors.margins: 4
            spacing: 2

            Repeater {
                model: _menuOpener.children
                delegate: Item {
                    required property var modelData
                    required property int index
                    readonly property bool edgeSeparator: modelData.isSeparator && (index === 0 || index === _menuOpener.children.values.length - 1)
                    width: parent.width
                    height: edgeSeparator ? 0 : modelData.isSeparator ? 9 : 32
                    visible: !edgeSeparator

                    SugoiRectangle { // separator
                        visible: modelData.isSeparator
                        anchors.centerIn: parent
                        width: parent.width - 8
                        height: 1
                        color: Colour.outlineVariant
                    }

                    Rectangle { // <- popup item
                        visible: !modelData.isSeparator
                        anchors.fill: parent
                        radius: 4
                        color: itemHover.containsMouse
                             ? Colour.surfaceContainerHigh
                             : "transparent"

                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 8
                            spacing: 8

                            IconImage {
                                //visible: modelData.icon =/= ""
                                source: modelData.icon
                                implicitSize: 16
                            }

                            SugoiText {
                                text: modelData.text
                                color: modelData.enabled
                                     ? Colour.surfaceOn
                                     : Colour.surfaceVariantOn
                                font.pixelSize: 13
                            }
                        }

                        MouseArea {
                            id: itemHover
                            anchors.fill: parent
                            hoverEnabled: true
                            enabled: modelData.enabled
                            onClicked: {
                                modelData.triggered()
                                trayPopup.visible = false
                                activePopup = null
                            }
                        }
                    }
                }
            }
        }
    }
}