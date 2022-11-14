// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15

Item {
    property alias source: effect.source
    property alias maskSource: maskBridge.sourceItem

    ShaderEffectSource {
        id: maskBridge
        anchors.fill: parent
        visible: false
    }

    ShaderEffect {
        id: effect
        anchors.fill: parent
        property var source
        property var maskSource: maskBridge
        fragmentShader: "qrc:/Qooey/shaders/opacity-mask.glsl"
    }
}

