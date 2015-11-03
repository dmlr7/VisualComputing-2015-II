public class Skeleton {
  ArrayList<Line> lines;
  Line l;
  public Skeleton() {
    lines=new ArrayList<Line>();
    Point p1 = new Point(0,0);
    Point p2 = new Point(0,-100);
    Point p3 = new Point(-50,-75);
    Point p4 = new Point(-65,0);
    Point p5 = new Point(-40,45);
    Point p6 = new Point(-50,90);
    Point p7 = new Point(-65,95);
    Point p8 = new Point(40,45);
    Point p9 = new Point(50,90);
    Point p10 = new Point(65,95);
    Point p11 = new Point(50,-75);
    Point p12 = new Point(65,0);
    Point p13 = new Point(-25,-115);
    Point p14 = new Point(-25,-130);
    Point p15 = new Point(0,-145);
    Point p16 = new Point(25,-130);
    Point p17 = new Point(25,-115);
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
    lines.add(new Line(p16,p17));
  }
  
  public void draw(Window window ,LineClippingFunction clipping){
    for(Line line: lines)
      window.drawLine(line, clipping);
  }
}