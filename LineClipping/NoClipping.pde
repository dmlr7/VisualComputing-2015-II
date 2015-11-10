public class NoClipping implements LineClippingFunction {
  
  @Override
  public Line cut(Line line, Line[] borders) {
    return line;
  }
  
}