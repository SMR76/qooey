// Copyright (C) 2022 smr.
// SPDX-License-Identifier: LGPL-3.0-only
// http://s-m-r.ir

import QtQuick 2.0

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

        fragmentShader: "
            // https://www.shadertoy.com/view/ttjGDz
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float seed;
            uniform highp float distort;
            uniform highp float sw;
            uniform highp float width;
            uniform highp vec4 color;
            uniform lowp bool fill;

            highp vec2 random2(highp vec2 st) {
                st = vec2(dot(st,vec2(127.1, 311.7)), dot(st, vec2(269.5, 183.3)));
                return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
            }

            float noise(vec2 st) {
                highp vec2 i = floor(st);
                highp vec2 f = fract(st);

                highp vec2 u = f * f * (3.0 - 2.0 * f);

                return mix(mix(dot(random2(i + vec2(0.0,0.0)), f - vec2(0.0,0.0)),
                               dot(random2(i + vec2(1.0,0.0)), f - vec2(1.0,0.0)), u.x),
                           mix(dot(random2(i + vec2(0.0,1.0)), f - vec2(0.0,1.0)),
                               dot(random2(i + vec2(1.0,1.0)), f - vec2(1.0,1.0)), u.x), u.y);
            }

            float circle(highp vec2 coord, highp vec2 center, float radius) {
                return smoothstep(1., 1. - 1/width, distance(coord, center) / radius);
            }

            float ring(highp vec2 coord, highp vec2 center, float radius) {
                return circle(coord, center, radius) - circle(coord, center, radius - sw/width);
            }

            void main() {
                highp vec2 coord = qt_TexCoord0 - vec2(0.5);

                highp float angle = atan(coord.y, coord.x);
                highp float angleNoise = atan(coord.y, coord.x) + seed;

                highp vec2 nPos = vec2(cos(angleNoise), sin(angleNoise));

                highp float n1 = noise(nPos);
                highp float n2 = noise(nPos + seed);
                highp float r = 0.67 + sin(distort  * 2.0 * angle) * n1 *
                                0.28 + sin(distort  * 4.0 * angle) * n2 * 0.08;

                highp float pct = fill ? circle(coord, vec2(0.), r * 0.65) : ring(coord, vec2(0.), r * 0.65);
                gl_FragColor = color * pct * qt_Opacity;
            }"
    }
}
