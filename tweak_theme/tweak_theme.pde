
ArrayList<Circle> circles;

void setup()
{
  size(2050, 130);
  smooth();
  colorMode(HSB, 360, 100, 100, 100);
  initCircles();
}

void draw()
{
  background(0);
  for (Circle c : circles)
  {
    c.draw();
  }
}

void mousePressed()
{
  initCircles();
}

class Circle
{
  PVector pos;
  color c;
  
  public Circle(float x, float y, color c)
  {
    pos = new PVector(x, y);
    this.c = c;
  }

  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    fill(c);
    noStroke();
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}

void initCircles()
{
  circles = new ArrayList<Circle>();
  for (int i=0; i<100; i++)
  {
    float x = random(width);
    float y = random(height);
    color c = color(random(0, 360), random(0, 100), random(0, 100));
    circles.add(new Circle(x, y, c));
  }
}
  
  
