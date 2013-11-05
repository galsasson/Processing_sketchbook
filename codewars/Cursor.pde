
public class Cursor
{
  PVector pos;
  
  public Cursor(float x, float y)
  {
    pos = new PVector(x, y);
  }
  
  public void setPos(PVector p)
  {
    pos = p;
  }
  
  public void update()
  {
//    frame = (frame+1)%animation.length;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(50);
    fill(50);
    
    noStroke();
    for (int i=0; i<10; i++)
    {
      ellipse(random(0, 6), random(-10, 0), 2, 2);
    }     
    
    popMatrix();
  }
}
