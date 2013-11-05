
class Nail
{
  PVector pos;
  float length;
  float angle;
  float t;
  
  int encryptX;
  int decryptX;
  
  int status;
  
  boolean drawLine;
  
  public Nail(float x, float y, float l)
  {
    pos = new PVector(x, y);
    length = l;
    angle = 0;
    
    t = random(PI*2);
    
    status = 0;
    drawLine = false;
    encryptX = (int)random(width/4, width/4 + 10);
    decryptX = (int)random(width*3/4, width*3/4 + 10);
  }
  
  public void update()
  {
    if (abs(pos.x - encryptX + (int)random(5)) < 5) {
//    if (pos.x == encryptX) {
      angle = random(PI*2);
      drawLine = true;      
    }
    else if (abs(pos.x - decryptX + (int)random(5)) < 5) {
      if (angle != 0)
      {
//      else if (pos.x == decryptX) {
        angle = 0;
        drawLine = true;
      }
    }
    
    pos.x += 2;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    
    noFill();
    strokeWeight(5);
    stroke(255, 255, 255, 60);
    line(-length/2, 0, length/2, 0);
    
    popMatrix();
    
    noStroke();
    fill(255);
    rect(encryptX-1, 0, 2, 20);
    rect(encryptX-5, 20, 10, 5);
    rect(decryptX-1, 0, 2, 20);
    rect(decryptX-5, 20, 10, 5); 
    
    noFill();
    if (drawLine) {
      strokeWeight(1);
      stroke(255, 255, 255, 150);
      line(pos.x, 20, pos.x, pos.y);
      drawLine = false;
    }
  }
  
  boolean verifyBounds()
  {
    if (pos.x > width) {
      return false;
    }
    
    return true;
  }
}
