public class Node {
  
  public Point translation;
  public float angle;
  public ArrayList<Line> lines;
  public ArrayList<Node> children;
  
  public Node(Point translation, float angle) {
    this.translation = translation;
    this.angle = angle;
    this.lines = new ArrayList<Line>();
    this.children = new ArrayList<Node>();
  }
  
  public void addLine(Line line) {
    lines.add(line);
  }
  
  public void addChild(Node child) {
    children.add(child);
  }
  
  public void draw(PGraphics pg, color c) {
    pg.pushMatrix();
    pg.translate(translation.x, translation.y);
    pg.rotate(angle);
    drawLines(pg, c);
    drawChildren(pg, c);
    //translation.draw(pg,c);
    pg.popMatrix();
  }
  
  public void drawLines(PGraphics pg, color c) {
    for(Line line: lines)
      line.draw(pg, c);
  }
  
  public void drawChildren(PGraphics pg, color c) {
    for(Node node: children)
      node.draw(pg, c);
  }
  
  public void scale(float sx, float sy) {
    translation.scale(sx, sy);
    for(Line line: lines)
      line.scale(sx, sy);
    for(Node node: children)
      node.scale(sx, sy);
  }
  
  public Node copy() {
    Node node = new Node(translation.copy(), angle);
    for(Line line: lines)
      node.addLine(line.copy());
    for(Node child: children)
      node.addChild(child.copy());
    return node;
  }
  
  public ArrayList<Line> getLines() {
    return lines;
  }
  
  public ArrayList<Line> mergeLines() {
    ArrayList<Line> result = new ArrayList<Line>();
    for(Line line: lines)
      result.add(apply(line));
    for(Node node: children)
      for(Line line: node.mergeLines())
        result.add(apply(line));
    return result;
  }
  
  public Line apply(Line line) {
    Line res = line.copy();
    res.rotate(angle);
    res.translate(translation);
    return res;
  }
  
}