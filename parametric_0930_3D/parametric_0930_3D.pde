import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

Arc arc;

// camera
UNav3D nav;

void setup()
{
  size(600, 600, OPENGL);
  smooth();
  
  UMbMk2.setPApplet(this);
  
  nav = new UNav3D();
  
  build();
}

void draw()
{
  translate(width/2, height/2);
  background(0);
  
  lights();
  
  nav.doTransforms();
  
  int numArcs = 100;
  
  for (int i=0; i<numArcs; i++)
  {
    arcs.get(i).build();
    arcs.get(i).draw();
  }
}

