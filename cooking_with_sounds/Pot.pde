
class Pot
{
  PVector pos;
  PVector size;
  
  ArrayList<SampleMaker> samples;
  float speed = 0.03;
  
  public Pot(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    
    samples = new ArrayList<SampleMaker>();
  }
  
  public void updateSamples()
  {
    for (SampleMaker s : samples)
    {
      s.pos.rotate(speed);
      if (s.pos.x>0 && s.prevX<0) {
//        println("playing");
        s.play();
      }
      s.prevX = s.pos.x;
    }
  }
  
  public void updateLines(ArrayList<PLine> lines)
  {
    for (int i=0; i<lines.size(); i++)
    {
      pullVerts(lines.get(i));
      rotateVerts(lines.get(i));
    }
  }
  
  public void takeSample(SampleMaker sample)
  {
    sample.pos.sub(pos);
    samples.add(sample);
  }
  
  public void clearSamples()
  {
    samples.clear();
  }
  
  public void removeOneSample()
  {
    if (samples.size() > 0)
      samples.remove(0);
  }
  
  public void draw()
  {
    pushMatrix();
    
    noFill();
    stroke(50, 50, 50);
    strokeWeight(3);
    translate(pos.x, pos.y);
    ellipse(0, 0, size.x, size.y);
    
    for (SampleMaker s : samples)
    {
      s.draw();
    }
    
    popMatrix();
  }
  
  public void pullVerts(PLine line)
  {
    float rad = size.x/2;
    for (int i=0; i<line.size(); i++)
    {
      PVector vert = line.verts.get(i);
      PVector sub = PVector.sub(pos, vert);
      
      if (sub.mag() - line.targetRadius < 2) {
        sub.normalize();
        sub.mult(line.targetRadius);
        vert = PVector.add(pos, sub);
      }
      else if (sub.mag() > line.targetRadius) {
        sub.normalize();
        float val = map(sub.mag(), rad, 0, 0.01, 1);
        sub.mult(val);
//        sub.mult(2.2);    // tweak[1,3]
        vert.add(sub);
      }
      else if (sub.mag() < line.targetRadius) {
        sub.normalize();
        float val = map(sub.mag(), rad, 0, 0.01, 1);
        sub.mult(val);  // tweak[1,3]
        vert.sub(sub);
      }
    }
  }
  
  public void rotateVerts(PLine line)
  {
    float rad = size.x/2;
    for (PVector v : line.verts)
    {
      PVector sub = PVector.sub(pos, v);
      if (sub.mag() < rad)
      {
        // get vector of point with 0,0 at center of pot
        PVector newV = PVector.mult(sub,-1);
        float r = map(sub.mag(), 0, rad, 0.03, 0.04);
//        newV.rotate(r);
        newV.rotate(speed);
//        newV.rotate(rad/sub.mag() / 30);  // tweak[80,150]
        newV.add(pos);
        v.set(newV);
      }
    }
  }
  
}
