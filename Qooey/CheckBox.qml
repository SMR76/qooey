// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding,
                             indicator.height + topPadding + bottomPadding)
    padding: 6
    spacing: 6

    indicator: BoxShadow {
        implicitWidth: 30
        implicitHeight: implicitWidth

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        radius: width/5
        spread: width/5

        color: '#fff'

        layer.enabled: true
        layer.effect: ContrastEffect {
            color: control.visualFocus ? control.palette.highlight : control.palette.button
        }

        Rectangle {
            id: flash
            x: (parent.width - width)/2
            y: (parent.height - height)/2
            width: parent.width * 0.65; height: width
            radius: width/8
            color: "#000"
            border.width: 0
            border.color: "#fff"
        }

        BoxShadow {
            id: checkC
            y: (parent.height - height)/2
            width: 0
            height: parent.height * 0.3
        }

        Item {
            x: -1; y: -width * 0.4
            width: parent.width
            height: parent.height
            rotation: -45

            BoxShadow {
                id: checkA
                x: width
                y: parent.height - height
                width: parent.width
                height: parent.width * 0.3
            }

            BoxShadow {
                id: checkB
                y: parent.height - height
                width: parent.width * 0.3
                height: 0
            }

            states:[
                State {
                    name: "checked"; when: control.checkState === Qt.Checked
                    PropertyChanges { target: checkA; x: 3; width: parent.width * 0.9 }
                    PropertyChanges { target: checkB; height: parent.width * 0.5 }
                    PropertyChanges { target: checkC; x: -width * 1.1 }
                    PropertyChanges { target: flash; border.width: width }
                },
                State {
                    name: "unchecked"; when: control.checkState === Qt.Unchecked
                    PropertyChanges { target: checkA; x: parent.width; width: parent.width * 2 }
                    PropertyChanges { target: checkC; x: -width * 1.1 }
                    PropertyChanges { target: flash; border.width: 0 }
                },
                State {
                    name: "partial"; when: control.checkState === Qt.PartiallyChecked
                    PropertyChanges { target: checkC; x: (parent.width - width)/2; width: parent.width * 0.7 }
                    PropertyChanges { target: flash; border.width: width }
                }
            ]

            transitions: [
                Transition {
                    to: "checked"
                    ParallelAnimation {
                        SequentialAnimation {
                            NumberAnimation { targets: [checkA, checkC]; properties: "x,width"; duration: 200 }
                            NumberAnimation { target: checkB; properties: "height"; duration: 400; easing.type: Easing.OutBack }
                        }
                    }
                },
                Transition {
                    from: "checked"
                    SequentialAnimation {
                        NumberAnimation { target: checkB; properties: "height"; duration: 300 }
                        NumberAnimation { targets: [checkA, checkC]; properties: "x,width"; duration: 200; easing.type: Easing.InBack }
                        NumberAnimation { target: flash; properties: "width"; duration: 900; easing.type: Easing.OutBounce}
                    }
                },
                Transition {
                    to: "*"
                    SpringAnimation { properties: "x,width"; spring: 2; damping: 0.1 }
                }
            ]
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.palette.windowText
    }
}
