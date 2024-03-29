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
// Graph Variables
float graphHeight = 80;
Graph graph;
// Screw Variables
Screw screw;
int sides = 20;
float r = 20, h = 10;
PShape screws;
// Snail Path Variables
SnailPath spath;
int views = 20;
int path = 1;

void setup(){
  size(840, 620, renderer);
  canvas = createGraphics((int)width, (int)(height - graphHeight), renderer);
  graph = new Graph(height - graphHeight, graphHeight, 400);
  scene = new Scene(this, canvas);
  if(scene.is3D()) scene.setCameraType(Camera.Type.PERSPECTIVE);
  scene.setRadius(200);
  scene.showAll();
  
  screw = new Screw(sides);
  screws = createShape(GROUP);
  for(float x = -100; x < 100; x += 3 * r)
    for(float y = -100; y < 100; y += 3 * r)
      for(float z = -100; z < 100; z += 2 * h)
        screws.addChild(screw.create(new Point(x, y, z), r, h));
  
  spath = new SnailPath(views, path);
  for(float dist = 150; dist > 0; dist -= 50) {
    spath.createPath(scene, dist, 150, -10);
    spath.createPath(scene, dist, -150, 10);
  }
}

void draw(){
  background(0);
  drawProsceneSample();
  graph.addValue(frameRate);
  graph.drawGraph();
  scene.eye().playPath(path);
}

void drawProsceneSample() {
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  scene.pg().shape(screws);
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);
}