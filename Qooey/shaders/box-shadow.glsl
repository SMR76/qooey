varying highp vec2 qt_TexCoord0;
uniform highp float qt_Opacity;
uniform highp float radius;
uniform highp float spread;
uniform highp vec2 ratio;
uniform highp vec4 color;

void main() {
    highp vec2 center = ratio / 2.0;
    highp vec2 coord = qt_TexCoord0 * ratio;
    highp float dist = length(max(abs(center - coord) - center + radius, 0.0)) - radius;
    gl_FragColor = color * smoothstep(0.0, spread, - dist + 0.001) * qt_Opacity;
}
