
class Morpher
{
  UVertexList getMorph(UVertexList source, UVertexList target, float t)
  {
    UVertexList res = new UVertexList();
    
    t = 1.00*t*t;
  
    
    for (int i=0; i<source.size(); i++)
    {
      UVertex sv = source.get(i);
      UVertex tv = target.get(i);
      res.add(new UVertex(sv.x + (tv.x - sv.x) * t, sv.y + (tv.y - sv.y) * t));
    }
    
    return res;
  }
}
