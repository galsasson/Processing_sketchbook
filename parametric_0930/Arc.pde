class Arc
{
  float a, aD;
  float rMin, rD;
  UVertexList vlMin, vlMax;
  
  public Arc()
  {
    a = random(TWO_PI);
    aD = radians(random(30, 60));
    
    rMin = random(10, 300);
    rD = random(20, 60);
    
    build();
  }
  
  void build()
  {
    int n=12;
    
    float rMod=1.00;
    float aMod=1.00;
    
    vlMin = new UVertexList();
    for (int i=0; i<n; i++) {
      float deg = map(i, 0, n-1, a, a+(aD*aMod));
      vlMin.add(new UVertex(rMin, 0).rotZ(deg));
    }
    
    vlMax = vlMin.copy().scale((rMin+(rD*rMod))/rMin);
  }
  
  void draw()
  {
    for(int i=0; i<vlMin.size(); i++)
    {
      UVertex v1 = vlMin.get(i);
      UVertex v2 = vlMax.get(i);
      
      stroke(255);
      line(v1.x, v1.y, v2.x, v2.y);
    }
  }
}
