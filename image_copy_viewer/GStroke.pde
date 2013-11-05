
class GStroke
{
  ArrayList<TimedPVector> points;
  PVector origin;

  public GStroke()
  {
    origin = new PVector(0, 0);
    points = new ArrayList<TimedPVector>();
  }
  
  public GStroke(int x, int y)
  {
    origin = new PVector(x, y);
    points = new ArrayList<TimedPVector>();
  }
  
  public void setOrigin(int x, int y)
  {
    origin = new PVector(x, y);
  }
  
  public void addPoint(int x, int y)
  {
    points.add(new TimedPVector(x-origin.x, y-origin.y, frameCount));
  }
  
  public void addPoint(int x, int y, int frame)
  {
    points.add(new TimedPVector(x-origin.x, y-origin.y, frame));
  }
  
  public int getFirstFrame()
  {
    if (points.size() > 0)
    {
      return points.get(0).frameNum;
    }
    
    return 0;
  }

  public void draw()
  {
    pushMatrix();
    translate(origin.x, origin.y);
    
    // draw painting
    noFill();
    stroke(50, 50, 50);
    strokeWeight(5);
    beginShape();
    for (PVector p : points)
    {
      vertex(p.x, p.y);
    }
    endShape();
    
    popMatrix();
  }
  
  public void draw(int frame)
  {
    pushMatrix();
    translate(origin.x, origin.y);
    
    // draw painting
    noFill();
    stroke(50, 50, 50);
    strokeWeight(5);
    beginShape();
    for (TimedPVector p : points)
    {
      if (p.frameNum < frame) {
        vertex(p.x, p.y);
      }
      else {
        break;
      }
    }
    endShape();
    
    popMatrix();
  }

}
