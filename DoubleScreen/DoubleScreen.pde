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

Scene scene1, scene2;
PGraphics canvas1, canvas2;
Window window;
Point prewMouseLocation, mouseLocation, pointDragged;
//LineClippingFunction clipping;
DrawableObject sceneGraph;
Mat inverseMatrix=new Mat();
Skeleton sk1, sk2;
//String renderer = P2D;
// if opengl is not supported comment the prev line and uncomment this:
String renderer = P2D;
//dim
int w = 840;
int h = 680;
DrawableObject dO,dO2;


void setup() {
  size(840, 680, renderer);
  canvas1 = createGraphics(width, height, renderer);
  canvas2 = createGraphics(w*3/4, h/4, renderer);
  scene1 = new Scene(this, canvas1);
  scene1.showAll();
  scene1.setGridVisualHint(false);
  scene1.setAxesVisualHint(false);
  scene1.disableMotionAgent();

  scene2 = new Scene(this, canvas2, 0, 0);
  scene2.showAll();
  scene2.setGridVisualHint(false);
  scene2.setAxesVisualHint(false);
  scene2.disableMotionAgent();
  window =new Window(scene2,100,100);
  sk1 = new Skeleton(scene1);
  sk2= new Skeleton(scene2);
  dO=new Point(scene1, 0, 0);
  dO.setMobility(true);
  dO2=new Point(scene2, 0, 0);
  dO2.setMobility(true);
}

void draw() {
  canvas1.beginDraw();
  scene1.beginDraw();
  canvas1.background(50);
  sk1.draw(scene1.pg());
  
  scene1.endDraw();
  canvas1.endDraw();

  image(canvas1, 0, 0);
  
  canvas2.beginDraw();
  scene2.beginDraw();
  canvas2.background(0);
  canvas2.translate(-canvas2.width*0.8/2,0);
  sk2.draw(scene2.pg());
  window.draw();
  scene2.endDraw();
  canvas2.endDraw();

  image(canvas2, w*3/4, 0);
}
//public void handleMouse() {
//  if (mouseY > h/4||mouseX<w/4*3) {
//    scene1.enableMotionAgent();
//    scene1.enableKeyboardAgent();
//    scene2.disableMotionAgent();
//    scene2.disableKeyboardAgent();
//  } else {
//    scene1.disableMotionAgent();
//    scene1.disableKeyboardAgent();
//    scene2.enableMotionAgent();
//    scene2.enableKeyboardAgent();
//  }
//}
void mousePressed(){
  if (!(mouseY > h/4||mouseX<w/4*3))
    println(mouseX,mouseY);
}

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
     window.setCenter(new Point(window.getScene(),
     window.getCenter().x + dx,
     window.getCenter().y + dy
     ));
   }
   prewMouseLocation = mouseLocation;
 }
 /*
 void keyPressed() {
   if(key == '1')
     clipping = new NoClipping();
   else if(key == '2')
     clipping = new CohenSutherland();
 }*/
 
 
 void keyPressed() {
   if(key == '1')
     sk2.getPos();
   else if(key == '2')
     key=' ';
 }