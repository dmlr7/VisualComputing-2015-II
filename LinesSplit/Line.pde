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
  
  public float slope() {
    return (a.y - b.y) / (a.x - b.x);
  }
  
  public Point cross(Line line) {
    float m1 = this.slope(), m2 = line.slope();
    float c = this.b.y - (m1 * this.b.x), d = line.b.y - (m2 * line.b.x);
    Point cr =  new Point((d - c) / (m1 - m2), ((m1 * d) - (m2 * c)) / (m1 - m2));
    if(this.isInside(cr) && line.isInside(cr))
      return cr;
    return null;
  }
  
  private boolean isInside(Point point) {
    return (min(a.x, b.x) <= point.x && point.x <= max(a.x, b.x))
        && (min(a.y, b.y) <= point.y && point.y <= max(a.y, b.y));
  }
  
}