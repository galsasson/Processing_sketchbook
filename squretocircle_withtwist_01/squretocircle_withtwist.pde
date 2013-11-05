import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UGeo model;
UNav3D nav;

void setup()
{
  size(600, 600, OPENGL);
  smooth();

  UMB.setPApplet(this);
  nav = new UNav3D();
  
  buildModel();
}

void draw()
{
  buildModel();
  
  background(0);
  translate(width/2, height/2, 0);
  
  nav.doTransforms();
  
  stroke(255);
  noFill();
//  for (float a=0; a<PI*2; a+=PI/16)
//  {
//    stroke(map(a, 0, PI*2, 0, 255), 0, 255);
//    
//    PVector inter = findInter(a, 30f, 30f);
//    line(0, 0, inter.x, inter.y);
//  }

  model.draw();
  
}

UVertexList createSquareVL(float size, int n)
{
  UVertexList res = new UVertexList();
  
  for (float a=0; a<TWO_PI; a+=TWO_PI/n)
  {
    PVector inter = findInter(a, size, size);    
    res.add(new UVertex(inter.x, inter.y, 0));
  }
  
  return res;
}

void buildModel()
{
  model = new UGeo();
  UVertexList circle = new UVertexList();
  UVertexList square;
  
  int n=16;
  for (int i=0; i<n; i++) {
    circle.add(new UVertex(50, 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
  }
  circle.close();
  
  square = createSquareVL(400, n);
  square.close();
  
  UVertexList last = square;
  for (float t=0.025; t<=1; t+=0.025)
  {
    UVertexList vl = Morpher.getMorph(square, circle, t);
    vl.translate(0, 0, t*300);
    model.quadstrip(last, vl);
    last = vl;
  }
}

