// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.SpinBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + 2 * padding +
                            up.implicitIndicatorWidth +
                            down.implicitIndicatorWidth)
    implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight,
                             up.implicitIndicatorHeight,
                             down.implicitIndicatorHeight)
    padding: 6

    leftPadding: padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
    rightPadding: padding + (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

    font.bold: true

    component Indicator: Text {
        width: 30; height: parent.height

        font.pointSize: 10
        font.bold: true

        opacity: !enabled ? 0.4 : 1

        color: control.palette.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    component Drop: BoxShadow {
        y: (parent.height - height)/2
        width: parent.height
        height: width
        color: '#fff'
        spread: 10
    }

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        text: control.displayText

        font: control.font
        color: control.palette.buttonText
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: Indicator {
        x: control.mirrored ? 0 : parent.width - width
        text: "+";
    }

    down.indicator: Indicator {
        x: control.mirrored ? parent.width - width : 0
        text: "-";
    }

    background: Item {
        id: background
        implicitWidth: 100
        implicitHeight: 30

        layer.enabled: true
        layer.effect: ContrastEffect {
            color: control.palette.button
        }

        Drop { // main
            x: (parent.width - width)/2
            width: parent.height + 4 * control.value / Math.abs(control.to - control.from)
        }
        Drop { x: up.indicator.x; spread: 18 } // up
        Drop { x: down.indicator.x; spread: 18 } // down

        Drop { id: upShot
            x: up.indicator.x + width * 0.3
            width: parent.height * 0.5
        }
        Drop { id: downShot
            x: up.indicator.x + width * 0.3
            width: parent.height * 0.5
        }

        NumberAnimation {
            duration: 400
            running: up.pressed
            alwaysRunToEnd: true
            target: upShot; property: 'x'
            from: up.indicator.x + upShot.width * 0.3
            to: (control.background.width - upShot.width)/2
            easing.type: Easing.OutBack
            easing.overshoot: 4
        }

        NumberAnimation {
            duration: 400
            running: down.pressed
            alwaysRunToEnd: true
            target: downShot; property: 'x'
            from: (control.background.width - upShot.width * 2)/2
            to: down.indicator.x + downShot.width * 0.3
            easing.type: Easing.InExpo
        }
    }
}
