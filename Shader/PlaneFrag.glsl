#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_LIGHT_SHADER

varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;
varying vec3 myColor;
varying float LightIntensity;

void main(void)
{
    gl_FragColor = vec4(LightIntensity * myColor.rgb, 1.);
}
