/*PShader toon,diffuse,assigned,light,plane,te;
String shader= "";
int shaderSelect= 2;
float div=1;
PImage img;

void setup() {
  size(1280, 600, P3D);
  noStroke();
  fill(204);
  toon = loadShader("ToonFrag.glsl", "ToonVert.glsl");
  toon.set("fraction", 1.0);
  
  te = loadShader("TeFrag.glsl", "TeVert.glsl");
  
  diffuse = loadShader("DiffuseFrag.glsl", "DiffuseVert.glsl");
  light = loadShader("LightFrag.glsl", "GenericVert.glsl");
  light.set("option", 0);
  plane = loadShader("LightFrag.glsl", "GenericVert.glsl");
  plane.set("option", 1);
  shader="te";
  assigned=te;
  img=createImage(200, 200, ARGB);
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = color(100, 0, 0); 
  }
  img.updatePixels();
}*/

PShape can;
float angle;

PShader lightShader;

void setup() {
  size(640, 360, P3D);
  can = createCan(100, 200, 32);
  lightShader = loadShader("TeFrag.glsl", "TeVert.glsl");
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
  //sh.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    sh.normal(x, 0, z);
    sh.vertex(x * r, -h/2, z * r, u, 0);
    sh.vertex(x * r, +h/2, z * r, u, 1);    
  }
  sh.endShape(); 
  return sh;
}
//scene.eye().frame().trasnformOf()
//myshader.set("mylight",scene.eye().frame().trasnformOf() );
void draw() {
  /*
  shader(assigned);
  
  float dirY = (mouseY / float(height) - 0.5) * 2;
  float dirX = (mouseX / float(width) - 0.5) * 2;
 // float[] lightPosition = new float[4];
 // lightPosition[0]=dirX;
 // lightPosition[1]=dirY;
 // lightPosition[2]=-0.5;
  //lightPosition[3]=1.0;
  //assigned.set("lightNormal", lightPosition);
  background(0); 
  //lightSpecular(250,250,250);
  directionalLight(104, 104, 104, -dirX/div, -dirY/div, -0.5);
  //directionalLight(104, 104, 104, 1, 1, 1);
  //directionalLight(104, 104, 104, -1, 1, 1);
  //directionalLight(104, 104, 104, -1, -1, 1);
 // directionalLight(104, 104, 104, 1, -1, 1);
  lightSpecular(0,0,0);
  translate(width/2, height/2);
  //ambientLight(80, 80, 80, -1, -1, -1);
  specular(120,120,120);
  //ambient(200);
  shininess(30);
  fill(color(100,0,0));  
  sphereDetail(100);
  //texture(img);
  sphere(250);
  //fill(color(0,100,0));
  //ellipse(0,0,20,20);*/
  
  background(0);

  shader(lightShader);

  pointLight(255, 255, 255, width/2, height, 200);

  translate(width/2, height/2);
  rotateY(angle);  
  shape(can);  
  angle += 0.01;
}
/*
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
}*/