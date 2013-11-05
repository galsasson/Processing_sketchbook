
int playCounter = 0;

void setup()
{
  size(800, 800);
  colorMode(HSB);
  smooth();
  
  frameRate(30);
  background(220);
  noStroke();
}

void draw()
{
  fill(random(0, 255), 57, 207);
  
  ellipse(random(width), random(height), 10, 10);
}

