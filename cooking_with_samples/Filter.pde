
class Filter
{
  PVector pos;
  PVector vel;
  PVector acc;
  
  float cutFreq;
  color c;
  String type;
  
  public Filter(float x, float y)
  {
    pos = new PVector(x, y);
    vel = new PVector();
    acc = new PVector();
    
    if (random(1) < 0.9)
    {
      type="lowpass";
      cutFreq = random(60, 700);
      c = color(map(cutFreq, 60, 700, 227, 359), 100, 255);
    }
    else {
      type="none";
      c = color(255);
    }
  }
  
  public boolean update()
  {
    // apply acceleration
    acc.add(new PVector(0, 0.02));
    vel.add(acc);
    pos.add(vel);
    
    if (pos.y > height) {
      return false;
    }
    
    return true;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(c);
    ellipse(0, 0, 10, 10);
    
    popMatrix();
  }
}
