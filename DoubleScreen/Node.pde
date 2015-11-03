public class Node{
  ArrayList<Node> children;
  ArrayList<Line> lines;
  Point ref;
  
  public Node(Point a){
    this.ref=a.copy();
  }
  
  public void addChild(Node node){
    children.add(node);
  }
  
  public void addLine(Line line) {
    lines.add(line);
  }
  
  public void draw(PGraphics pg){
    pg.pushMatrix();
    for(Line line: lines)
      line.draw(pg, color(105, 201, 224));
    pg.popMatrix();
  }
  
}