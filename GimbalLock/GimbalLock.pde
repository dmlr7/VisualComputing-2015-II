//import remixlab.bias.branch.*;
import remixlab.bias.core.*;
import remixlab.bias.event.*;
//import remixlab.dandelion.branch.*;
import remixlab.dandelion.constraint.*;
import remixlab.dandelion.core.*;
import remixlab.dandelion.geom.*;
import remixlab.fpstiming.*;
import remixlab.proscene.*;
import remixlab.util.*;

String renderer = P3D;
PGraphics canvas;
Scene scene;
// 3D Objects
Object3D objects[];

void setup() {
  size(840, 620, renderer);
  canvas = createGraphics((int)width, (int)height, renderer);
  scene = new Scene(this, canvas);
  if(scene.is3D()) scene.setCameraType(Camera.Type.PERSPECTIVE);
  scene.setRadius(100);
  scene.showAll();
  
  objects = new Object3D[6];
  objects[0] = new Ring(Object3D.X, 100, 10, 5, color(255, 0, 0));
  objects[1] = new Ring(Object3D.Z, 95, 10, 5, color(0, 255, 0));
  objects[2] = new Ring(Object3D.Y, 90, 10, 5, color(0, 0, 255));
  objects[3] = new Drum(new Point(0, 0, 0), Object3D.Z, 10, 50, 20, color(115, 60, 200));
  objects[4] = new Drum(new Point(0, 0, 20), Object3D.Z, 20, 30, 20, color(115, 60, 200));
  objects[5] = new Drum(new Point(0, 0, -20), Object3D.Z, 20, 30, 20, color(115, 60, 200));
}

void draw(){
  background(0);
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  drawObjects(scene.pg());
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);
  rotateObjects(PI / 180);
}

void drawObjects(PGraphics pg) {
  for(int i = 0; i < objects.length; ++i)
    objects[i].draw(pg);
}

void rotateObjects(float angle) {
  for(int i = 0; i < objects.length; ++i)
    objects[i].rotate(Object3D.Z, angle);
  for(int i = 1; i < objects.length; ++i)
    objects[i].rotate(Object3D.Y, angle);
  for(int i = 2; i < objects.length; ++i)
    objects[i].rotate(Object3D.X, angle);
}