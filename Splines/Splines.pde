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
  size(800, 600, renderer);
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
      scene.line(points.get(i-1).getX(),points.get(i-1).getY(),points.get(i-1).getZ(),
      points.get(i).getX(),points.get(i).getY(),points.get(i).getZ());
    
    box.draw(true);
  }
  if(points.size()>=4){
    ItPoint box1,box2,box3,box4;
    for (int i = 0; i < points.size() && points.size()-i>=4; i += 3) {
    box1 = points.get(i);
    box2 = points.get(i + 1);
    box3 = points.get(i + 2);
    box4 = points.get(i + 3);
    bezier3d(box1.getP(),box2.getP(),box3.getP(),box4.getP());
  }
 }
}
public void addPoint() {
  ItPoint iPoint = new ItPoint(scene,mouseX,mouseY,0);
  points.add(iPoint);
}
public void removeLastPoint() {
  points.remove(points.size()-1);
}

void mouseReleased(){
  if(key == 'x')
    addPoint();
  key=' ';
}

public void bezier3d(Point p1,Point p2,Point p3,Point p4) {
  int numParts=20;
  float flag;
  float a=p1.x;
  float b=p1.y;
  float c=p1.z;
  for(int i = 1 ; i <= numParts; i++){
      flag = (i+0.0)/numParts;
      float c1 = (1-flag)*(1-flag)*(1-flag);
      float c2 = flag*(1-flag)*(1-flag);
      float c3 = flag*flag*(1-flag);
      float c4 = flag*flag*flag;
      float xi = (c1*p1.x)+(c2*3*p2.x)+(c3*3*p3.x)+(c4*p4.x);
      float yi = (c1*p1.y)+(c2*3*p2.y)+(c3*3*p3.y)+(c4*p4.y);
      float zi = (c1*p1.z)+(c2*3*p2.z)+(c3*3*p3.z)+(c4*p4.z);
      scene.pg().stroke(color(255,0,0));
      scene.line(a,b,c,xi,yi,zi);
      a=xi;
      b=yi;
      c=zi;
    }
}