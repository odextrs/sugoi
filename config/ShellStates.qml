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
            property bool isActive: true
            property bool barVertical: true
            property bool barFloating: false
            property int barSize: 40
            property bool floatingWidgets: false
            property bool floatingWidgetsBlur: false // <- this sucks btw - mori
            property bool floatingCorners: false

            property JsonObject widgets: JsonObject {
                property bool centerSection: true
            }
        }

        property JsonObject notifications: JsonObject {
            property bool isActive: true
        }

        property JsonObject appLauncher: JsonObject {
            property bool isActive: true
        }

        property JsonObject quickSettings: JsonObject {
            property bool isFocusable: true
        }
    }
}