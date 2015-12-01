import remixlab.bias.branch.*;
import remixlab.bias.core.*;
import remixlab.bias.event.*;
import remixlab.dandelion.branch.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.fpstiming.*;
import remixlab.proscene.*;
import remixlab.util.*;

PShape can;
float angle;
int shaderSelect= 2;
float div=1;

PShader gouround,gouround2, phong,assigned;
Scene scene;
InteractiveLight light,target;
Vec lightPosition,targetPos,dir;

void setup() {
  size(640, 360, P3D);
  scene = new Scene(this);  
  scene.setRadius(100);
  scene.showAll();
  scene.setGridVisualHint(true);
  scene.setPickingVisualHint(true);
  //can = createCan(100, 200, 32);
  can=loadShape("suzanne.obj");
  gouround = loadShader("TeaFrag.glsl", "TeaVert.glsl");
  gouround2 = loadShader("LightFrag.glsl", "GenericVert.glsl");
  phong = loadShader("TeFrag.glsl", "TeVert.glsl");
  assigned=gouround;
  light = new InteractiveLight(scene);
  target = new InteractiveLight(scene);
  dir= new Vec(0,0,0);
}

PShape createCan(float r, float h, int detail) {
  textureMode(NORMAL);
  PShape sh = createShape();
  sh.beginShape(QUAD_STRIP);
  sh.noStroke();
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
  lightPosition = light.getPosition();
  targetPos = target.getPosition();
  
  background(0);
  shader(assigned);  
  pointLight(255,255,255, lightPosition.x(), lightPosition.y(), lightPosition.z());
  pointLight(255,255,255, targetPos.x(), targetPos.y(), targetPos.z());
  specular(30);
  scale(100);
  shape(can);
  scale(0.01);
  light.draw();
  angle += 0.01;
}

void keyPressed(){
  if(key=='1'){
  div=2;
  shaderSelect += 1;
  shaderSelect %= 2;
  println(shaderSelect);
  if(shaderSelect==0)
    assigned=gouround;
  if(shaderSelect==1)
    assigned=phong;
  if(shaderSelect==2)
    assigned=gouround2;
}
key=' ';
}