//
// This file is part of Sugar Dark, a theme for the Simple Display Desktop Manager.
//
// Copyright 2026 NeekoKun
//
// Sugar Dark is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// Sugar Dark is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with Sugar Dark. If not, see <https://www.gnu.org/licenses/>.
//

import QtQuick 2.11
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.11

Rectangle {
    id: footer
    color: "#D5CFAF"
    
    Layout.fillWidth: true
    Layout.preferredHeight: 80 //TODO: Relative scaling

    property var formFunctions: parent
    property int typewriterCharIndex: 0

    property alias typewriterForward: typewriterForward
    property alias typewriterBackward: typewriterBackward

    // Fakeass dropshadow effect
    Rectangle {
        anchors.fill: parent
        anchors.leftMargin: 4
        anchors.topMargin: 4
        anchors.rightMargin: -4
        anchors.bottomMargin: -4
        color: "#45000000"
        z: parent.z - 1
    }

    Image { //TODO: Use 2 rects instead
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        source: Qt.resolvedUrl("../Assets/vertical_bar.png")
        opacity: 0.7
    }

    Rectangle {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.bottomMargin: 10

        width: 20
        height: 20
        color: "#000000"
        opacity: 0.7
    }

    Row {
        anchors.fill: parent
        anchors.leftMargin: 60 //TODO: Relative scaling

        Row {  // Time & Date
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 15 //TODO: Relative scaling
            spacing: 20 //TODO: Relative scaling

            // DATE
            Text {
                id: currentDate
                anchors.verticalCenter: parent.verticalCenter

                property string date: {
                    var date = new Date();
                    var day = date.getDate();
                    var suffix = "th";
                    if (day % 10 === 1 && day !== 11) suffix = "st";
                    else if (day % 10 === 2 && day !== 12) suffix = "nd";
                    else if (day % 10 === 3 && day !== 13) suffix = "rd";
                    var formattedDate = Qt.formatDate(date, config.dateFormat || "dddd, d of MMMM, yyyy");
                    // Replace the day number with day+suffix
                    formattedDate = formattedDate.replace(new RegExp("\\b" + day + "\\b"), day + suffix);
                    return formattedDate
                }

                text: formFunctions.getTypewriterText(date, footer.typewriterCharIndex)
                font.pointSize: 15 * 1.2
                font.family: formContainer.fontFamily
                color: "#34332B"
                opacity: footer.typewriterCharIndex > 0 ? 0.8 : 0
            }

            // Separator
            Rectangle {
                width: 2 //TODO: Relative scaling
                height: parent.height * 0.7
                anchors.verticalCenter: parent.verticalCenter
                color: "#34332B"
                opacity: footer.typewriterCharIndex > currentDate.date.length ? 0.8 : 0
            }

            // TIME
            Text {
                id: currentTime
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: sizeHelper.height / 67
                font.family: formContainer.fontFamily
                color: "#34332B"

                property string time: Qt.formatTime(new Date(), "HH:mm")

                text: formFunctions.getTypewriterText(currentTime.time, footer.typewriterCharIndex - currentDate.date.length - 1)
                opacity: footer.typewriterCharIndex > currentDate.date.length + 1 ? 0.8 : 0
            }

            // Separator
            Rectangle {
                width: 2 //TODO: Relative scaling
                height: parent.height * 0.7
                anchors.verticalCenter: parent.verticalCenter
                color: "#34332B"
                opacity: footer.typewriterCharIndex > currentDate.date.length + currentTime.time.length + 1 ? 0.8 : 0
            }

            // Optional: System info section
            Text {
                id: systemInfo
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: sizeHelper.height / 67
                font.family: formContainer.fontFamily
                color: "#34332B"
                opacity: footer.typewriterCharIndex > currentDate.date.length + currentTime.time.length + 2 ? 0.8 : 0

                property string system: (sddm.hostName || "YoRHa") + " System"

                text: formFunctions.getTypewriterText(systemInfo.system, footer.typewriterCharIndex - currentDate.date.length - currentTime.time.length - 2)
            }
        }

        SystemButtons {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.rightMargin: 60 //TODO: Relative scaling
            exposedLogin: input.exposeLogin
            spacing: 20 //TODO: Relative scaling
        }
    }

    SequentialAnimation {
        id: typewriterForward

        PauseAnimation { duration: 600 }

        NumberAnimation {
            target: footer
            property: "typewriterCharIndex"
            from: 0
            to: currentDate.date.length + currentTime.time.length + systemInfo.system.length + 2
            duration: 400
            easing.type: Easing.Linear
        }
    }

    NumberAnimation {
        id: typewriterBackward
        target: footer
        property: "typewriterCharIndex"
        to: 0
        duration: 400
        easing.type: Easing.Linear
    }

    Connections {
        target: typewriterForward

        function onFinished() {
            timeUpdater.start()
        }
    }

    // Timer to update time every second
    Timer {
        id: timeUpdater
        interval: 1000
        repeat: true
        running: false
        onTriggered: {
            currentTime.text = Qt.formatTime(new Date(), config.HourFormat == "12" ? "hh:mm AP" : "HH:mm")
            var date = new Date();
            var day = date.getDate();
            var suffix = "th";
            if (day % 10 === 1 && day !== 11) suffix = "st";
            else if (day % 10 === 2 && day !== 12) suffix = "nd";
            else if (day % 10 === 3 && day !== 13) suffix = "rd";
            var formattedDate = Qt.formatDate(date, config.DateFormat || "dddd, MMMM d, yyyy");
            formattedDate = formattedDate.replace(new RegExp("\\b" + day + "\\b"), day + suffix);
            currentDate.date = formattedDate;
        }
    }
}