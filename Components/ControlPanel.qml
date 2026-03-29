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
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4

Item {
    id: controlPanelRoot

    anchors.topMargin: 60
    anchors.leftMargin: 63
    anchors.rightMargin: 63

    required property PanelButton controlPanelButton

    function getTypewriterText(fullText, charCount) {
        var chars = "abcdefghijklmnopqrstuvwxyz";
        var typed = fullText.substring(0, Math.min(charCount, fullText.length));

        if (charCount < fullText.length ) {
            if (fullText.charAt(typed.length) == fullText.charAt(typed.length).toUpperCase()) { // next character is uppercase, probably a new word, add a space for better readability
                typed += chars.charAt(Math.floor(Math.random() * chars.length)).toUpperCase();
            } else {
                typed += chars.charAt(Math.floor(Math.random() * chars.length));
            }
        }
        return typed;
    }

    function spawn() {
        header.spawn()
    }

    function despawn() {
        header.despawn()
    }

    // HEADER
    Item {
        id: header
        opacity: 1
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60

        function spawn() {
            header.opacity = 1
            headerTypewriterBackwardTimer.stop()
            headerTypewriterForwardTimer.start()
        }

        function despawn() {
            headerTypewriterForwardTimer.stop()
            headerTypewriterBackwardTimer.start()
        }

        property var text: "SYSTEM CONTROL"
        property var typewriterCharIndex: 0

        Text {
            id: headerTextShadow
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 5
            text: controlPanelRoot.getTypewriterText(header.text, header.typewriterCharIndex)
            font.family: root.fontFamily
            font.pointSize: sizeHelper.height / 27
            color: "#000000"
            opacity: 0.27
            z: 0
        }

        Text {
            id: headerText
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: controlPanelRoot.getTypewriterText("SYSTEM CONTROL", header.typewriterCharIndex)
            font.family: root.fontFamily
            font.pointSize: sizeHelper.height / 27
            color: "#34332B"
            opacity: 0.8
            z: 1
        }

        Timer {
            id: headerTypewriterForwardTimer
            interval: 20
            repeat: true
            running: false
            onTriggered: {
                header.typewriterCharIndex++
                // Stop once reached a reasonable max length
                if (header.typewriterCharIndex > header.text.length) {
                    headerTypewriterForwardTimer.stop()
                }
            }
        }

        Timer {
            id: headerTypewriterBackwardTimer
            interval: 20
            repeat: true
            running: false
            onTriggered: {
                header.typewriterCharIndex--
                // Stop once reached 0
                if (header.typewriterCharIndex < 0) {
                    headerTypewriterBackwardTimer.stop()
                    header.opacity = 0
                }
            }
        }
    }

    // CONTROL BUTTONS + 
    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        anchors.bottom: parent.bottom

        anchors.topMargin: 20

        // Control Buttons
        ControlButtons {
            id: controlButtons
            anchors.top: parent.top
            anchors.topMargin: 50
            
            controlPanelButton: controlPanelRoot.controlPanelButton
        }
    }
}