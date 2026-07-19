import Quickshell
import Quickshell.Io
import QtQuick

import qs.widgets
import qs.config

Rectangle {
    color: "transparent"
    height: workspaceGrid.height
    width: workspaceGrid.width

    property var workspacesData: [];

    Process {
        running: true  
        command: ["niri", "msg", "-j", "event-stream"]
        stdout: SplitParser {
            onRead: data => {
                let event = JSON.parse(data);
                if (event.WorkspacesChanged)
                    workspacesData = event.WorkspacesChanged.workspaces.sort((a, b) => a.idx - b.idx);
                if (event.WorkspaceActivated)
                    workspacesJsonProcess.running = true
            }
        }
    }

    Process {
        id: workspacesJsonProcess
        running: true  
        command: ["niri", "msg", "-j", "workspaces"]
        stdout: SplitParser {
            onRead: data => {
                workspacesData = JSON.parse(data).sort((a, b) => a.idx - b.idx);
            }
        }
    }

    Grid {
        id: workspaceGrid
        columns: 1
        rows: 0

        spacing: 4
        anchors.centerIn: parent

        Repeater {
            model: workspacesData

            SugoiRectangle {
                implicitWidth: 26
                implicitHeight: 26
                radius: 4

                color: workspacesData[index].is_active ? Colour.secondaryContainer : "transparent"

                SugoiText {
                    anchors.centerIn: parent
                    text: workspacesData[index].idx
                    font.pixelSize: 14
                }
            }
        }
    }

}