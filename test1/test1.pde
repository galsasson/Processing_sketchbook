import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UGeo model;
Tail tail;

void setup()
{
  size(800, 600, OPENGL);
  
  UBase.setGraphics(this);
  
  tail = new Tail();
  tail.buildSpine();
  
  //build();
}

void draw()
{
  background(150);
  lights();
  
  translate(width/2, height/2, 53);
  
  rotateX(rotateX);
  rotateY(rotateY);
  translate(0, 0, 0.0);    // Zoom

  tail.drawSpine();
//  model.draw();
}

void keyPressed()
{
  tail.buildSpine();
}

void build()
{
  int DETAILS = 100;
  int SEGMENT_HEIGHT = 5;
  int TOTAL_HEIGHT = 708;
  
  model = new UGeo();
  
  UVertexList base = new UVertexList();

  for (int i=0; i<DETAILS; i++)
  {
    base.add(new UVertex(63, 0).rotY(map(i, 0, DETAILS-1, 0, TWO_PI)));
  }
  
  UVertexList last = base;
  
  for (int h=SEGMENT_HEIGHT; h<=TOTAL_HEIGHT; h+=SEGMENT_HEIGHT)
  {
    UVertexList vl = new UVertexList();
    for (int i=0; i<DETAILS-1; i++)
    {
      vl.add(new UVertex(50 + random(14), h).rotY(map(i, 0, DETAILS-1, 0, TWO_PI)));
    }
    float lastX = vl.v.get(0).x;
    vl.add(new UVertex(lastX, h).rotY(TWO_PI));
    
    //vl.add(vl.v[0].copy());
    model.quadstrip(last, vl);
    last = vl;
  }
  
  model.translate(0, -TOTAL_HEIGHT/2, 0);
}


float rotateX=0;
float rotateY=0;

void mouseDragged()
{
    rotateY += radians(mouseX - pmouseX);
    rotateX += radians(pmouseY - mouseY);
}


