float shaper(float t)
{
  float val = noise(t*10);//sin(t*PI);
  
  return val;
}

float shaperAB(float t)
{
  float val = bezierPoint(0, a, b, 1, t);
  
  return val;
}

void mouseDragged()
{
  if (mouseButton == LEFT)
  {
    a = map(mouseX, 0, width-1, 0, 1);
  }
  else
  {
    b = map(mouseX, 0, width-1, 0, 1);
  }
  
  build();
}

