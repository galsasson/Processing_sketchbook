




void setup()
{
  size(600, 600);
  smooth();
}




void draw()
{
  background(220);
  stroke(50);
  noFill();
  strokeWeight(14);
  
  float a = 100 / 1;
  
  float var = 12.556;
  
  translate(width/2, height/2);
  beginShape();
  for (int i=0; i<20; i++)
  {
    vertex(random(10)*var, random(10)*var);
  }
  endShape();
}




