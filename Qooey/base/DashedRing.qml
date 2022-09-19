// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

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

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float count;
            uniform highp float dashWidth;
            uniform highp float strokeWidth;
            uniform highp float width;
            uniform highp vec4 color;

            void main() {
                highp vec2 normal = qt_TexCoord0 - vec2(0.5);
                highp float ticks = smoothstep(0.0, 10.0/width/count, -abs(fract(atan(normal.x, normal.y) * 57.2958 / count) - 0.5) + dashWidth / count);
                highp float ring = smoothstep(0.0, 0.5/width, -abs(length(normal) - 0.5 + strokeWidth) + strokeWidth);
                gl_FragColor = color * ring * ticks;
            }"
    }
}
