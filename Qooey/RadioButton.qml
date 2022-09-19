// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import QtGraphicalEffects 1.15
import Qooey 1.0
import 'base'

T.RadioButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Rectangle {
        implicitWidth:  25
        implicitHeight: 25

        x: control.text ?
               (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) :
               (control.leftPadding + (control.availableWidth - width) / 2)

        y: control.topPadding + (control.availableHeight - height) / 2

        smooth: true
        radius: width
        color: "#fff"

        layer.enabled: true
        layer.effect: ContrastEffect {
            color: control.visualFocus ? control.palette.highlight : control.palette.button
        }

        BoxShadow {
            property point center: Qt.point((parent.width - width)/2, (parent.height - height)/2)

            x: mouse.hovered && control.checked ? Qooey.clamp(mouse.mouseX - width/2, -5, parent.width - width + 5) : center.x
            y: mouse.hovered && control.checked ? Qooey.clamp(mouse.mouseY - width/2, -5, parent.width - width + 5) : center.y

            width: parent.width
            height: parent.height

            radius: width
            spread: width / 5

            Behavior on x { SpringAnimation { mass: 2; spring: 2; damping: 0.3 } }
            Behavior on y { SpringAnimation { mass: 2; spring: 2; damping: 0.3 } }

            Rectangle {
                id: eye
                x: (parent.width - width)/2
                y: (parent.height - height)/2
                width: parent.width * 0.5
                height: width
                radius: width
                transform: Scale {
                    origin.y: eye.height/2;
                    yScale: control.checked
                    Behavior on yScale { NumberAnimation { duration: 100 } }
                }
            }
        }

        HoverHandler {
            id: mouse
            readonly property real mouseX: point.position.x
            readonly property real mouseY: point.position.y
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        color: palette.windowText
        text: control.text
        font: control.font
    }
}
