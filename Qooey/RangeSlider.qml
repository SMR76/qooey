// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls  2.15 as QQC

T.RangeSlider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            first.implicitHandleWidth + leftPadding + rightPadding,
                            second.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             first.implicitHandleHeight + topPadding + bottomPadding,
                             second.implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    first.handle: Item { }
    second.handle: Item { }

    background: Item {
        x: (control.width - width) / 2
        y: (control.height - height) / 2

        implicitWidth: !control.vertical ? 200 : 25
        implicitHeight: control.vertical ? 200 : 25

        layer.enabled: true
        layer.effect: ContrastEffect { color: control.palette.button }

        BoxShadow {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            width: !control.vertical ? control.availableWidth : 5
            height: control.vertical ? control.availableHeight : 5

            spread: Math.min(width, height) * 0.8
            color: "#fff"

            component Ball: BoxShadow {
                property real vpos: 0
                x:!control.vertical ? vpos * parent.width - width/2 : (parent.width - width)/2
                y: control.vertical ? vpos * parent.height - height/2 : (parent.height - height)/2

                width: 21; height: width
                radius: width; spread: 20
                color: "#fff"
            }

            Ball {
                vpos: control.first.visualPosition
                Behavior on vpos { SpringAnimation { spring: 5; damping: 0.3 } }
            }
            Ball {
                vpos: control.first.visualPosition
                Behavior on vpos { SpringAnimation { spring: 5; damping: 0.2 } }
            }

            Ball {
                vpos: control.second.visualPosition
                Behavior on vpos { SpringAnimation { spring: 5; damping: 0.3 } }
            }
            Ball {
                vpos: control.second.visualPosition
                Behavior on vpos { SpringAnimation { spring: 5; damping: 0.2 } }
            }
        }
    }
}
