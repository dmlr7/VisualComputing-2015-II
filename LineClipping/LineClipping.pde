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

void setup() {
  size(840, 620, P2D);
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
}

void draw() {
  background(0);
  window.draw();
  for(Line line: lines)
    window.drawLine(line, clipping);
  if(!cinit)
    mouseLocation.draw(scene.pg(), color(0, 255, 0));
}

boolean cinit = true;

void mouseClicked() {
  mouseLocation = window.toWindowPoint(mouseX, mouseY);
  
  if(cinit)
    cinit = false;
  else {
    cinit = true;
    lines.add(new Line(prewMouseLocation, mouseLocation));
  }
  prewMouseLocation = mouseLocation;
}

boolean dinit = true;

void mouseDragged() {
  //clipping = new NoClipping();
  mouseLocation = window.toWindowPoint(mouseX, mouseY);
  cinit = true;
  if(dinit) {
    prewMouseLocation = mouseLocation;
    dinit = false;
    pointDragged = searchLinePointInsiding(mouseLocation);
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

Point searchLinePointInsiding(Point point) {
  for(Line line: lines)
    if(line.a.isInside(point))
      return line.a;
    else if(line.b.isInside(point))
      return line.b;
  return null;
}

void mouseReleased() {
  dinit = true;
  pointDragged = null;
}

void keyPressed() {
  if(key == '1')
    clipping = new NoClipping();
  else if(key == '2')
    clipping = new CohenSutherland();
}