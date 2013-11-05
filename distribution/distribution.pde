
void setup()
{
  size(500, 500);
  smooth();
}

void draw()
{
  background(240);
  stroke(50);
  
  for (int x=0; x<500; x++)
  {
    float y = 0.186 * pow(x, 1.543) + -0.096 * x;
    point(x, y);
  }
}
