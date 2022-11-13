// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.TextArea {
    id: control

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4

    color: control.palette.windowText
    placeholderTextColor: palette.mid
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width    - (control.leftPadding  + control.rightPadding)
        height: control.height  - (control.topPadding   + control.bottomPadding)

        text: control.placeholderText
        font: control.font

        color: control.placeholderTextColor

        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 40

        opacity: control.activeFocus ? 1 : 0.5
        color: Qt.lighter(palette.window, palette.window.hslLightness * 2)

        border.color: Qt.lighter(palette.button, 0.5 + palette.window.hslLightness)
        border.width: 0.5

        Behavior on opacity { NumberAnimation { duration: 100 } }

        Item {
            width: parent.width
            height: parent.height

            layer.enabled: true
            layer.effect: ContrastEffect { color: palette.button }

            SequentialAnimation {
                running: control.activeFocus
                alwaysRunToEnd: true
                PropertyAction {
                    target: ball
                    properties: "width,height"
                    value: 8
                }
                NumberAnimation {
                    target: ball; property: "y"
                    from: -ball.height; to: control.height - ball.height/2
                    easing.type: Easing.OutBack
                    easing.amplitude: 0.1
                }
                NumberAnimation {
                    target: ball; property: "width"
                    to: control.width + 10
                    duration: 1000
                    easing.type: Easing.OutCirc
                }
            }

            BoxShadow {
                id: ball
                x: (parent.width - width)/2; y: 0
                width: 0; height: 8
                color: "#fff"
            }
        }
    }
}
