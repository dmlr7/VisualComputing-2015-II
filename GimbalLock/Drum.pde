class Drum extends Object3D {
  
  protected Point[] upperPoints, lowerPoints;
  protected int sides;
  protected color c;
  
  public Drum(Point p, int axis, int sides, float radius, float thickness, color c) {
     this.sides = sides;
     this.c = c;
     upperPoints = calculatePoints(p, axis, sides, radius, thickness / 2);
     lowerPoints = calculatePoints(p, axis, sides, radius, -thickness / 2);
  }
  
  public Point[] calculatePoints(Point p, int axis, int sides, float radius, float h) {
    Point[] points = new Point[sides];
    float angle = 0;
    for(int i = 0; i < sides; ++i, angle += (PI * 2) / sides)
      points[i] = calculatePoint(p, axis, radius, angle, h);
    return points;
  }
  
  protected Point calculatePoint(Point p, int axis, float radius, float angle, float h) {
    if(axis == X)
      return new Point(p.x + h, p.y + (radius * sin(angle)), p.z + (radius * cos(angle)));
    else if(axis == Y)
      return new Point(p.x + (radius * sin(angle)), p.y + h, p.z + (radius * cos(angle)));
    return new Point(p.x + (radius * sin(angle)), p.y + (radius * cos(angle)), p.z + h);
  }
  
  @Override
  public void draw(PGraphics pg) {
    pg.stroke(0);
    pg.fill(c);
    drawBase(pg, upperPoints);
    drawEdge(pg, upperPoints, lowerPoints);
    drawBase(pg, lowerPoints);
  }
  
  public void drawBase(PGraphics pg, Point[] points) {
    pg.beginShape();
    for(Point p: points)
      pg.vertex(p.x, p.y, p.z);
    pg.endShape();
  }
  
  public void drawEdge(PGraphics pg, Point[] upper, Point[] lower) {
    pg.beginShape(TRIANGLE_STRIP);
    for(int i = 0; i < upper.length; ++i)
      addBottomAndTopVertex(pg, upper[i], lower[i]);
    addBottomAndTopVertex(pg, upper[0], lower[0]);
    pg.endShape();
  }
  
  public void addBottomAndTopVertex(PGraphics pg, Point upper, Point lower) {
    pg.vertex(upper.x, upper.y, upper.z);
    pg.vertex(lower.x, lower.y, lower.z);
  }
  
  @Override
  public void rotate(int axis, float angle) {
    float[][] matrix = calculateRotationMatrix(axis, angle);
    for(int i = 0; i < sides; ++i) {
      upperPoints[i] = rotatePoint(upperPoints[i], matrix);
      lowerPoints[i] = rotatePoint(lowerPoints[i], matrix);
    }
  }
  
}