
class Deformer
{
  UVertex loc;
  float rad;
  float force;
  
  public Deformer(float x, float y, float z, float r)
  {
    loc = new UVertex(x, y, z);
    rad = r;
    force = 20;
  }
  
  void deform(UGeo model)
  {
    for (UVertex vv:model.getV())
    {
      float d=loc.dist(vv);
      if (d<rad) {
        d = d/rad;
        float push = (1-d) * force;
        
        // get the delta vector between log and vv
        UVertex delta = vv.copy().sub(loc);
        delta.norm();
        vv.add(delta.mult(push));
    }
  }
  
}
  
  
}
