public class Node extends DrawableObject{
  ArrayList<Node> children;
  ArrayList<DrawableObject> dos;
  Point ref;
  
  public Node(Scene scn,Point a){
    super(scn);
    this.ref=a.copy();
    dos=new ArrayList<DrawableObject>();
    children = new ArrayList<Node>();
  }
  
  public void addChildren(Node node){
    children.add(node);
  }
  
  public void addDrawableObject(DrawableObject dO) {
    dos.add(dO);
  }
  public void setMobility(boolean mobility){
    for(DrawableObject dO:dos)
      dO.setMobility(mobility);
  }
  
  public void draw(PGraphics pg,color c){
    pg.pushMatrix();
    //ref.draw(pg, c);
    for(DrawableObject dO: dos){
      if(dO.isDrawable())
        dO.draw(pg, c);
    }
    for(Node node : children)
      node.draw(pg,c);
    pg.popMatrix();
  }
  
}