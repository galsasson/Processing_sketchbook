
class Ball
{
  PVector pos;
  PVector vel;
  color col;
  
  public Ball(float x, float y, color c)
  {
    pos = new PVector(x, y);
    vel = new PVector(random(5), random(5));
    col = c;
  }
  
  public void update()
  {
    pos.add(vel);
    
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    fill(col);
    noStroke();
    ellipse(0, 0, 40, 40);
    
    popMatrix();
  }
}
