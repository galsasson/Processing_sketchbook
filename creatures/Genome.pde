
class Genome
{
  ArrayList<PVector> tailRotations;
  ArrayList<Float> tailShape;
  ArrayList<Float> tailRadius;
  
  int tailLength;
  int tailDetail;
  float tailStartRadius;
  float maxRadiusFactor;
  
  public Genome()
  {
    tailRotations = new ArrayList<PVector>();
    tailRadius = new ArrayList<Float>();
    tailShape = new ArrayList<Float>();
    
    tailLength = 50;
    tailDetail = 16;
    tailStartRadius = 20;
    maxRadiusFactor = 1.3;
    
    randomizeTailRotation();
    randomizeTailRadius();
    randomizeTailShape();
  }
  
  void randomizeTailRotation()
  {
    float t=random(100000);
    float tt=random(100000);
    
    for (int i=0; i<tailLength; i++)
    {
      PVector rot = new PVector();
//      if (i<tailLength/2) {
        rot.x = 0;
        rot.y = radians(noise(t)*40-20);
        rot.z = radians(noise(tt)*10-5);
//      }
      
      tailRotations.add(rot);
      
      t += 0.05;
      tt += 0.3;
    }
  }
  
  void randomizeTailRadius()
  {
    float t = random(100000);
    
    float decAmount = tailStartRadius/tailLength;
    for (int i=0; i<tailLength; i++)
    {
      float radius = tailStartRadius - i*decAmount;
      tailRadius.add((noise(t)+1)*maxRadiusFactor*radius);
      
      t += 0.2;
    }
  }
  
  void randomizeTailShape()
  {
    float t = random(100000);
    
    for (int i=0; i<tailDetail-1; i++)
    {
      tailShape.add(random(1)*5);
      t += 0.2;
    }
    tailShape.add(tailShape.get(0));
  }
}
