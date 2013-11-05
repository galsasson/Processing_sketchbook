
public class Space
{
  PVector pos;
  PVector size;
  
  ArrayList<Turtle> turtles;
  
  public Space(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    
    turtles = new ArrayList<Turtle>();
  }
  
  public void addTurtle(Turtle t)
  {
    turtles.add(t);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(50);
    strokeWeight(2);
    fill(50);
    rect(0, 0, size.x, size.y);
    
    for (Turtle t : turtles)
    {
      t.draw();
    }
    
    popMatrix();
  }
}
