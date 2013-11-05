import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UGeo model;
UNav3D nav;

Morpher morpher = new Morpher();

void setup()
{
  size(800, 800, OPENGL);
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
  
  stroke(100);
  fill(228);
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
  ArrayList<UVertexList> shape = new ArrayList<UVertexList>();
  
  float[] sizes = {192,   102, 90, 47, 55, 27, 40, 30,  1};
  int[] iterations =     {  15, 15, 28,  12,  15, 7, 7, 1};
  int[] holdIterations = {  10,  1, 10,  1,   10,  1, 10,  0};
//  float[] heightIncs = {10, 20, 7, 8, 7, 8};
//  float[] rotations = {0.14, 0.36, 0.41, 0.30};
  
//  float h=0;
  
  int n=16;
  UVertexList lastElement = new UVertexList();
  for (int i=0; i<n; i++) {
    lastElement.add(new UVertex(sizes[0]/2, 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
  }
  lastElement.close();
  shape.add(lastElement);
//  model.triangleFan(lastElement, true);
  
  // loop through all the elements
  for (int element = 0; element < iterations.length; element++)
  {
    // create next element target
    UVertexList nextElement;
    if (element%2 == 0) {
      nextElement = createSquareVL(sizes[element+1], n);
      nextElement.close();
    }
    else {
      nextElement = new UVertexList();
      for (int i=0; i<n; i++) {
        nextElement.add(new UVertex(sizes[element+1]/2, 0, 0).rotZ(map(i, 0, n, 0, TWO_PI)));
      }
      nextElement.close();
    }
    
    // interpolate between lastElement and nextElement
    UVertexList last = lastElement;
    float rot=0;
    for (float t=(float)1/iterations[element]; t<=1.00; t+=(float)1/iterations[element])
    {
      UVertexList vl = morpher.getMorph(lastElement, nextElement, t);
//      vl.translate(0, 0, h);
      shape.add(vl);
      last = vl;
//      h += heightIncs[element];
    }
    
    // add height to nextElement
    for (int i=0; i<holdIterations[element]; i++)
    {
      UVertexList vl = last.copy();
      for (UVertex v : vl) {
        v.z = 0;
      }
//      h += heightIncs[element];
//      vl.translate(0, 0, h);
      shape.add(vl);
      last = vl;
    }
    
    lastElement = last;
  }
  
  
  // apply twist
  float t=0.000, tt=0.000;
  float rotation=0.000;
  float heightInc = 2.41;
  float h=0;
  for (int i=1; i<shape.size(); i++)
  {
    UVertexList vl = shape.get(i);
    vl.rotZ(rotation);
    h += heightInc;
    vl.translate(0, 0, h);
    model.quadstrip(shape.get(i-1), vl);
//    rotation += sin(t)*0.000+sin(tt)*0.048;
    rotation += sin(tt)*0.141;
    t += 0.000;
    tt += 0.15 + sin(t)*1.87;
  }
  
  model.triangleFan(shape.get(0), true);
  model.triangleFan(shape.get(shape.size()-1));
  
  model.translate(0, 0, -h/2);
}

void keyPressed()
{
  if (key=='s') {
    // export the model
    String filename=UFile.nextFilename("data/", "GalSasson_Tower_1104");
    UGeoIO.writeSTL(filename+".stl", model);
    saveFrame(filename+".png"); // saving a png image
  }
}


