

float t=0;
float tt=0;
float tSine=0;

void setup()
{
  size(800, 600, P3D);
  smooth();
  
  colorMode(HSB, 255, 100, 100);
  
}


void draw()
{
  translate(width/2, height/2, 0);

  background(99);
  fill(255);
  noStroke();

  translate(50, -112, 0);  
  for (int i=0; i<75; i++)
  {
    fill(noise(tt)*229, 50, 100);
    sphere(12);
    rotateZ(PI/11);
    translate(32, 7, -87.766*noise(t, tt));
    tt += sin(tSine)*1.232;
    tSine += 1.667;
  } 
  
  t += 0.000;
}
