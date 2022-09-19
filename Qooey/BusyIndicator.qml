// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import 'base'

T.BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    running: true

    contentItem: Item {
        implicitWidth: 25
        implicitHeight: 25

        width: control.width
        height: control.height

        property real seed: 0
        property real distort: control.running ? 3 : 0

        Behavior on distort { SmoothedAnimation { velocity: 1 } }

        Timer {
            interval: 33 // Almost 30Hz
            repeat: true; running: control.running
            onTriggered: parent.seed += 0.04
        }

        Repeater {
            model: 5
            Liquid {
                width: parent.width - index * 3
                height: parent.height - index * 3
                anchors.centerIn: parent
                seed: parent.seed + index / 10
                strokeWidth: 2
                distorted: parent.distort
                fill: index === 4
                color: control.palette.button
                opacity: index === 4 ? 0.6 : 0.3
            }
        }
    }
}
