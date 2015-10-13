class Screw {
  protected int sides;
  
  Screw(int sides) {
    this.sides = sides;
  }
  
  public PShape create(Point pt, float r, float h) {
    PShape screw = createShape(GROUP);
    paintVertex(screw, calculateBasePoints(pt, r), h);
    return screw;
  }
  
  public ArrayList<Point> calculateBasePoints(Point pt, float r) {
    ArrayList<Point> points = new ArrayList<Point>();
    float angle = 0;
    for(int i = 0; i < sides; ++i, angle += (PI * 2) / sides)
      points.add(new Point(pt.x + (r * sin(angle)), pt.y + (r * cos(angle)), pt.z));
    return points;
  }
  
  public void paintVertex(PShape screw, ArrayList<Point> points, float h) {
    screw.addChild(drawBase(points, 0));
    screw.addChild(drawEdge(points, h));
    screw.addChild(drawBase(points, h));
  }
  
  public PShape drawBase(ArrayList<Point> points, float h) {
    PShape base = createShape();
    base.beginShape();
    for(Point p: points)
      base.vertex(p.x, p.y, p.z + h);
    base.endShape(CLOSE);
    return base;
  }
  
  public PShape drawEdge(ArrayList<Point> points, float h) {
    PShape edge = createShape();
    edge.beginShape(TRIANGLE_STRIP);
    for(Point point: points)
      addBottomAndTopVertex(edge, point, h);
    addBottomAndTopVertex(edge, points.get(0), h);
    edge.endShape(CLOSE);
    return edge;
  }
  
  private void addBottomAndTopVertex(PShape ps, Point point, float h) {
    ps.vertex(point.x, point.y, point.z);
    ps.vertex(point.x, point.y, point.z + h);
  }
  
}