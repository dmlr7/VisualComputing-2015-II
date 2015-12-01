#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

varying vec4 vertColor;
varying vec3 ecVertex;
varying vec3 ecNormal;
varying float index;
varying vec3 direction[8];

void main() {
  vec4 temp=vec4(0.1);
  highp int lightCount = int(index);  
  for (int i = 0; i < lightCount; i++) {
    float intensityDiffuse = max(0.0, dot(direction[i], ecNormal));
  
    vec3 lR = normalize(-reflect(direction[i],ecNormal));
    vec3 v = normalize(-ecVertex);
    float intensitySpecular = max(0.0, dot(lR,v));    

    vec4 diffuse=vec4(vec3(intensityDiffuse),1);
    vec4 specular=vec4(vec3(intensitySpecular),1);
    temp = normalize(specular*vec4(0.5))+normalize(diffuse)+temp;
}
  
  gl_FragColor = vertColor*temp;
}
