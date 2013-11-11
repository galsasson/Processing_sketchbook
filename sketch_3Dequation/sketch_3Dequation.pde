
ArrayList<PVector> pos = new ArrayList<PVector>();
ArrayList<Float> times = new ArrayList<Float>();
void setup()
{
  size(400, 400, OPENGL);
  sphereDetail(5);
  for (int i=0; i<200; i++)
  {
    times.add(new Float(-TWO_PI+i*0.001));
    pos.add(getPosForTime(-TWO_PI+i*0.001));
  }
}

void draw()
{
  background(0);
  translate(width/2, height/2, 0);
  scale(0.1, 0.1, 0.1);
  
  fill(255);
  for (int i=0; i<pos.size(); i++)
  {
    float t = times.get(i);
    times.set(i, t + 0.02);
    PVector p = getPosForTime(t);
    pos.set(i, p);
    
    pushMatrix();
    translate(p.x*1000, p.y*1000, p.z*1000);
    sphere(100);
    popMatrix();
  }
  
  
}

PVector getPosForTime(float t)
{
  return new PVector(
    sin(t*cos(t)),
    cos(t*sin(t)),
    sin(t*tan(t))
  );
}
