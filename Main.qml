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
import "Components"

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

    font.family: config.Font
    font.pointSize: config.FontSize !== "" ? config.FontSize : parseInt(height / 80)
    focus: true

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    Rectangle {
        id: curtain
        anchors.fill: parent
        color: "#000000"
        z: 9999
    }

    signal trigDespawnTrigger()

    Item {
        id: sizeHelper

        height: 1080
        width: 1920

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        // Mask source Item - must be defined at sizeHelper level for timer access
        Item {
            id: mask
            anchors.fill: parent
            width: sizeHelper.width
            height: sizeHelper.height
            z: -1

            signal linesAnimationTrigger()

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
                    onLinesAnimationTrigger: {
                        topHorizontalLine.width = sizeHelper.width
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
                    onLinesAnimationTrigger: {
                        bottomHorizontalLine.width = sizeHelper.width
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
                    onLinesAnimationTrigger: {
                        topLeftDiagonal1.width = 1528 // sqrt(2 * 1080^2)
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
                    onLinesAnimationTrigger: {
                        topLeftDiagonal2.width = 1528 // sqrt(2 * 1080^2)
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
                    onLinesAnimationTrigger: {
                        topRightDiagonal1.width = 1528 // sqrt(2 * 1080^2)
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
                    onLinesAnimationTrigger: {
                        topRightDiagonal2.width = 1528 // sqrt(2 * 1080^2)
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
                    onLinesAnimationTrigger: {
                        bottomLeftDiagonal.width = 1528 // sqrt(2 * 1080^2)
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
                    onLinesAnimationTrigger: {
                        bottomRightDiagonal.width = 1528 // sqrt(2 * 1080^2)
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
                    width: sizeHelper.width / 8 - 4
                    height: sizeHelper.height / 9 - 4

                    rotation: idx%2 == 0 ? 0 : 180

                    transform: Translate {
                        x: -width / 2
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
                        id: randomDelayTimer
                        running: false
                        repeat: false
                        onTriggered: {
                            trigDespawn.start()
                        }
                    }

                    Connections {
                        target: root
                        onTrigDespawnTrigger: {
                            randomDelayTimer.interval = Math.random() * 300
                            randomDelayTimer.start()
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

        LoginForm {
            id: form

            height: parent.height
            width: parent.width
            anchors.horizontalCenter: config.FormPosition == "center" ? parent.horizontalCenter : undefined
            anchors.left:parent.left
            anchors.right: parent.right
            z: 1
        }

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
            anchors.topMargin: 67
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
                    source: "Assets/horizontal_bar_left.png"
                    border.top: 0
                    border.bottom: 0
                    border.left: 0
                    border.right: 5
                }

                // Tiling body
                Image {
                    id: horizontalBarTop
                    source: "Assets/horizontal_bar_tile.png"
                    Layout.preferredWidth: parent.tiled_width
                    fillMode: Image.TileHorizontally
                    horizontalAlignment: Image.AlignLeft
                }

                BorderImage {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    source: "Assets/horizontal_bar_right.png"
                    border.top: 0
                    border.bottom: 0
                    border.left: 6
                    border.right: 0
                }
            }

            NumberAnimation {
                id: horizontalTopBarSlideInAnimation
                target: horizontalTopBarContainer
                property: "width"
                from: 0
                to: parent.width
                duration: 600
                easing.type: Easing.OutCubic
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
                    source: "Assets/horizontal_bar_left.png"
                    border.top: 0
                    border.bottom: 0
                    border.left: 0
                    border.right: 5
                }

                // Tiling body
                Image {
                    id: horizontalBarBottom
                    source: "Assets/horizontal_bar_tile.png"
                    Layout.preferredWidth: parent.tiled_width
                    fillMode: Image.TileHorizontally
                    horizontalAlignment: Image.AlignLeft
                }

                BorderImage {
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                    source: "Assets/horizontal_bar_right.png"
                    border.top: 0
                    border.bottom: 0
                    border.left: 6
                    border.right: 0
                }
            }

            NumberAnimation {
                id: horizontalBotBarSlideInAnimation
                target: horizontalBotBarContainer
                property: "width"
                from: 0
                to: parent.width
                duration: 600
                easing.type: Easing.OutCubic
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

            NumberAnimation {
                id: firstDiagonalBarWidthAnim
                target: firstDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.Linear
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

            NumberAnimation {
                id: secondDiagonalBarWidthAnim
                target: secondDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.OutCubic
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

            NumberAnimation {
                id: thirdDiagonalBarWidthAnim
                target: thirdDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.Linear
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
            source: "Assets/semicircle.png" // Fake fuckass circle
            opacity: 0.13
            rotation: 180

            NumberAnimation {
                id: firstBottomCircleRotationAnim
                target: firstBottomCircle
                property: "rotation"
                from: 180
                to: 270
                duration: 1000
                easing.type: Easing.Linear
            }
        }

        Image {
            id: secondBottomCircle
            anchors.horizontalCenter: parent.right
            anchors.verticalCenter: parent.bottom
            width: 1224
            height: 1224
            source: "Assets/semicircle.png"
            opacity: 0.13
            rotation: 180

            NumberAnimation {
                id: secondBottomCircleRotationAnim
                target: secondBottomCircle
                property: "rotation"
                from: 180
                to: 280
                duration: 1000
                easing.type: Easing.Linear
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

            NumberAnimation {
                id: firstTopDiagonalBarWidthAnim
                target: firstTopDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.Linear
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

            NumberAnimation {
                id: secondTopDiagonalBarWidthAnim
                target: secondTopDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.Linear
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

            NumberAnimation {
                id: thirdTopDiagonalBarWidthAnim
                target: thirdTopDiagonalBar
                property: "width"
                from: 0
                to: 3000
                duration: 800
                easing.type: Easing.Linear
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
            source: "Assets/semicircle.png" // Fake fuckass circle
            opacity: 0.13
            rotation: 0

            NumberAnimation {
                id: firstTopCircleRotationAnim
                target: firstTopCircle
                property: "rotation"
                from: 0
                to: 180
                duration: 1000
                easing.type: Easing.Linear
            }
        }

        Image {
            id: secondTopCircle
            anchors.horizontalCenter: parent.left
            anchors.verticalCenter: parent.top
            width: 1224
            height: 1224
            source: "Assets/semicircle.png"
            opacity: 0.13
            rotation: 0

            NumberAnimation {
                id: secondTopCircleRotationAnim
                target: secondTopCircle
                property: "rotation"
                from: 0
                to: 100
                duration: 1000
                easing.type: Easing.Linear
            }
        }

        // GRID TILE OVERLAY
        Image {
            id: gridTileOverlay
            anchors.fill: parent
            source: "Assets/grid_tile.png"
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
        id: animationDirector
        interval: 100
        running: true
        repeat: true

        property int step: 0

        onTriggered: {
            switch (step) {
                case 0:
                    curtain.opacity = 0
                    break
                case 1:
                    mask.linesAnimationTrigger()
                    break
                case 3:
                    root.trigDespawnTrigger()
                    break
                case 7:
                    horizontalTopBarSlideInAnimation.start()
                    horizontalBotBarSlideInAnimation.start()
                    firstTopCircleRotationAnim.start()
                    secondTopCircleRotationAnim.start()
                    firstBottomCircleRotationAnim.start()
                    secondBottomCircleRotationAnim.start()

                    firstDiagonalBarWidthAnim.start()
                    secondDiagonalBarWidthAnim.start()
                    thirdDiagonalBarWidthAnim.start()
                    firstTopDiagonalBarWidthAnim.start()
                    secondTopDiagonalBarWidthAnim.start()
                    thirdTopDiagonalBarWidthAnim.start()
                    break
                case 11:
                    form.header.visible = true
                    form.headerTypewriter.start()
                    form.avatarContainerFadeIn.start()
                    form.avatarContainerSlideIn.start()
                    form.infoBoardFadeIn.start()
                    form.infoBoardSlideIn.start()
                    form.avatarTypewriter.start()
                    form.inputAnimation.start()
                    break
            }
            step++
        }
    }
}
