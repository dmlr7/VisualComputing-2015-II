public class Line {
  
  public Point a, b;
  public float err = 0.00001;
  
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
    
    Point cr = null;
    if(this.isVerticalLine()) {
      if(!line.isVerticalLine())
        cr = new Point(this.a.x, (m2 * this.a.x) + d);
    } else if(line.isVerticalLine())
      cr = new Point(line.a.x, (m1 * line.a.x) + c);
    else
      cr = new Point((d - c) / (m1 - m2), ((m1 * d) - (m2 * c)) / (m1 - m2));
    return cr;
  }
  
  private boolean isVerticalLine() {
    return abs(a.x - b.x) < 0.000001;
  }
  
  private boolean isInside(Point point) {
    return (min(a.x, b.x) <= point.x && point.x <= max(a.x, b.x))
        && (min(a.y, b.y) <= point.y && point.y <= max(a.y, b.y));
  }
  
  public Line copy() {
    return new Line(a.copy(), b.copy());
  }
  
}