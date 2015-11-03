public class Skeleton {
  ArrayList<Line> lines;
  Line l;
  float s=1.5;
  public Skeleton(){
    SkeletonG(s);
  }
  public Skeleton(float a){
    SkeletonG(a);
  }
  public void SkeletonG(float s) {      
  
    Point p1 = new Point(0/s,0/s);
    Point p2 = new Point(0/s,-100/s);
    Point p3 = new Point(-50/s,-75/s);
    Point p4 = new Point(-65/s,0/s);
    Point p5 = new Point(-40/s,45/s);
    Point p6 = new Point(-50/s,90/s);
    Point p7 = new Point(-65/s,95/s);
    Point p8 = new Point(40/s,45/s);
    Point p9 = new Point(50/s,90/s);
    Point p10 = new Point(65/s,95/s);
    Point p11 = new Point(50/s,-75/s);
    Point p12 = new Point(65/s,0/s);
    Point p13 = new Point(-25/s,-115/s);
    Point p14 = new Point(-25/s,-130/s);
    Point p15 = new Point(0/s,-145/s);
    Point p16 = new Point(25/s,-130/s);
    Point p17 = new Point(25/s,-115/s);
    
    
    /*
    lines.add(new Line(p1,p2));
    lines.add(new Line(p1,p5));
    lines.add(new Line(p1,p8));
    lines.add(new Line(p2,p3));
    lines.add(new Line(p2,p11));
    lines.add(new Line(p2,p13));
    lines.add(new Line(p2,p17));
    lines.add(new Line(p3,p4));
    lines.add(new Line(p5,p6));
    lines.add(new Line(p6,p7));
    lines.add(new Line(p8,p9));
    lines.add(new Line(p9,p10));
    lines.add(new Line(p11,p12));
    lines.add(new Line(p13,p14));
    lines.add(new Line(p14,p15));
    lines.add(new Line(p15,p16));
    lines.add(new Line(p16,p17));*/
  }
  
  public void draw(PGraphics pg){
    for(Line line: lines)
      line.draw(pg, color(105, 201, 224));
  }
}