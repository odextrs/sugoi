import Quickshell
import QtQuick
import qs.widgets

// An experiment
PanelWindow {
    id: root
    implicitHeight: 200
    implicitWidth: 200

    color: '#71020514'

    exclusionMode: ExclusionMode.Normal

    Column {
        TextInput {
            text: "Hello world"
            color: "white"
        }
    
        SugoiButton {
            message: "test"
        }
    }

}