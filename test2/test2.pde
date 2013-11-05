

void setup()
{
  size(500, 500);
  g.colorMode(RGB, 1, 1, 1);
}

void draw()
{
  fill(1.00, 1.00, 1.00);
  
  ellipse(random(width), random(height), 10, 10); 
  
}
