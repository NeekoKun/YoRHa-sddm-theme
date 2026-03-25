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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0

Item {
    id: sessionButton

    focus: true
    activeFocusOnTab: true

    property var selectedSession: selectSession.currentIndex
    property string textConstantSession
    property bool popupOpened: selectSession.popup.visible

    property var formFunctions: parent.parent.formFunctions
    property int sessionCharIndex: 0

    readonly property string currentSessionName: selectSession.currentText

    KeyNavigation.right: selectSession

    ComboBox {
        id: selectSession
        anchors.fill: parent

        hoverEnabled: true
        anchors.left: parent.left
        activeFocusOnTab: false

        model: sessionModel
        currentIndex: model.lastIndex
        textRole: "name"

        background: Rectangle {
            color: "transparent"
        }

        contentItem: Item {
            // Empty
        }

        onActiveFocusChanged: {
            if (activeFocus) {
                popup.open()
                sessionTypewriterTimer.start()
            } else {
                popup.close()
                sessionTypewriterTimer.stop()
                sessionButton.sessionCharIndex = 0
            }
        }

        onHighlightedIndexChanged: {
            if (popup.visible) {
                selectSession.currentIndex = highlightedIndex
            }
        }

        indicator {
            visible: false
        }

        delegate: ItemDelegate {
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            height: root.font.pointSize * 5

            
            highlighted: parent.highlightedIndex === index

            background: Item {
                // VERTICAL BAR
                Image {
                    anchors.right: sessionSelect.left
                    anchors.rightMargin: 0
                    anchors.verticalCenter: sessionSelect.verticalCenter
                    width: 30
                    height: parent.height
                    source: Qt.resolvedUrl("../Assets/vertical_bar.png")
                    opacity: 0.13
                }

                // FOCUS POINTER
                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 10
                    x: x + 15
                    width: 40
                    height: 27
                    source: Qt.resolvedUrl("../Assets/focus_pointer.png")
                    opacity: selectSession.highlightedIndex === index ? 0.63 : 0
                    visible: opacity > 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: 200
                        }
                    }
                }

                // SIDEBARS
                Rectangle {
                    id: itemUpwardsSidebar
                    width: 389
                    height: 2
                    anchors.bottom: parent.top
                    anchors.bottomMargin: -12
                    anchors.horizontalCenter: parent.horizontalCenter
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
                    id: itemDownwardsSidebar
                    width: 389
                    height: 2
                    anchors.top: parent.bottom
                    anchors.topMargin: -12
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "#000000"
                    opacity: 0

                    Behavior on anchors.topMargin {
                        NumberAnimation {
                            duration: 100
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

            }

            contentItem: Item {
                anchors.fill: parent

                Item {
                    id: itemTextWrapper
                    anchors.centerIn: parent
                    width: 389
                    height: 48
                    
                    Item {
                        id: itemBackground
                        anchors.fill: parent

                        // SQUARE
                        Rectangle {
                            id: itemSquare
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: 12
                            anchors.topMargin: 12
                            anchors.bottomMargin: 12
                            width: height
                            color: "#34332B"
                            opacity: 0.8
                            z: 10
                        }

                        Rectangle {
                            id: defaultBackground
                            anchors.fill: parent
                            color: "#000000"
                            opacity: 0.2

                            layer.enabled: false
                            layer.effect: DropShadow {
                                horizontalOffset: 4
                                verticalOffset: 4
                                radius: 0
                                samples: 17
                                cached: true
                                color: "#45000000"
                            }
                        }

                        Rectangle {
                            id: itemDarkener
                            anchors.left: parent.left
                            height: parent.height
                            width: 0
                            color: "#000000"
                            opacity: 0

                            SequentialAnimation on opacity {
                                running: selectSession.highlightedIndex === index
                                loops: Animation.Infinite
                                PauseAnimation { duration: 700 }
                                NumberAnimation { to: 0.3; duration: 300; easing.type: Easing.InOutQuad }
                                PauseAnimation { duration: 300 }
                                NumberAnimation { to: 0.5; duration: 300; easing.type: Easing.InOutQuad }
                            }

                            Behavior on width {
                                enabled: !itemDarkener.width > 0
                                NumberAnimation { duration: 500; easing.type: Easing.OutExpo }
                            }
                        }
                    }

                    Text {
                        id: itemText
                        text: sessionButton.formFunctions.getTypewriterText(model.name, sessionButton.sessionCharIndex)
                        leftPadding: itemSquare.width + 2 * itemSquare.anchors.leftMargin
                        font.pointSize: root.font.pointSize
                        font.family: inputContainer.fontFamily
                        color: selectSession.highlightedIndex === index ? "#C9C3A3" : "#34332B"
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                states: [
                    State {
                        name: "highlighted"
                        when: selectSession.highlightedIndex === index
                        PropertyChanges {
                            target: defaultBackground
                            layer.enabled: true
                        }
                        PropertyChanges {
                            target: itemDarkener
                            width: parent.width
                            opacity: 0.5
                        }
                        PropertyChanges {
                            target: itemUpwardsSidebar
                            anchors.bottomMargin: -10
                            opacity: 0.63
                        }
                        PropertyChanges {
                            target: itemDownwardsSidebar
                            anchors.topMargin: -9
                            opacity: 0.63
                        }
                        PropertyChanges {
                            target: itemSquare
                            color: "#C9C3A3"
                        }
                    }
                ]
            }
        }

        popup: Popup {
            id: popupHandler
            y: parent.y + (parent.height - height) / 2
            x: parent.x + parent.width - 10
            width: 545
            implicitHeight: contentItem.implicitHeight
            padding: 10

            background: Rectangle {
                color: "transparent"
            }

            contentItem: ListView {
                clip: true
                implicitHeight: contentHeight + 20
                model: selectSession.popup.visible ? selectSession.delegateModel : null
                currentIndex: selectSession.highlightedIndex
                ScrollIndicator.vertical: ScrollIndicator { }

                focus: true
            }

            enter: Transition {
                NumberAnimation { property: "opacity"; from: 0; to: 1 }
            }
        }
    }

    Timer {
        id: sessionTypewriterTimer
        interval: 20
        running: false
        repeat: true

        onTriggered: {
            sessionButton.sessionCharIndex++
            // Stop once reached a reasonable max length
            if (sessionButton.sessionCharIndex > 2000) {
                sessionTypewriterTimer.stop()
            }
        }
    }
}
