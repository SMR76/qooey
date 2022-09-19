// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Tumbler {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    font.pixelSize: 12
    palette.text: "gray"

    delegate: Text {
        text: modelData
        color: control.visualFocus ? control.palette.highlightedText : control.palette.buttonText
        font: control.font
        opacity: 0.4 + Math.max(0, 1 - Math.abs(Tumbler.displacement)) * 0.6
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    contentItem: PathView {
        id: pathview
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        implicitWidth: 60
        implicitHeight: 80
        clip: true
        model: control.model
        delegate: control.delegate
        pathItemCount: control.visibleItemCount
        maximumFlickVelocity : 300
        path: Path {
            startX: control.availableWidth / 2
            startY: 0
            PathLine {
                x: control.availableWidth / 2
                y: control.availableHeight
            }
        }
    }

    background: Item {
        implicitWidth: 60
        implicitHeight: 80

        layer.enabled: true
        layer.effect: ContrastEffect { color: control.palette.button }

        Bubbles {
            anchors.fill: parent
            seed: -pathview.offset/3 - 1
            color: "#fff"
            grid: 3

            Bubbles {
                anchors.fill: parent
                seed: parent.seed
                color: "#fff"
                grid: 2
            }
        }

        BoxShadow {
            x: (parent.width - width)/2
            y: ((pathview.offset + 0.5) % 1) * parent.height - height/2
            width: parent.width * 0.5; height: width
            radius: width
            spread: 15
            color: "#fff"
        }
    }
}
