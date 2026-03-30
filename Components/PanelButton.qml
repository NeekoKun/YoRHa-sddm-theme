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

Item {
    id: panelButtonWrapper

    anchors.top: parent.top
    
    height: 48
    width: 214

    required property string buttonText
    required property url buttonIcon
    required property string fontFamily

    property PanelButton rightButton: null
    property PanelButton leftButton: null

    property alias button: panelButton

    property bool active: false

    SoundEffect {
        id: focusSound
        source: Qt.resolvedUrl("../Assets/sfx/focus.wav")
        volume: 1
    }

    FocusScope {
        id: panelButton
        anchors.fill: parent
        focus: false

        onActiveFocusChanged: {
            if (activeFocus) {
                panelButtonWrapper.active = true
            }
        }

        Keys.onLeftPressed: {
            if (leftButton) {
                leftButton.button.forceActiveFocus()
                panelButtonWrapper.active = false
                focusSound.play()
            }
        }

        Keys.onRightPressed: {
            if (rightButton) {
                rightButton.button.forceActiveFocus()
                panelButtonWrapper.active = false
                focusSound.play()
            }
        }

        Keys.onDownPressed: {
            KeyNavigation.down.forceActiveFocus()
            focusSound.play()
        }

        Keys.onReturnPressed: {
            KeyNavigation.down.forceActiveFocus()
            focusSound.play()
        }

        // Background
        Rectangle {
            id: buttonBackground

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: parent.height

            color: "#000000"
            opacity: 0.2

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }

        // Darkener
        Rectangle {
            id: buttonDarkener

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: 0

            color: "#000000"
            opacity: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutCubic
                }
            }
        }

        // Icon
        Rectangle {
            id: buttonSquare

            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left

            anchors.topMargin: 10
            anchors.bottomMargin: 10
            anchors.leftMargin: 10

            width: height

            color: root.palette.text

            layer.enabled: true
            layer.effect: OpacityMask {
                invert: true
                maskSource: Image {
                    id: buttonIcon

                    fillMode: Image.PreserveAspectFit
                    opacity: 0.5

                    mipmap: true

                    source: panelButtonWrapper.buttonIcon
                }
            }
        }

        // Pointer
        Rectangle {
            id: pointer

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left
            anchors.rightMargin: 10

            width: 40
            height: 27

            color: panelButton.activeFocus ? root.palette.text : root.palette.highlight
            opacity: 0

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Image {
                    fillMode: Image.PreserveAspectFit
                    source: Qt.resolvedUrl("../Assets/focus_pointer.png")
                }
            }
        }

        Text {
            id: buttonText
            
            anchors.left: buttonSquare.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            anchors.leftMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10

            text: panelButtonWrapper.buttonText
            color: root.palette.text

            fontSizeMode: Text.Fit
            font.pixelSize: 1000
            font.family: panelButtonWrapper.fontFamily
            font.weight: Font.Medium
        }

        states: [
            State {
                name: "active"
                when: panelButtonWrapper.active
                
                PropertyChanges {
                    target: buttonBackground
                    height: parent.height + 23
                }

                PropertyChanges {
                    target: buttonDarkener
                    height: parent.height + 23
                    opacity: 0.5
                }

                PropertyChanges {
                    target: buttonSquare
                    color: root.palette.highlight
                }

                PropertyChanges {
                    target: buttonText
                    color: root.palette.highlight
                }

                PropertyChanges {
                    target: pointer
                    opacity: 1
                }
            }
        ]
    }
}