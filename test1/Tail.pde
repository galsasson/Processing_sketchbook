
class Tail
{
  UGeo model;
  UVertexList spineVL;
  
  float startHeight;
  float startRadius;
  float endRadius;
  float fuzziness;
  
  int details = 12;
  
  public Tail()
  {
    startHeight = random(100, 200);
    fuzziness = random(0, 1);
    startRadius = random(30, 50);
    endRadius = 2;
    
    buildSpine();
  }
  
  public void buildSpine()
  {
    spineVL = new UVertexList();
    
    UVertex spineV = new UVertex(0, startHeight, 0);
    UVertex inc = new UVertex(-5, -10, 0);
    
    spineVL.add(spineV);
    
    while (spineV.y > 0)
    {
      spineV.add(inc);
      spineVL.add(spineV);
    }
  }
  
  public void drawSpine()
  {
    spineVL.draw();
  }
  
  /*
  public void build()
  {
    model = new UGeo();
    
    UVertex spineV = new UVertex(0, startHeight, 0);
    UVertex rot = new UVertex(0, PI, 0);
    UVertex inc = new UVertex(10, 0, 0);
    spineV.y = startHeight;
    float radius = startRadius;
    
    while (spineV.y > 0)
    {
      // move center point
      spineV.add(dir);
      
      // add vertexlist of circle
      UVertexList vl = new UVertexList();
      for (int i=0; i<details; i++)
      {
        
        UVertex v = new UVertex(radius, 0, 0);
        
        vl.add(new UVertex(v.x, v.y + radius, v.z).rotX
      }
      
    }
    
    
    
  }
  */
  
}
