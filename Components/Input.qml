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
        source: Qt.resolvedUrl("../Assets/focus.wav")
        volume: 1
    }

    SoundEffect {
        id: popupOpenSound
        source: Qt.resolvedUrl("../Assets/open.wav")
        volume: 1
    }

    SoundEffect {
        id: popupCloseSound
        source: Qt.resolvedUrl("../Assets/close.wav")
        volume: 1
    }

    property Control exposeLogin: loginButton
    property alias inputAnimationsTrigger: inputAnimationsTrigger
    property bool failed
    property string fontFamily: "Arial"
    property var formFunctions: parent.parent

    // Disable Tab navigation
    Keys.onPressed: {
        if (event.key === Qt.Key_Tab) {
            event.accepted = true
        }
    }

    // USERNAME INPUT
    Item {
        id: usernameField

        property int usernameCharIndex: 0

        height: 75
        width: 500 //TODO: Relative scaling
        anchors.left: parent.left

        // VERTICAL BAR
        Image {
            id: usernameVerticalBar
            anchors.right: parent.left
            anchors.rightMargin: -21 //TODO: Relative scaling
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30 //TODO: Relative scaling
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0
        }

        // FOCUS POINTER
        Image {
            id: usernameFocusPointer
            anchors.right: username.left
            anchors.rightMargin: 10 //TODO: Relative scaling
            anchors.verticalCenter: username.verticalCenter
            width: 40 //TODO: Relative scaling
            height: 27 //TODO: Relative scaling
            source: Qt.resolvedUrl("../Assets/focus_pointer.png")
            opacity: username.activeFocus ? 0.63 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        // SIDEBARS
        Rectangle {
            id: usernameUpwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.bottom: username.top
            anchors.bottomMargin: -2
            anchors.horizontalCenter: username.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.bottomMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
        
        Rectangle {
            id: usernameDownwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.top: username.bottom
            anchors.topMargin: -2
            anchors.horizontalCenter: username.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // USERNAME SQUARE
        Rectangle {
            id: usernameSquare
            anchors.left: parent.left
            anchors.top: username.top
            anchors.bottom: username.bottom
            anchors.leftMargin: 7 //TODO: Relative scaling
            anchors.topMargin: 12 //TODO: Relative scaling
            anchors.bottomMargin: 12 //TODO: Relative scaling
            width: height
            color: root.palette.text
            opacity: 0
            z: 5
        }

        TextField {
            id: username
            text: config.ForceLastUser === "true" ? userModel.lastUser : ""
            font.capitalization: Font.Capitalize
            font.family: inputContainer.fontFamily
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 55 //TODO: Relative scaling
            height: 48 //TODO: Relative scaling
            width: 389 //TODO: Relative scaling 
            placeholderText: ""
            selectByMouse: true
            horizontalAlignment: TextInput.AlignLeft
            renderType: Text.QtRendering
            color: root.palette.text
            leftPadding: usernameSquare.width + 24
            opacity: 0

            background: Item {
                Rectangle {
                    anchors.fill: parent
                    color: root.palette.button
                }

                Rectangle {
                    id: usernameDarkener
                    anchors.left: parent.left
                    height: parent.height
                    width: 0
                    color: "#000000"
                    opacity: 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on width {
                        enabled: !usernameDarkener.width > 0 // Fire animation only when expanding, not collapsing
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }

                layer.enabled: false
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 0
                    samples: 17
                    color: "#45000000"
                }
            }
            Keys.onReturnPressed: loginButton.clicked()
            KeyNavigation.down: password
            Keys.onDownPressed: {
                fieldFocusSound.play()
                KeyNavigation.down.forceActiveFocus()
            }
            z: 1

            states: [
                State { // On focus:
                    name: "focused"
                    when: username.activeFocus
                    PropertyChanges { // Change text color
                        target: username
                        color: root.palette.highlight
                    }
                    PropertyChanges { // Darken the background
                        target: usernameDarkener
                        opacity: 0.5
                        width: parent.width
                    }
                    PropertyChanges { // Add shadow to the background
                        target: username.background
                        layer.enabled: true
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: usernameUpwardsSidebar
                        anchors.bottomMargin: 4 //TODO: Relative scaling
                        opacity: 0.63
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: usernameDownwardsSidebar
                        anchors.topMargin: 4 //TODO: Relative scaling
                        opacity: 0.63
                    }
                    PropertyChanges { // Highlight square
                        target: usernameSquare
                        color: root.palette.highlight
                    }
                }
            ]
        }
    }

    // PASSWORD INPUT
    Item {
        id: passwordField
        
        property int passwordCharIndex: 0
        
        height: 15 * 5
        width: 500 //TODO: Relative scaling
        anchors.left: parent.left

        // VERTICAL BAR
        Image {
            id: passwordVerticalBar
            anchors.right: parent.left
            anchors.rightMargin: -21 //TODO: Relative scaling
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30 //TODO: Relative scaling
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0
        }

        // FOCUS POINTER
        Image {
            id: passwordFocusPointer
            anchors.right: password.left
            anchors.rightMargin: 10 //TODO: Relative scaling
            anchors.verticalCenter: password.verticalCenter
            width: 40 //TODO: Relative scaling
            height: 27 //TODO: Relative scaling
            source: Qt.resolvedUrl("../Assets/focus_pointer.png")
            opacity: password.activeFocus ? 0.63 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        // SIDEBARS
        Rectangle {
            id: passwordUpwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.bottom: password.top
            anchors.bottomMargin: -2
            anchors.horizontalCenter: password.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.bottomMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }
        
        Rectangle {
            id: passwordDownwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.top: password.bottom
            anchors.topMargin: -2
            anchors.horizontalCenter: password.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // PASSWORD SQUARE
        Rectangle {
            id: passwordSquare
            anchors.left: parent.left
            anchors.top: password.top
            anchors.bottom: password.bottom
            anchors.leftMargin: 7 //TODO: Relative scaling
            anchors.topMargin: 12 //TODO: Relative scaling
            anchors.bottomMargin: 12 //TODO: Relative scaling
            width: height
            color: root.palette.text
            opacity: 0
            z: 5
        }

        TextField {
            id: password
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 55 //TODO: Relative scaling
            opacity: 0
            height: 48 //TODO: Relative scaling
            width: 389 //TODO: Relative scaling
            focus: false
            anchors.centerIn: parent
            activeFocusOnTab: false
            selectByMouse: true
            echoMode: TextInput.Password
            placeholderText: ""
            font.family: inputContainer.fontFamily
            horizontalAlignment: TextInput.AlignLeft
            passwordCharacter: "*"
            passwordMaskDelay: 0
            renderType: Text.QtRendering
            color: root.palette.text
            leftPadding: passwordSquare.width + 24

            background: Item {
                Rectangle {
                    anchors.fill: parent
                    color: root.palette.button
                }

                Rectangle {
                    id: passwordDarkener
                    anchors.left: parent.left
                    height: parent.height
                    width: 0
                    color: "#000000"
                    opacity: 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on width {
                        enabled: !passwordDarkener.width > 0 // Fire animation only when expanding, not collapsing
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }

                layer.enabled: false
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 0
                    samples: 17
                    color: "#45000000"
                }
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

            states: [
                State { // On focus:
                    name: "focused"
                    when: password.activeFocus
                    PropertyChanges { // Darken the background
                        target: passwordDarkener
                        opacity: 0.5
                        width: parent.width
                    }
                    PropertyChanges { // Add shadow to the background
                        target: password.background
                        layer.enabled: true
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: passwordUpwardsSidebar
                        anchors.bottomMargin: 4 //TODO: Relative scaling
                        opacity: 0.63
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: passwordDownwardsSidebar
                        anchors.topMargin: 4 //TODO: Relative scaling
                        opacity: 0.63
                    }
                    PropertyChanges { // Change text color
                        target: password
                        color: root.palette.highlight
                    }
                    PropertyChanges { // Highlight square
                        target: passwordSquare
                        color: root.palette.highlight
                    }
                }
            ]
        }
    }

    // SESSION SELECT
    Item {
        id: sessionSelectContainer
        
        property int sessionSelectCharIndex: 0
        
        height: 15 * 5
        width: 500 //TODO: Relative scaling
        anchors.left: parent.left

        // VERTICAL BAR
        Image {
            id: sessionVerticalBar
            anchors.right: parent.left
            anchors.rightMargin: -21 //TODO: Relative scaling
            anchors.verticalCenter: sessionSelect.verticalCenter
            width: 30 //TODO: Relative scaling
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0
        }

        // FOCUS POINTER
        Image {
            id: sessionFocusPointer
            anchors.right: sessionSelect.left
            anchors.rightMargin: 10 //TODO: Relative scaling
            anchors.verticalCenter: sessionSelect.verticalCenter
            width: 40 //TODO: Relative scaling
            height: 27 //TODO: Relative scaling
            source: Qt.resolvedUrl("../Assets/focus_pointer.png")
            opacity: sessionSelect.activeFocus ? 0.63 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        // SIDEBARS
        Rectangle {
            id: sessionUpwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.bottom: sessionSelect.top
            anchors.bottomMargin: -2
            anchors.right: sessionSelect.right
            color: "#000000"
            opacity: 0

            Behavior on anchors.bottomMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutExpo
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Rectangle {
            id: sessionDownwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.top: sessionSelect.bottom
            anchors.topMargin: -2
            anchors.right: sessionSelect.right
            color: "#000000"
            opacity: 0

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutExpo
                }
            }

            Behavior on width {
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // SESSION SQUARE
        Rectangle {
            id: sessionSquare
            anchors.left: parent.left
            anchors.top: sessionSelect.top
            anchors.bottom: sessionSelect.bottom
            anchors.leftMargin: 7 //TODO: Relative scaling
            anchors.topMargin: 12 //TODO: Relative scaling
            anchors.bottomMargin: 12 //TODO: Relative scaling
            width: height
            color: root.palette.text
            opacity: 0
            z: 5
        }

        SessionButton {
            id: sessionSelect
            activeFocusOnTab: false
            implicitWidth: 389 //TODO: Relative scaling
            anchors.left: parent.left
            focus: false
            anchors.leftMargin: -5 //TODO: Relative scaling
            opacity: 0
            anchors.verticalCenter: parent.verticalCenter
            height: 48 //TODO: Relative scaling

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

            // Background
            Item {
                id: sessionBackground
                anchors.fill: parent

                Rectangle {
                    anchors.fill: parent
                    color: root.palette.button
                }

                Rectangle {
                    id: sessionDarkener
                    anchors.left: parent.left
                    height: parent.height
                    width: 0
                    color: "#000000"
                    opacity: 0
                    z: 4

                    SequentialAnimation on opacity {
                        id: sessionDarkenerAnimation
                        running: false
                        loops: Animation.Infinite
                        PauseAnimation { duration: 700 }
                        NumberAnimation { to: 0.3; duration: 300; easing.type: Easing.InOutQuad }
                        PauseAnimation { duration: 300 }
                        NumberAnimation { to: 0.5; duration: 300; easing.type: Easing.InOutQuad }
                    }

                    Behavior on width {
                        enabled: sessionDarkener.width === 0 // Fire animation only when expanding, not collapsing
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }

                layer.enabled: false
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 0
                    samples: 17
                    cached: true
                    color: "#45000000"
                }
            }

            // Text
            Text {
                id: sessionText
                anchors.fill: parent
                text: inputContainer.formFunctions.getTypewriterText(parent.currentSessionName, sessionSelectContainer.sessionSelectCharIndex)
                font.pointSize: 15
                font.family: inputContainer.fontFamily
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: sessionSquare.width + 24
                color: root.palette.text
            }
        }

        states: [
            State { // When focused:
                name: "focused"
                when: sessionSelect.visualFocus || sessionSelect.activeFocus
                PropertyChanges { // Pop upwards sidebar
                    target: sessionUpwardsSidebar
                    anchors.bottomMargin: 4 //TODO: Relative scaling
                    opacity: 0.63
                }
                PropertyChanges { // Pop downwards sidebar
                    target: sessionDownwardsSidebar
                    anchors.topMargin: 4 //TODO: Relative scaling
                    opacity: 0.63
                }
                PropertyChanges { // Enable drop shadow
                    target: sessionBackground
                    layer.enabled: true
                }
                PropertyChanges { // Darken background
                    target: sessionDarkener
                    opacity: 0.50
                    width: parent.width
                }
                PropertyChanges { // Play background animation
                    target: sessionDarkenerAnimation
                    running: true
                }
                PropertyChanges { // Highlight text
                    target: sessionText
                    color: root.palette.highlight
                }
                PropertyChanges { // Highlight square
                    target: sessionSquare
                    color: root.palette.highlight
                }
            },
            State { // When the popup is open:
                name: "opened"
                when: sessionSelect.popupOpened
                PropertyChanges { // Stop the animation
                    target: sessionDarkenerAnimation
                    running: false
                }
                PropertyChanges { // Lower the opacity
                    target: sessionDarkener
                    opacity: 0.3
                    width: parent.width
                }
                PropertyChanges { // Widen button
                    target: sessionSelect
                    width: 389 + 30 //TODO: Relative scaling
                }
                PropertyChanges { // Pop upwards sidebar
                    target: sessionUpwardsSidebar
                    width: 0
                    opacity: 0.63
                    anchors.bottomMargin: 4 //TODO: Relative scaling
                }
                PropertyChanges { // Pop downwards sidebar
                    target: sessionDownwardsSidebar
                    width: 0
                    opacity: 0.63
                    anchors.topMargin: 4 //TODO: Relative scaling
                }
                PropertyChanges { // Highlight text
                    target: sessionText
                    color: root.palette.highlight
                }
                PropertyChanges { // Highlight square
                    target: sessionSquare
                    color: root.palette.highlight
                }
            }
        ]
    }

    // LOGIN BUTTON
    Item {
        id: login
        height: 15 * 5
        width: 500 //TODO: Relative scaling
        anchors.left: parent.left

        property int loginCharIndex: 0
        property real opacityMultiplier: (username.text.length > 0 && password.text.length > 0) ? 1 : 0.6

        // VERTICAL BAR
        Image {
            id: loginVerticalBar
            anchors.right: parent.left
            anchors.rightMargin: -21 //TODO: Relative scaling
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30 //TODO: Relative scaling
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0
        }

        // FOCUS POINTER
        Image {
            id: loginFocusPointer
            anchors.right: loginButton.left
            anchors.rightMargin: 10 //TODO: Relative scaling
            anchors.verticalCenter: login.verticalCenter
            width: 40 //TODO: Relative scaling
            height: 27 //TODO: Relative scaling
            source: Qt.resolvedUrl("../Assets/focus_pointer.png")
            opacity: loginButton.activeFocus ? 0.63 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        // SIDEBARS
        Rectangle {
            id: loginUpwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.bottom: loginButton.top
            anchors.bottomMargin: -2
            anchors.horizontalCenter: loginButton.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.bottomMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Rectangle {
            id: loginDownwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.top: loginButton.bottom
            anchors.topMargin: -2
            anchors.horizontalCenter: loginButton.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // LOGIN SQUARE
        Rectangle {
            id: loginSquare
            anchors.left: parent.left
            anchors.top: loginButton.top
            anchors.bottom: loginButton.bottom
            anchors.leftMargin: -root.width
            anchors.topMargin: 12 //TODO: Relative scaling
            anchors.bottomMargin: 12 //TODO: Relative scaling
            width: height
            color: root.palette.text
            opacity: login.opacityMultiplier
            z: 5
        }

        Button {
            id: loginButton
            activeFocusOnTab: false
            anchors.left: parent.left
            anchors.leftMargin: -5 //TODO: Relative scaling
            anchors.verticalCenter: parent.verticalCenter
            text: "Login"
            height: 48 //TODO: Relative scaling
            width: 389 //TODO: Relative scaling
            implicitWidth: parent.width
            enabled: true
            hoverEnabled: true
            opacity: 0

            contentItem: Text {
                text: inputContainer.formFunctions.getTypewriterText(loginButton.text, login.loginCharIndex)
                leftPadding: loginSquare.width + 24 - 7 //TODO: Relative scaling
                color: root.palette.text
                opacity: login.opacityMultiplier
                font.pointSize: 15
                font.family: inputContainer.fontFamily
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
            }

            background: Item {
                id: buttonBackground
                Rectangle {
                    anchors.fill: parent
                    color: root.palette.button
                }

                Rectangle {
                    id: loginDarkener
                    anchors.left: parent.left
                    height: parent.height
                    width: 0
                    color: "#000000"
                    opacity: 0
                    SequentialAnimation on opacity {
                        id: loginDarkenerAnimation
                        running: false
                        loops: Animation.Infinite
                        PauseAnimation { duration: 700 }
                        NumberAnimation { to: 0.3; duration: 300; easing.type: Easing.InOutQuad }
                        PauseAnimation { duration: 300 }
                        NumberAnimation { to: 0.5; duration: 300; easing.type: Easing.InOutQuad }
                    }

                    Behavior on width {
                        enabled: !loginDarkener.width > 0 // Fire animation only when expanding, not collapsing
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutExpo
                        }
                    }
                }

                layer.enabled: false
                layer.effect: DropShadow {
                    transparentBorder: true
                    horizontalOffset: 4
                    verticalOffset: 4
                    radius: 0
                    samples: 17
                    color: "#45000000"
                }
            }

            KeyNavigation.up: sessionSelect
            Keys.onUpPressed: {
                fieldFocusSound.play()
                KeyNavigation.up.forceActiveFocus()
            }

            states: [
                State {
                    name: "hovered"
                    when: loginButton.activeFocus
                    PropertyChanges {
                        target: loginSquare
                        color: root.palette.highlight
                    }
                    PropertyChanges {
                        target: loginButton.contentItem
                        color: root.palette.highlight
                    }
                    PropertyChanges {
                        target: loginDarkener
                        opacity: 0.50 * login.opacityMultiplier
                        width: parent.width
                    }
                    PropertyChanges {
                        target: loginDarkenerAnimation
                        running: username.text.length > 0 && password.text.length > 0 ? true : false
                    }
                    PropertyChanges {
                        target: buttonBackground
                        layer.enabled: username.text.length > 0 && password.text.length > 0 ? true : false
                    }
                    PropertyChanges {
                        target: loginUpwardsSidebar
                        anchors.bottomMargin: 4 //TODO: Relative scaling
                        opacity: 0.63 * login.opacityMultiplier
                    }
                    PropertyChanges {
                        target: loginDownwardsSidebar
                        anchors.topMargin: 4 //TODO: Relative scaling
                        opacity: 0.63 * login.opacityMultiplier
                    }
                }
            ]

            Keys.onReturnPressed: clicked()

            onClicked: if (username.text.length > 0 && password.text.length > 0) {
                sddm.login(username.text, password.text, sessionSelect.selectedSession)
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

    Connections {
        target: sddm
        onLoginSucceeded: {} //TODO: Play sound on login success
        onLoginFailed: { //TODO: Play sound on login failure
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    ParallelAnimation {
        id: animationSequence

        // USERNAME ANIMATIONS
        SequentialAnimation {
            id: usernameAnimations
            
            ParallelAnimation {
                NumberAnimation {
                    target: usernameSquare
                    property: "opacity"
                    from: 0
                    to: 0.8
                    duration: 200
                }

                NumberAnimation {
                    target: usernameSquare.anchors
                    property: "leftMargin"
                    from: 7 //TODO: Relative scaling
                    to: 67 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: username
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }

                NumberAnimation {
                    target: username.anchors
                    property: "leftMargin"
                    from: -5 //TODO: Relative scaling
                    to: 55 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: usernameVerticalBar
                    property: "opacity"
                    from: 0
                    to: 0.13
                    duration: 200
                }
            }
            
            ScriptAction {
                script: usernameTypewriterTimer.start()
            }
        }

        // PASSWORD ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 100 }
            
            ParallelAnimation {
                NumberAnimation {
                    target: passwordSquare
                    property: "opacity"
                    from: 0
                    to: 0.8
                    duration: 200
                }

                NumberAnimation {
                    target: passwordSquare.anchors
                    property: "leftMargin"
                    from: 7 //TODO: Relative scaling
                    to: 67 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: password
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }

                NumberAnimation {
                    target: password.anchors
                    property: "leftMargin"
                    from: -5 //TODO: Relative scaling
                    to: 55 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: passwordVerticalBar
                    property: "opacity"
                    from: 0
                    to: 0.13
                    duration: 200
                }
            }

            ScriptAction {
                script: {
                    if (config.ForcePasswordFocus === "true") {
                        password.focus = true
                    }
                    passwordTypewriterTimer.start()
                }
            }
        }

        // SESSION SELECT ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 200 }
            ParallelAnimation {
                NumberAnimation {
                    target: sessionSquare
                    property: "opacity"
                    from: 0
                    to: 0.8
                    duration: 200
                }

                NumberAnimation {
                    target: sessionSquare.anchors
                    property: "leftMargin"
                    from: 7 //TODO: Relative scaling
                    to: 67 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: sessionSelect
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }

                NumberAnimation {
                    target: sessionSelect.anchors
                    property: "leftMargin"
                    from: -5 //TODO: Relative scaling
                    to: 55 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: sessionVerticalBar
                    property: "opacity"
                    from: 0
                    to: 0.13
                    duration: 200
                }
            }
            
            ScriptAction {
                script: sessionSelectTypewriterTimer.start()
            }
        }

        // LOGIN BUTTON ANIMATIONS
        SequentialAnimation {
            PauseAnimation { duration: 300 }
            ParallelAnimation {
                NumberAnimation {
                    target: loginSquare
                    property: "opacity"
                    from: 0
                    to: login.opacityMultiplier
                    duration: 200
                }

                NumberAnimation {
                    target: loginSquare.anchors
                    property: "leftMargin"
                    from: 7 //TODO: Relative scaling
                    to: 67 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: loginButton
                    property: "opacity"
                    from: 0
                    to: 1
                    duration: 200
                }

                NumberAnimation {
                    target: loginButton.anchors
                    property: "leftMargin"
                    from: -5 //TODO: Relative scaling
                    to: 55 //TODO: Relative scaling
                    duration: 200
                }

                NumberAnimation {
                    target: loginVerticalBar
                    property: "opacity"
                    from: 0
                    to: 0.13
                    duration: 200
                }
            }
            
            ScriptAction {
                script: loginTypewriterTimer.start()
            }
        }
    }

    Timer {
        id: inputAnimationsTrigger
        interval: 100
        running: false
        repeat: false

        onTriggered: {
            animationSequence.start()
        }
    }

    Timer {
        id: usernameTypewriterTimer
        interval: 20
        running: false
        repeat: true

        onTriggered: {
            usernameField.usernameCharIndex++
            // Update the placeholder text directly
            var placeholder = config.TranslateUsernamePlaceholder || textConstants.userName;
            username.placeholderText = inputContainer.formFunctions.getTypewriterText(placeholder, usernameField.usernameCharIndex);
            
            // Stop once reached a reasonable max length
            if (usernameField.usernameCharIndex > 2000) {
                usernameTypewriterTimer.stop()
            }
        }
    }

    Timer {
        id: passwordTypewriterTimer
        interval: 20
        running: false
        repeat: true

        onTriggered: {
            passwordField.passwordCharIndex++
            // Update the placeholder text directly
            var placeholder = "Password"
            password.placeholderText = inputContainer.formFunctions.getTypewriterText(placeholder, passwordField.passwordCharIndex);
            
            // Stop once reached a reasonable max length
            if (passwordField.passwordCharIndex > 2000) {
                passwordTypewriterTimer.stop()
            }
        }
    }

    Timer {
        id: sessionSelectTypewriterTimer
        interval: 20
        running: false
        repeat: true

        onTriggered: {
            sessionSelectContainer.sessionSelectCharIndex++
            // Update the text directly
            sessionText.text = inputContainer.formFunctions.getTypewriterText(sessionSelect.currentSessionName, sessionSelectContainer.sessionSelectCharIndex);
            
            // Stop once reached a reasonable max length
            if (sessionSelectContainer.sessionSelectCharIndex > 2000) {
                sessionSelectTypewriterTimer.stop()
            }
        }
    }

    Timer {
        id: loginTypewriterTimer
        interval: 20
        running: false
        repeat: true

        onTriggered: {
            login.loginCharIndex++
            // The contentItem text already binds to login.loginCharIndex, so just incrementing it will update the display
            
            // Stop once reached a reasonable max length
            if (login.loginCharIndex > 2000) {
                loginTypewriterTimer.stop()
            }
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}