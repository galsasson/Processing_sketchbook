
public class SpaceShip
{
  PVector pos;
  ArrayList<ArrayList<PVector>> body;
  ArrayList<PVector> currentShape;
  
  public SpaceShip(float x, float y)
  {
    pos = new PVector(x, y);
    
    body = new ArrayList<ArrayList<PVector>>();
    
    currentShape = null;
  }
  
  public void beginNewShape()
  {
    currentShape = new ArrayList<PVector>();
  }
  
  public void addVertex(PVector p)
  {
    currentShape.add(p);
  }
  
  public void endNewShape()
  {
    if (currentShape == null)
      return;
      
    if (currentShape.size() > 1)
    {
      body.add(currentShape);
    }
    else
    {
      // release currentShape
    }
    
    currentShape = null;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    // draw currentShape
    stroke(255);
    strokeWeight(2);
    noFill();
    
    if (currentShape != null)
    {
      beginShape();
      for (PVector p : currentShape)
      {
        vertex(p.x, p.y);
      }
      endShape();
    }
    
    // draw the rest of the body
    for (ArrayList<PVector> shape : body)
    {
      beginShape();
      for (PVector p : shape)
      {
        vertex(p.x, p.y);
      }
      endShape();
    }
    
    popMatrix();
  }
  
}
