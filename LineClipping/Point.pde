public class Point {
  public float x, y;
  public final static float radius = 5;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public void draw(PGraphics pg, color c) {
    pg.stroke(c);
    pg.fill(c);
    pg.ellipse(x, y, radius, radius);
  }
  
  public float dist(Point point) {
    float dx = x - point.x;
    float dy = y - point.y;
    return sqrt((dx * dx) + (dy * dy));
  }
  
  public boolean isInside(Point point) {
    return abs(dist(point)) < radius;
  }
  
  public void movePoint(float dx, float dy) {
    x += dx;
    y += dy;
  }
  
  public Point copy() {
    return new Point(x, y);
  }
  
}