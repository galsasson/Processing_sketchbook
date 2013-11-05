class Paint
{
  PVector pos;
  ArrayList<GStroke> strokes;
  int firstStrokeFrame;
  int firstDrawFrame;
  
  public Paint()
  {
    pos = new PVector(0, 0);
    strokes = new ArrayList<GStroke>();
    
    firstStrokeFrame = 9999999;
    firstDrawFrame = 0;
  }

  public Paint(int x, int y)
  {
    pos = new PVector(x, y);
    strokes = new ArrayList<GStroke>();
    
    firstStrokeFrame = 9999999;
    firstDrawFrame = 0;
  }
  
  public void addStroke(GStroke stroke)
  {
    if (stroke.getFirstFrame() < firstStrokeFrame)
    {
      firstStrokeFrame = stroke.getFirstFrame();
    }
    
    strokes.add(stroke);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    for (GStroke s : strokes)
    {
      s.draw();
    }
    
    popMatrix();
  }
  
  public void startDraw(int frame)
  {
    firstDrawFrame = frame;
  }
  
  public void draw(int frame)
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    for (GStroke s : strokes)
    {
      s.draw(frame);
    }
    
    popMatrix();    
  }
}
