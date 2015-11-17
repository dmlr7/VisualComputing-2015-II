PShader toon,diffuse,assigned;
String shader= "";
int shaderSelect= 0;
int lightSelect= 0;

void setup() {
  size(640, 360, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);
  
  diffuse = loadShader("DiffuseFrag.glsl", "DiffuseVert.glsl");
  
  shader="toon";
  assigned=diffuse;
}

void draw() {
  shader(assigned);
  background(0); 
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  ambientLight(204, 204, 204, 1, 0.5, -1);
  directionalLight(204, 204, 204, -dirX, -dirY, -1);
  translate(width/2, height/2);
  sphere(120);
}

void mouseReleased(){
  if(shaderSelect==0)
    assigned=toon;
  if(shaderSelect==1)
    assigned=diffuse;
  shaderSelect=(shaderSelect+1)%2;
}
void setLight(){
  
}