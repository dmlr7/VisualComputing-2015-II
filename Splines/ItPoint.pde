public class ItPoint extends PShape{
  InteractiveFrame iFrame;
  Scene scene;
  Point p;
  int c;
  PShape t;
  ItPoint(Scene scn,int a, int b, int c) {
    scene = scn;    
    iFrame = new InteractiveFrame(scene);
    iFrame.setGrabsInputThreshold(scene.radius()/4, true);
    iFrame.setScalingSensitivity(0);
    p=new Point(a,b,c);
    setColor(125);
    setPosition();
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

    if (iFrame.grabsInput(scene.motionAgent()))
      fill(255, 0, 0);
    else
      fill(getColor());
    scene.drawCylinder(5,5);
    popStyle();
    popMatrix();
    updatePosition();
  }

  public int getColor() {
    return c;
  }
  public void updatePosition(){
    Vec pos=iFrame.position();
    p.x=pos.x();
    p.y=pos.y();
    p.z=pos.z();
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
  public void setPosition() {
    Vec pos = scene.is3D() ? new Vec(p.x, p.y, p.z) 
                           : new Vec(p.x,p.y);
    iFrame.setPosition(pos);
  }
  public float getX(){
    return p.x;
  }
  public float getY(){
    return p.y;
  }
  public float getZ(){
    return p.z;
  }
  public Point getP(){
    return p;
  }


  public void setPosition(Vec pos) {
    iFrame.setPosition(pos);
  }

  public Rotation getOrientation() {
    return iFrame.orientation();
  }
  
}