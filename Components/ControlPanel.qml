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
import QtGraphicalEffects 1.12

Item {
    id: controlPanelRoot

    anchors.topMargin: 60
    anchors.leftMargin: 63
    anchors.rightMargin: 63

    required property PanelButton controlPanelButton
    required property Item modalBox
    required property Item systemModal

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
        controlButtons.spawn()
        descriptionContainer.spawn()
    }

    function despawn() {
        header.despawn()
        controlButtons.despawn()
        descriptionContainer.despawn()
    }

    // HEADER
    Item {
        id: header
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

    // CONTROL BUTTONS + DESCRIPTION
    Item {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: header.bottom
        height: 540

        anchors.topMargin: 20

        // Control Buttons
        ControlButtons {
            id: controlButtons
            anchors.top: parent.top
            anchors.topMargin: 150
            
            controlPanelButton: controlPanelRoot.controlPanelButton
            modalBox: controlPanelRoot.modalBox
            systemModal: controlPanelRoot.systemModal
        }

        // Description
        Item {
            id: descriptionContainer
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0
            width: 440 //TODO: Relative scaling
            height: 540 //TODO: Relative scaling

            property var typewriterCharIndex: 0

            property var headerText: [ "Suspend", "Hibernate", "Reboot", "Shutdown", "---" ]
            property int state: controlButtons.focusedButtonIndex
            property var captionText: [
                [ "Low Power Standby Protocol", "Core systems powered down.\nexternal interfaces secured.\nMinimal energy required.\nReady for brief reactivation." ],
                [ "Deep System Hibernation Protocol", "All communication channels closed.\nMemory preserved.\nCore processing halted.\nReactivation requires full system boot sequence." ],
                [ "System Reset Protocol", "All active processes terminated.\nMemory cleared.\nCore processing reinitialized." ],
                [ "Emergency Power Down Protocol", "All systems forcibly powered off.\nMemory flushed.\nNo active processes." ],
                [ "No Protocol", "No Protocol Selected.\nSelect a protocol to display details." ]
            ]
            property var icon: [ "suspend.svg", "hibernate.svg", "reboot.svg", "shutdown.svg", "empty.svg" ]

            function spawn() {
                descriptionContainerFadeIn.start()
                descriptionContainerSlideIn.start()
                descriptionTypewriterBackward.stop()
                descriptionTypewriterForward.start()
            }

            function despawn() {
                descriptionTypewriterForward.stop()
                descriptionTypewriterBackward.start()
            }

            onStateChanged: {
                descriptionTypewriterForward.stop()
                descriptionTypewriterBackward.stop()
                descriptionContainer.typewriterCharIndex = 0
                descriptionTypewriterForward.start()
            }

            Rectangle {
                id: descriptionBackground
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

            Item {
                anchors.fill: parent
                
                Rectangle {
                    id: descriptionHeader

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 47

                    color: "#B2000000"

                    Text {
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter

                        anchors.leftMargin: 30
                        text: root.getTypewriterText(descriptionContainer.headerText[descriptionContainer.state], descriptionContainer.typewriterCharIndex)
                        font.family: root.fontFamily
                        font.pointSize: 15
                        color: "#D5CFAF"
                    }
                }

                Rectangle {
                    id: descriptionIcon

                    anchors.top: descriptionHeader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 20
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30

                    height: 200

                    color: "#AFA98F"

                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter

                        anchors.topMargin: 20
                        anchors.bottomMargin: 20

                        width: parent.height - 40
                        height: parent.height - 40

                        color: "#464646"

                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Image {
                                anchors.fill: parent
                                source: Qt.resolvedUrl("../Assets/Icons/" + descriptionContainer.icon[descriptionContainer.state])
                                fillMode: Image.PreserveAspectFit
                            }
                        }
                    }
                }

                Text {
                    id: descriptionProtocol
                    anchors.top: descriptionIcon.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 20
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30

                    text: root.getTypewriterText(descriptionContainer.captionText[descriptionContainer.state][0], descriptionContainer.typewriterCharIndex)
                    font.family: root.fontFamily
                    font.pointSize: 15

                    color: "#34332B"
                    opacity: 0.8
                }

                // Spacer
                Rectangle {
                    id: descriptionSpacer

                    anchors.top: descriptionProtocol.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 20
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30

                    height: 2

                    color: "#AFA98F"
                }

                Text {
                    anchors.top: descriptionSpacer.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.topMargin: 20
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30

                    text: root.getTypewriterText(descriptionContainer.captionText[descriptionContainer.state][1], descriptionContainer.typewriterCharIndex)
                    wrapMode: Text.WordWrap
                    font.family: root.fontFamily
                    font.pointSize: 13

                    color: "#34332B"
                    opacity: 0.8
                }
            }

            NumberAnimation {
                id: descriptionContainerFadeIn
                target: descriptionContainer
                property: "opacity"
                from: 0
                to: 1
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: descriptionContainerSlideIn
                target: descriptionContainer.anchors
                property: "rightMargin"
                from: -60 //TODO: Relative scaling
                to: 0
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: descriptionContainerFadeOut
                target: descriptionContainer
                property: "opacity"
                from: 1
                to: 0
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: descriptionContainerSlideOut
                target: descriptionContainer.anchors
                property: "rightMargin"
                from: 0
                to: -60 //TODO: Relative scaling
                duration: 600
                easing.type: Easing.OutCubic
            }

            NumberAnimation {
                id: descriptionTypewriterForward
                target: descriptionContainer
                property: "typewriterCharIndex"
                from: 0
                to: 122
                duration: 300
                easing.type: Easing.Linear
            }

            NumberAnimation {
                id: descriptionTypewriterBackward
                target: descriptionContainer
                property: "typewriterCharIndex"
                to: 0
                duration: 300
                easing.type: Easing.Linear
            }

            Connections {
                target: descriptionTypewriterForward

                function onStarted() {
                    // Ensure fully visible text at the end of the animation
                    descriptionContainer.headerText.opacity = 1
                    descriptionContainer.captionText.opacity = 1
                }
            }

            Connections {
                target: descriptionTypewriterBackward

                function onStopped() {
                    descriptionContainer.headerText.opacity = 0
                    descriptionContainer.captionText.opacity = 0
                    descriptionContainerFadeOut.start()
                    descriptionContainerSlideOut.start()
                }
            }
        }
    }
}