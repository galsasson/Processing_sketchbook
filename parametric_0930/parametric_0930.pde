import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

Arc arc;

void setup()
{
  size(600, 600);
  smooth();
  
  UMbMk2.setPApplet(this);
  
  build();
}

void draw()
{
  translate(width/2, height/2);
  background(0);
  
  int numArcs = 100;
  
  for (int i=0; i<numArcs; i++)
  {
    arcs.get(i).build();
    arcs.get(i).draw();
  }
}

