import Quickshell
import QtQuick
import qs.widgets
import qs.config

import "modules/bar"
import "modules/launcher"
import "modules/notifications"

// LazyLoader { id:<item>Loader; loading:false; active:<property>; <item>}
ShellRoot {
    LazyLoader { id: barLoader; loading: false; active: ShellStates.flags.bar.isActive; Bar{} }
    LazyLoader { id: appLauncherLoader; loading: false; active: ShellStates.flags.appLauncher.isActive; AppLauncher{}}
    LazyLoader { id: notificationSystemLoader; loading: false; active: ShellStates.flags.notifications.isActive; Notification{}}
}