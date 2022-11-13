// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15

ShaderEffect {
    id: effect

    property real grid: 5
    property real seed: 0
    property color color: '#fff'

    fragmentShader: "qrc:/Qooey/shaders/bubbles.glsl"
}
