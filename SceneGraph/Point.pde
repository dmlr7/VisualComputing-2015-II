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
  
  public Point copy() {
    return new Point(x, y);
  }
  
  public void scale(float sx, float sy) {
    x *= sx;
    y *= sy;
  }
  
  public void rotate(float angle) {
    float px = x, py = y;
    x = (px * cos(angle)) - (py * sin(angle));
    y = (px * sin(angle)) + (py * cos(angle));
  }
  
  public void translate(Point t) {
    this.x += t.x;
    this.y += t.y;
  }
  
}