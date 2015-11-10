public class Point extends DrawableObject{
  public float x, y;
  public final static float radius = 5;
  public Point(Scene scn,float x, float y) {
    super(scn);
    this.x = x;
    this.y = y;
  }
  
  public void draw(PGraphics pg, color c) {
    pg.stroke(c);
    pg.fill(c);
    pg.ellipse(x, y, radius, radius);
    println(this.x,this.y);
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
    return new Point(this.scene,x, y);
  }
  
}