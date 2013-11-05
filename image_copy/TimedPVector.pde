
class TimedPVector extends PVector
{
  int frameNum;
  
  public TimedPVector(float x, float y, int t)
  {
    super(x, y);
    frameNum = t;
  }
}
