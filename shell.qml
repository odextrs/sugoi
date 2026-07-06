import Quickshell
import QtQuick
import qs.widgets

import "modules/bar"
import "modules/launcher"

ShellRoot {
    readonly property bool barLoaderActive: true
    LazyLoader { id: barLoader; loading: false; active:barLoaderActive; Bar{} }
    LazyLoader { id: appLauncherLoader; loading: false; active: false; AppLauncher{}}
    //LazyLoader { id: rectangleLoader; loading: true; active:barLoaderActive; SugoiPanelWindow { Rectangle{ color: "red"; implicitWidth: 200; implicitHeight: 200; } } }
    // LazyLoader { id:<item>Loader; loading:false; active:<property>; <item>}
}