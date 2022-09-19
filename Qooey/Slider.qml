// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import QtGraphicalEffects 1.15
import 'base'

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    handle: Item {}

    background: Item {
        implicitWidth: !control.vertical ? 200 : 25
        implicitHeight: control.vertical ? 200 : 25

        layer.enabled: true
        layer.effect: ContrastEffect { color: control.palette.button }

        BoxShadow {
            x: (control.width - width)/2
            y: (control.height - height)/2

            width: !control.vertical ? control.availableWidth : 5
            height: control.vertical ? control.availableWidth : 5

            spread: Math.min(width, height) * 0.8
            color: "#fff"

            component Ball: BoxShadow {
                property real vpos: control.visualPosition
                x: !control.vertical ? vpos * parent.width - width/2 : (parent.width - width)/2
                y: control.vertical ? vpos * parent.height - height/2 : (parent.height - height)/2

                width: 21; height: width
                radius: width; spread: 20
                color: "#fff"
            }
            Ball { Behavior on vpos { SpringAnimation { spring: 5; damping: 0.3 } } }
            Ball { Behavior on vpos { SpringAnimation { spring: 5; damping: 0.2 } } }
        }
    }
}
