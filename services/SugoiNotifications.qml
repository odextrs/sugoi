pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    NotificationServer {
        id: notificationService
        onNotification: notification => {
            console.log(notification.urgency)
            notification.tracked = true;
        }
    }

    function getNotifications() {
        return notificationService.trackedNotifications
    }

}