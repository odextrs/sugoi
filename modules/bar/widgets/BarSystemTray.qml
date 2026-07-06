import Quickshell
import QtQuick

import Quickshell.Services.SystemTray

// very basic

Grid {
    columns: 1
    rows: 0

    Repeater {
        model: SystemTray.items

        Item {
            IconImage {
                source: modelData.icon
                implicitSize: 14
            }

            // for the menu
            LazyLoader {
                loading: false
            }

        }
    }
}