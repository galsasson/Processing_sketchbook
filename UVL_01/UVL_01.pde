import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;


UGeo model;

void setup()
{
  size(600, 600, OPENGL);
  
  UBase.setGraphics(this);
  
  build();
}

void draw()
{
  background(150);
  
  translate(width/2, height/2);
  
  rotateX(radians(frameCount));
  rotateY(radians(frameCount*2));
  
  model.draw();
}

void keyPressed()
{
  build();
}

void build()
{
  UVertexList vl, vl2;
  vl = new UVertexList();
  
  for (int i=0; i<12; i++) {
    vl.add(new UVertex(100, 0).rotY(map(i, 0, 11, 0, TWO_PI)));
  }
  
  float h=100;
  vl2 = vl.copy().translate(0, h, 0);
  vl.translate(0, -h, 0);
  
  model = new UGeo();
  model.quadstrip(vl, vl2);
  model.triangleFan(vl);
  model.triangleFan(vl2);
}
