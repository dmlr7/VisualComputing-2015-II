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

Scene scene;
PGraphics canvas;
Window window;
Point prewMouseLocation, mouseLocation, pointDragged;
ArrayList<Line> lines;
LineClippingFunction clipping;
Skeleton sk;

void setup() {
  size(840, 620, JAVA2D);
  canvas = createGraphics(width, height, JAVA2D);
  scene = new Scene(this);
  scene.setRadius(200);
  scene.showAll();
  scene.setGridVisualHint(false);
  scene.setAxesVisualHint(false);
  scene.disableMotionAgent();
  window = new Window(scene, 200, 300);
  lines = new ArrayList<Line>();
  clipping = new NoClipping();
  sk = new Skeleton();
}

boolean cinit = true;

boolean dinit = true;

void draw() {
  background(0);
  window.draw();
  sk.draw(window,clipping);
  if(!cinit)
    mouseLocation.draw(scene.pg(), color(0, 255, 0));
}

void mouseDragged() {
  //clipping = new NoClipping();
  mouseLocation = window.toWindowPoint(mouseX, mouseY);
  cinit = true;
  if(dinit) {
    prewMouseLocation = mouseLocation;
    dinit = false;
    pointDragged = null;
  }
  float dx = mouseLocation.x - prewMouseLocation.x;
  float dy = mouseLocation.y - prewMouseLocation.y;
  
  if(pointDragged != null)
    pointDragged.movePoint(dx, dy);
  else {
    window.setCenter(new Point(
      window.getCenter().x + dx,
      window.getCenter().y + dy
    ));
  }
  prewMouseLocation = mouseLocation;
}