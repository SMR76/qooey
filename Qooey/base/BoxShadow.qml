// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15

Item {
    id: control

    implicitWidth: 50
    implicitHeight: 50

    property color color: "#000"
    property real radius: width/2
    property real spread: 5

    ShaderEffect {
        id: effect

        width: control.width;
        height: control.height;

        readonly property color color: control.color;
        readonly property vector2d ratio: Qt.vector2d(width / whmax, height / whmax);
        readonly property real whmax: Math.max(width, height);
        readonly property real spread: control.spread / whmax;
        readonly property real radius: {
            const min = Math.min(width, height);
            return Math.min(Math.max(control.radius, spread), min/2) / whmax;
        }

        fragmentShader: "qrc:/Qooey/shaders/box-shadow.glsl"
    }
}
