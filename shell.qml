import Quickshell
import QtQuick
import qs.widgets
import qs.config

import "modules/bar"
import "modules/launcher"
import "modules/notifications"

ShellRoot {
    LazyLoader { id: barLoader; loading: false; active: ShellStates.flags.bar.isActive; Bar{} }
    LazyLoader { id: appLauncherLoader; loading: false; active: false; AppLauncher{}}
    LazyLoader { id: notificationSystemLoader; loading: false; active: ShellStates.flags.notifications.isActive; Notification{}}
    //LazyLoader { id: rectangleLoader; loading: true; active:barLoaderActive; SugoiPanelWindow { Rectangle{ color: "red"; implicitWidth: 200; implicitHeight: 200; } } }
    // LazyLoader { id:<item>Loader; loading:false; active:<property>; <item>}
}