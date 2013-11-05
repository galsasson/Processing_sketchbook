
class Tail
{
  PVector pos;
  
  Genome genome;
  UGeo model;
  UVertexList spineVL;
  
  
  public Tail(Genome gen, float x, float y)
  {
    genome = gen;
    pos = new PVector(x, y);
    
    buildSpine();
    buildModel();
  }
  
  public void buildSpine()
  {
    int count=0;
    spineVL = new UVertexList();
    
    UVertex spineV = new UVertex(0, 0, 0);
    UVertex inc = new UVertex(10, 0, 0);
   
    for (int i=0; i<genome.tailLength; i++)
    {
      spineVL.add(spineV);
      spineV.add(inc);

      inc.rotZ(genome.tailRotations.get(i).z);
      inc.rotY(genome.tailRotations.get(i).y);
    }
  }
  
  public void buildModel()
  {
    UVertexList lastCone = null;
    model = new UGeo();
    ArrayList<UVertexList> coneList = new ArrayList<UVertexList>();

    for (int i=0; i<genome.tailLength-1; i++)
    {
      UVertex s = spineVL.v.get(i);
      UVertex e = spineVL.v.get(i+1);
      
      UVertex dir = e.copy().sub(s);
      
      PMatrix3D rot = getRotationMatrix(new PVector(0, 1, 0), new PVector(dir.x, dir.y, dir.z));
      
      UVertexList cone = new UVertexList();
      println("creating cone #" + i);
      for (int j=0; j<genome.tailDetail; j++)
      {
        UVertex v = new UVertex(genome.tailRadius.get(i) + genome.tailShape.get(j), 0, 0);
        v.rotY(map(j, 0, genome.tailDetail-1, TWO_PI, 0));
        PVector pv = new PVector(v.x, v.y, v.z);
        PVector pv2 = rot.mult(pv, null);
        cone.add(new UVertex(pv2.x, pv2.y, pv2.z));
      }
      cone.translate(s);
      coneList.add(cone);
    }
    
    model.quadstrip(coneList);
    model.triangleFan(coneList.get(0), true);
    model.triangleFan(coneList.get(coneList.size()-1));
  }
  
  // calculate rotation matrix between two arbitrary vectors
  // taken from: http://answers.google.com/answers/threadview/id/361441.html
  // and: http://math.stackexchange.com/questions/293116/rotating-one-3-vector-to-another
  public PMatrix3D getRotationMatrix(PVector v1, PVector v2)
  {
    v1.normalize();
    v2.normalize();
    
    // find rotation axis
    PVector rotAxis = v1.cross(v2);
    rotAxis.normalize();
    // find rotation angle
    float r = acos(v1.dot(v2));
    if (r<0.01) {
      return new PMatrix3D();
    }
    else if (PI-r<0.01) {
      PMatrix3D mat = new PMatrix3D();
      mat.rotate(PI, 0, 0, 1);
      return mat;
    }

    PMatrix3D mat = new PMatrix3D();
    mat.rotate(r, rotAxis.x, rotAxis.y, rotAxis.z);
    
    return mat;
  }
  
  public void drawSpine()
  {
    noFill();
    stroke(255);
    spineVL.draw();
    
    noStroke();
    fill(255, 0, 0);
    for (UVertex uv : spineVL)
    {
      pushMatrix();
      translate(uv.x, uv.y, uv.z);
      box(5, 5, 5);
      popMatrix();
    }
  }
  
  public void draw()
  {
    fill(0, 0, 255);
    model.draw();
    
    fill(0, 255, 0);
    for (UVertex v : model.vl)
    {
      pushMatrix();
      translate(v.x, v.y, v.z);
      box(2, 2, 2);
      popMatrix();
    }
  }  
}
