class Screw {
  protected int sides;
  
  Screw(int sides) {
    this.sides = sides;
  }
  
  public void draw(PGraphics pg, Point pt, float r, float h) {
    //pg.stroke(125);
    //pg.fill(125);
    paintVertex(pg, calculateBasePoints(pt, r), h);
  }
  
  public ArrayList<Point> calculateBasePoints(Point pt, float r) {
    ArrayList<Point> points = new ArrayList<Point>();
    float angle = 0;
    for(int i = 0; i < sides; ++i, angle += (PI * 2) / sides)
      points.add(new Point(pt.x + (r * sin(angle)), pt.y + (r * cos(angle)), pt.z));
    return points;
  }
  
  public void paintVertex(PGraphics pg, ArrayList<Point> points, float h) {
    drawBase(pg, points, 0);
    drawEdge(pg, points, h);
    drawBase(pg, points, h);
  }
  
  public void drawBase(PGraphics pg, ArrayList<Point> points, float h) {
    pg.beginShape();
    for(Point p: points)
      pg.vertex(p.x, p.y, p.z + h);
    pg.endShape();
  }
  
  public void drawEdge(PGraphics pg, ArrayList<Point> points, float h) {
    pg.beginShape(TRIANGLE_STRIP);
    for(Point point: points)
      addBottomAndTopVertex(pg, point, h);
    addBottomAndTopVertex(pg, points.get(0), h);
    pg.endShape();
  }
  
  private void addBottomAndTopVertex(PGraphics pg, Point point, float h) {
    pg.vertex(point.x, point.y, point.z);
    pg.vertex(point.x, point.y, point.z + h);
  }
  
}