import unlekker.mb2.geo.*;
import unlekker.mb2.util.*;
import ec.util.*;

UVertex v, dir;
UVertexList vl;

void setup()
{
  size(600, 600, OPENGL);
  
  UBase.setGraphics(this);
  
  vl = new UVertexList();
  v = new UVertex();
  dir = new UVertex(25, 0).rot(random(TWO_PI));
  vl.add(v);
}

void draw()
{
  background(54);
  translate(width/2, height/2);
  
  noFill();
  stroke(255);
  vl.draw();
  stroke(195, 59, 59);
  ellipse(v.x, v.y, 50, 50);
  line(v.x, v.y, v.x+dir.x, v.y+dir.y);
 
  stroke(166, 201, 25);
  strokeWeight(2);
  for (UVertex tmpv : vl) {
    ellipse(tmpv.x, tmpv.y, 9, 10);
  } 
}

void keyPressed()
{
  if (keyCode == UP) {
    v.add(dir);
  }
  else if (keyCode == DOWN) {
    v.sub(dir);
  }
  else if (keyCode == RIGHT) {
    dir.rot(radians(5));
  }
  else if (keyCode == LEFT) {
    dir.rot(radians(-5));
  }
  
  if (keyCode == UP || keyCode == DOWN) {
    vl.add(v);
  }  
}

