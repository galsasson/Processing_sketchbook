
class PLine
{
  PVector s,t;
  
  public PLine(PVector _s, PVector _t)
  {
    s = _s;
    t = _t;
  }
}

class PRect
{
  public ArrayList<PLine> lines;
  PVector min, max;
  float w, h;
  
  public PRect(PVector _min, PVector _max)
  {
    min = _min;
    max = _max;
    w = max.x - min.x;
    h = max.y - min.y;
    
    lines = new ArrayList<PLine>();
    lines.add(new PLine(new PVector(_min.x, _min.y), new PVector(_max.x, _min.y)));
    lines.add(new PLine(new PVector(_max.x, _min.y), new PVector(_max.x, _max.y)));
    lines.add(new PLine(new PVector(_max.x, _max.y), new PVector(_min.x, _max.y)));
    lines.add(new PLine(new PVector(_min.x, _max.y), new PVector(_min.x, _min.y)));
  }
}
