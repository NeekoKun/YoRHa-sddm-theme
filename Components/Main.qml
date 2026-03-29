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
import "."

Pane {
    id: root

    height: config.ScreenHeight || Screen.height
    width: config.ScreenWidth || Screen.ScreenWidth

    LayoutMirroring.enabled: config.ForceRightToLeft == "true" ? true : Qt.application.layoutDirection === Qt.RightToLeft
    LayoutMirroring.childrenInherit: true

    padding: config.ScreenPadding

    palette.button: "#33000000"
    palette.highlight: "#C9C3A3"
    palette.text: "#34332B"

    FontLoader {
        id: rodinFont
        source: Qt.resolvedUrl("../fonts/Rodin-Pro-M.otf")
    }

    property string fontFamily: rodinFont.name

    focus: true

    Rectangle {
        anchors.fill: parent
        color: "#000000"

        z: -1
    }

    Rectangle {
        id: curtain
        anchors.fill: parent
        color: "#000000"
        z: 9999
    }

    signal trigDespawnTrigger()
    signal trigRespawnTrigger()

    Item {
        id: sizeHelper

        height: 1080
        width: 1920

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        // Mask
        Item {
            id: mask
            anchors.fill: parent
            width: sizeHelper.width
            height: sizeHelper.height
            z: -1

            signal linesDespawnAnimationTrigger()
            signal linesRespawnAnimationTrigger()

            // TOP HORIZONTAL BAR
            Rectangle {
                id: topHorizontalLine
                anchors.verticalCenter: parent.top
                anchors.right: parent.right
                anchors.verticalCenterOffset: 120
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        topHorizontalLine.width = sizeHelper.width
                    }

                    function onLinesRespawnAnimationTrigger() {
                        topHorizontalLine.width = 0
                    }
                }
            }

            // BOTTOM HORIZONTAL BAR
            Rectangle {
                id: bottomHorizontalLine
                anchors.verticalCenter: parent.bottom
                anchors.left: parent.left
                anchors.verticalCenterOffset: -120
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        bottomHorizontalLine.width = sizeHelper.width
                    }

                    function onLinesRespawnAnimationTrigger() {
                        bottomHorizontalLine.width = 0
                    }
                }
            }

            // TOP LEFT DIAGONALS
            Rectangle {
                id: topLeftDiagonal1
                anchors.verticalCenter: parent.top
                anchors.left: parent.left
                transformOrigin: Item.Left
                rotation: 45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        topLeftDiagonal1.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        topLeftDiagonal1.width = 0
                    }
                }
            }
            
            Rectangle {
                id: topLeftDiagonal2
                anchors.verticalCenter: parent.top
                anchors.left: parent.left
                transformOrigin: Item.Left
                anchors.leftMargin: 240
                rotation: 45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        topLeftDiagonal2.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        topLeftDiagonal2.width = 0
                    }
                }
            }

            // TOP RIGHT DIAGONALS
            Rectangle {
                id: topRightDiagonal1
                anchors.verticalCenter: parent.top
                anchors.right: parent.right
                transformOrigin: Item.Right
                rotation: -45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        topRightDiagonal1.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        topRightDiagonal1.width = 0
                    }
                }
            }

            Rectangle {
                id: topRightDiagonal2
                anchors.verticalCenter: parent.top
                anchors.right: parent.right
                transformOrigin: Item.Right
                anchors.rightMargin: 240
                rotation: -45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        topRightDiagonal2.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        topRightDiagonal2.width = 0
                    }
                }
            }

            // BOTTOM LEFT DIAGONAL
            Rectangle {
                id: bottomLeftDiagonal
                anchors.verticalCenter: parent.bottom
                anchors.left: parent.left
                transformOrigin: Item.Left
                rotation: -45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        bottomLeftDiagonal.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        bottomLeftDiagonal.width = 0
                    }
                }
            }

            // BOTTOM RIGHT DIAGONAL
            Rectangle {
                id: bottomRightDiagonal
                anchors.verticalCenter: parent.bottom
                anchors.right: parent.right
                transformOrigin: Item.Right
                rotation: 45
                width: 0
                height: 3
                color: "#000000"

                Behavior on width {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                Connections {
                    target: mask
                    function onLinesDespawnAnimationTrigger() {
                        bottomRightDiagonal.width = 1528 // sqrt(2 * 1080^2)
                    }

                    function onLinesRespawnAnimationTrigger() {
                        bottomRightDiagonal.width = 0
                    }
                }
            }

            Repeater {
                model: 17 * 9

                Image {
                    id: triangleInstance
                    opacity: 0
                    property int idx: index

                    x: (idx % 17) * (sizeHelper.width / 16)
                    y: Math.floor(idx / 17) * (sizeHelper.height / 9)

                    source: Qt.resolvedUrl("../Assets/triangle.png")
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    width: sizeHelper.width / 8 - 2
                    height: sizeHelper.height / 9 - 2

                    rotation: idx%2 == 0 ? 0 : 180

                    transform: Translate {
                        x: -width / 2
                    }

                    NumberAnimation {
                        id: trigRespawn
                        target: triangleInstance
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: 120
                    }

                    SequentialAnimation {
                        id: trigDespawn

                        NumberAnimation {
                            target: triangleInstance
                            property: "opacity"
                            from: 0
                            to: 1
                            duration: 120
                        }

                        PauseAnimation { duration: 40 }

                        ParallelAnimation {
                            NumberAnimation {
                                target: triangleInstance
                                property: "width"
                                to: sizeHelper.width / 8
                                duration: 10
                                running: false
                            }

                            NumberAnimation {
                                target: triangleInstance
                                property: "height"
                                to: sizeHelper.height / 9
                                duration: 10
                                running: false
                            }
                        }
                    }

                    Timer {
                        id: randomDespawnDelayTimer
                        running: false
                        repeat: false
                        onTriggered: {
                            if (Math.random() < 0.5) {
                                triangleInstance.width = sizeHelper.width / 8
                                triangleInstance.height = sizeHelper.height / 9
                            }
                            trigDespawn.start()
                        }
                    }

                    Timer {
                        id: randomRespawnDelayTimer
                        running: false
                        repeat: false
                        onTriggered: {
                            trigRespawn.start()
                        }
                    }

                    Connections {
                        target: root
                        function onTrigDespawnTrigger() {
                            randomDespawnDelayTimer.interval = Math.random() * 300
                            randomDespawnDelayTimer.start()
                        }

                        function onTrigRespawnTrigger() {
                            randomRespawnDelayTimer.interval = Math.random() * 300
                            randomRespawnDelayTimer.start()
                        }
                    }
                }
            }
        }

        // Black screen overlay
        Rectangle {
            id: blackOverlay
            anchors.fill: parent
            color: "#000000"
            z: 9998

            layer.enabled: true
            layer.effect: OpacityMask {
                invert: true
                maskSource: mask
            }
        }

        // UI
        Item {
            id: uiContainer
            anchors.fill: parent

            // Panel seletion buttons
            Item {
                id: panelButtonsContainer
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.topMargin: 38
                anchors.leftMargin: 63
                anchors.rightMargin: 63
                height: 71

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.bottomMargin: 23
                    width: 16
                    color: "#000000"
                    opacity: 0.13
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.leftMargin: 22
                    anchors.bottomMargin: 23
                    width: 4
                    color: "#000000"
                    opacity: 0.13
                }

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 60

                    spacing: 40

                    // Future Session Start Button
                    PanelButton {
                        id: loginPanelButtonWrapper
                        buttonText: "SESSION"
                        buttonIcon: Qt.resolvedUrl("../Assets/login_icon.png")

                        rightButton: controlPanelButtonWrapper

                        fontFamily: rodinFont.name
                    }

                    // Future System Control Button
                    PanelButton {
                        id: controlPanelButtonWrapper
                        buttonText: "CONTROL"
                        buttonIcon: Qt.resolvedUrl("../Assets/control_icon.png")

                        leftButton: loginPanelButtonWrapper
                        rightButton: informationPanelButtonWrapper

                        fontFamily: rodinFont.name
                    }

                    // Future System Informations Button
                    PanelButton {
                        id: informationPanelButtonWrapper
                        buttonText: "SYSTEM"
                        buttonIcon: Qt.resolvedUrl("../Assets/info_icon.png")

                        leftButton: controlPanelButtonWrapper

                        fontFamily: rodinFont.name
                    }
                }

                z: 9999
            }

            LoginPanel {
                id: loginPanel

                anchors.top: panelButtonsContainer.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottomMargin: 350

                loginPanelButton: loginPanelButtonWrapper

                visible: loginPanelButtonWrapper.active
            }

            ControlPanel {
                id: controlPanel

                anchors.top: panelButtonsContainer.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottomMargin: 350

                controlPanelButton: controlPanelButtonWrapper

                visible: controlPanelButtonWrapper.active
            }

            Footer {
                id: infoBoard

                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right

                anchors.leftMargin: 63
                anchors.rightMargin: 63

                height: 70
                anchors.bottomMargin: -60 // Gets modified by animation
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

                z: 2
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

            Connections {
                target: loginPanelButtonWrapper
                function onActiveChanged() {
                    if (loginPanelButtonWrapper.active) {
                        loginPanel.spawn()
                    } else {
                        loginPanel.despawn()
                    }
                }
            }

            Connections {
                target: controlPanelButtonWrapper
                function onActiveChanged() {
                    if (controlPanelButtonWrapper.active) {
                        controlPanel.spawn()
                    } else {
                        controlPanel.despawn()
                    }
                }
            }

            z: 3
        }

        // BACKGROUND
        Item {
            id: backgroundContainer
            anchors.fill: parent

            // BACKGROUND COLOR + GRADIENT
            Rectangle {
                id: backgroundImage
                height: parent.height
                width: parent.width
                anchors.fill: parent
                color: "#CAC6A7"


                layer.enabled: true
                layer.effect: RadialGradient {

                    gradient: Gradient {
                        GradientStop { position: 0; color: "#CAC6A7" }
                        GradientStop { position: 0.1; color: "#CAC6A7" }
                        GradientStop { position: 1; color: "#6d6b59" }
                    }
                }
            }

            // Horizontal Bars
            Item {
                id: horizontalTopBarContainer
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 109
                width: 0
                height: 31
                clip: true

                RowLayout {
                    id: horizontalTopBarRow
                    anchors.top: parent.top
                    anchors.right: parent.right
                    width: parent.parent.width
                    spacing: 0

                    property var tiled_width: ((parent.parent.width - parent.parent.width % 76) / 76 - 1) * 76

                    BorderImage {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        source: "../Assets/horizontal_bar_left.png"
                        border.top: 0
                        border.bottom: 0
                        border.left: 0
                        border.right: 5
                    }

                    // Tiling body
                    Image {
                        id: horizontalBarTop
                        source: "../Assets/horizontal_bar_tile.png"
                        Layout.preferredWidth: parent.tiled_width
                        fillMode: Image.TileHorizontally
                        horizontalAlignment: Image.AlignLeft
                    }

                    BorderImage {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        source: "../Assets/horizontal_bar_right.png"
                        border.top: 0
                        border.bottom: 0
                        border.left: 6
                        border.right: 0
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutCubic
                    }
                }
            }

            Item {
                id: horizontalBotBarContainer
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 67
                width: 0
                height: 31
                clip: true

                RowLayout {
                    id: horizontalBotBarRow
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    width: parent.parent.width
                    spacing: 0

                    property var tiled_width: ((parent.parent.width - parent.parent.width % 76) / 76 - 1) * 76

                    BorderImage {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        source: "../Assets/horizontal_bar_left.png"
                        border.top: 0
                        border.bottom: 0
                        border.left: 0
                        border.right: 5
                    }

                    // Tiling body
                    Image {
                        id: horizontalBarBottom
                        source: "../Assets/horizontal_bar_tile.png"
                        Layout.preferredWidth: parent.tiled_width
                        fillMode: Image.TileHorizontally
                        horizontalAlignment: Image.AlignLeft
                    }

                    BorderImage {
                        Layout.fillWidth: true
                        Layout.fillHeight: false
                        source: "../Assets/horizontal_bar_right.png"
                        border.top: 0
                        border.bottom: 0
                        border.left: 6
                        border.right: 0
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 600
                        easing.type: Easing.OutCubic
                    }
                }
            }

            // BOTTOM CORNER
            // DIAGONAL LINES
            Rectangle {
                id: firstDiagonalBar
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.bottom
                anchors.horizontalCenterOffset: -100
                anchors.verticalCenterOffset: -120
                width: 0
                height: 4
                color: "#3d3b34"
                rotation: 45
                opacity: 0.13

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: rightMarginAnim
                    target: firstDiagonalBar.anchors
                    property: "horizontalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        rightMarginAnim.from = firstDiagonalBar.anchors.horizontalCenterOffset;
                        rightMarginAnim.to = Math.random() * 20 - 100;
                        rightMarginAnim.start();
                    }
                }

                PropertyAnimation {
                    id: bottomMarginAnim
                    target: firstDiagonalBar.anchors
                    property: "verticalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        bottomMarginAnim.from = firstDiagonalBar.anchors.verticalCenterOffset;
                        bottomMarginAnim.to = Math.random() * 20 - 120;
                        bottomMarginAnim.start();
                    }
                }

                Component.onCompleted: {
                    rightMarginAnim.from = firstDiagonalBar.anchors.horizontalCenterOffset;
                    rightMarginAnim.to = Math.random() * 20 - 100;
                    rightMarginAnim.start();

                    bottomMarginAnim.from = firstDiagonalBar.anchors.verticalCenterOffset;
                    bottomMarginAnim.to = Math.random() * 20 - 120;
                    bottomMarginAnim.start();
                }
            }

            Rectangle {
                id: secondDiagonalBar
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.bottom
                anchors.horizontalCenterOffset: -80
                anchors.verticalCenterOffset: -20
                width: 0
                height: 4
                color: "#3d3b34"
                rotation: 45
                opacity: 0.13

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: rightMarginAnim2
                    target: secondDiagonalBar.anchors
                    property: "horizontalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        rightMarginAnim2.from = secondDiagonalBar.anchors.horizontalCenterOffset;
                        rightMarginAnim2.to = Math.random() * 20 - 80;
                        rightMarginAnim2.start();
                    }
                }

                PropertyAnimation {
                    id: bottomMarginAnim2
                    target: secondDiagonalBar.anchors
                    property: "verticalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        bottomMarginAnim2.from = secondDiagonalBar.anchors.verticalCenterOffset;
                        bottomMarginAnim2.to = Math.random() * 20 - 20;
                        bottomMarginAnim2.start();
                    }
                }

                Component.onCompleted: {
                    rightMarginAnim2.from = secondDiagonalBar.anchors.horizontalCenterOffset;
                    rightMarginAnim2.to = Math.random() * 20 - 80;
                    rightMarginAnim2.start();

                    bottomMarginAnim2.from = secondDiagonalBar.anchors.verticalCenterOffset;
                    bottomMarginAnim2.to = Math.random() * 20 - 20;
                    bottomMarginAnim2.start();
                }
            }

            Rectangle {
                id: thirdDiagonalBar
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.bottom
                anchors.horizontalCenterOffset: 40
                anchors.verticalCenterOffset: -100
                width: 0
                height: 4
                color: "#3d3b34"
                rotation: 45
                opacity: 0.13

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: rightMarginAnim3
                    target: thirdDiagonalBar.anchors
                    property: "horizontalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        rightMarginAnim3.from = thirdDiagonalBar.anchors.horizontalCenterOffset;
                        rightMarginAnim3.to = Math.random() * 20 + 40;
                        rightMarginAnim3.start();
                    }
                }

                PropertyAnimation {
                    id: bottomMarginAnim3
                    target: thirdDiagonalBar.anchors
                    property: "verticalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        bottomMarginAnim3.from = thirdDiagonalBar.anchors.verticalCenterOffset;
                        bottomMarginAnim3.to = Math.random() * 20 - 100;
                        bottomMarginAnim3.start();
                    }
                }

                Component.onCompleted: {
                    rightMarginAnim3.from = thirdDiagonalBar.anchors.horizontalCenterOffset;
                    rightMarginAnim3.to = Math.random() * 20 + 40;
                    rightMarginAnim3.start();

                    bottomMarginAnim3.from = thirdDiagonalBar.anchors.verticalCenterOffset;
                    bottomMarginAnim3.to = Math.random() * 20 - 100;
                    bottomMarginAnim3.start();
                }
            }

            // CIRCLES
            Image {
                id: firstBottomCircle
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.bottom
                width: 1194
                height: 1194
                source: "../Assets/semicircle.png" // Fake fuckass circle
                opacity: 0.13
                rotation: 180

                Behavior on rotation {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.Linear
                    }
                }
            }

            Image {
                id: secondBottomCircle
                anchors.horizontalCenter: parent.right
                anchors.verticalCenter: parent.bottom
                width: 1224
                height: 1224
                source: "../Assets/semicircle.png"
                opacity: 0.13
                rotation: 180

                Behavior on rotation {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.Linear
                    }
                }
            }

            // TOP CORNER
            // DIAGONAL LINES
            Rectangle {
                id: firstTopDiagonalBar
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                anchors.horizontalCenterOffset: 40
                anchors.verticalCenterOffset: -20
                width: 0
                height: 4
                color: "#3d3b34"
                rotation: 45
                opacity: 0.13

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: leftMarginAnim
                    target: firstTopDiagonalBar.anchors
                    property: "horizontalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        leftMarginAnim.from = firstTopDiagonalBar.anchors.horizontalCenterOffset;
                        leftMarginAnim.to = Math.random() * 20 + 40;
                        leftMarginAnim.start();
                    }
                }

                PropertyAnimation {
                    id: topMarginAnim
                    target: firstTopDiagonalBar.anchors
                    property: "verticalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        topMarginAnim.from = firstTopDiagonalBar.anchors.verticalCenterOffset;
                        topMarginAnim.to = Math.random() * 20 - 20;
                        topMarginAnim.start();
                    }
                }

                Component.onCompleted: {
                    leftMarginAnim.from = firstTopDiagonalBar.anchors.horizontalCenterOffset;
                    leftMarginAnim.to = Math.random() * 20 + 40;
                    leftMarginAnim.start();

                    topMarginAnim.from = firstTopDiagonalBar.anchors.verticalCenterOffset;
                    topMarginAnim.to = Math.random() * 20 - 20;
                    topMarginAnim.start();
                }
            }

            Rectangle {
                id: secondTopDiagonalBar
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                anchors.horizontalCenterOffset: 30
                anchors.verticalCenterOffset: 90
                opacity: 0.13
                color: "#3d3b34"
                width: 0
                height: 4
                rotation: 45

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: leftMarginAnim2
                    target: secondTopDiagonalBar.anchors
                    property: "horizontalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        leftMarginAnim2.from = secondTopDiagonalBar.anchors.horizontalCenterOffset;
                        leftMarginAnim2.to = Math.random() * 20 + 30;
                        leftMarginAnim2.start();
                    }
                }

                PropertyAnimation {
                    id: topMarginAnim2
                    target: secondTopDiagonalBar.anchors
                    property: "verticalCenterOffset"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        topMarginAnim2.from = secondTopDiagonalBar.anchors.verticalCenterOffset;
                        topMarginAnim2.to = Math.random() * 20 + 90;
                        topMarginAnim2.start();
                    }
                }

                Component.onCompleted: {
                    leftMarginAnim2.from = secondTopDiagonalBar.anchors.horizontalCenterOffset;
                    leftMarginAnim2.to = Math.random() * 20 + 30;
                    leftMarginAnim2.start();

                    topMarginAnim2.from = secondTopDiagonalBar.anchors.verticalCenterOffset;
                    topMarginAnim2.to = Math.random() * 20 + 90;
                    topMarginAnim2.start();
                }
            }

            Rectangle {
                id: thirdTopDiagonalBar
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                anchors.horizontalCenterOffset: -20
                anchors.verticalCenterOffset: 100
                opacity: 0.13
                color: "#3d3b34"
                height: 4
                width: 0
                rotation: 45

                Behavior on width {
                    NumberAnimation {
                        duration: 800
                        easing.type: Easing.Linear
                    }
                }

                PropertyAnimation {
                    id: leftMarginAnim3
                    target: thirdTopDiagonalBar.anchors
                    property: "leftMargin"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        leftMarginAnim3.from = thirdTopDiagonalBar.anchors.leftMargin;
                        leftMarginAnim3.to = Math.random() * 20 - 20;
                        leftMarginAnim3.start();
                    }
                }

                PropertyAnimation {
                    id: topMarginAnim3
                    target: thirdTopDiagonalBar.anchors
                    property: "topMargin"
                    duration: 3000
                    easing.type: Easing.InOutSine
                    onStopped: {
                        topMarginAnim3.from = thirdTopDiagonalBar.anchors.topMargin;
                        topMarginAnim3.to = Math.random() * 20 + 100;
                        topMarginAnim3.start();
                    }
                }

                Component.onCompleted: {
                    leftMarginAnim3.from = thirdTopDiagonalBar.anchors.leftMargin;
                    leftMarginAnim3.to = Math.random() * 20 - 20;
                    leftMarginAnim3.start();

                    topMarginAnim3.from = thirdTopDiagonalBar.anchors.topMargin;
                    topMarginAnim3.to = Math.random() * 20 + 100;
                    topMarginAnim3.start();
                }
            }

            // CIRCLES
            Image {
                id: firstTopCircle
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                width: 1194
                height: 1194
                source: "../Assets/semicircle.png" // Fake fuckass circle
                opacity: 0.13
                rotation: 0

                Behavior on rotation {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.Linear
                    }
                }
            }

            Image {
                id: secondTopCircle
                anchors.horizontalCenter: parent.left
                anchors.verticalCenter: parent.top
                width: 1224
                height: 1224
                source: "../Assets/semicircle.png"
                opacity: 0.13
                rotation: 0

                Behavior on rotation {
                    NumberAnimation {
                        duration: 1000
                        easing.type: Easing.Linear
                    }
                }
            }
        }

        // GRID TILE OVERLAY
        Image {
            id: gridTileOverlay
            anchors.fill: parent
            source: "../Assets/grid_tile.png"
            fillMode: Image.Tile
            asynchronous: true
            cache: true
            smooth: false
            opacity: 0.03
            z: 9999
            visible: source !== ""
        }

        MouseArea {
            anchors.fill: backgroundImage
            onClicked: parent.forceActiveFocus()
        }

        transform: Scale {
            xScale: {
                let scaleByWidth  = root.width  / sizeHelper.width
                let scaleByHeight = root.height / sizeHelper.height
                return Math.min(scaleByWidth, scaleByHeight)  // fit within screen
            }
            yScale: xScale
        }
    }


    // Timer to fire the various animations in order
    Timer {
        id: openingAnimationDirector
        interval: 100
        running: true
        repeat: true

        property int step: 0

        onTriggered: {
            switch (step) {
                case 0:
                    curtain.opacity = 0
                    closingAnimationDirector.stop()
                    break
                case 1:
                    mask.linesDespawnAnimationTrigger()
                    break
                case 3:
                    root.trigDespawnTrigger()
                    break
                case 7: // BACKGROUND ANIMATIONS
                    blackOverlay.opacity = 0
                    mask.linesRespawnAnimationTrigger()
                    horizontalTopBarContainer.width = 1920
                    horizontalBotBarContainer.width = 1920
                    
                    firstDiagonalBar.width = 2700
                    secondDiagonalBar.width = 2700
                    thirdDiagonalBar.width = 2700

                    firstTopDiagonalBar.width = 2700
                    secondTopDiagonalBar.width = 2700
                    thirdTopDiagonalBar.width = 2700

                    firstBottomCircle.rotation = 270
                    secondBottomCircle.rotation = 270

                    firstTopCircle.rotation = 90
                    secondTopCircle.rotation = 90
                    break
                case 11: // UI SPAWN
                    loginPanelButtonWrapper.button.forceActiveFocus()
                    infoBoard.spawn()
                    break
                case 12:
                    openingAnimationDirector.stop()
                    step = -1
                    break
            }
            step++
        }
    }

    Timer {
        id: closingAnimationDirector
        interval: 100
        running: false
        repeat: true

        property int step: 0

        onTriggered: {
            switch (step) {
                case 0: // UI DESPAWN
                    openingAnimationDirector.stop()
                    form.header.despawn()
                    form.avatarContainer.despawn()
                    form.input.despawn()
                    infoBoard.despawn()
                    break
                case 1: // Background despawn
                    firstDiagonalBar.width = 0
                    secondDiagonalBar.width = 0
                    thirdDiagonalBar.width = 0

                    firstTopDiagonalBar.width = 0
                    secondTopDiagonalBar.width = 0
                    thirdTopDiagonalBar.width = 0

                    firstBottomCircle.rotation = 180
                    secondBottomCircle.rotation = 180

                    firstTopCircle.rotation = 0
                    secondTopCircle.rotation = 0
                    break
                case 5:
                    horizontalTopBarContainer.width = 0
                    horizontalBotBarContainer.width = 0
                    break
                case 3:
                    blackOverlay.opacity = 1
                    root.trigRespawnTrigger()
                    break
                case 7:
                    closingAnimationDirector.stop()
                    step = -1
            }
            step++
        }
    }
}
