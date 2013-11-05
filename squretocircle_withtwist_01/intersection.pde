PVector findInter(float ang,  // angle from 00
                         float w, float h)
{
  PVector inter = new PVector(0, 0);
  
  if (ang < PI/4) {
    inter = new PVector(w/2, tan(ang)*w/2);
  }
  else if (ang < PI/2) {
    inter = new PVector(tan(PI/2 - ang)*h/2, h/2); 
  }
  else if (ang < 3*PI/4) {
    inter = new PVector(tan(ang - PI/2)*-h/2, h/2);
  }
  else if (ang < PI) {
    inter = new PVector(-w/2, tan(PI-ang)*w/2);
  }
  else if (ang < 5*PI/4) {
    inter = new PVector(-w/2, tan(ang)*-w/2);
  }
  else if (ang < 3*PI/2) {
    inter = new PVector(tan(3*PI/2 - ang)*-h/2, -w/2);
  }
  else if (ang < 7*PI/4) {
    inter = new PVector(tan(ang - 3*PI/2)*h/2, -w/2);
  }
  else {
    inter = new PVector(w/2, tan(2*PI - ang)*-w/2);
  }

  return inter;
}


