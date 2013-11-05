

void setup()
{
  size(600, 150);
  smooth();
}

void draw()
{
  pushMatrix();
  
  scale(1.0, 1.0);
  background(0, 0, 0);
  
  stroke(255, 255, 255);
  
  float prevY = 0;  
  for (int x=0; x<width; x++)
  {
    float y = pow(x,1.395) - pow(x,1.048) + 0.000 *x+ -62.000;
    
    line(x-1, prevY, x, y);
    prevY = y;
  }
  
  popMatrix();
}
