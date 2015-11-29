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
  
  objects = new Object3D[7];
  objects[0] = new Ring(Object3D.Z, 100, 5, 5, color(255, 0, 0));
  objects[1] = new Ring(Object3D.Z, 95, 5, 5, color(0, 255, 0));
  objects[2] = new Ring(Object3D.Z, 90, 5, 5, color(0, 0, 255));
  objects[3] = new Drum(new Point(0, 0, 0), Object3D.X, 10, 50, 20, color(115, 60, 200));
  objects[4] = new Drum(new Point(20, 0, 0), Object3D.X, 20, 30, 20, color(115, 60, 200));
  objects[5] = new Drum(new Point(-20, 0, 0), Object3D.X, 20, 30, 20, color(115, 60, 200));
  objects[6] = new Drum(new Point(0, 0, 0), Object3D.X, 10, 2, 180, color(115, 180, 100));
}

float angle = 0;

void draw(){
  background(0);
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  drawObjects(scene.pg());
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);
  angle += PI / 180;
  rotateObjects(angle);
}

void drawObjects(PGraphics pg) {
  for(int i = 0; i < objects.length; ++i)
    objects[i].draw(pg);
}

float save = 0;

void rotateObjects(float angle) {
  float[][] matrixY = objects[0].calculateRotationMatrix(Object3D.X, angle);
  float[][] inverseY = objects[0].calculateRotationInverse(Object3D.X, save);
  objects[0].rotate(inverseY);
  objects[0].rotate(matrixY);
  
  float[][] matrixX = objects[1].calculateRotationMatrix(Object3D.Y, angle);
  float[][] inverseX = objects[1].calculateRotationInverse(Object3D.Y, save);
  objects[1].rotate(inverseY);
  objects[1].rotate(inverseX);
  objects[1].rotate(matrixX);
  objects[1].rotate(matrixY);
  
  float[][] matrixY2 = objects[1].calculateRotationMatrix(Object3D.X, angle);
  float[][] inverseY2 = objects[1].calculateRotationInverse(Object3D.X, save);
  for(int i = 2; i < objects.length; ++i) {
    objects[i].rotate(inverseY);
    objects[i].rotate(inverseX);
    objects[i].rotate(inverseY2);
    objects[i].rotate(matrixY2);
    objects[i].rotate(matrixX);
    objects[i].rotate(matrixY);
  }
  
  save = angle;
}

float[][] multiply(float[][] A, float[][] B) {
  float[][] C = new float[A.length][B[0].length];
  for(int f = 0; f < A.length; ++f)
    for(int c = 0; c < A[f].length; ++c) {
      C[f][c] = 0;
      for(int i = 0; i < B[f].length; ++i)
        C[f][c] += A[f][i] * B[i][c];
    }
  return C;
}