class SnailPath {
  protected Screw screw;
  protected int path;
  
  SnailPath(int views, int path) {
    screw = new Screw(views);
    this.path = path;
  }
  
  public void createPath(Scene scene, float r, float zi, float inc) {
    ArrayList<Point> points = screw.calculateBasePoints(new Point(0, 0, zi), r);
    for(int i = 0; i < points.size(); ++i)
      addCameraPosition(scene, points.get(i), inc * i);
  }
  
  public void addCameraPosition(Scene scene, Point p, float h) {
    scene.camera().setPosition(new Vec(p.x, p.y, p.z + h));
    scene.camera().lookAt(scene.camera().sceneCenter());
    scene.camera().addKeyFrameToPath(path);
  }
  
}