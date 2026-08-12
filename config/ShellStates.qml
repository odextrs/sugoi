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
            property bool isActive: UserPreferences.bar.isActive ?? DefaultConfig.bar.isActive
            property bool barVertical: UserPreferences.bar.barVertical ?? DefaultConfig.bar.barVertical
            //property bool barFloating: UserPreferences.bar.barFloating ?? DefaultConfig.bar.barFloating
            property int barSize: UserPreferences.bar.barSize ?? DefaultConfig.bar.barSize
            property bool floatingWidgets: UserPreferences.bar.floatingWidgets ?? DefaultConfig.bar.floatingWidgets
            property bool floatingWidgetsBlur: UserPreferences.bar.floatingWidgetsBlur ?? DefaultConfig.bar.floatingWidgetsBlur

            property JsonObject widgets: JsonObject {
                property bool centerSection: UserPreferences.bar.widgets.centerSection ?? DefaultConfig.bar.widgets.centerSection
            }
        }

        property JsonObject notifications: JsonObject {
            property bool isActive: UserPreferences.notifications.isActive ?? DefaultConfig.notifications.isActive
        }

        property JsonObject appLauncher: JsonObject {
            property bool isActive: UserPreferences.appLauncher.isActive ?? DefaultConfig.appLauncher.isActive
        }
    }
}