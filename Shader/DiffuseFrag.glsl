#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


varying vec4 vertColor;
varying vec3 vertNormal;
varying vec3 vertLightDir;

void main(){
  float intensity;
  vec4 color;
  intensity = max(0.0, dot(vertLightDir, vertNormal));
  float dot_product = max(dot(normalize(vertLightDir), normalize(vertNormal)), 0.0);
  color = dot_product * vec4( 1.0, 1.0, 1.0, 1.0 );
  gl_FragColor = vertColor * normalize(color) * intensity;
}