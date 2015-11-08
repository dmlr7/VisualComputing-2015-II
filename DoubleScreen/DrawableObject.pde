public class DrawableObject {
  Point p=null;
  boolean isDrawable=false;
  InteractiveFrame iFrame;
  Scene scene;
  public DrawableObject(Scene scn){
    iFrame = new InteractiveFrame(scn);
    iFrame.setKeyboardSensitivity(0.0);
    iFrame.setWheelSensitivity(0.0);
    iFrame.setRotationSensitivity(0.0);
    iFrame.setTranslationSensitivity(0.0);
    iFrame.setScalingSensitivity(0.0);
    iFrame.setTranslationSensitivity(0.0);
  }
  
  public void draw(PGraphics pg, color c){
    
  }
  public boolean isDrawable(){
    return isDrawable;
  }
  public setMobility(boolean isMobable){
    float s=0.0;
    if(isMobable)
      s=1.0;
      
    iFrame.setKeyboardSensitivity(s);
    iFrame.setWheelSensitivity(s);
    iFrame.setRotationSensitivity(s);
    iFrame.setTranslationSensitivity(s);
    iFrame.setScalingSensitivity(s);
    iFrame.setTranslationSensitivity(s);
    
    }
  }
}