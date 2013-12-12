
void setup()
{
  size(500, 500);
  smooth();
}



void draw()
{
  background(0, 0, 0);  // tweak[0,255]
  
  noStroke();
  fill(255, 255, 255);  // tweak[0,255]
  float x = 250;  // tweak[0,500]
  ellipse(x, 250, 50, 50); // tweak[0,500]
}
