
class Tool
{
  PVector pos;
  PVector target;
  float freq;
  
  PVector toolLine;
  
  public Tool(float freq, PVector target)
  {
    pos = new PVector(0, 0);
    toolLine = new PVector(0, 0);
    this.freq = freq;
    this.target = target;
  }
  
  public void setPos(float x, float y)
  {
    pos.x = x;
    pos.y = y;
    
    toolLine = PVector.sub(pos, target);
    toolLine.normalize();
    toolLine.rotate(PI/2);
    toolLine.mult(20);
  }
  
  public void draw(int mode)
  {
    if (mode == 0)
    {
      noFill();
      stroke(30);
      strokeWeight(5);
      
      pushMatrix();
      translate(pos.x, pos.y);
      line(toolLine.x, toolLine.y, toolLine.x*-1, toolLine.y*-1);
      popMatrix();
    }
    else if (mode == 1)
    {
      pushMatrix();
      translate(pos.x, pos.y);
      noStroke();
      fill(200, 50, 50);
      ellipse(0, 0, 5, 5);
      popMatrix();
    }
  }
}
