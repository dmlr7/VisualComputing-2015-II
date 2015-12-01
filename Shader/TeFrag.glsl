#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec3 ecVertex;
varying vec3 ecNormal;
varying vec3 direction;

void main() { 
  float intensityDiffuse = max(0.0, dot(direction, ecNormal));
  
  vec3 lR = normalize(-reflect(direction,ecNormal));
  vec3 v = normalize(-ecVertex);
  float intensitySpecular = max(0.0, dot(lR,v));    

  vec4 diffuse=vec4(vec3(intensityDiffuse),1);
  vec4 specular=vec4(vec3(intensitySpecular),1);
  vec4 temp = normalize(specular*vec4(0.5))+normalize(diffuse);
  gl_FragColor = vertColor*temp;
}
