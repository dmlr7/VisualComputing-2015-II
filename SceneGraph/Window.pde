public class Window {
  
  protected int zoom;
  protected float w, h;
  protected Point origin;
  
  public Window(int zoom) {
    setZoom(zoom);
    this.origin = new Point(0, 0);
  }
  
  public void draw(PGraphics pg) {
    pg.fill(255, 214, 72);
    pg.stroke(0);
    pg.beginShape();
    pg.vertex(origin.x, origin.y);
    pg.vertex(origin.x + h, origin.y);
    pg.vertex(origin.x + h, origin.y + w);
    pg.vertex(origin.x, origin.y + w);  
    pg.endShape();
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
  
  public void setOrigin(Point origin) {
    this.origin = origin;
  }
  
  public Point getOrigin() {
    return origin;
  }
  
}