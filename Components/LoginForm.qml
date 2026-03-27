//
// This file is part of Sugar Dark, a theme for the Simple Display Desktop Manager.
//
// Copyright 2018 Marian Arlt
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
import SddmComponents 2.0 as SDDM
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

ColumnLayout {
    id: formContainer
    anchors.fill: parent
    anchors.leftMargin: 63 //TODO: Relative scaling
    anchors.rightMargin: 63 //TODO: Relative scaling

    SDDM.TextConstants { id: textConstants }

    FontLoader {
        id: rodinFont
        source: Qt.resolvedUrl("../fonts/Rodin-Pro-M.otf")
    }    

    property alias header: header
    property alias input: input
    property alias avatarContainer: avatarContainer
    property alias infoBoard: infoBoard
    //TODO: Footer typewriter effect

    property string fontFamily: rodinFont.name || "Arial"

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

    // HEADER - Simple text with HeaderText aligned to the left
    Item {
        id: header
        opacity: 0
        Layout.fillWidth: true
        Layout.preferredHeight: 60 //TODO: Relative scaling

        function spawn() {
            header.opacity = 1
            headerTypewriterForwardTimer.start()
        }

        function despawn() {
            headerTypewriterBackwardTimer.start()
        }

        property var text: "START SESSION"
        property var typewriterCharIndex: 0

        Text {
            id: headerTextShadow
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 5
            text: formContainer.getTypewriterText(header.text, header.typewriterCharIndex)
            font.family: formContainer.fontFamily
            font.pointSize: sizeHelper.height / 27
            color: "#000000"
            opacity: 0.27
            z: 0
        }

        Text {
            id: headerText
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            text: formContainer.getTypewriterText("START SESSION", header.typewriterCharIndex)
            font.family: formContainer.fontFamily
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

    // Input and Avatar
    Row {
        width: parent.width
        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        Layout.fillWidth: true
        Layout.preferredHeight: sizeHelper.height / 10
        Layout.leftMargin: 10 //TODO: Relative scaling
        // INPUT - Input fields aligned to the left
        Input {
            id: input
            anchors.verticalCenter: parent.verticalCenter
            fontFamily: formContainer.fontFamily
        }

        Item {
            id: avatarContainer
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0
            width: 440 //TODO: Relative scaling
            height: 540 //TODO: Relative scaling

            property var typewriterCharIndex: 0

            function spawn() {
                avatarContainerFadeIn.start()
                avatarContainerSlideIn.start()
                avatarTypewriterForward.start()
            }

            function despawn() {
                avatarTypewriterForward.stop()
                avatarTypewriterBackward.start()
            }

            Rectangle {
                id: avatarBackground
                anchors.fill: parent
                color: "#D5CFAF"

                layer.enabled: true
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 4 //TODO: Relative scaling
                    verticalOffset: 4 //TODO: Relative scaling
                    radius: 0
                    samples: 17
                    color: "#45000000"
                }
            }

            ColumnLayout {
                anchors.fill: parent
                spacing: 20

                Item {
                    id: logoHeader
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    height: 47 //TODO: Relative scaling

                    property string text: "YoRHa"

                    Rectangle {
                        anchors.fill: parent
                        color: "#000000"
                        opacity: 0.7
                    }

                    Text {
                        id: logoHeaderText
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.leftMargin: 30 //TODO: Relative scaling
                        text: formContainer.getTypewriterText(logoHeader.text, avatarContainer.typewriterCharIndex)
                        font.family: formContainer.fontFamily
                        font.pointSize: sizeHelper.height / 67
                        color: "#D5CFAF"
                        opacity: 0.9
                    }
                }

                Item {
                    id: logoContent
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                    Layout.leftMargin: 30 //TODO: Relative scaling
                    Layout.rightMargin: 30 //TODO: Relative scaling
                    Layout.preferredHeight: 200 //TODO: Relative scaling

                    Rectangle {
                        anchors.fill: parent
                        color: "#AFA98F"
                    }

                    Image {
                        id: yorhaLogo
                        anchors.fill: parent
                        anchors.centerIn: parent
                        anchors.margins: 10 //TODO: Relative scaling
                        source: Qt.resolvedUrl("../Assets/yorha_logo.png")
                        fillMode: Image.PreserveAspectFit
                        antialiasing: true
                    }
                }

                Item {
                    id: logoCaption
                    Layout.alignment: Qt.AlignLeft | Qt.AlignRight | Qt.AlignTop
                    Layout.leftMargin: 30 //TODO: Relative scaling
                    Layout.rightMargin: 30 //TODO: Relative scaling
                    Layout.preferredHeight: 47 //TODO: Relative scaling

                    property string text: "For the Glory of Mankind"

                    Text {
                        font.pointSize: sizeHelper.height / 67
                        font.family: formContainer.fontFamily
                        color: "#34332B"
                        text: formContainer.getTypewriterText(logoCaption.text, avatarContainer.typewriterCharIndex)
                        opacity: 0.8
                    }
                }

                Rectangle {
                    id: separator
                    Layout.alignment: Qt.AlignLeft | Qt.AlignRight
                    Layout.fillWidth: true
                    Layout.leftMargin: 30 //TODO: Relative scaling
                    Layout.rightMargin: 30 //TODO: Relative scaling
                    Layout.topMargin: -37 //TODO: Relative scaling
                    Layout.preferredHeight: 2 //TODO: Relative scaling
                    color: "#AFA98F"
                    opacity: 1
                }

                Item {
                    id: logoQuote
                    Layout.alignment: Qt.AlignLeft | Qt.AlignRight | Qt.AlignTop
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.leftMargin: 30 //TODO: Relative scaling
                    Layout.rightMargin: 30 //TODO: Relative scaling
                    Layout.bottomMargin: 30 //TODO: Relative scaling

                    property string line: {
                        var fileUrl = Qt.resolvedUrl("../Quotes/nier.txt"); // Edit this to change the quote file
                        var quoteText = "";
                        var xhr = new XMLHttpRequest();
                        xhr.open("GET", fileUrl, false);
                        xhr.onreadystatechange = function() {
                            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                                quoteText = xhr.responseText;
                            }
                        }
                        xhr.send();
                        var lines = quoteText.split(/\r?\n/).filter(function(line) { return line.trim().length > 0; });
                        if (lines.length > 0) {
                            var idx = Math.floor(Math.random() * lines.length);
                            return lines[idx];
                        }
                        return "";
                    }

                    property string quoteText: {
                        var lines = logoQuote.line.split(/\r?\n/).filter(function(line) { return line.trim().length > 0; });
                        if (lines.length > 0) {
                            var idx = Math.floor(Math.random() * lines.length);
                            var line = lines[idx];
                            var tildeIdx = line.indexOf("~");
                            var fullText = "";
                            if (tildeIdx !== -1)
                                fullText = line.substring(0, tildeIdx).trim();
                            else
                                fullText = line.trim();
                            return fullText;
                        }
                        return "";
                    }

                    property string quoteAuthor: {
                        var lines = logoQuote.line.split(/\r?\n/).filter(function(line) { return line.trim().length > 0; });
                        if (lines.length > 0) {
                            var idx = Math.floor(Math.random() * lines.length);
                            var line = lines[idx];
                            var tildeIdx = line.indexOf("~");
                            if (tildeIdx !== -1)
                                return line.substring(tildeIdx + 1).trim();
                        }
                        return "";
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: logoCaption.bottom
                        font.pointSize: sizeHelper.height / 80
                        font.family: formContainer.fontFamily
                        color: "#34332B"
                        opacity: 0.8
                        wrapMode: Text.WordWrap
                        text: formContainer.getTypewriterText(logoQuote.quoteText, avatarContainer.typewriterCharIndex)
                    }

                    Text {
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        font.pointSize: sizeHelper.height / 80
                        font.family: formContainer.fontFamily
                        color: "#34332B"
                        opacity: 0.8
                        text: formContainer.getTypewriterText(logoQuote.quoteAuthor, avatarContainer.typewriterCharIndex)
                    }
                }
            }

            NumberAnimation {
                id: avatarContainerFadeIn
                target: avatarContainer
                property: "opacity"
                from: 0
                to: 1
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: avatarContainerSlideIn
                target: avatarContainer.anchors
                property: "rightMargin"
                from: -60 //TODO: Relative scaling
                to: 0
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: avatarContainerFadeOut
                target: avatarContainer
                property: "opacity"
                from: 1
                to: 0
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: avatarContainerSlideOut
                target: avatarContainer.anchors
                property: "rightMargin"
                from: 0
                to: -60 //TODO: Relative scaling
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: avatarTypewriterForward
                target: avatarContainer
                property: "typewriterCharIndex"
                from: 0
                to: Math.max(logoHeader.text.length, logoCaption.text.length, logoQuote.quoteText.length)
                duration: 300
                easing.type: Easing.Linear
            }

            NumberAnimation {
                id: avatarTypewriterBackward
                target: avatarContainer
                property: "typewriterCharIndex"
                from: Math.max(logoHeader.text.length, logoCaption.text.length, logoQuote.quoteText.length)
                to: 0
                duration: 300
                easing.type: Easing.Linear
            }


            Connections {
                target: avatarTypewriterBackward

                function onStopped() {
                    logoHeaderText.opacity = 0
                    logoCaption.opacity = 0
                    logoQuote.opacity = 0
                    avatarContainerFadeOut.start()
                    avatarContainerSlideOut.start()
                }
            }
        }
    }

    // INFOBOARD - Box with current time and date, fills horizontally
    Footer {
        id: infoBoard
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0 // Gets modified by animation
        opacity: 0 // Gets modified by animation

        function spawn() {
            infoBoardFadeIn.start()
            infoBoardSlideIn.start()
            infoBoard.typewriterForward.start()
        }

        function despawn() {
            infoBoard.typewriterForward.stop()
            infoBoard.typewriterBackward.start()
            infoBoardFadeOut.start()
            infoBoardSlideOut.start()
        }
    }

    NumberAnimation {
        id: infoBoardFadeIn
        target: infoBoard
        property: "opacity"
        from: 0
        to: 1
        duration: 600
        easing.type: Easing.OutCubic
    }

    NumberAnimation {
        id: infoBoardSlideIn
        target: infoBoard.anchors
        property: "bottomMargin"
        from: -60 //TODO: Relative scaling
        to: 110 //TODO: Relative scaling
        duration: 600
        easing.type: Easing.OutCubic
    }

    SequentialAnimation {
        id: infoBoardFadeOut

        PauseAnimation { duration: 400 }

        NumberAnimation {
            target: infoBoard
            property: "opacity"
            from: 1
            to: 0
            duration: 600
            easing.type: Easing.OutCubic
        }
    }

    SequentialAnimation {
        id: infoBoardSlideOut

        PauseAnimation { duration: 400 }

        NumberAnimation {
            target: infoBoard.anchors
            property: "bottomMargin"
            from: 110 //TODO: Relative scaling
            to: -60 //TODO: Relative scaling
            duration: 600
            easing.type: Easing.OutCubic
        }
    }
}