int size=50;
int points=16;

void setup()
{
//  drawNormalSplash();
//  drawRetinaSplash();
//  drawNormalIpadIcon();
  drawRetinaIpadIcon();
}


void draw()
{
  
}

void drawNormalSplash()
{
  size(1024, 748);
  smooth();
  
  background(220);
  noFill();
  stroke(35);
  strokeWeight(2);
  
  for (int x=size; x<width-size; x+=size+20)
  {
    for (int y=size; y<height-size; y+=size+20)
    {
      drawShape(x, y);
    }
  }
  
  save("gogoam_splash.png");  
}

void drawRetinaSplash()
{
  size(2048, 1496);
  smooth();
  
  size = 60;
  
  background(220);
  noFill();
  stroke(35);
  strokeWeight(2);
  
  for (int x=size; x<width-size; x+=size+20)
  {
    for (int y=size; y<height-size; y+=size+20)
    {
      drawShape(x, y);
    }
  }
  
  save("gogoam_splash_retina.png");  
}

void drawNormalIpadIcon()
{
  size(72, 72);
  smooth();
  
  size = 60;
  points = 18;
  
  background(220);
  noFill();
  stroke(35);
  strokeWeight(2);
  
  drawShape(width/2, height/2);
  
  save("gogoam_icon.png");
}

void drawRetinaIpadIcon()
{
  size(144, 144);
  smooth();
  
  size = 120;
  points = 20;
  
  background(220);
  noFill();
  stroke(35);
  strokeWeight(3);
  
  drawShape(width/2, height/2);
  
  save("gogoam_icon_retina.png");
}

void drawShape(float x, float y)
{
  PVector pos = new PVector(random(size)-size/2, random(size)-size/2);
  pushMatrix();
  translate(x, y);
  
  beginShape();
  for (int i=0; i<points; i++)
  {
    vertex(pos.x, pos.y);
    if (i%2 == 0)
      pos.x = random(size)-size/2;
    else
      pos.y = random(size)-size/2;
  }
  endShape();
  
  popMatrix();
}


