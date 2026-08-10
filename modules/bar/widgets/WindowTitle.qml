import Quickshell
import Quickshell.Io
import QtQuick

import qs.config
import qs.widgets

Item {
    property string focusedTitle: ""
    implicitWidth: title.implicitWidth
    implicitHeight: title.implicitHeight

    SugoiText {
        id: title
        text: focusedTitle
        isMonospace: false

        rotation: ShellStates.flags.bar.barVertical? 90 : 0
    }

    Process {
        id: focusedWindow
        command: ["niri", "msg", "-j", "focused-window"]

        stdout: StdioCollector {
            onStreamFinished: {
                const w = JSON.parse(text)
                focusedTitle = prettyName(w.app_id)
            }
        }
    }

    Process {
        id: events
        command: ["niri", "msg", "-j", "event-stream"]
        running: true

        stdout: SplitParser {
            onRead: function(line) {
                const e = JSON.parse(line)

                if (e.WindowFocusChanged) focusedWindow.running = true
            }
        }
    }

    Component.onCompleted: focusedWindow.running = true

    function prettyName(id) {
        if (!id) return ""

        const names = {
            "zen": "Zen Browser",
            "foot": "Foot",
            "kitty": "Kitty",
            "alacritty": "Alacritty",
            "wezterm": "WezTerm",
            "ghostty": "Ghostty",
            "codium": "VSCodium",
            "code": "Visual Studio Code",
            "discord": "Discord",
            "vesktop": "Vesktop",
            "firefox": "Firefox",
            "chromium": "Chromium",
            "google-chrome": "Google Chrome",
            "brave-browser": "Brave",
            "librewolf": "LibreWolf",
            "steam": "Steam",
            "spotify": "Spotify",
            "obs": "OBS Studio",
            "mpv": "mpv",
            "vlc": "VLC",
            "org.gnome.Nautilus": "Files",
            "org.kde.dolphin": "Dolphin",
            "thunar": "Thunar",
            "org.gnome.Console": "Console",
            "org.gnome.Terminal": "Terminal"
        }

        if (names[id]) return names[id]

        return id.split(".").pop().replace(/[-_]/g, " ").replace(/\b\w/g, c => c.toUpperCase())
    }
}