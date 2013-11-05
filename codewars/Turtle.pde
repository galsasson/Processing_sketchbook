
class Turtle
{
  PVector pos;
  float angle;
  
  PVector offset;
  
  SpaceShip ship;
  
  boolean pen;
  
  public Turtle(float x, float y)
  {
    pos = new PVector(x, y);
    angle = 0;
    
    offset = new PVector(0, 0);
    
    ship = new SpaceShip(x, y);
  }
  
  public void penDown()
  {
    if (!pen)
    {
      pen = true;
      ship.beginNewShape();
      ship.addVertex(offset.get());
    }
  }
  
  public void penUp()
  {
    if (pen)
    {
      pen = false;
      ship.endNewShape();
    }
  }
  
  public void forward(String arg)
  {
    try
    {
      float pix = Float.parseFloat(arg);
      PVector move = new PVector(0, -pix);
      move.rotate(angle);
      pos.add(move);
      offset.add(move);
      
      if (pen)
        ship.addVertex(offset.get());
    }
    catch (NumberFormatException e)
    {
      // dont move
    }
  }
  
  public void backward(String arg)
  {
    try
    {
      float pix = Float.parseFloat(arg);
      PVector move = new PVector(0, pix);
      move.rotate(angle);
      pos.add(move);
      offset.add(move);
      
      if (pen)
        ship.addVertex(offset.get());
    }
    catch (NumberFormatException e)
    {
      // dont move
    }
  }
  
  public void right(String arg)
  {
    try
    {
      float ang = Float.parseFloat(arg);
      angle += radians(ang);
    }
    catch (NumberFormatException e)
    {
      // dont move
    }
  }
  
  public void left(String arg)
  {
    try
    {
      float ang = Float.parseFloat(arg);
      angle -= radians(ang);
    }
    catch (NumberFormatException e)
    {
      // dont move
    }
  }
  
  public String processString(String str)
  {
    String[] tokens = str.split(" ");
    
    if (tokens[0].equals("PENDOWN"))
        penDown();
    else if (tokens[0].equals("PENUP"))
        penUp();
    else if (tokens[0].equals("FORWARD"))
    {
        if (tokens.length < 2)
          forward("10");
        else
          forward(tokens[1]);
    }
    else if (tokens[0].equals("BACKWARD"))
    {
        if (tokens.length < 2)
          backward("10");
        else
          backward(tokens[1]);
    }
    else if (tokens[0].equals("RIGHT"))
    {
        if (tokens.length < 2)
          right("90");
        else
          right(tokens[1]);
    }
    else if (tokens[0].equals("LEFT"))
    {
        if (tokens.length < 2)
          left("90");
        else
          left(tokens[1]);
    }
    
    return "ok";
  }

  public void draw()
  {    
    ship.draw();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    
    // draw tutle shape
    noStroke();
    fill(130);
    beginShape();
    vertex(0, -15);
    vertex(5, 0);
    vertex(-5, 0);
    vertex(0, -15);
    endShape();
    
    if (pen)
    {
      fill(255);
      ellipse(0, 0, 3, 3);
    }
    
    popMatrix();
  }
}
