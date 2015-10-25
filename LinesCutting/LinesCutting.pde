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

Scene scene;
PGraphics canvas;
Window window;
Point prewMouseLocation, mouseLocation;

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
}

void draw() {
  background(0);
  window.draw();
}

void mouseClicked() {
  mouseLocation = new Point(mouseX, mouseY);
  print("clicked");
}

boolean dinit = true;

void mouseDragged() {
  mouseLocation = new Point(mouseX, mouseY);
  if(dinit) {
    prewMouseLocation = mouseLocation;
    dinit = false;
  }
  window.setCenter(new Point(
    window.getCenter().x + mouseLocation.x - prewMouseLocation.x,
    window.getCenter().y + mouseLocation.y - prewMouseLocation.y
  ));
  prewMouseLocation = mouseLocation;
}

void mouseReleased() {
  dinit = true;
}

void keyPressed() {
  
}