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

public void solve(double a[], double b[], double c[], double d[], int n) {
    /*
    // n is the number of unknowns

    |b0 c0 0 ||x0| |d0|
    |a1 b1 c1||x1|=|d1|
    |0  a2 b2||x2| |d2|

    1st iteration: b0x0 + c0x1 = d0 -> x0 + (c0/b0)x1 = d0/b0 ->

        x0 + g0x1 = r0               where g0 = c0/b0        , r0 = d0/b0

    2nd iteration:     | a1x0 + b1x1   + c1x2 = d1
        from 1st it.: -| a1x0 + a1g0x1        = a1r0
                    -----------------------------
                          (b1 - a1g0)x1 + c1x2 = d1 - a1r0

        x1 + g1x2 = r1               where g1=c1/(b1 - a1g0) , r1 = (d1 - a1r0)/(b1 - a1g0)

    3rd iteration:      | a2x1 + b2x2   = d2
        from 2st it. : -| a2x1 + a2g1x2 = a2r2
                       -----------------------
                       (b2 - a2g1)x2 = d2 - a2r2
        x2 = r2                      where                     r2 = (d2 - a2r2)/(b2 - a2g1)
    Finally we have a triangular matrix:
    |1  g0 0 ||x0| |r0|
    |0  1  g1||x1|=|r1|
    |0  0  1 ||x2| |r2|

    Condition: ||bi|| > ||ai|| + ||ci||

    in this version the c matrix reused instead of g
    and             the d matrix reused instead of r and x matrices to report results
    Written by Keivan Moradi, 2014
    */
    n--; // since we start from x0 (not x1)
    c[0] /= b[0];
    d[0] /= b[0];

    for (int i = 1; i < n; i++) {
        c[i] /= b[i] - a[i]*c[i-1];
        d[i] = (d[i] - a[i]*d[i-1]) / (b[i] - a[i]*c[i-1]);
    }

    d[n] = (d[n] - a[n]*d[n-1]) / (b[n] - a[n]*c[n-1]);
    for (int i = n; i-- > 0;) {
        d[i] -= c[i]*d[i+1];
    }
}