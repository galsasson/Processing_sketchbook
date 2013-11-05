import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UGeo model;
UNav3D nav;

Morpher morpher = new Morpher();

void setup()
{
  size(800, 1200, OPENGL);
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
  lights();
  nav.doTransforms();
  
  stroke(255);
  fill(125);
//  noFill();
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
  UVertexList circle2 = new UVertexList();
  UVertexList square, square2;
  
  float[] sizes = {121, 51, 8, 19, 1};
  float[] heightIncs = {7, -4, 4, 9};
  int[] iterations = {11,
                      10,
                      10,
                      10};
  int[] holdIterations = {2, 1, 0, 0};
  
  float h=0;
  
  int n=16;
  UVertexList lastElement = new UVertexList();
  for (int i=0; i<n; i++) {
    lastElement.add(new UVertex(sizes[0], 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
  }
  lastElement.close();
  for (int element = 0; element < heightIncs.length; element++)
  {
    UVertexList nextElement;
    if (element%2 == 0) {
      nextElement = createSquareVL(sizes[element+1], n);
      nextElement.close();
    }
    else {
      nextElement = new UVertexList();
      for (int i=0; i<n; i++) {
        nextElement.add(new UVertex(sizes[element+1], 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
      }
      nextElement.close();
    }
    
    UVertexList last = lastElement;
    for (float t=0; t<=1.00; t+=(float)1/iterations[element])
    {
      UVertexList vl = morpher.getMorph(lastElement, nextElement, t);
      vl.translate(0, 0, h);
      model.quadstrip(last, vl);
      last = vl;
      h += heightIncs[element];
    }
    
    for (int i=0; i<holdIterations[element]; i++)
    {
      UVertexList vl = last.copy();
      for (UVertex v : vl) {
        v.z = 0;
      }
      vl.translate(0, 0, h);
      model.quadstrip(last, vl);
      last = vl;
      h += heightIncs[element];
    }
    
    lastElement = last;
  }
  
  
//  for (int i=0; i<n; i++) {
//    circle.add(new UVertex(257, 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
//  }
//  circle.close();
//  
//  for (int i=0; i<n; i++) {
//    circle2.add(new UVertex(5, 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
//  }
//  circle2.close();
//
//  square = createSquareVL(303, n);
//  square.close();
//  square2 = createSquareVL(180, n);
//  square2.close();
//  
//  float h=0;
//  
//  UVertexList last = square;
//  for (float t=0.02; t<=1.00; t+=0.02)
//  {
//    UVertexList vl = morpher.getMorph(square, circle, t);
//    vl.translate(0, 0, h);
//    model.quadstrip(last, vl);
//    last = vl;
//    h+=5;
//  }
//  
//  for (float t=1; t>=0; t-= 0.1)
//  {
//    UVertexList vl = morpher.getMorph(square2, circle, t);
//    vl.translate(0, 0, h);
//    model.quadstrip(last, vl);
//    last = vl;
//    h+=8;
//  }
//  
//  for (float t=0; t<=1; t+= 0.1)
//  {
//    UVertexList vl = morpher.getMorph(square2, circle2, t);
//    vl.translate(0, 0, h);
//    model.quadstrip(last, vl);
//    last = vl;
//    h+=11;
//  }

  model.translate(0, 0, -h/2);
}

