

void setup()
{
  size(480, 200);
  colorMode(HSB);
  
  background(255);
  noStroke();
}

void draw()
{
  float size = random(12);
  color c = color(249, 130, 239);
  
  int tmphex = 0xff0000ff;
  byte tmp_byte = 12;
  
  float[] array = {-1.200, 54, -90};
  
  float tmp = (43.000>-2.000) ?-1.000 :1.000;
  
  float tmp2 = (-12.000<5.00) ?2.0:-60.000;
  
  int tweak = 1;
  int dummy = -12;
  
  fill(c);
  ellipse(random(width), random(height), size, size);
  
  int col = 0xffff0000;
  fill(col);
  rect(0.0, 0.0,  79, 155);
  
}



class Circle
{
  float size;
  float c;
  
  public Circle()
  {
    size = -38.352;
    c = 5         + 8.211        + 7.323        - 8.912            + 0.001      + 50   + 100 + 12.1 + 15.232 + 54 - 34 -2       -12 + 50 / 83.1 + 91.0 + 80 + 12            -2323                 * 12323         - 12                                  ;      //gives an error
  }
}

