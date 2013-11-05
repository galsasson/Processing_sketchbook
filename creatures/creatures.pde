import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

Tail tail;

PMatrix mat;

void setup()
{
  size(800, 600, OPENGL);
  
  UBase.setGraphics(this);
  
  tail = new Tail(new Genome(), 0, 0);
  
}

void draw()
{
  background(150);
  lights();
  
  translate(width/2, height/2, 8);
  
  rotateX(rotateX+PI);
  rotateY(rotateY);
  //rotateZ(PI);

  tail.drawSpine();
  tail.draw();
}

void keyPressed()
{
  if (key==' ') {
    tail = new Tail(new Genome(), 0, 0);
  }
  else if (key=='s') {
    // export the model
    String filename=UFile.nextFilename("data/", "GalSasson_Tail_0923");
    UGeoIO.writeSTL(filename+".stl", tail.model);
    saveFrame(filename+".png"); // saving a png image
  }
}

float rotateX=0;
float rotateY=0;

void mouseDragged()
{
    rotateY += radians(mouseX - pmouseX);
    rotateX += radians(pmouseY - mouseY);
}
