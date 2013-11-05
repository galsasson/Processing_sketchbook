import processing.opengl.*;



ArrayList boxes = new ArrayList();

PVector camEye;
PVector camCenter;
PVector camUp;
boolean leftKey, upKey, rightKey, downKey;
//Camera camera

void setup() 
{ 
  size(640, 360, OPENGL); 
  noStroke();
  smooth();
  colorMode(RGB, 255);
  lights();
  
  float s = 0.5;
  
  Box b;
  for (int z=-8 ; z<8 ; z++)
  {
    for (int y=-8 ; y<8 ; y++)
    {
      for (int x=-8 ; x<8 ; x++)
      {
        b = new Box(new PVector(x*s + x*0.1, y*s + y*0.1, z*s + z*0.1), new PVector(s, s, s));
        boxes.add(b);
      }
    }
  }

  camEye = new PVector(width/2, height/2, (height/2.0) / tan(PI*60.0 / 360.0));
  camCenter = new PVector(width/2, height/2, 0);
  camUp = new PVector(0, 1, 0);
  
}

void draw() 
{ 
  background(0.5);
  camera(camEye.x, camEye.y, camEye.z, camCenter.x, camCenter.y, camCenter.z, camUp.x, camUp.y, camUp.z);
//  pushMatrix();
//  translate(width/2, height/2);
//  scale(50, 50, 50);
  
  for (int i=0 ; i<boxes.size(); i++)
  {
    Box b = (Box)boxes.get(i);
    b.draw();
  }
  
  if (leftKey)
    camEye.x+=30;
  if (upKey)
    camEye.z-=30;
  if (rightKey)
    camEye.x-=30;
  if (downKey)
    camEye.z+=30;
  
//  popMatrix();
}

void keyPressed()
{
  if (key == CODED)
  {
    switch(keyCode)
    {
      case LEFT:
        leftKey = true;
        break;
      case UP:
        upKey = true;
        break;
      case RIGHT:
        rightKey = true;
        break;
      case DOWN:
        downKey = true;
        break;
    }
  }
}

void keyReleased()
{
  if (key == CODED)
  {
    switch(keyCode)
    {
      case LEFT:
        leftKey = false;
        break;
      case UP:
        upKey = false;
        break;
      case RIGHT:
        rightKey = false;
        break;
      case DOWN:
        downKey = false;
        break;
    }
  }
}

class Camera
{
  PVector p;
  PVector r;
  
  
  public Camera()
  {
    p = new PVector(0, 0, 0);
    r = new PVector(0, 0, 0);
  }
}

class Box
{
  PVector p;      // position
  PVector r;      // rotation
  PVector s;      // size
  color c;        // color
  
  public Box()
  {
    p = new PVector(0,0,0);
    r = new PVector(0,0,0);
    
    s = new PVector(1,1,1);
    
    c = color(237, 236, 240);
  }
  
  public Box(PVector _p, PVector _s)
  {
    p = _p;
    s = _s;
    r = new PVector(0,0,0);
    c = color(237, 236, 240);
  }

  
  public Box(PVector _p, PVector _s, color _c)
  {
    p = _p;
    s = _s;
    c = _c;
    r = new PVector(0, 0, 0);
  }
  
  void draw()
  {
    pushMatrix(); 
 
    translate(p.x, p.y, p.z); 
    scale(s.x, s.y, s.z);
    rotateX(r.x);
    rotateY(r.y);
    rotateZ(r.z);
    stroke(255, 255, 255);
    strokeWeight(1.1);
    fill(c);
    box(1,1,1);
    
    popMatrix();     
  }
}
