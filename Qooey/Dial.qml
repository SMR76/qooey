// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    background: Item {
        implicitWidth: 184
        implicitHeight: 184

        layer.enabled: true
        layer.effect: ContrastEffect { color: control.palette.button }

        DashedRing {
            x: (parent.width - width)/2
            y: x
            width: mouse1.hovered || control.down ? control.width : 0
            height: width
            strokeWidth: 2
            dashWidth: 1
            dashCount: 55
            palette.base: "#fff"
            Behavior on width { SmoothedAnimation{ velocity: 150 } }

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Pie {
                    width: control.width
                    height: width
                    to: 152
                    from: -152
                }
            }
        }

        BoxShadow {
            width: parent.width
            height: width
            spread: width/5
            radius: width
            color: "#fff"
        }

        Item {
            width: parent.width
            height: width
            rotation: control.angle * 1.07

            BoxShadow {
                x: (parent.width - width)/2
                y: mouse1.hovered ? -height-2 : -height/2
                width: parent.width * 0.62; height: width
                radius: 14; spread: 20
                color: '#000'
                rotation: 45
                Behavior on y { SpringAnimation { spring: 2; damping: 0.2 } }
            }
        }
    }

    handle: Item {
        width: control.width
        height: control.height

        rotation: control.angle * 1.07

        Rectangle {
            x: (parent.width - width)/2
            y: mouse1.hovered ? -height : parent.height * 0.15
            width: 6; height: 6; radius: width/4
            color: control.palette.button
            rotation: 45
            Behavior on y { SpringAnimation { spring: 2; damping: 0.2 } }
        }
    }

    HoverHandler { id: mouse1 }
}
