public class Line {
  public Point a, b;
  
  public Line(Point a, Point b) {
    this.a = a;
    this.b = b;
  }
  
  public void draw(PGraphics pg, color c) {
    pg.stroke(c);
    pg.line(a.x, a.y, b.x, b.y);
  } 
  
}