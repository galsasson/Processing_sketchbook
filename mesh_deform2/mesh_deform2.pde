import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UVertexList path, prof;
UNav3D nav;
UGeo geo;

ArrayList<UVertexList> sweep;

UHeading head;
UGeo headbox;

void setup()
{
  size(600, 600, OPENGL);
  smooth();
 
  UMB.setPApplet(this);
  nav = new UNav3D();
  
  build();
}

void draw()
{
  Deformer def = new Deformer(0, 50, 0, 50);
  def.deform(geo);

  background(0);
  translate(width/2, height/2);
  
  lights();
  nav.doTransforms();

  // draw AXIS
  stroke(255, 0, 0);
  line(0, 0, 0, 400, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 400, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 400);
  
  fill(255, 255, 0);
  geo.draw();
  stroke(0, 255, 255);
  geo.drawNormals(10);
  
}

void buildProfile()
{
   prof = new UVertexList();
   int n=36;
   for (int i=0; i<n; i++)
   {
     prof.add(new UVertex(30, 0, 0).rotY(map(i,0,n-1,0,2*PI)));
     prof.last().U = map(i, 0, n-1, 0, 1); // U indicates the rotational order
   }
   
   geo = new UGeo().triangleFan(prof);
}

void build()
{
  buildProfile();
  
  sweep = new ArrayList<UVertexList>();
  int n=36;
  for (int i=0; i<n; i++)
  {
    sweep.add(prof.copy().translate(0, map(i, 0, n-1, 0, 400), 0));
    
    int vn = prof.size();
    for (UVertex vv: sweep.get(sweep.size()-1))
    {
      vv.V = map(i, 0, n-1, 0, 1);  // V indicating the horizontal order
    }
  }
  
  geo = new UGeo().quadstrip(sweep);
  
  for (UVertex vv : geo.getV())
  {
    vv.mult(0.5 + 0.5*vv.V, 1, 0.5 + 0.5*vv.V);
    vv.rotX(vv.V * radians(30));
  }
  
}
