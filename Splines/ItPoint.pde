public class ItPoint extends PShape{
  InteractiveFrame iFrame;
  Scene scene;
  int x;
  int y;
  int z;
  int c;
  PShape t;
  ItPoint(Scene scn,int a, int b, int c) {
    scene = scn;    
    iFrame = new InteractiveFrame(scene);
    iFrame.setGrabsInputThreshold(scene.radius()/4, true);
    iFrame.setWheelSensitivity(0.0);
    x=a;
    y=b;
    z=c;
    setColor(255);
    setPosition();
    t= new PShape(SPHERE);
    iFrame.setRotationSensitivity(0);
  }
  public void draw() {
    draw(false);
  }
  public void draw(boolean axes) {
    pushMatrix();
    pushStyle();
    // Multiply matrix to get in the frame coordinate system.
    //applyMatrix(Scene.toPMatrix(iFrame.matrix())); // is handy but inefficient
    iFrame.applyTransformation(); // optimum
    
    if (axes)
      scene.drawAxes(20 * 1.3f);
    noStroke();

    fill(255, 0, 0);

    if (iFrame.grabsInput(scene.motionAgent()) )
      fill(255, 0, 0);
    else
      fill(getColor());
    scene.drawCylinder(5,5);
    
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
    Vec pos = scene.is3D() ? new Vec(x, y, z) 
                           : new Vec(x,y);
    iFrame.setPosition(pos);
  }

  public void setPosition(Vec pos) {
    iFrame.setPosition(pos);
  }

  public Rotation getOrientation() {
    return iFrame.orientation();
  }
  
}