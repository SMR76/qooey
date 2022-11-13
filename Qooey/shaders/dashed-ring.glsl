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
    gl_FragColor = color * ring * ticks * qt_Opacity;
}
