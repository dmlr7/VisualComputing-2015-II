public class Skeleton extends DrawableObject{
  Node sk;
  float s=1.5;
  public Skeleton(Scene scn){
    super(scn);
    SkeletonG(s);
  }
  public Skeleton(Scene scn,float a){
    super(scn);
    SkeletonG(a);
  }
  public void SkeletonG(float s) {
    Scene scn=this.scene;
    Point p1 = new Point(scn,0/s,0/s);
    Point p2 = new Point(scn,0/s,-100/s);
    Point p3 = new Point(scn,-50/s,-75/s);
    Point p4 = new Point(scn,-65/s,0/s);
    Point p5 = new Point(scn,-40/s,45/s);
    Point p6 = new Point(scn,-50/s,90/s);
    Point p7 = new Point(scn,-65/s,95/s);
    Point p8 = new Point(scn,40/s,45/s);
    Point p9 = new Point(scn,50/s,90/s);
    Point p10 = new Point(scn,65/s,95/s);
    Point p11 = new Point(scn,50/s,-75/s);
    Point p12 = new Point(scn,65/s,0/s);
    Point p13 = new Point(scn,-25/s,-115/s);
    Point p14 = new Point(scn,-25/s,-130/s);
    Point p15 = new Point(scn,0/s,-145/s);
    Point p16 = new Point(scn,25/s,-130/s);
    Point p17 = new Point(scn,25/s,-115/s);
    Node n=new Node(this.scene,p17);
    n.addDrawableObject(new Line(this.scene,p17,p2));
    Node m=new Node(this.scene,p16);
    m.addDrawableObject(new Line(this.scene,p16,p17));
    m.addChildren(n);
    
    n=new Node(this.scene,p15);
    n.addDrawableObject(new Line(this.scene,p15,p16));
    n.addChildren(m);
    m=new Node(this.scene,p14);
    m.addDrawableObject(new Line(this.scene,p14,p15));
    m.addChildren(n);
    
    n=new Node(this.scene,p13);
    n.addDrawableObject(new Line(this.scene,p13,p14));
    n.addChildren(m);
    Node n2=new Node(this.scene,p2);
    n2.addDrawableObject(new Line(this.scene,p2,p13));
    n2.addChildren(n);
    
    m=new Node(this.scene,p4);
    m.addDrawableObject(new Line(this.scene,p4,p3));
    n=new Node(this.scene,p3);
    n.addDrawableObject(new Line(this.scene,p3,p2));
    n.addChildren(m);
    n2.addChildren(n);
    
    m=new Node(this.scene,p12);
    m.addDrawableObject(new Line(this.scene,p12,p11));
    n=new Node(this.scene,p11);
    n.addDrawableObject(new Line(this.scene,p11,p2));
    n.addChildren(m);
    n2.addChildren(n);
    n=n2;
    
    n2=new Node(this.scene,p1);
    n2.addDrawableObject(new Line(this.scene,p1,p2));
    n2.addChildren(n);
    
    n=new Node(this.scene,p7);
    n.addDrawableObject(new Line(this.scene,p7,p6));
    m=new Node(this.scene,p6);
    m.addDrawableObject(new Line(this.scene,p6,p5));
    m.addChildren(n);
    n=new Node(this.scene,p5);
    n.addDrawableObject(new Line(this.scene,p5,p1));
    n.addChildren(m);
    n2.addChildren(n);
    
    n=new Node(this.scene,p10);
    n.addDrawableObject(new Line(this.scene,p10,p9));
    m=new Node(this.scene,p9);
    m.addDrawableObject(new Line(this.scene,p9,p8));
    m.addChildren(n);
    n=new Node(this.scene,p8);
    n.addDrawableObject(new Line(this.scene,p8,p1));
    n.addChildren(m);
    n2.addChildren(n);
    sk=n2;
    /*
    lines.add(new Line(p1,p2));
    lines.add(new Line(p1,p5));
    lines.add(new Line(p1,p8));
    lines.add(new Line(p2,p3));
    lines.add(new Line(p2,p11));
    lines.add(new Line(p2,p13));
    lines.add(new Line(p2,p17));
    lines.add(new Line(p3,p4));
    lines.add(new Line(p5,p6));
    lines.add(new Line(p6,p7));
    lines.add(new Line(p8,p9));
    lines.add(new Line(p9,p10));
    lines.add(new Line(p11,p12));
    lines.add(new Line(p13,p14));
    lines.add(new Line(p14,p15));
    lines.add(new Line(p15,p16));
    lines.add(new Line(p16,p17));*/
  }
  
  public void draw(PGraphics pg){
    pg.pushMatrix();
    sk.draw(pg, color(105, 201, 224));
    pg.popMatrix();
  }
}