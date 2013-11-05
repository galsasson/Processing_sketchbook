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
  
  stroke(255);
  noFill();
  path.draw();
  
  fill(255, 255, 0);
  geo.draw();
  stroke(0, 255, 255);
  geo.drawNormals(10);
  
}

void buildProfile()
{
   prof = new UVertexList();
   int n=6;
   for (int i=0; i<n; i++)
   {
     prof.add(new UVertex(15, 0, 0).rotZ(map(i,0,n,0,2*PI)));
   }
   prof.close();
   
   geo = new UGeo().triangleFan(prof);
}

void build()
{
  buildProfile();
  path = new UVertexList();
  int n=30;
  for (int i=0; i<n; i++)
  {
    float t = map(i, 0, n-1, 0, 1);
    path.add(new UVertex(i*20, 0, 0));
    
    // bend the path by rotating incrementally
    path.last().rotZ(t*HALF_PI).rotY(t*PI/3);
  }
  
  sweep = UHeading.sweep(path, prof);
  
  n=sweep.size();
  int cnt=0;
  for (UVertexList l : sweep)
  {
    l.scaleInPlace(map(cnt++, 0, n-1, 1.5, 0.25));
  }
  
  geo = new UGeo().quadstrip(sweep);
//  head = new UHeading(new UVertex(0, 0, 1).rotY(random(PI)).rotX(random(PI)));
//  headbox = UGeo.box(100, 100, 5);
}

void keyPressed() 
{
//  head.align(geo);
}
