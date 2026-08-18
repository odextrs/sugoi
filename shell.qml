import Quickshell
import QtQuick
import qs.widgets
import qs.config

import "modules/bar"
import "modules/launcher"
import "modules/notifications"
import "modules/lockscreen"

ShellRoot {
    LazyLoader { id: barLoader; loading: false; active: ShellStates.flags.bar.isActive; Bar{} }
    LazyLoader { id: appLauncherLoader; loading: false; active: ShellStates.flags.appLauncher.isActive; AppLauncher{}}
    LazyLoader { id: notificationSystemLoader; loading: false; active: ShellStates.flags.notifications.isActive; Notification{}}
    LazyLoader { id: lockscreenLoader; loading: false; active: true; Lock{}}
}
