// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.0

ShaderEffect {
    id: effect

    property real grid: 5
    property real seed: 0
    property color color: '#fff'

    fragmentShader: "
        #ifdef GL_ES
            precision highp float;
            precision highp vec2;
        #endif

        uniform highp float qt_Opacity;
        varying highp vec2 qt_TexCoord0;
        uniform highp vec4 color;
        uniform highp float seed;
        uniform highp float width;
        uniform highp float grid;

        vec2 noise2(highp vec2 st) {
            st = vec2(dot(st,vec2(127.1, 311.7)), dot(st, vec2(269.5, 183.3)));
            return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
        }

        highp vec2 getPos(vec2 id) {
            vec2 noise = noise2(id);
            float x = sin(seed * noise.x);
            float y = cos(seed * noise.y);
            return vec2(x, y) * 0.3;
        }

        void main() {
            vec2 uv = qt_TexCoord0;
            uv *= grid;
            uv.y -= seed;
            vec2 gridUv = fract(uv) -.5;
            vec2 cellId = floor(uv);
            vec2 position = getPos(floor(uv));
            float dist = length(gridUv - position);
            gl_FragColor = color * (1. - smoothstep(0.0, 17./width, dist));
        }"
}
