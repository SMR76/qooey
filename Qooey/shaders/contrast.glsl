varying highp vec2 qt_TexCoord0;
uniform highp float qt_Opacity;
uniform highp float width;
uniform highp sampler2D source;
uniform lowp vec4 color;

void main() {
    highp vec4 p = texture2D(source, qt_TexCoord0);
    gl_FragColor = color * qt_Opacity * smoothstep(0.0f, 10.0f/width, p.r - 0.25f);
}
