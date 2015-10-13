import java.util.*;
String renderer = P2D;
ArrayList<Point> points = new ArrayList<Point>();
Point p;
PGraphics canvas;
boolean var,var2;
int draw=0;
Point line[]=new Point[4];
void setup(){
  size(840, 620, renderer);
  canvas = createGraphics((int)width, (int)(height), renderer);
  //5, 26, 5, 26, 73, 24, 73, 61
}
void draw(){
  background(0);
  //noFill();
  //curve(5, 26, 5, 26, 73, 24, 73, 61);
  //curve(5, 26, 73, 24, 73, 61, 15, 65);
  fill(255);
  for(Point p: points){
    ellipse(p.x, p.y, 5, 5);
  }
  noFill();
  drawLines();
}
void drawLines(){
  int sizePoints= points.size();
  var=true;
  var2=true;
  for(int i=0;i<sizePoints && var;i++){
    if(var2){
     try{
      line[0]=points.get(i);
      line[1]=points.get(i+1);
      line[2]=points.get(i+2);
      stroke(255);
      if(draw==0)
       curve(line[0].x,line[0].y, line[0].x, line[0].y, line[1].x, line[1].y, line[2].x, line[2].y);
      if(draw==1)
       bezier(line[0].x, line[0].y, line[0].x, line[0].y, line[1].x, line[1].y, line[2].x, line[2].y);
      var2=false;
     }catch(Exception e){
      var=false;
     }
    }
    try{
      if(draw==1)
        i+=2;
      line[0]=points.get(i);
      line[1]=points.get(i+1);
      line[2]=points.get(i+2);
      line[3]=points.get(i+3);
      stroke(255);
      if(draw==0)
        curve(line[0].x, line[0].y, line[1].x, line[1].y, line[2].x, line[2].y, line[3].x, line[3].y);
      if(draw==1)
        bezier(line[0].x, line[0].y, line[1].x, line[1].y, line[2].x, line[2].y, line[3].x, line[3].y);

    }catch(Exception e){
      var=false;
    }
  }
    
  }
  
void mouseReleased() {
  p=new Point(mouseX,mouseY,0);
  points.add(p);
}
void keyPressed() {
  if (draw == 0) {
    draw = 1;
  } else {
    draw = 0;
  }
}