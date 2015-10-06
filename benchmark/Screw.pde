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
    for(int i = 0; i < sides; ++i)
      drawEdge(pg, points.get(i), points.get((i + 1) % sides), h);
    drawBase(pg, points, h);
  }
  
  public void drawBase(PGraphics pg, ArrayList<Point> points, float h) {
    pg.beginShape();
    for(int i = 0; i < sides; ++i)
      pg.vertex(points.get(i).x, points.get(i).y, points.get(i).z + h);
    pg.endShape();
  }
  
  public void drawEdge(PGraphics pg, Point a, Point b, float h) {
    pg.beginShape();
    pg.vertex(a.x, a.y, a.z);
    pg.vertex(b.x, b.y, b.z);
    pg.vertex(b.x, b.y, b.z + h);
    pg.vertex(a.x, a.y, a.z + h);
    pg.endShape();
  }
  
}