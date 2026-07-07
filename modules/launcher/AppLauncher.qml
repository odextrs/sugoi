import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.widgets


import Qt.labs.folderlistmodel

// Still an experiment :O
SugoiPanelWindow {
    color: "transparent"
    id: root
    implicitHeight: 200
    implicitWidth: 200

    exclusionMode: ExclusionMode.Normal

    SugoiRectangle {
        anchors.fill: parent
        radius: 8
    }

    FolderListModel {
        id: desktopFiles
        folder: "file:///usr/share/applications" 
        
        showDirs: false
        showDotAndDotDot: false
        nameFilters: ["*.desktop"]

        onCountChanged: {
            for (let i = 0; i < desktopFiles.count; ++i) {
                console.log(desktopFiles.get(i, "fileName"));
            }
        }
    }

    Column {
        TextInput {
            text: "Hello world"
            color: "white"
        }

        ScrollView {
            ColumnLayout {
                Repeater {
                    model: desktopFiles

                    SugoiText {
                        text: modelData.fileName
                        color: "white"
                    }

                }
            }
        }
    }

}