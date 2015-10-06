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
float graphHeight = 60;
Graph graph;
// Screw Variables
Screw screw;
int sides = 8;
float r = 20, h = 10;
// Snail Path Variables
SnailPath spath;
int views = 50;
int path = 1;

void setup(){
  size(840, 620, renderer);
  canvas = createGraphics((int)width, (int)(height - graphHeight), renderer);
  graph = new Graph(height - graphHeight, graphHeight, 400);
  scene = new Scene(this, canvas);
  if(scene.is3D()) scene.setCameraType(Camera.Type.ORTHOGRAPHIC);
  scene.setRadius(200);
  scene.showAll();
  screw = new Screw(sides);
  spath = new SnailPath(views, path);
  spath.createPath(scene, 150, 150, -10);
  spath.createPath(scene, 150, -150, 10);
}

void draw(){
  background(0);
  drawProsceneSample();
  graph.addValue(frameRate);
  graph.drawGraph();
  scene.eye().playPath(path);
  println(frameRate);
}

void drawProsceneSample() {
  canvas.beginDraw();
  scene.beginDraw();
  canvas.background(0);
  for(float x = -100; x < 100; x += 3 * r)
    for(float y = -100; y < 100; y += 3 * r)
      for(float z = -100; z < 100; z += 2 * h)
        screw.draw(scene.pg(), new Point(x, y, z), r, h);
  scene.endDraw();
  canvas.endDraw();
  image(canvas, 0, 0);
}