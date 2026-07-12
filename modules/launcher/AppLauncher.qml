import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.widgets
import qs.config

import Quickshell.Widgets

Scope {
    property bool isActive: false;

    LazyLoader {

        active: isActive

    SugoiPanelWindow {
        color: "transparent"
        id: root
        implicitHeight: 350
        implicitWidth: 400

        focusable: true

        exclusionMode: ExclusionMode.Ignore

        SugoiRectangle {
            anchors.fill: parent
            radius: 12
        }

        Column {
            anchors.centerIn: parent
            height: parent.height - 12
            width: parent.width - 12

            spacing: 8

            SugoiTextInput {
                id: inputBox
                width: parent.width
            }

            ScrollView {
                height: parent.height - inputBox.height

                ScrollBar.vertical.policy: ScrollBar.AlwaysOn

                ColumnLayout {
                    Repeater {
                        model: DesktopEntries.applications.values.filter(entry => {
                            return entry.name.toLowerCase().includes(inputBox.text);
                        })

                        SugoiRectangle {
                            id: appItem
                            implicitHeight: content.height + 6
                            implicitWidth: root.width
                            radius: 2

                            RowLayout {
                                id: content
                                spacing: 4

                                anchors.verticalCenter: parent.verticalCenter

                                IconImage {
                                    source: Quickshell.iconPath(modelData.icon)
                                    implicitSize: 24
                                }

                                SugoiText {
                                    text: modelData.name
                                    font.pixelSize: 16
                                }
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: modelData.execute()
                                onEntered: appItem.color = Colour.surfaceVariant
                                onExited: appItem.color = Colour.surface
                            }
                        }
                    }
                }
            }
        }

        Shortcut {
            sequence: "Escape"
            onActivated: isActive = !isActive
        }
    }

    }
}