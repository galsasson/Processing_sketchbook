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
   prof.add(10, 0, 0);
   prof.add(100, 0, 0);
   prof.add(100, 200, 0);
   prof.add(80, 200, 0);
   prof.add(80, 20, 0);
   prof.add(10, 20, 0);
}

void build()
{
  buildProfile();
  
  sweep = new ArrayList<UVertexList>();
  int n=30;
  for (int i=0; i<n; i++)
  {
    sweep.add(prof.copy().rotY(map(i, 0, n, 0, TWO_PI)));
  }
  
  geo = new UGeo().quadstrip(sweep);
  
//  for (UVertex vv : geo.getV())
//  {
//    vv.mult(0.5 + 0.5*vv.V, 1, 0.5 + 0.5*vv.V);
//    vv.rotX(vv.V * radians(30));
//  }
  
}
