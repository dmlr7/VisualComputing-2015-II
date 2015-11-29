#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

uniform int option;
uniform sampler2D texture;

varying vec4 vertColor;
varying vec4 backVertColor;
varying vec4 vertTexCoord;
varying vec4 positionFS;

void main() {
  if(option==0)
    gl_FragColor = gl_FrontFacing ? vertColor : backVertColor;    
  if(option==1){
    gl_FragColor = vertColor * normalize(positionFS)*10;
  }
}


