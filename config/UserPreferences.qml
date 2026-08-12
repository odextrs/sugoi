pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root

    FileView {
        path: Quickshell.env("HOME") + "/.local/state/quickshell/user/preferences.json"

        JsonAdapter {
            id: adapter

            property JsonObject bar: JsonObject {
                property var isActive
                property var barVertical
                property var barFloating
                property var barSize
                property var floatingWidgets
                property var floatingWidgetsBlur
                property var floatingCorners

                property JsonObject widgets: JsonObject {
                    property var centerSection
                }
            }

            property JsonObject notifications: JsonObject {
                property var isActive
            }

            property JsonObject appLauncher: JsonObject {
                property var isActive
            }
        }
    }

    property alias bar: adapter.bar
    property alias notifications: adapter.notifications
    property alias appLauncher: adapter.appLauncher
}