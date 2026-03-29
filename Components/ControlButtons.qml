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
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.4

ColumnLayout {
    property var suspend: ["Suspend", config.TranslateSuspend || textConstants.suspend, sddm.canSuspend]
    property var hibernate: ["Hibernate", config.TranslateHibernate || textConstants.hibernate, sddm.canHibernate]
    property var reboot: ["Reboot", config.TranslateReboot || textConstants.reboot, sddm.canReboot]
    property var shutdown: ["Shutdown", config.TranslateShutdown || textConstants.shutdown, sddm.canPowerOff]
    property var model: [suspend, hibernate, reboot, shutdown]

    spacing: 0

    required property PanelButton controlPanelButton

    // Suspend Button
    Item {
        id: suspendButton

        property int typewriterCharIndex: 0
        height: 75
        width: 500
        anchors.left: parent.left

        // VERTICAL BAR
        Image {
            id: suspendVerticalBar
            anchors.right: parent.left
            anchors.rightMargin: -21
            width: 30
            height: parent.height
            source: Qt.resolvedUrl("../Assets/vertical_bar.png")
            opacity: 0.13 //0
        }

        // FOCUS POINTER
        Image {
            id: suspendFocusPointer
            anchors.right: suspend.left
            anchors.rightMargin: 10 //TODO: Relative scaling
            anchors.verticalCenter: suspendButton.verticalCenter
            width: 40 //TODO: Relative scaling
            height: 27 //TODO: Relative scaling
            source: Qt.resolvedUrl("../Assets/focus_pointer.png")
            opacity: suspend.activeFocus ? 0.63 : 0
            visible: opacity > 0

            Behavior on opacity {
                NumberAnimation {
                    duration: 200
                }
            }
        }

        // SIDEBARS
        Rectangle {
            id: suspendUpwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.bottom: suspend.top
            anchors.bottomMargin: -2
            anchors.horizontalCenter: suspend.horizontalCenter
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
            id: suspendDownwardsSidebar
            width: 389 //TODO: Relative scaling
            height: 2 //TODO: Relative scaling
            anchors.top: suspend.bottom
            anchors.topMargin: -2
            anchors.horizontalCenter: suspend.horizontalCenter
            color: "#000000"
            opacity: 0

            Behavior on anchors.topMargin {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InOutQuad
                }
            }
        }

        // SQUARE
        Rectangle {
            id: suspendSquare
            anchors.left: suspend.left
            anchors.top: suspend.top
            anchors.bottom: suspend.bottom
            anchors.leftMargin: 7
            anchors.topMargin: 12
            anchors.bottomMargin: 12
            width: height
            color: root.palette.text
            opacity: 1 //0
            z: 5
        }

        // BUTTON
        Button {
            id: suspend
            text: suspend[0]
            enabled: suspend[2]

            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 55 //TODO: Relative scaling
            height: 48
            width: 389

            background: Item {
                Rectangle {
                    anchors.fill: parent
                    color: root.palette.button
                }

                Rectangle {
                    id: suspendDarkener
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

            onClicked: {
                parent.forceActiveFocus()
                sddm.suspend() //TODO: "Are you sure?" check box
            }

            KeyNavigation.up: controlPanelButton.button
            Keys.onReturnPressed: clicked()
        }

        states: [
            State {
                name: "focused"
                when: suspend.activeFocus
                PropertyChanges { // Change text color
                    target: suspend
                    color: root.palette.highlight
                }
                PropertyChanges { // Darken the background
                    target: suspendDarkener
                    opacity: 0.5
                    width: parent.width
                }
                PropertyChanges { // Add shadow to the background
                    target: suspend.background
                    layer.enabled: true
                }
                PropertyChanges { // Pop out the sidebars
                    target: suspendUpwardsSidebar
                    anchors.bottomMargin: 4 //TODO: Relative scaling
                    opacity: 0.63
                }
                PropertyChanges { // Pop out the sidebars
                    target: suspendDownwardsSidebar
                    anchors.topMargin: 4 //TODO: Relative scaling
                    opacity: 0.63
                }
                PropertyChanges { // Highlight square
                    target: suspendSquare
                    color: root.palette.highlight
                }
            }
        ]

        transitions: [
            Transition {
                PropertyAnimation {
                    properties: "palette.buttonText, border.color"
                    duration: 150
                }
            }
        ]
    }
}
