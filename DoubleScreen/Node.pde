public class Node extends DrawableObject{
  ArrayList<Node> children;
  ArrayList<DrawableObject> dos;
  Point ref;
  
  public Node(Scene scn,Point a){
    super(scn);
    this.ref=a.copy();
  }
  
  public void addChild(Node node){
    children.add(node);
  }
  
  public void addDrawableObject(DrawableObject dO) {
    dos.add(dO);
  }
  
  public void draw(PGraphics pg){
    pg.pushMatrix();
    for(DrawableObject dO: dos){
      if(dO.isDrawable())
        dO.draw(pg, color(105, 201, 224));
    }
    pg.popMatrix();
  }
  
}