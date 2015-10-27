public class NoSplit implements SplitFunction {
  
  @Override
  public Line split(Line line, Line[] borders) {
    return line;
  }
  
}