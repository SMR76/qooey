// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: palette.buttonText

    display: AbstractButton.TextOnly

    contentItem: Item {
        Grid {
            anchors.centerIn: parent
            spacing: control.display == AbstractButton.TextOnly ||
                     control.display == AbstractButton.IconOnly ? 0 : control.spacing

            flow: control.display == AbstractButton.TextUnderIcon ? Grid.TopToBottom :
                                                                    Grid.LeftToRight
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down || control.checked ? 0.8 : 1.0

            Image {
                visible: control.display != AbstractButton.TextOnly
                source: control.icon.source
                width: control.icon.width
                height: control.icon.height
                cache: control.icon.cache
            }

            Text {
                visible: control.display != AbstractButton.IconOnly
                text: control.text
                font: control.font
                color: !control.enabled ? 'gray' :
                    control.highlighted ? palette.highlightedText :
                                          palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: Item {
        implicitWidth: 55
        implicitHeight: 55

        Item {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            // 20 is the extra space for ball to freely move outside of button
            width: parent.width + 20
            height: parent.height + 20

            layer.enabled: true
            layer.effect: ContrastEffect {
                color: {
                    const  _color =  control.highlighted ? palette.highlight : palette.button
                    _color.a = control.flat ? 0.7 : 1.0;
                    control.down ? Qt.lighter(_color, 1.1) : _color
                }
            }

            BoxShadow {
                visible: control.enabled

                width: parent.width - 20
                height: parent.height - 20

                anchors.centerIn: parent

                radius: width
                spread: 5
                color: "#fff"

                BoxShadow {
                    x: mouse.hovered ? mouse.mouseX - width/2 : (parent.width - width)/2
                    y: mouse.hovered ? mouse.mouseY - width/2 : (parent.height - width)/2

                    width: control.checked ? ball.width + 6 : 0
                    height: width
                    visible: !control.flat

                    Behavior on x { enabled: control.checked; SpringAnimation { mass: 2; spring: 1.6; damping: 0.3 } }
                    Behavior on y { enabled: control.checked; SpringAnimation { mass: 2; spring: 1.6; damping: 0.3 } }
                }

                BoxShadow {
                    id: ball
                    x: mouse.hovered ? Qooey.clamp(mouse.mouseX - width/2, -5, parent.width - width + 5) :
                                                 (parent.width - width)/2
                    y: mouse.hovered ? Qooey.clamp(mouse.mouseY - width/2, -5, parent.height - width + 5) :
                                                 (parent.height - width)/2

                    width: Math.min(parent.width, parent.height) * 0.85
                    height: width
                    spread: width / 5
                    visible: !control.flat

                    color: "#fff"

                    Behavior on x { SpringAnimation { mass: 2; spring: 2; damping: 0.3 } }
                    Behavior on y { SpringAnimation { mass: 2; spring: 2; damping: 0.3 } }
                }

                HoverHandler {
                    id: mouse
                    readonly property real mouseX: point.position.x
                    readonly property real mouseY: point.position.y
                }
            }
        }
    }
}
