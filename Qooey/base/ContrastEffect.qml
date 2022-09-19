import QtQuick 2.0

ShaderEffect {
    id: control

    property var source
    property color color: "#fff"

    fragmentShader: "
        uniform lowp sampler2D source;
        uniform lowp float qt_Opacity;
        uniform lowp float width;
        uniform lowp vec4 color;
        varying highp vec2 qt_TexCoord0;

        void main() {
            highp vec4 p = texture2D(source, qt_TexCoord0);
            gl_FragColor = color * qt_Opacity * smoothstep(0.0f, 10.0f/width, p.r - 0.25f);
        }"
}
