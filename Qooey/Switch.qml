// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Switch {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Rectangle {
        implicitWidth: 50
        implicitHeight: 28

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        color: '#000'
        radius: width
        border.color: "#fff"
        border.width: 2

        layer.enabled: true
        layer.effect: ContrastEffect {
            color: control.visualFocus ? control.palette.highlight : control.palette.button
        }

        component Ball: BoxShadow {
            y: (parent.height - height)/2
            x: Qooey.clamp(control.visualPosition * control.indicator.width - height/2,
                           y,
                           control.indicator.width - height - y)

            width: control.indicator.height * 0.9
            height: width
            color: "#fff"

            radius: width
            spread: width/2
        }

        Ball { Behavior on x { enabled: !control.down; NumberAnimation{ duration: 120 } } }
        Ball { Behavior on x { SpringAnimation { spring: 2; damping: 0.2 } } }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator &&  control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.palette.text
    }
}
