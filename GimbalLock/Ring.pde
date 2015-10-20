class Ring extends Object3D {
  
  protected Point[] upperExteriorPoints, upperInteriorPoints;
  protected Point[] lowerExteriorPoints, lowerInteriorPoints;
  protected color c;
  protected int sides = 360;
  
  public Ring(int axis, float radius, float breadth, float thickness, color c) {
    upperExteriorPoints = calculatePoints(axis, radius, breadth / 2);
    upperInteriorPoints = calculatePoints(axis, radius - thickness, breadth / 2);
    lowerExteriorPoints = calculatePoints(axis, radius, -breadth / 2);
    lowerInteriorPoints = calculatePoints(axis, radius - thickness, -breadth / 2);
    this.c = c;
  }
  
  public Point[] calculatePoints(int axis, float radius, float h) {
    Point[] points = new Point[sides];
    float angle = 0;
    for(int i = 0; i < sides; ++i, angle += (PI * 2) / sides)
      points[i] = calculatePoint(axis, radius, angle, h);
    return points;
  }
  
  protected Point calculatePoint(int axis, float radius, float angle, float h) {
    if(axis == X)
      return new Point(h, radius * sin(angle), radius * cos(angle));
    else if(axis == Y)
      return new Point(radius * sin(angle), h, radius * cos(angle));
    return new Point(radius * sin(angle), radius * cos(angle), h);
  }
  
  @Override
  public void draw(PGraphics pg) {
    pg.stroke(c);
    pg.fill(c);
    drawEdge(pg, upperExteriorPoints, upperInteriorPoints);
    drawEdge(pg, upperExteriorPoints, lowerExteriorPoints);
    drawEdge(pg, upperInteriorPoints, lowerInteriorPoints);
    drawEdge(pg, lowerExteriorPoints, lowerInteriorPoints);
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
      upperExteriorPoints[i] = rotatePoint(upperExteriorPoints[i], matrix);
      upperInteriorPoints[i] = rotatePoint(upperInteriorPoints[i], matrix);
      lowerExteriorPoints[i] = rotatePoint(lowerExteriorPoints[i], matrix);
      lowerInteriorPoints[i] = rotatePoint(lowerInteriorPoints[i], matrix);
    }
  }
  
}