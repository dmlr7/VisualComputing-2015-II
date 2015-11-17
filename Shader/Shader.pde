PShader toon,diffuse,assigned,light,plane;
String shader= "";
int shaderSelect= 2;
float div=1;
PImage img;

void setup() {
  size(800, 600, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);
  
  diffuse = loadShader("DiffuseFrag.glsl", "DiffuseVert.glsl");
  light = loadShader("LightFrag.glsl", "GenericVert.glsl");
  light.set("option", 0);
  plane = loadShader("LightFrag.glsl", "GenericVert.glsl");
  plane.set("option", 1);
  shader="toon";
  assigned=light;
  img=createImage(200, 200, ARGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(100, 0, 0); 
  }
  img.updatePixels();
}

void draw() {
  shader(assigned);
  background(0); 
  lightSpecular(250,250,250);
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
  directionalLight(104, 104, 104, -dirX/div, -dirY/div, -0.5);
  directionalLight(104, 104, 104, 1, 1, 1);
  directionalLight(104, 104, 104, -1, 1, 1);
  directionalLight(104, 104, 104, -1, -1, 1);
  directionalLight(104, 104, 104, 1, -1, 1);
  lightSpecular(0,0,0);
  translate(width/2, height/2);
  ambientLight(80, 80, 80, 1, 1, 1);
  specular(120,120,120);
  //ambient(200);
  shininess(30);
  fill(color(100,0,0));  
  sphereDetail(300);
  //texture(img);
  sphere(250);
  //fill(color(0,100,0));
  //ellipse(0,0,20,20);
}

void mouseReleased(){
  div=2;
  shaderSelect += 1;
  shaderSelect %= 4;
  println(shaderSelect);
  if(shaderSelect==0)
    assigned=toon;
  if(shaderSelect==1)
    assigned=diffuse;
  if(shaderSelect==3)
    assigned=plane;
  if(shaderSelect==2){
    assigned=light;
    div=0.3;
  }
}