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
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.11
import SddmComponents 2.0 as SDDM

Column {
    id: inputContainer
    Layout.fillWidth: true

    SoundEffect {
        id: fieldFocusSound
        source: Qt.resolvedUrl("../Assets/sfx/focus.wav")
        volume: 1
    }

    SoundEffect {
        id: popupOpenSound
        source: Qt.resolvedUrl("../Assets/sfx/open.wav")
        volume: 1
    }

    SoundEffect {
        id: popupCloseSound
        source: Qt.resolvedUrl("../Assets/sfx/close.wav")
        volume: 1
    }

    property Button exposeLogin: loginButton
    property bool failed
    property string fontFamily: "Arial"
    property var formFunctions: parent.parent

    required property PanelButton loginPanelButton

    function spawn() {
        spawnAnimationSequence.start()
    }

    function despawn() {
        despawnAnimationSequence.start()
    }

    // USERNAME INPUT
    Item {
        id: usernameField

        property int typewriterCharIndex: 0

        height: 75
        width: 453 //TODO: Relative scaling
        anchors.left: parent.left

        TextField {
            id: username
            text: config.ForceLastUser === "true" ? userModel.lastUser : ""
            //font.capitalization: Font.Capitalize
            
            font.family: inputContainer.fontFamily
            font.pointSize: 15

            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            placeholderText: root.getTypewriterText("Username", usernameField.typewriterCharIndex)
            selectByMouse: true
            horizontalAlignment: TextInput.AlignLeft
            renderType: Text.QtRendering
            color: username.activeFocus ? root.palette.highlight : root.palette.text
            leftPadding: 112
            opacity: 0

            background: ButtonBackground {
                id: usernameBackground
                focused: username.activeFocus
            }

            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
            KeyNavigation.up: loginPanelButton.button

            Keys.onDownPressed: {
                fieldFocusSound.play()
                password.forceActiveFocus()
            }

            Keys.onUpPressed: {
                fieldFocusSound.play()
                loginPanelButton.button.forceActiveFocus()
            }

            z: 1
        }
        
        NumberAnimation {
            id: usernameTypewriter
            target: usernameField
            property: "typewriterCharIndex"
            from: 0
            to: 8
            duration: 200
            easing.type: Easing.Linear
        }

        Connections {
            target: usernameBackground
            function onSpawned() {
                usernameTypewriter.start()
            }
        }
    }

    // PASSWORD INPUT
    Item {
        id: passwordField
        
        property int passwordCharIndex: 0
        
        height: 75
        width: 453 //TODO: Relative scaling
        anchors.left: parent.left

        TextField {
            id: password

            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            focus: false
            anchors.centerIn: parent
            selectByMouse: true
            echoMode: TextInput.Password
            placeholderText: root.getTypewriterText("Password", passwordField.passwordCharIndex)
            font.family: inputContainer.fontFamily
            font.pointSize: 15
            horizontalAlignment: TextInput.AlignLeft
            passwordCharacter: "*"
            passwordMaskDelay: 0
            renderType: Text.QtRendering
            color: password.activeFocus ? root.palette.highlight : root.palette.text
            leftPadding: 112

            background: ButtonBackground {
                id: passwordBackground
                focused: password.activeFocus
            }

            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: sessionSelect

            Keys.onDownPressed: {
                fieldFocusSound.play()
                KeyNavigation.down.forceActiveFocus()
            }

            Keys.onUpPressed: {
                fieldFocusSound.play()
                KeyNavigation.up.forceActiveFocus()
            }
        }

        NumberAnimation {
            id: passwordTypewriter
            target: passwordField
            property: "passwordCharIndex"
            from: 0
            to: 8
            duration: 200
            easing.type: Easing.Linear
        }

        Connections {
            target: passwordBackground
            function onSpawned() {
                passwordTypewriter.start()
            }
        }
    }

    // SESSION SELECT
    Item {
        id: sessionSelectContainer
        
        property int sessionSelectCharIndex: 0
        
        height: 75
        width: 453 //TODO: Relative scaling
        anchors.left: parent.left

        SessionButton {
            id: sessionSelect

            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            KeyNavigation.up: password
            KeyNavigation.down: loginButton

            Keys.onUpPressed: {
                fieldFocusSound.play()
                KeyNavigation.up.forceActiveFocus()
            }
            Keys.onDownPressed: {
                fieldFocusSound.play()
                KeyNavigation.down.forceActiveFocus()
            }

            onPopupOpenedChanged: {
                if (!popupOpened) {
                    sessionDarkener.width = sessionBackground.width
                    sessionDarkener.opacity = 0.5
                    popupCloseSound.play()
                } else {
                    sessionDarkener.opacity = 0.3
                    popupOpenSound.play()
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration: 500
                    easing.type: Easing.OutExpo
                }
            }

            ButtonBackground {
                id: sessionBackground
                anchors.fill: parent
                focused: sessionSelect.activeFocus
                textToDisplay: parent.currentSessionName
                popupOpened: sessionSelect.popupOpened
            }
        }

        SequentialAnimation {
            id: sessionSelectTypewriter

            NumberAnimation {
                target: sessionSelectContainer
                property: "sessionSelectCharIndex"
                from: 0
                to: sessionSelect.currentSessionName.length
                duration: 200
                easing.type: Easing.Linear
            }

            NumberAnimation {
                target: sessionSelectContainer
                property: "sessionSelectCharIndex"
                from: sessionSelect.currentSessionName.length
                to: 200 // Arbitrary large number to ensure it doesn't stop prematurely if the session name changes
            }
        }
    }

    // LOGIN BUTTON
    Item {
        id: login
        height: 75
        width: 453 //TODO: Relative scaling
        anchors.left: parent.left

        property int loginCharIndex: 0
        property real opacityMultiplier: (username.text.length > 0 && password.text.length > 0) ? 1 : 0.6

        Button {
            id: loginButton

            width: parent.width
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter

            opacity: 0

            background: ButtonBackground {
                id: loginBackground
                anchors.fill: parent
                focused: loginButton.activeFocus
                textToDisplay: "Login"
                enabled: username.text.length > 0 && password.text.length > 0
            }

            KeyNavigation.up: sessionSelect
            Keys.onUpPressed: {
                fieldFocusSound.play()
                KeyNavigation.up.forceActiveFocus()
            }

            Keys.onReturnPressed: clicked()

            onClicked: if (username.text.length > 0 && password.text.length > 0) {
                closingAnimationDirector.start()

                loginDelayTimer.running ? loginDelayTimer.stop() && loginDelayTimer.start() : loginDelayTimer.start()
            }
        }
    }

    // ERROR FIELD
    Item {
        height: 15 * 2.3
        width: parent.width / 2
        anchors.left: parent.left
        Label {
            id: errorMessage
            width: parent.width
            text: failed ? config.TranslateLoginFailed || textConstants.loginFailed + "!" : keyboard.capsLock ? textConstants.capslockWarning : null
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 15 * 0.8
            font.italic: true
            color: root.palette.text
            opacity: 0
            states: [
                State {
                    name: "fail"
                    when: failed
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                },
                State {
                    name: "capslock"
                    when: keyboard.capsLock
                    PropertyChanges {
                        target: errorMessage
                        opacity: 1
                    }
                }
            ]
            transitions: [
                Transition {
                    PropertyAnimation {
                        properties: "opacity"
                        duration: 100
                    }
                }
            ]
        }
    }

    // Login triggers
    Connections {
        target: sddm
        onLoginSucceeded: { }
        onLoginFailed: {
            failed = true
            openingAnimationDirector.start()
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    ParallelAnimation {
        id: spawnAnimationSequence

        // USERNAME ANIMATIONS
        SequentialAnimation {
            id: usernameAnimations
            
            ScriptAction {
                script: {
                    usernameBackground.spawn()
                }
            }
        }

        // PASSWORD ANIMATIONS
        SequentialAnimation {
            id: passwordAnimations
            
            PauseAnimation { duration: 100 }

            ScriptAction {
                script: {
                    passwordBackground.spawn()
                }
            }
        }

        // SESSION ANIMATIONS
        SequentialAnimation {
            id: sessionAnimations
            
            PauseAnimation { duration: 200 }

            ScriptAction {
                script: {
                    sessionBackground.spawn()
                }
            }
        }

        // LOGIN ANIMATIONS
        SequentialAnimation {
            id: loginAnimations
            
            PauseAnimation { duration: 300 }

            ScriptAction {
                script: {
                    loginBackground.spawn()
                }
            }
        }
    }

    ParallelAnimation {
        id: despawnAnimationSequence

        // USERNAME ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 300 }

            ScriptAction {
                script: {
                    usernameBackground.despawn()
                }
            }
        }

        // PASSWORD ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 200 }

            ScriptAction {
                script: {
                    passwordBackground.despawn()
                }
            }
        }

        // SESSION SELECT ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 100 }

            ScriptAction {
                script: {
                    sessionBackground.despawn()
                }
            }
        }

        // LOGIN ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 000 }

            ScriptAction {
                script: {
                    loginBackground.despawn()
                }
            }
        }
    }

    Timer {
        id: loginDelayTimer
        interval: 800
        running: false
        repeat: false
        onTriggered: sddm.login(username.text, password.text, sessionSelect.selectedSession)
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}