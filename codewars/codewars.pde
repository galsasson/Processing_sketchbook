
Turtle turtle;
CodePanel cp;
Space space;

void setup()
{
  size(1000, 400);
  smooth();
  frameRate(30);
  
  turtle = new Turtle(width/4, height/2);
  space = new Space(0, 0, width/2, height);
  space.addTurtle(turtle);
  cp = new CodePanel(width/2, 0, width/2, height);
  cp.setTurtle(turtle);
}


void keyPressed()
{
  cp.keyPressed(keyCode);
}

void draw()
{
  background(200);
  
  space.draw();
  
  cp.update();
  cp.draw();
}
