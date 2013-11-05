





void setup()
{
  size(100, 100);
  smooth();
}

void draw()
{
  background(255);
  
  stroke(0);
  
  for (int x=0; x<100; x++)
  {
    point(x, height-getNormalDist(((float)x-50)/12.5)*100);   
  }
}

float getNormalDist(float xx)
{
  float tmp = -0.5*pow(xx, 2);
  return (float)(1 / Math.sqrt(2.0*PI)) * exp(tmp);
}
