
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
varying vec3 direction;

void main() {
  vec4 temp=vec4(0.1);
  gl_Position = transform * vertex;    
  ecVertex = vec3(modelview * vertex);  
  ecNormal = normalize(normalMatrix * normal);
  for (int i = 0; i < lightCount; i++) {
    direction = normalize(lightPosition[i].xyz - ecVertex);

    float intensityDiffuse = max(0.0, dot(direction, ecNormal));
  
    vec3 lR = normalize(-reflect(direction,ecNormal));
    vec3 v = normalize(-ecVertex);
    float intensitySpecular = max(0.0, dot(lR,v));    
  
    vec4 diffuse=vec4(vec3(intensityDiffuse),1);
    vec4 specular=vec4(vec3(intensitySpecular),1);
    temp = normalize(specular)+normalize(diffuse)+temp;
  }
  vertColor = color*temp; 
}
