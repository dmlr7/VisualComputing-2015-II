class Graph {
  protected int piv;
  protected float maxVal, y;
  protected float[] values;
  
  Graph(float y, int n) {
    values = new float[n];
    this.y = y;
    init();
  }
  
  public void init() {
    piv = 0;
    maxVal = 0;
  }
  
  public void addYCoordinate(float val) {
    if(piv == values.length)
      init();
    if(val > maxVal)
      maxVal = val;
    values[piv++] = val;
  }
  
  public void drawGraph(float h) {
    drawGraphBackground(h);
    drawCoordinateBars(h);
    drawCoordinates(y + 5, y + h - 10, 10, width - 5);
  }
  
  private void drawGraphBackground(float h) {
    stroke(0);
    rect(0, y, width, h);
  }
  
  private void drawCoordinateBars(float h) {
    stroke(255);
    line(10, y + 5, 10, y + h - 5);
    line(5, y + h - 10, width - 5, y + h - 10);
  }
  
  private void drawCoordinates(float uh, float lh, float lw, float rw) {
    stroke(255, 0, 0);
    float dw = rw - lw, dh = lh - uh;
    float x1 = lw, y1 = lh - calculatePosition(dh, maxVal, values[0]);
    for(int i = 1; i < piv; ++i) {
      float x2 = lw + calculatePosition(dw, values.length, i);
      float y2 = lh - calculatePosition(dh, maxVal, values[i]);
      line(x1, y1, x2, y2);
      x1 = x2; y1 = y2;
    }
  }
  
  public float calculatePosition(float h, float maxP, float val) {
    return (h * val) / maxP;
  }
}