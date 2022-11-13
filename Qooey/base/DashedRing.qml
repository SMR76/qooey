// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property real dashCount: 2
    property real dashWidth: 2
    property real strokeWidth: 2

    ShaderEffect {
        id: effect
        width: parent.width;
        height: width;
        readonly property real count: 360 / control.dashCount
        readonly property real dashWidth: control.dashWidth / 2
        readonly property real strokeWidth: control.strokeWidth / width / 2
        readonly property color color: control.palette.base;

        fragmentShader: "qrc:/Qooey/shaders/dashed-ring.glsl"
    }
}
