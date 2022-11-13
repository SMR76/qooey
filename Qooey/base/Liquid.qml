// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15

Item {
    id: control

    property alias fill: effect.fill
    property alias seed: effect.seed
    property alias color: effect.color
    property alias distorted: effect.distort
    property alias strokeWidth: effect.sw

    ShaderEffect {
        id: effect

        width: control.width
        height: control.height

        property bool fill: false
        property real seed: 0
        property real distort : 3
        property real sw: 1
        property color color: '#000'

        fragmentShader: "qrc:/Qooey/shaders/liquid.glsl"
    }
}
