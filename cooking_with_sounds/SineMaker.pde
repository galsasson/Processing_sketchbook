
// TODO: should extends Tool
class SineMaker 
{
  PVector pos;
  PVector target;
  float freq;

  float time;
  
  public SineMaker(float x, float y, PVector target, float freq)
  {
    pos = new PVector(x, y);
    this.target = target;
    this.freq = freq;
    
    time = 0;
  }
  
  public void setPos(float x, float y)
  {
    pos.x = x;
    pos.y = y;
  }
  
  public void update(PLine line)
  {
    time++;
    
    PVector v = PVector.sub(pos, target);
    v.normalize();
    v.rotate(PI/2);
    float ft = map(freq, 50, 800, 0.03, 1);
    v.mult(20 * sin(time*ft));
    
    
    line.addVertex(PVector.add(pos,v));
  }  
}
