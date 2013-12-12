
class Ball
{
  PVector pos;
  PVector vel;
  PVector acc;
  float m = 10;
  
  public Ball(float x, float y)
  {
    pos = new PVector(x, y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  public void applyForce(PVector f)
  {
    PVector tmpForce = f.get();
    tmpForce.div(m);
    acc.add(tmpForce);
  }
  
  public void update()
  {
    vel.add(acc);
    pos.add(vel);
    
    applyBounds();
    
    acc.mult(0);
    acc.set(0, 1/m*4);
    
    // apply friction
    vel.mult(0.96);
  }
  
  public void draw()
  {
      fill(128, 45, 129);
      ellipse(pos.x, pos.y, 10, 10);
  }
 
  public void applyBounds()
  {
    if (pos.x < 0) {
      pos.x = 0;
    }
    else if (pos.x > width) {
      pos.x = width;
    }
    
    if (pos.y < 0) {
      pos.y = 0;
    }
    else if (pos.y > height) {
      pos.y = height;
    }
  } 
}
