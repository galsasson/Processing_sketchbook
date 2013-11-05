






















void setup()
{
  size(400, 500);
}

void draw()
{
  background(0, 0, 200);
  noStroke();
  
  for (int i=0; i<10; i++)
  {
    fill(0, 0, 50);
    
    ellipse(random(width), random(height), random(10), random(10));
  } 
}











