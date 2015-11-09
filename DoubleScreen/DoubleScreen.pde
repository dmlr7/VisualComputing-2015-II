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

Scene scene1,scene2;
PGraphics canvas1, canvas2;
Window window;
Point prewMouseLocation, mouseLocation, pointDragged;
//LineClippingFunction clipping;
DrawableObject sceneGraph;
Mat inverseMatrix=new Mat();
Skeleton sk1 ;
//String renderer = P2D;
// if opengl is not supported comment the prev line and uncomment this:
String renderer = P2D;
//dim
int w = 840;
int h = 680;
DrawableObject dO;


void setup() {
  size(840, 680, renderer);
  canvas1 = createGraphics(width*3/4, height, renderer);
  canvas2 = createGraphics(w*3/4, h, renderer);
  scene1 = new Scene(this,canvas1);
  scene1.showAll();
  scene1.setGridVisualHint(false);
  scene1.setAxesVisualHint(false);
  scene1.disableMotionAgent();

  scene2 = new Scene(this,canvas2,w*3/4,0);
  scene2.showAll();
  scene2.setGridVisualHint(false);
  scene2.setAxesVisualHint(false);
  scene2.disableMotionAgent();
  sk1 = new Skeleton(scene1);
  dO=new Point(scene1,0,0);
  //dO.setMobility(true);
}

void draw() {
  canvas1.beginDraw();
  scene1.beginDraw();
  canvas1.background(10);
  sk1.draw(scene1.pg());
  dO.draw(scene1.pg(),color(100,100,255));
  
  scene1.endDraw();
  canvas1.endDraw();
  
  canvas2.beginDraw();
  scene2.beginDraw();
  canvas2.background(0);
  //sk2.draw(scene2.pg());
  scene2.endDraw();
  canvas2.endDraw();
  
  image(canvas1,0,0);
  image(canvas2,w*3/4,0);
}
/*
boolean cinit = true;

boolean dinit = true;

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


void keyPressed() {
  if(key == '1')
    clipping = new NoClipping();
  else if(key == '2')
    clipping = new CohenSutherland();
}*/