public class CohenSutherland implements LineClippingFunction {
  
  public final static int INSIDE = 0;
  public final static int LEFT = 1;
  public final static int RIGHT = 1<<1;
  public final static int BELOW = 1<<2;
  public final static int ABOVE = 1<<3;
  
  protected float xmin, xmax, ymin, ymax;
  protected float err = 0.00001;
  
  @Override
  public Line cut(Line line, Line[] borders) {
    xmin = borders[0].a.x;
    xmax = borders[2].a.x;
    ymin = borders[1].a.y;
    ymax = borders[3].a.y;
    
    int pacode = computeCode(line.a);
    int pbcode = computeCode(line.b);
    
    while((pacode | pbcode) != INSIDE && (pacode & pbcode) == INSIDE) {
      if(pacode != INSIDE)
        line.a = calculatePoint(pacode, line, borders);
      else
        line.b = calculatePoint(pbcode, line, borders);
      pacode = computeCode(line.a);
      pbcode = computeCode(line.b);
    }
    if((pacode | pbcode) == INSIDE)
      return line;
    return null;
  }
  
  private int computeCode(Point point) {
    int code = INSIDE;
    if(point.x < xmin && abs(point.x - xmin) > err)
      code |= LEFT;
    if(point.x > xmax && abs(point.x - xmax) > err)
      code |= RIGHT;
    if(point.y < ymin && abs(point.y - ymin) > err)
      code |= BELOW;
    if(point.y > ymax && abs(point.y - ymax) > err)
      code |= ABOVE;
    return code;
  }
  
  private Point calculatePoint(int code, Line line, Line[] borders) {
    if((code & LEFT) > 0)
      return line.cross(borders[0]);
    if((code & ABOVE) > 0)
      return line.cross(borders[3]);
    if((code & RIGHT) > 0)
      return line.cross(borders[2]);
    return line.cross(borders[1]);
  }
  
}