varying highp vec2 qt_TexCoord0;
uniform highp float qt_Opacity;
uniform highp sampler2D source;
uniform highp sampler2D maskSource;

void main() {
    gl_FragColor = qt_Opacity *
                   texture2D(source, qt_TexCoord0) *
                   texture2D(maskSource, qt_TexCoord0).a;
}
