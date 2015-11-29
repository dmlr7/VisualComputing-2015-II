
#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 ecVertex;
varying vec3 ecNormal;
varying vec3 direction;

void main() {
  gl_Position = transform * vertex;    
  ecVertex = vec3(modelview * vertex);  
  ecNormal = normalize(normalMatrix * normal);
  direction = normalize(lightPosition.xyz - ecVertex);
  vertColor = color;
  
}
