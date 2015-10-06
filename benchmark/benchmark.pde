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

float graphHeight = 60;
Graph graph;

Screw screw;
int sides = 8;
float r = 20, h = 10;

void setup(){
  size(840, 620, renderer);
  canvas = createGraphics((int)width, (int)(height - graphHeight), renderer);
  graph = new Graph(height - graphHeight, graphHeight, 400);
  scene = new Scene(this, canvas);
  if(scene.is3D()) scene.setCameraType(Camera.Type.ORTHOGRAPHIC);
  scene.setRadius(200);
  scene.showAll();
  screw = new Screw(sides);
}

void draw(){
  background(0);
  drawProsceneSample();
  graph.addValue(frameRate);
  graph.drawGraph();
  println(frameRate);
}

void drawProsceneSample() {
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  screw.draw(scene.pg(), new Point(0, 0, 0), r, h);
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);
}