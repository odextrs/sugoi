pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    property alias flags: jsonAdapter

    JsonAdapter {
        id: jsonAdapter

        property JsonObject bar: JsonObject {
            property bool barVertical: false
            property bool barFloating: false
            property bool floatingWidgets: false
            property bool floatingCorners: false

            property JsonObject widgets: JsonObject {
                
            }
        }
    }
}