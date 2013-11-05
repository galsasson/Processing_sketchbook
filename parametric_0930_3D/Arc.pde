class Arc
{
  float a, aD;
  float rMin, rD;
  float z1, z2;
  UVertexList vlMin, vlMax;
  UGeo model;
  
  public Arc()
  {
    a = random(TWO_PI);
    aD = radians(random(30, 60));
    
    rMin = random(10, 300);
    rD = random(20, 60);
    
    z1 = random(20, 200);
    z2 = random(20, 200);
    
    
    build();
  }
  
  void build()
  {
    int n=12;
    
    float rMod=1.00;
    float aMod=1.00;
    float z1Mod = 1.00;
    float z2Mod = 1.00;
    
    vlMin = new UVertexList();
    for (int i=0; i<n; i++) {
      float deg = map(i, 0, n-1, a, a+(aD*aMod));
      vlMin.add(new UVertex(rMin, 0).rotZ(deg));
    }
    
    UVertexList vl1, vl2;
    float maxScale = (rMin+(rD*rMod))/rMin;
    vlMax = vlMin.copy().scale(maxScale);
    vl1 = vlMin.copy().scale(maxScale/3).translate(0, 0, z1*z1Mod);
    vl2 = vlMin.copy().scale(maxScale*2/3).translate(0, 0, z2*z2Mod);
    
    model = new UGeo();
    model.quadstrip(vlMin, vl1);
    model.quadstrip(vl1, vl2);
    model.quadstrip(vl2, vlMax);
    model.quadstrip(vlMax, vlMin);    
  }
  
  void draw()
  {
    model.draw();
    for(int i=0; i<vlMin.size(); i++)
    {
      UVertex v1 = vlMin.get(i);
      UVertex v2 = vlMax.get(i);
      
      stroke(255);
      line(v1.x, v1.y, v2.x, v2.y);
    }
  }
}
