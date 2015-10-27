public class Window {
  protected Scene scene;
  protected InteractiveFrame iframe;
  protected float l, h;
  protected Point center;
  protected Line[] divisions;
  
  public final static float borderX = 270;
  public final static float borderY = 200;
  
  Window(Scene scene, float h, float l) {
    this.scene = scene;
    iframe = new InteractiveFrame(scene, null);
    center = new Point(0, 0);
    this.l = l;
    this.h = h;
    calculateDivisions();
  }
  
  public void calculateDivisions() {
    float dh = h / 2, dl = l / 2;
    divisions = new Line[4];
    divisions[0] = new Line(new Point(center.x - dl, -borderY), new Point(center.x - dl, borderY));
    divisions[1] = new Line(new Point(-borderX, center.y - dh), new Point(borderX, center.y - dh));
    divisions[2] = new Line(new Point(center.x + dl, -borderY), new Point(center.x + dl, borderY));
    divisions[3] = new Line(new Point(-borderX, center.y + dh), new Point(borderX, center.y + dh));
  }
  
  public void draw() {
    iframe.applyTransformation();
    drawWindow(scene.pg());
    drawDivisions(scene.pg());
  }
  
  public void drawWindow(PGraphics pg) {
    float dh = h / 2, dl = l / 2;
    pg.fill(120, 120, 120);
    pg.beginShape();
    pg.vertex(center.x -dl, center.y - dh);
    pg.vertex(center.x -dl, center.y + dh);
    pg.vertex(center.x + dl, center.y + dh);
    pg.vertex(center.x + dl, center.y - dh);
    pg.endShape();
  }
  
  public void drawDivisions(PGraphics pg) {
    for(int i = 0; i < divisions.length; ++i)
      divisions[i].draw(pg, color(255, 255, 255));
  }
  
  public void setCenter(Point center) {
    if(isInside(center)) {
      this.center = center;
      calculateDivisions();
    }
  }
  
  public Point getCenter() {
    return center;
  }
  
  public boolean isInside(Point p) {
    float dh = h / 2, dl = l / 2;
    return (p.x - dl > -borderX + 50) && (p.x + dl < borderX - 50)
        && (p.y - dh > -borderY + 50) && (p.y + dh < borderY - 50);
  }
  
  public Point toWindowPoint(float x, float y) {
    return new Point((x * 0.6429f) - borderX, (y * 0.6452f) - borderY);
  }
  
  public void drawLine(Line line, LineClippingFunction clipping) {
    Line res = clipping.cut(line.copy(), divisions);
    drawResidues(line, res);
    if(res != null) {
      res.draw(scene.pg(), color(105, 201, 224));
      res.a.draw(scene.pg(), color(105, 105, 255));
      res.b.draw(scene.pg(), color(105, 105, 255));
    }
  }
  
  public void drawResidues(Line org, Line res) {
     
  }
  
}