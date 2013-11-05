

ArrayList<GStroke> template = null;
ArrayList<GStroke> painting;
GStroke currentStroke = null;

boolean initialized = false;
boolean completed = false;
PFont font;
boolean didDraw = false;

String verificationCode = null;

boolean completedBefore = false;

void setup()
{
  size(840, 500);
  smooth();

  painting = new ArrayList<GStroke>();
  font = loadFont("Serif-24.vlw");
  textFont(font, 24);
  frameRate(30);
}

void draw()
{ 
  background(0);

  fill(255);
  
  if (completedBefore)
  {
    text("This task was completed. Thank you.", 150, 250);
    return;
  }
  
  if (completed)
  {
    text("Thank you! Your confirmation code: "+verificationCode, 150, 250);
    return;
  }
  else if (initialized)
  {
    text("Copy the image on the right as precisely as possible.", 10, 35);
  }
  
  if (!initialized)
  {
    return;
  }
  
  // drawing pad
  noStroke();
  fill(200);
  rect(10, 60, 400, 400);
  // draw user painting
  for (GStroke s : painting)
  {
    s.draw();
  }
  if (currentStroke != null)
  {
    currentStroke.draw();
  }
  
  // template
  fill(150);
  noStroke();
  rect(430, 60, 400, 400);
  if (template != null)
  {
    for (GStroke s : template)
    {
      s.draw();
    }
  }
  
  // draw mouse cursor
  if (isInsidePad())
  {
    fill(50, 50, 50);
    noStroke();
    ellipse(mouseX, mouseY, 8, 8);
  }
}

boolean isInsidePad()
{
  if (mouseX > 10 && mouseX < 410 &&
      mouseY > 60 && mouseY < 460)
        return true;
  
  return false;
}

void mousePressed()
{
  if (!initialized || completed)
    return;
    
  if (isInsidePad())
  {
    didDraw = true;
    currentStroke = new GStroke(10, 60);
    currentStroke.addPoint(mouseX, mouseY);
  }
}

void mouseDragged()
{
  if (!initialized || completed)
    return;
    
  if (currentStroke != null)
  {
    if (isInsidePad())
    {
      currentStroke.addPoint(mouseX, mouseY);
    }
    else {
      painting.add(currentStroke);
      currentStroke = null;
    }
  }
}

void mouseReleased()
{
  if (!initialized || completed)
    return;
    
  if (currentStroke != null)
  {
    painting.add(currentStroke);
    currentStroke = null;
  }
}

void initTemplate(ArrayList<GStroke> temp)
{
  for (GStroke s : temp)
  {
    s.setOrigin(430, 60);
  }
  template = temp;
}

void setVerificationCode(String code)
{
  verificationCode = code;
}

void startSketch()
{
  initialized = true;
}

ArrayList<GStroke> getPainting()
{
  return painting;
}

void taskCompleted()
{
  completed = true;
}

boolean userDidDraw()
{
  return didDraw;
}

void alreadyCompleted()
{
  completedBefore = true;
}

