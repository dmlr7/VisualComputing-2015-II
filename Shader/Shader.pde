PShader toon,diffuse,assigned,light;
String shader= "";
int shaderSelect= 0;

void setup() {
  size(800, 600, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);
  
  diffuse = loadShader("DiffuseFrag.glsl", "DiffuseVert.glsl");
  light = loadShader("LightFrag.glsl", "GenericVert.glsl");
  light.set("shininess", 30.0);  
  shader="toon";
  assigned=light;
}

void draw() {
  shader(assigned);
  background(0); 
  lightSpecular(250,250,250);
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  ambientLight(50, 50, 50, -1, -1, -1);
  directionalLight(104, 104, 104, -dirX, -dirY, -0.5);
  //directionalLight(104, 104, 104, dirX, -dirY, -1);
  translate(width/2, height/2);
  //specular(255,255,255);
  //ambient(200);
  shininess(50.0);
  fill(color(100,0,0));
  sphereDetail(100);
  sphere(250);
}

void mouseReleased(){
  shaderSelect += 1;
  println(shaderSelect);
  if(shaderSelect==1)
    assigned=toon;
  if(shaderSelect==2)
    assigned=diffuse;
  if(shaderSelect==3)
    assigned=light;
  
  if(shaderSelect>=2)
    shaderSelect %= 3;
}