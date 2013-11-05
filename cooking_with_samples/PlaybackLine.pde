
class PlaybackLine
{
  float x;
  
  public PlaybackLine(float x)
  {
    this.x = x;
  }
  
  public void draw()
  {
    stroke(255);
    line(x, 0, x, height);
  }
}
