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

    property bool leftleft: config.HaveFormBackground == "true" &&
                            config.PartialBlur == "false" &&
                            config.FormPosition == "left" &&
                            config.BackgroundImageAlignment == "left"

    property bool leftcenter: config.HaveFormBackground == "true" &&
                              config.PartialBlur == "false" &&
                              config.FormPosition == "left" &&
                              config.BackgroundImageAlignment == "center"

    property bool rightright: config.HaveFormBackground == "true" &&
                              config.PartialBlur == "false" &&
                              config.FormPosition == "right" &&
                              config.BackgroundImageAlignment == "right"

    property bool rightcenter: config.HaveFormBackground == "true" &&
                               config.PartialBlur == "false" &&
                               config.FormPosition == "right" &&
                               config.BackgroundImageAlignment == "center"

    Item {
        id: sizeHelper

        anchors.fill: parent
        height: parent.height
        width: parent.width

        Rectangle {
            id: formBackground
            anchors.fill: form
            anchors.centerIn: form
            color: "#000000"
            opacity: 0
            z: 1
        }

        LoginForm {
            id: form

            height: virtualKeyboard.state == "visible" ? parent.height - virtualKeyboard.implicitHeight : parent.height
            width: parent.width
            anchors.horizontalCenter: config.FormPosition == "center" ? parent.horizontalCenter : undefined
            anchors.left:parent.left
            anchors.right: parent.right
            z: 1
        }

        Button {
            id: vkb
            onClicked: virtualKeyboard.switchState()
            visible: virtualKeyboard.status == Loader.Ready && config.ForceHideVirtualKeyboardButton == "false"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: implicitHeight
            anchors.horizontalCenter: form.horizontalCenter
            z: 1
            contentItem: Text {
                text: config.TranslateVirtualKeyboardButton || "Virtual Keyboard"
                color: parent.visualFocus ? palette.highlight : palette.text
                font.pointSize: root.font.pointSize * 0.8
            }
            background: Rectangle {
                id: vkbbg
                color: "transparent"
            }
        }

        Loader {
            id: virtualKeyboard
            source: "Components/VirtualKeyboard.qml"
            state: "hidden"
            property bool keyboardActive: item ? item.active : false
            onKeyboardActiveChanged: keyboardActive ? state = "visible" : state = "hidden"
            width: parent.width
            z: 1
            function switchState() { state = state == "hidden" ? "visible" : "hidden" }
            states: [
                State {
                    name: "visible"
                    PropertyChanges {
                        target: form
                        systemButtonVisibility: false
                        clockVisibility: false
                    }
                    PropertyChanges {
                        target: virtualKeyboard
                        y: root.height - virtualKeyboard.height
                        opacity: 1
                    }
                },
                State {
                    name: "hidden"
                    PropertyChanges {
                        target: virtualKeyboard
                        y: root.height - root.height/4
                        opacity: 0
                    }
                }
            ]
            transitions: [
                Transition {
                    from: "hidden"
                    to: "visible"
                    SequentialAnimation {
                        ScriptAction {
                            script: {
                                virtualKeyboard.item.activated = true;
                                Qt.inputMethod.show();
                            }
                        }
                        ParallelAnimation {
                            NumberAnimation {
                                target: virtualKeyboard
                                property: "y"
                                duration: 100
                                easing.type: Easing.OutQuad
                            }
                            OpacityAnimator {
                                target: virtualKeyboard
                                duration: 100
                                easing.type: Easing.OutQuad
                            }
                        }
                    }
                },
                Transition {
                    from: "visible"
                    to: "hidden"
                    SequentialAnimation {
                        ParallelAnimation {
                            NumberAnimation {
                                target: virtualKeyboard
                                property: "y"
                                duration: 100
                                easing.type: Easing.InQuad
                            }
                            OpacityAnimator {
                                target: virtualKeyboard
                                duration: 100
                                easing.type: Easing.InQuad
                            }
                        }
                        ScriptAction {
                            script: {
                                Qt.inputMethod.hide();
                            }
                        }
                    }
                }
            ]
        }

        Image {
            id: backgroundImage

            height: parent.height
            width: config.HaveFormBackground == "true" && config.FormPosition != "center" && config.PartialBlur != "true" ? parent.width - formBackground.width : parent.width
            anchors.left: leftleft || 
                          leftcenter ?
                                formBackground.right : undefined

            anchors.right: rightright ||
                           rightcenter ?
                                formBackground.left : undefined

            horizontalAlignment: config.BackgroundImageAlignment == "left" ?
                                 Image.AlignLeft :
                                 config.BackgroundImageAlignment == "right" ?
                                 Image.AlignRight :
                                 config.BackgroundImageAlignment == "center" ?
                                 Image.AlignHCenter : undefined

            source: config.background || config.Background
            fillMode: config.ScaleImageCropped == "true" ? Image.PreserveAspectCrop : Image.PreserveAspectFit
            asynchronous: true
            cache: true
            clip: true
            mipmap: true
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
        Image {
            id: firstDiagonalBar
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -100
            anchors.bottomMargin: -120
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: rightMarginAnim
                target: firstDiagonalBar.anchors
                property: "rightMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    rightMarginAnim.from = firstDiagonalBar.anchors.rightMargin;
                    rightMarginAnim.to = Math.random() * 20 - 100;
                    rightMarginAnim.start();
                }
            }

            PropertyAnimation {
                id: bottomMarginAnim
                target: firstDiagonalBar.anchors
                property: "bottomMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    bottomMarginAnim.from = firstDiagonalBar.anchors.bottomMargin;
                    bottomMarginAnim.to = Math.random() * 20 - 120;
                    bottomMarginAnim.start();
                }
            }

            Component.onCompleted: {
                rightMarginAnim.from = firstDiagonalBar.anchors.rightMargin;
                rightMarginAnim.to = Math.random() * 20 - 100;
                rightMarginAnim.start();

                bottomMarginAnim.from = firstDiagonalBar.anchors.bottomMargin;
                bottomMarginAnim.to = Math.random() * 20 - 120;
                bottomMarginAnim.start();
            }
        }

        Image {
            id: secondDiagonalBar
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -80
            anchors.bottomMargin: -20
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: rightMarginAnim2
                target: secondDiagonalBar.anchors
                property: "rightMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    rightMarginAnim2.from = secondDiagonalBar.anchors.rightMargin;
                    rightMarginAnim2.to = Math.random() * 20 - 80;
                    rightMarginAnim2.start();
                }
            }

            PropertyAnimation {
                id: bottomMarginAnim2
                target: secondDiagonalBar.anchors
                property: "bottomMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    bottomMarginAnim2.from = secondDiagonalBar.anchors.bottomMargin;
                    bottomMarginAnim2.to = Math.random() * 20 - 20;
                    bottomMarginAnim2.start();
                }
            }

            Component.onCompleted: {
                rightMarginAnim2.from = secondDiagonalBar.anchors.rightMargin;
                rightMarginAnim2.to = Math.random() * 20 - 80;
                rightMarginAnim2.start();

                bottomMarginAnim2.from = secondDiagonalBar.anchors.bottomMargin;
                bottomMarginAnim2.to = Math.random() * 20 - 20;
                bottomMarginAnim2.start();
            }
        }

        Image {
            id: thirdDiagonalBar
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -300
            anchors.bottomMargin: -120
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: rightMarginAnim3
                target: thirdDiagonalBar.anchors
                property: "rightMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    rightMarginAnim3.from = thirdDiagonalBar.anchors.rightMargin;
                    rightMarginAnim3.to = Math.random() * 20 - 300;
                    rightMarginAnim3.start();
                }
            }

            PropertyAnimation {
                id: bottomMarginAnim3
                target: thirdDiagonalBar.anchors
                property: "bottomMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    bottomMarginAnim3.from = thirdDiagonalBar.anchors.bottomMargin;
                    bottomMarginAnim3.to = Math.random() * 20 - 120;
                    bottomMarginAnim3.start();
                }
            }

            Component.onCompleted: {
                rightMarginAnim3.from = thirdDiagonalBar.anchors.rightMargin;
                rightMarginAnim3.to = Math.random() * 20 - 300;
                rightMarginAnim3.start();

                bottomMarginAnim3.from = thirdDiagonalBar.anchors.bottomMargin;
                bottomMarginAnim3.to = Math.random() * 20 - 120;
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
            source: "Assets/circle.png"
            opacity: 0.13
        }

        Image {
            id: secondBottomCircle
            anchors.horizontalCenter: parent.right
            anchors.verticalCenter: parent.bottom
            width: 1224
            height: 1224
            source: "Assets/circle.png"
            opacity: 0.13
        }

        // TOP CORNER
        // DIAGONAL LINES
        Image {
            id: firstTopDiagonalBar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -180
            anchors.topMargin: -220
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: leftMarginAnim
                target: firstTopDiagonalBar.anchors
                property: "leftMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    leftMarginAnim.from = firstTopDiagonalBar.anchors.leftMargin;
                    leftMarginAnim.to = Math.random() * 20 - 180;
                    leftMarginAnim.start();
                }
            }

            PropertyAnimation {
                id: topMarginAnim
                target: firstTopDiagonalBar.anchors
                property: "topMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    topMarginAnim.from = firstTopDiagonalBar.anchors.topMargin;
                    topMarginAnim.to = Math.random() * 20 - 220;
                    topMarginAnim.start();
                }
            }

            Component.onCompleted: {
                leftMarginAnim.from = firstTopDiagonalBar.anchors.leftMargin;
                leftMarginAnim.to = Math.random() * 20 - 180;
                leftMarginAnim.start();

                topMarginAnim.from = firstTopDiagonalBar.anchors.topMargin;
                topMarginAnim.to = Math.random() * 20 - 220;
                topMarginAnim.start();
            }
        }

        Image {
            id: secondTopDiagonalBar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -80
            anchors.topMargin: -20
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: leftMarginAnim2
                target: secondTopDiagonalBar.anchors
                property: "leftMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    leftMarginAnim2.from = secondTopDiagonalBar.anchors.leftMargin;
                    leftMarginAnim2.to = Math.random() * 20 - 80;
                    leftMarginAnim2.start();
                }
            }

            PropertyAnimation {
                id: topMarginAnim2
                target: secondTopDiagonalBar.anchors
                property: "topMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    topMarginAnim2.from = secondTopDiagonalBar.anchors.topMargin;
                    topMarginAnim2.to = Math.random() * 20 - 20;
                    topMarginAnim2.start();
                }
            }

            Component.onCompleted: {
                leftMarginAnim2.from = secondTopDiagonalBar.anchors.leftMargin;
                leftMarginAnim2.to = Math.random() * 20 - 80;
                leftMarginAnim2.start();

                topMarginAnim2.from = secondTopDiagonalBar.anchors.topMargin;
                topMarginAnim2.to = Math.random() * 20 - 20;
                topMarginAnim2.start();
            }
        }

        Image {
            id: thirdTopDiagonalBar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -180
            anchors.topMargin: -60
            source: "Assets/diagonal_line.png"
            opacity: 0.13

            PropertyAnimation {
                id: leftMarginAnim3
                target: thirdTopDiagonalBar.anchors
                property: "leftMargin"
                duration: 3000
                easing.type: Easing.InOutSine
                onStopped: {
                    leftMarginAnim3.from = thirdTopDiagonalBar.anchors.leftMargin;
                    leftMarginAnim3.to = Math.random() * 20 - 180;
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
                    topMarginAnim3.to = Math.random() * 20 - 60;
                    topMarginAnim3.start();
                }
            }

            Component.onCompleted: {
                leftMarginAnim3.from = thirdTopDiagonalBar.anchors.leftMargin;
                leftMarginAnim3.to = Math.random() * 20 - 180;
                leftMarginAnim3.start();

                topMarginAnim3.from = thirdTopDiagonalBar.anchors.topMargin;
                topMarginAnim3.to = Math.random() * 20 - 60;
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
            source: "Assets/circle.png"
            opacity: 0.13
        }

        Image {
            id: secondTopCircle
            anchors.horizontalCenter: parent.left
            anchors.verticalCenter: parent.top
            width: 1224
            height: 1224
            source: "Assets/circle.png"
            opacity: 0.13

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
    }

    // Timer to fire the various animations in order
    Timer {
        interval: 100
        running: true
        repeat: false
        onTriggered: {
            horizontalTopBarSlideInAnimation.start()
            horizontalBotBarSlideInAnimation.start()
        }
    }
}
