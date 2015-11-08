public class Line extends DrawableObject{
  
  public Point a, b;
  public float err = 0.00001;
  
  public Line(Scene scn,Point a, Point b) {
    super(scn);
    this.a = a;
    this.b = b;
    isDrawable=true;
  }
  @Override
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
        cr = new Point(this.scene,this.a.x, (m2 * this.a.x) + d);
    } else if(line.isVerticalLine())
      cr = new Point(this.scene,line.a.x, (m1 * line.a.x) + c);
    else
      cr = new Point(this.scene,(d - c) / (m1 - m2), ((m1 * d) - (m2 * c)) / (m1 - m2));
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
    return new Line(this.
    scene,a.copy(), b.copy());
  }
  
}