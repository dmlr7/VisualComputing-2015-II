public class Horse {

  protected Node root;
  protected color c;
  
  public Horse(float size, color c) {
    this.c = c;
    paintHorse(size);
  }
  
  public Horse(Node root, color c) {
    this.root = root;
    this.c = c;
  }
  
  private void paintHorse(float size) {
    float sqe = size * sqrt(2);
    // Head
    root = new Node(new Point(2*size, 0), QUARTER_PI);
    paintTriangle(root, sqe);
    // Neck
    Node nd = new Node(new Point(sqe, 0), QUARTER_PI);
    root.addChild(nd);
    paintSquire(nd, size);
    // Body 1
    nd.addChild(new Node(new Point(size, 0), 0));
    nd = nd.children.get(0);
    paintTriangle(nd, 2 * size);
    // leg 1
    Node child = new Node(new Point(0, 2*size), -QUARTER_PI);
    paintTriangle(child, size);
    nd.addChild(child);
    // Body 2
    child = new Node(new Point(sqe, -sqe), QUARTER_PI);
    paintTriangle(child, 2 * size);
    nd.addChild(child);
    nd = child;
    // leg 2
    child = new Node(new Point(2*size, 0), QUARTER_PI);
    nd.addChild(child);
    child.addChild(new Node(new Point(0, -size / 2), 0));
    paintTriangle(child.children.get(0), size);
    // tail
    child = new Node(new Point(0, 0), -PI / 6);
    paintRhombus(child, size);
    nd.addChild(child);
  }
  
  public void paintTriangle(Node node, float size) {
    Point a = new Point(0, 0);
    Point b = new Point(size, 0);
    Point c = new Point(0, size);
    node.addLine(new Line(a, b));
    node.addLine(new Line(a, c));
    node.addLine(new Line(b, c));
  }
  
  public void paintSquire(Node node, float size) {
    Point a = new Point(0, 0);
    Point b = new Point(size, 0);
    Point c = new Point(0, size);
    Point d = new Point(size, size);
    node.addLine(new Line(a, b));
    node.addLine(new Line(a, c));
    node.addLine(new Line(b, d));
    node.addLine(new Line(c, d));
  }
  
  public void paintRhombus(Node node, float size) {
    Point a = new Point(0, 0);
    Point b = new Point(size, -size);
    Point c = new Point(size, 0);
    Point d = new Point(2*size, -size);
    node.addLine(new Line(a, b));
    node.addLine(new Line(a, c));
    node.addLine(new Line(b, d));
    node.addLine(new Line(c, d));
  }
  
  public void draw(PGraphics pg) {
    root.draw(pg, c);
  }
  
  public void scale(float sx, float sy) {
    root.scale(sx, sy);
  }
  
  public Horse copy() {
    return new Horse(root.copy(), c);
  }
  
}