public class Point {
  public float x, y;
  public final static float radius = 5;
  
  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  void draw(PGraphics pg, color c) {
    pg.stroke(c);
    pg.fill(c);
    pg.ellipse(x, y, radius, radius);
  }
  
  float dist(Point point) {
    float dx = x - point.x;
    float dy = y - point.y;
    return sqrt((dx * dx) + (dy * dy));
  }
  
  boolean isInside(Point point) {
    return abs(dist(point)) < radius;
  }
  
  void movePoint(float dx, float dy) {
    x += dx;
    y += dy;
  }
  
}