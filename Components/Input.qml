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

    MediaPlayer {
        id: fieldFocusSound
        source: Qt.resolvedUrl("../Assets/focus.mp3")
        volume: 1
    }

    MediaPlayer {
        id: popupOpenSound
        source: Qt.resolvedUrl("../Assets/open.mp3")
        volume: 1
    }

    MediaPlayer {
        id: popupCloseSound
        source: Qt.resolvedUrl("../Assets/close.mp3")
        volume: 1
    }

    property Control exposeLogin: loginButton
    property bool failed
    property string fontFamily: "Arial"

    // USERNAME INPUT
    Item {
        id: usernameField

        height: root.font.pointSize * 5
        width: 500
        anchors.left: parent.left

        // VERTICAL BAR
        Image {
            id: usernameVerticalBar
            anchors.right: username.left
            anchors.rightMargin: 34
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0.13
        }

        // FOCUS POINTER
        Image {
            id: usernameFocusPointer
            anchors.right: username.left
            anchors.rightMargin: 10
            anchors.verticalCenter: username.verticalCenter
            width: 40
            height: 27
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
            width: 389
            height: 2
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
            width: 389
            height: 2
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
            anchors.left: username.left
            anchors.top: username.top
            anchors.bottom: username.bottom
            anchors.leftMargin: 12
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            width: height
            color: root.palette.text
            opacity: 0.8
            z: 5
        }

        TextField {
            id: username
            text: config.ForceLastUser === "true" ? userModel.lastUser : ""
            font.capitalization: Font.Capitalize
            font.family: inputContainer.fontFamily
            anchors.centerIn: parent
            height: 48 
            width: 389 
            placeholderText: config.TranslateUsernamePlaceholder || textConstants.userName
            selectByMouse: true
            horizontalAlignment: TextInput.AlignLeft
            renderType: Text.QtRendering
            color: root.palette.text
            leftPadding: usernameSquare.width + 2 * usernameSquare.anchors.leftMargin

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
                        anchors.bottomMargin: 4
                        opacity: 0.63
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: usernameDownwardsSidebar
                        anchors.topMargin: 4
                        opacity: 0.63
                    }
                    PropertyChanges { // Highlight square
                        target: usernameSquare
                        color: root.palette.highlight
                    }
                }
            ]

            Connections {
                target: username
                onActiveFocusChanged: {
                    if (username.activeFocus) {
                        fieldFocusSound.play()
                    }
                }
            }
        }

    }

    // PASSWORD INPUT
    Item {
        id: passwordField
        height: root.font.pointSize * 5
        width: 500
        anchors.left: parent.left

        Image {
            id: passwordVerticalBar
            anchors.right: password.left
            anchors.rightMargin: 34
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0.13
        }

        Image {
            id: passwordFocusPointer
            anchors.right: password.left
            anchors.rightMargin: 10
            anchors.verticalCenter: password.verticalCenter
            width: 40
            height: 27
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
            width: 389
            height: 2
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
            width: 389
            height: 2
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
            anchors.left: password.left
            anchors.top: password.top
            anchors.bottom: password.bottom
            anchors.leftMargin: 12
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            width: height
            color: root.palette.text
            opacity: 0.8
            z: 5
        }

        TextField {
            id: password
            anchors.centerIn: parent
            height: 48
            width: 389
            focus: config.ForcePasswordFocus == "true" ? true : false
            selectByMouse: true
            echoMode: TextInput.Password
            placeholderText: "Password"
            font.family: inputContainer.fontFamily
            horizontalAlignment: TextInput.AlignLeft
            passwordCharacter: "*"//"•"
            passwordMaskDelay: 0
            renderType: Text.QtRendering
            color: root.palette.text
            leftPadding: passwordSquare.width + 2 * passwordSquare.anchors.leftMargin

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
                        anchors.bottomMargin: 4
                        opacity: 0.63
                    }
                    PropertyChanges { // Pop out the sidebars
                        target: passwordDownwardsSidebar
                        anchors.topMargin: 4
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

            Connections {
                target: password
                onActiveFocusChanged: {
                    if (password.activeFocus) {
                        fieldFocusSound.play()
                    }
                }
            }
        }
    }

    // SESSION SELECT
    Item {
        id: sessionSelectContainer
        height: root.font.pointSize * 5
        width: 500
        anchors.left: parent.left

        KeyNavigation.down: loginButton

        // VERTICAL BAR
        Image {
            id: sessionVerticalBar
            anchors.right: sessionSelect.left
            anchors.rightMargin: 34
            anchors.verticalCenter: sessionSelect.verticalCenter
            width: 30
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0.13
        }

        // FOCUS POINTER
        Image {
            id: sessionFocusPointer
            anchors.right: sessionSelect.left
            anchors.rightMargin: 10
            anchors.verticalCenter: sessionSelect.verticalCenter
            width: 40
            height: 27
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
            width: 389
            height: 2
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
            width: 389
            height: 2
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
            anchors.left: sessionSelect.left
            anchors.top: sessionSelect.top
            anchors.bottom: sessionSelect.bottom
            anchors.leftMargin: 12
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            width: height
            color: root.palette.text
            opacity: 0.8
            z: 5
        }

        SessionButton {
            id: sessionSelect
            implicitWidth: 389
            anchors.left: parent.left
            anchors.leftMargin: 55
            anchors.verticalCenter: parent.verticalCenter
            height: 48

            onPopupOpenedChanged: {
                if (!popupOpened) {
                    sessionDarkener.width = sessionBackground.width
                    sessionDarkener.opacity = 0.5
                } else {
                    sessionDarkener.opacity = 0.3
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
                text: parent.currentSessionName
                font.pointSize: root.font.pointSize
                font.family: inputContainer.fontFamily
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                leftPadding: sessionSquare.width + 2 * sessionSquare.anchors.leftMargin
                color: root.palette.text
            }
        }

        states: [
            State { // When focused:
                name: "focused"
                when: sessionSelect.visualFocus || sessionSelect.activeFocus
                PropertyChanges { // Pop upwards sidebar
                    target: sessionUpwardsSidebar
                    anchors.bottomMargin: 4
                    opacity: 0.63
                }
                PropertyChanges { // Pop downwards sidebar
                    target: sessionDownwardsSidebar
                    anchors.topMargin: 4
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
                    width: 389 + 30
                }
                PropertyChanges { // Pop upwards sidebar
                    target: sessionUpwardsSidebar
                    width: 0
                    opacity: 0.63
                    anchors.bottomMargin: 4
                }
                PropertyChanges { // Pop downwards sidebar
                    target: sessionDownwardsSidebar
                    width: 0
                    opacity: 0.63
                    anchors.topMargin: 4
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

        Connections {
            target: sessionSelect
            onActiveFocusChanged: {
                if (sessionSelect.activeFocus) {
                    fieldFocusSound.play()
                }
            }
        }

        Connections {
            target: sessionSelect.popup
            onOpened: popupOpenSound.play()
            onClosed: popupCloseSound.play()
        }
    }

    // LOGIN BUTTON
    Item {
        id: login
        height: root.font.pointSize * 5
        width: 500
        anchors.left: parent.left

        property real opacityMultiplier: (username.text.length > 0 && password.text.length > 0) ? 1 : 0.6

        // VERTICAL BAR
        Image {
            id: loginVerticalBar
            anchors.right: loginButton.left
            anchors.rightMargin: 34
            anchors.verticalCenter: loginButton.verticalCenter
            width: 30
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0.13
        }

        // FOCUS POINTER
        Image {
            id: loginFocusPointer
            anchors.right: loginButton.left
            anchors.rightMargin: 10
            anchors.verticalCenter: login.verticalCenter
            width: 40
            height: 27
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
            width: 389
            height: 2
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
            width: 389
            height: 2
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
            anchors.left: loginButton.left
            anchors.top: loginButton.top
            anchors.bottom: loginButton.bottom
            anchors.leftMargin: 12
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            width: height
            color: root.palette.text
            opacity: login.opacityMultiplier
            z: 5
        }

        Button {
            id: loginButton
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.centerIn: parent
            text: "Login"
            height: 48
            width: 389
            implicitWidth: parent.width
            enabled: true
            hoverEnabled: true

            contentItem: Text {
                text: parent.text
                leftPadding: loginSquare.width + 2 * loginSquare.anchors.leftMargin - 7
                color: root.palette.text
                opacity: login.opacityMultiplier
                font.pointSize: root.font.pointSize
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

            states: [
                State {
                    name: "hovered"
                    when: loginButton.visualFocus
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
                        anchors.bottomMargin: 4
                        opacity: 0.63 * login.opacityMultiplier
                    }
                    PropertyChanges {
                        target: loginDownwardsSidebar
                        anchors.topMargin: 4
                        opacity: 0.63 * login.opacityMultiplier
                    }
                }
            ]

            Connections {
                target: loginButton
                onActiveFocusChanged: {
                    if (loginButton.activeFocus) {
                        fieldFocusSound.play()
                    }
                }
            } //TODO: Add sound for clicking the button, but only if username and password are filled in

            Keys.onReturnPressed: clicked()

            onClicked: if (username.text.length > 0 && password.text.length > 0) {
                sddm.login(username.text, password.text, sessionSelect.selectedSession)
            }
        }
    }

    // ERROR FIELD
    Item {
        height: root.font.pointSize * 2.3
        width: parent.width / 2
        anchors.left: parent.left
        Label {
            id: errorMessage
            width: parent.width
            text: failed ? config.TranslateLoginFailed || textConstants.loginFailed + "!" : keyboard.capsLock ? textConstants.capslockWarning : null
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: root.font.pointSize * 0.8
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
        onLoginSucceeded: {}
        onLoginFailed: {
            failed = true
            resetError.running ? resetError.stop() && resetError.start() : resetError.start()
        }
    }

    Timer {
        id: resetError
        interval: 2000
        onTriggered: failed = false
        running: false
    }
}