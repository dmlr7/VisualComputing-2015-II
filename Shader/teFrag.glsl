#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


uniform int lightCount;
uniform vec3 lightNormal[8];
 
varying vec4 vertColor;
varying vec3 vertNormal;
//varying vec3 vertLightDir;


void main(){
  gl_FragColor =vec4(0.0);
  float intensity;
  vec4 color;
  //vec3 vertLightDir[8];
  for(int i =0;i<lightCount;i++){
   //vertLightDir[i]=-lightNormal[i];
   intensity = max(0.0, dot(-lightNormal[i], vertNormal));
   float dot_product = max(dot(normalize(-lightNormal[i]), normalize (vertNormal)), 0.0);
   color = dot_product * vec4( 1.0, 1.0, 1.0, 1.0 );
   gl_FragColor =gl_FragColor+( vertColor * intensity * color);
  }
}
