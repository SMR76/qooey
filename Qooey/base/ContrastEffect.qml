// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15

ShaderEffect {
    id: control

    property var source
    property color color: "#fff"

    fragmentShader: "qrc:/Qooey/shaders/contrast.glsl"
}
