
class PLine
{
  ArrayList<PVector> verts;
  float targetRadius;
  
  public PLine(float targetR)
  {
    targetRadius = targetR;
    verts = new ArrayList<PVector>();    
  }
  
  public void addVertex(float x, float y)
  {
    verts.add(new PVector(x, y));
  }
  
  public void addVertex(PVector v)
  {
    verts.add(v);
  }
  
  public int size()
  {
    return verts.size();
  }
  
  public void draw()
  {
    noFill();
    stroke(0, 100);
    strokeWeight(2);
    beginShape();
    for (PVector v : verts)
    {
      vertex(v.x, v.y);
    }
    endShape();
  }
}
