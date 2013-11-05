import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UVertexList vl;
float a, b;

void setup()
{
  size(600, 600, OPENGL);
  
  UBase.setGraphics(this);
  
  build();
}

void draw()
{
  background(255);
  noFill();
  
  vl.draw();
  
  fill(0);
  text("a="+nf(a, 0, 3)+" b="+nf(b, 0, 3), 10, height-10);
}

void build()
{
  float t=0;
  int n=50;
  
  vl = new UVertexList();
  
  for (int i=0; i<n; i++)
  {
    t = map(i, 0, n-1, 0, 1);
    
    // x=t, y=shaper(t)
    vl.add(t, shaperAB(t));
  }
  
  vl.scale(width, height, 1);
}



