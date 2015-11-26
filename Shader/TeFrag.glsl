#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec4 diffuse;
varying vec4 specular;

void main() {
  vec3 direction = normalize(lightDir);
  vec3 normal = normalize(ecNormal);
  float intensityDiffuse = max(0.0, dot(direction, normal));
  float intensitySpecular = max(0.0, dot(direction, normal));
  gl_FragColor = vec4(vec3(intensityDiffuse), 1) * vertColor;
  
  vec3 lR = normalize(-reflect(direction,ecNormal));
  vec3 v = normalize(-ecVertex);
  float intensitySpecular = max(0.0, dot(lR,v));
  
  diffuse=vec4(vec3(intensityDiffuse),1);
  specular=vec4(vec3(intensitySpecular),1);
  
  gl_FragColor = vertColor*diffuse;//*specular;
}
