public class PShapeDO extends DrawableObject{
  PShape shape; 
  public PShapeDO(Scene scn,PShape s){
    super(scn);
    shape=s;
  }
  public PShape getShape(){
    return this.shape;
  }
}