public class InteractiveLight {
  InteractiveFrame iFrame;
  int c;
  Scene scene;

  InteractiveLight(Scene scn) {
    scene = scn;    
    iFrame = new InteractiveFrame(scene);
    iFrame.setGrabsInputThreshold(scene.radius()/4, true);
    setColor();
    setPosition();
  }

  // don't draw local axis
  public void draw() {
    draw(false);
  }

  public void draw(boolean drawAxes) {
    pushMatrix();
    pushStyle();
    // Multiply matrix to get in the frame coordinate system.
    //applyMatrix(Scene.toPMatrix(iFrame.matrix())); // is handy but inefficient
    iFrame.applyTransformation(); // optimum
    if (drawAxes)
      scene.drawAxes(20 * 1.3f);
    noStroke();

    fill(255, 0, 0);

    if (iFrame.grabsInput(scene.motionAgent()) )
      fill(255, 0, 0);
    else
      fill(getColor());
    
    scene.drawShooterTarget(new Vec(255,255,255),50);
    popStyle();
    popMatrix();
  }

  public int getColor() {
    return c;
  }

  // sets color randomly
  public void setColor() {
    c = color(random(0, 255), random(0, 255), random(0, 255), random(100, 200));
  }

  public void setColor(int myC) {
    c = myC;
  }

  public Vec getPosition() {
    return iFrame.position();
  }

  // sets position randomly
  public void setPosition() {
    float low = 50;
    float high = 200;
    Vec pos = scene.is3D() ? new Vec(random(low, high), random(low, high), random(low, high)) 
                           : new Vec(random(low, high), random(low, high));
    iFrame.setPosition(pos);
  }

  public void setPosition(Vec pos) {
    iFrame.setPosition(pos);
  }

  public Rotation getOrientation() {
    return iFrame.orientation();
  }
}