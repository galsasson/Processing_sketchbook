
class FImage
{
  PImage img;
  float rotation;
  float rotSpeed;
  float rotAcc;
  
  PVector pos;
  PVector size;
  float mass;
  
  
  public FImage()
  {
    pos = new PVector(width/2, height/2);
    size = new PVector(width*2, height*2);
    mass = 50;
//    img = createSineImage((int)size.x, (int)size.y, random(30, 35));
    img = createTestImage((int)size.x, (int)size.y, random(30, 35));
  }
  
  public FImage(float x, float y, int w, int h)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    mass = random(50);
//    img = createSineImage((int)size.x, (int)size.y, random(30, 35));
    img = createTestImage((int)size.x, (int)size.y, random(30, 35));
  }
  
  public void applyRotationForce(float force)
  {
    rotAcc += force/mass;
  }
  
  public void update()
  {
    rotSpeed += rotAcc;
    rotation += rotSpeed;
    
    // limit rotation speed
    if (rotSpeed > 0.1) {
      rotSpeed = 0.1;
    }
    else if (rotSpeed < -0.1) {
      rotSpeed = -0.1;
    }
    
    rotAcc = 0;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(rotation);
    translate(-size.x/2, -size.y/2);
    
    image(img, 0, 0);
    
    popMatrix();
  }
}


/***********************/
/* Image generator
/***********************/

PImage createSineImage(int w, int h, float freq)
{
  PImage img = createImage(w, h, ARGB);
  img.loadPixels();
  for (int i=0; i<img.pixels.length; i++) {
    img.pixels[i] = color(0, 0, 0, sin((float)i/freq)*255);
  }
  
  return img;
}


PImage createTestImage(int w, int h, float freq)
{
  PImage img = createImage(w, h, ARGB);
  img.loadPixels();
  float t=0;
 
  float freq1 = freq+random(10000, 20000);
  float freq2 = freq+random(30000, 40000);
  println("Using two frequencies: " + freq1 + " * " + freq2);  
  for (int i=0; i<img.pixels.length; i++) {
    float val1 = sin((float)i/freq1);
    float val2 = sin((float)i/freq2);
    float val3 = val1 + val2 + noise(t);
    constrain(val3, -1, 1);
    val3 = map(val3, -1, 1, 0, 1);
    img.pixels[i] = color(0, 0, 0, val3*255);// val3<0.5?0:255);//(int)(val3*255));
    
    t += 0.01; 
  }
  
  return img;
}

FImage createImageFromFile(String filename)
{
   return new FImage(); 
}
