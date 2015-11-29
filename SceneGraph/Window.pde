public class Window {
  
  protected int zoom;
  protected float w, h;
  protected float angle;
  protected Point center;
  
  public Window(int zoom) {
    setZoom(zoom);
    this.center = new Point(h/2, w/2);
    this.angle = 0;
  }
  
  public void draw(PGraphics pg) {
    pg.fill(255, 214, 72);
    pg.stroke(0);
    pg.beginShape();
    for(Point vertex: calutateVertex())
      pg.vertex(vertex.x, vertex.y);  
    pg.endShape();
  }
  
  public ArrayList<Point> calutateVertex() {
    ArrayList<Point> vertex = new ArrayList<Point>();
    vertex.add(new Point(center.x - (h/2), center.y - (w/2)));
    vertex.add(new Point(center.x + (h/2), center.y - (w/2)));
    vertex.add(new Point(center.x + (h/2), center.y + (w/2)));
    vertex.add(new Point(center.x - (h/2), center.y + (w/2)));
    for(Point point: vertex)
      point.rotate(angle);
    return vertex;
  }
  
  public void setZoom(int zoom) {
    this.zoom = zoom;
    this.w = zoom * 5;
    this.h = zoom * 7;
  }
  
  public float getW() {
    return w;
  }
  
  public float getH() {
    return h;
  }
  
  public int getZoom() {
    return zoom;
  }
  
  public void setCenter(Point center) {
    this.center = center;
  }
  
  public Point getCenter() {
    return center;
  }
  
  public Point getOrigin() {
    return new Point(center.x - (h/2), center.y - (w/2));
  }
  
  public void setAngle(float angle) {
    this.angle = angle;
  }
  
  public float getAngle() {
    return angle;
  }
  
}