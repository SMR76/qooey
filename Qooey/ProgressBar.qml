// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

import 'base'

T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int orientation: Qt.Horizontal
    padding: 2

    QtObject {
        id: internals
        property bool vertical: control.orientation == Qt.Vertical
        property bool horizontal: control.orientation == Qt.Horizontal
    }

    contentItem: Item { }

    background: Item {
        implicitWidth: internals.horizontal ? 200 : 18
        implicitHeight: internals.vertical ? 200 : 18

        Rectangle {
            width: parent.width
            height: parent.height
            radius: width
            color: 'transparent'
            border.width: 1
            border.color: control.palette.button
        }

        Item {
            width: parent.width
            height: parent.height
            layer.enabled: true
            layer.effect: ContrastEffect {
                color: control.palette.button
            }

            component Bar: BoxShadow {
                y: (control.height - height)/2
                width: control.position * control.width
                height: Math.min(width, control.height)
                spread: 15
                color: "#fff"
            }

            Bar { // top
                y: (parent.height - height)/2-2; spread: 15
                Behavior on width { SpringAnimation { spring: 2.2; damping: 0.1 } }
            }
            Bar { // middle
                Behavior on width { SpringAnimation { spring: 2.6; damping: 0.1 } }
            }
            Bar { // bottom
                y: (parent.height - height)/2+2; spread: 15
                Behavior on width { SpringAnimation { spring: 3.2; damping: 0.1 } }
            }
        }
    }
}
