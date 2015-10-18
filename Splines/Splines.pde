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

ArrayList<ItPoint> points;
Scene scene;
//Choose one of P3D for a 3D scene, or P2D or JAVA2D for a 2D scene
String renderer = P3D;

void setup() {
  size(640, 360, renderer);
  //Scene instantiation
  scene = new Scene(this);
  scene.setGridVisualHint(true);
  scene.eyeFrame().setDamping(0.5);
  if(scene.is3D()) scene.setCameraType(Camera.Type.PERSPECTIVE);
  scene.setRadius(200);
  scene.showAll();
  //println("spinning sens: " +  scene.eyeFrame().spinningSensitivity());
  points = new ArrayList(); 
}

void draw() {
  background(0);
  for (int i = 0; i < points.size(); i++) {
    ItPoint box = points.get(i);
    //fill(255);    
    scene.pg().stroke(255);
    if(i!=0)
      scene.line(points.get(i-1).getX(),points.get(i-1).getY(),points.get(i).getX(),points.get(i).getY());
    box.draw(true);
  }
}
public void addPoint() {
  ItPoint iPoint = new ItPoint(scene,mouseX,mouseY,0);
  points.add(iPoint);
}

void mouseReleased(){
  if(key == 'x')
    addPoint();
  println(mouseX,mouseY);
  key=' ';
}