
#define PROCESSING_LIGHT_SHADER

uniform mat4 modelview;
uniform mat4 transform;
uniform mat4 pojection;
uniform mat3 normalMatrix;

uniform vec4 lightPosition;
uniform vec3 mylight;

attribute vec4 vertex;
attribute vec4 color;
attribute vec3 normal;

varying vec4 vertColor;
varying vec3 ecNormal;
varying vec3 lightDir;

varying vec4 diffuse;
varying vec4 specular;

void main() {
  gl_Position = transform * vertex;    
  vec3 ecVertex = vec3(modelview * vertex);  
  
  ecNormal = normalize(normalMatrix * normal);
  
  lightDir = normalize(lightPosition.xyz - ecVertex);    
  
  float intensityDiffuse = max(0.0, dot(direction, ecNormal));
              
  vec3 lR = normalize(-reflect(direction,ecNormal));
  vec3 v = normalize(-ecVertex);
  float intensitySpecular = max(0.0, dot(lR,v));
  
  diffuse=vec4(vec3(intensityDiffuse),1);
  specular=vec4(vec3(intensitySpecular),1);
  vertColor=color;
  
}
