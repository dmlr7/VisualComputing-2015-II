class Graph {
  protected int piv;
  protected float maxVal, minVal, iy, h;
  protected float[] values;
  
  protected float[] x;
  protected float[] y;
  
  Graph(float iy, float h, int n) {
    values = new float[n];
    x = new float[n];
    for(int i = 0; i < n; ++i)
      x[i] = 10 + calculatePosition(width - 15, values.length, i);
    y = new float[n];
    this.iy = iy;
    this.h = h;
    init();
  }
  
  public void init() {
    piv = 0;
    maxVal = 0;
    minVal = 1000;
  }
  
  public void addValue(float val) {
    if(piv == values.length)
      init();
    if(val > maxVal) {
      maxVal = val;
      calculateYValues();
    }
    if(val < minVal) {
      minVal = val;
      calculateYValues();
    }
    y[piv] = iy + h - 10 - calculatePosition(h - 15, maxVal - minVal, val - minVal);
    values[piv++] = val;
  }
  
  protected void calculateYValues() {
    float lh = iy + h - 10, mx = maxVal - minVal;
    for(int i = 0; i < piv; ++i)
      y[i] = lh - calculatePosition(h - 15, mx, values[i] - minVal);
  }
  
  public void drawGraph() {
    drawGraphBackground();
    drawCoordinateBars();
    drawCoordinates(iy + 5, iy + h - 10);
  }
  
  private void drawGraphBackground() {
    stroke(0);
    fill(0);
    rect(0, iy, width, h);
  }
  
  private void drawCoordinateBars() {
    stroke(255);
    line(10, iy + 5, 10, iy + h - 5);
    line(5, iy + h - 10, width - 5, iy + h - 10);
  }
  
  private void drawCoordinates(float uh, float lh) {
    stroke(255, 0, 0);
    float dh = lh - uh;
    for(int i = 1; i < piv; ++i)
      line(x[i - 1], y[i - 1], x[i], y[i]);
  }
  
  public float calculatePosition(float h, float maxP, float val) {
    return (h * val) / maxP;
  }
}