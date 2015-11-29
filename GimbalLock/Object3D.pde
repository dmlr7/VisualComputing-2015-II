public abstract class Object3D {
  
  public abstract void draw(PGraphics pg);
  public abstract void rotate(float[][] matrix);
  
  public final static int X = 0;
  public final static int Y = 1;
  public final static int Z = 2;
  
  public float[][] calculateRotationMatrix(int axis, float angle) {
    float [][] matrix = new float[3][3];
    if(axis == Z) {
      matrix[0][0] = cos(angle); matrix[0][1] = -sin(angle); matrix[0][2] = 0;
      matrix[1][0] = sin(angle); matrix[1][1] = cos(angle); matrix[1][2] = 0;
      matrix[2][0] = 0; matrix[2][1] = 0; matrix[2][2] = 1;
    } else if(axis == X) {
      matrix[0][0] = 1; matrix[0][1] = 0; matrix[0][2] = 0;
      matrix[1][0] = 0; matrix[1][1] = cos(angle); matrix[1][2] = -sin(angle);
      matrix[2][0] = 0; matrix[2][1] = sin(angle); matrix[2][2] = cos(angle);
    } else {
      matrix[0][0] = cos(angle); matrix[0][1] = 0; matrix[0][2] = sin(angle);
      matrix[1][0] = 0; matrix[1][1] = 1; matrix[1][2] = 0;
      matrix[2][0] = -sin(angle); matrix[2][1] = 0; matrix[2][2] = cos(angle);
    }
    return matrix;
  }
  
  public float[][] calculateRotationInverse(int axis, float angle) {
    float [][] matrix = new float[3][3];
    if(axis == Z) {
      matrix[0][0] = cos(angle); matrix[0][1] = sin(angle); matrix[0][2] = 0;
      matrix[1][0] = -sin(angle); matrix[1][1] = cos(angle); matrix[1][2] = 0;
      matrix[2][0] = 0; matrix[2][1] = 0; matrix[2][2] = 1;
    } else if(axis == X) {
      matrix[0][0] = 1; matrix[0][1] = 0; matrix[0][2] = 0;
      matrix[1][0] = 0; matrix[1][1] = cos(angle); matrix[1][2] = sin(angle);
      matrix[2][0] = 0; matrix[2][1] = -sin(angle); matrix[2][2] = cos(angle);
    } else {
      matrix[0][0] = cos(angle); matrix[0][1] = 0; matrix[0][2] = -sin(angle);
      matrix[1][0] = 0; matrix[1][1] = 1; matrix[1][2] = 0;
      matrix[2][0] = sin(angle); matrix[2][1] = 0; matrix[2][2] = cos(angle);
    }
    return matrix;
  }
  
  public Point rotatePoint(Point p, float[][] matrix) {
    return new Point((p.x * matrix[0][0]) + (p.y * matrix[0][1]) + (p.z * matrix[0][2]),
                     (p.x * matrix[1][0]) + (p.y * matrix[1][1]) + (p.z * matrix[1][2]),
                     (p.x * matrix[2][0]) + (p.y * matrix[2][1]) + (p.z * matrix[2][2]));
  }
  
}