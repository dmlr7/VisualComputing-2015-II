
#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat3 normalMatrix;

uniform int lightCount;
uniform vec4 lightPosition[8];


attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 ecVertex;
varying vec3 ecNormal;
varying vec3 direction[8];
varying float index;
void main() {
  index = lightCount;
  gl_Position = transform * vertex;    
  ecVertex = vec3(modelview * vertex);  
  ecNormal = normalize(normalMatrix * normal);
  for (int i = 0; i < lightCount; i++) {
  direction[i] = normalize(lightPosition[i].xyz - ecVertex);
}
  vertColor = color;  
}
