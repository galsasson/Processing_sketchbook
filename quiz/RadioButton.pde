
class RadioButton
{
  boolean checked;
  PVector pos;
  
  public RadioButton(float x, float y)
  {
    checked = false;
    pos = new PVector(x, y);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noFill();
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, 20, 20);
    
    if (checked) {
      fill(0);
      ellipse(0, 0, 8, 8);
    }
    
    popMatrix();
  }
  
  public boolean hit(int x, int y)
  {
    PVector p = new PVector(x, y);
    if (p.dist(pos) < 15) {
      return true;
    }
    
    return false;
  }
}
