public class DrawableObject {
  Point p=null;
  boolean isDrawable=false;
  InteractiveFrame iFrame;
  public DrawableObject(Scene scn){
    iFrame = new InteractiveFrame(scn);
  }
  public void draw(PGraphics pg, color c){}
  public boolean isDrawable(){
    return isDrawable;
  }
}