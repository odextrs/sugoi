pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

//experiment
Singleton {
    id: root

    property bool isEnabled: false
    property var availableWifi: []
    property bool toggled: false

    property string currentSSID: "Disconnected"
    property string connectionType: "disconnected"

    readonly property string textSSID: {
        if (connectionType === "ethernet")
            return "Ethernet"
        if (!isEnabled)
            return "Off"
        return currentSSID
    }

    function toggle() {
        wifiSet.command = [ "nmcli", "radio", "wifi", root.isEnabled ? "off" : "on" ]
        wifiSet.running = true
    }

    function connect(ssid) {
        wifiConnect.command = ["nmcli","device","wifi","connect", ssid ]
        wifiConnect.running = true
    }

    function scan() {
        if (root.toggled)
            wifiScan.running = true
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            wifiGet.running = true

            if (root.toggled)
                scan()
        }
    }

    Process {
        id: wifiConnect
        stdout: StdioCollector {
            onStreamFinished: {
                wifiGet.running = true

                if (root.toggled)
                    wifiScan.running = true
            }
        }
    }

    Process {
        id: wifiScan
        command: [ "nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY", "device", "wifi", "list" ]

        stdout: StdioCollector {
            onStreamFinished: {
                var networks = []

                for (const line of text.trim().split("\n")) {
                    if (!line)
                        continue

                    const parts = line.split(":")

                    if (parts.length < 3)
                        continue

                    const ssid = parts[0]
                    const signal = Number(parts[1])
                    const security = parts[2]

                    if (!ssid)
                        continue

                    networks.push({
                        ssid: ssid,
                        signal: signal,
                        security: security
                    })
                }

                var uniqueNetworks = {}

                for (const network of networks) {
                    if (!uniqueNetworks[network.ssid]) {
                        uniqueNetworks[network.ssid] = network
                    } else if (
                        network.signal >
                        uniqueNetworks[network.ssid].signal
                    ) {
                        uniqueNetworks[network.ssid] = network
                    }
                }

                root.availableWifi = Object.values(uniqueNetworks)
            }
        }
    }

    Process {
        id: wifiSet

        stdout: StdioCollector {
            onStreamFinished: {
                wifiGet.running = true
            }
        }
    }

    Process {
        id: wifiGet
        command: [ "sh", "-c", "echo \"radio:$(nmcli radio wifi)\"; " + "nmcli -t -f TYPE,STATE,CONNECTION device" ]

        stdout: StdioCollector {
            onStreamFinished: {
                const lines = text.trim().split("\n")

                root.connectionType = "disconnected"
                root.currentSSID = "Disconnected"

                for (const line of lines) {
                    if (line.startsWith("radio:")) {
                        root.isEnabled = line.substring(6).trim() === "enabled"
                        continue
                    }

                    const parts = line.split(":")
                    if (parts.length < 2)
                        continue

                    const type = parts[0]
                    const state = parts[1]
                    const connection = parts.slice(2).join(":")
                    if (state !== "connected")
                        continue
                    if (type === "wifi") {
                        root.connectionType = "wifi"
                        root.currentSSID = connection || "Connected"
                    } else if (type === "ethernet") {
                        root.connectionType = "ethernet"
                        root.currentSSID = "Ethernet"
                    }
                }
            }
        }
    }
}