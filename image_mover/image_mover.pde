
FImage[] imgs;

void setup()
{
  size(400, 400);
  smooth();
  frameRate(60);
  
  imgs = new FImage[2];
  for (int i=0; i<imgs.length; i++)
  {
    imgs[i] = new FImage();
  }
}


void draw()
{
  background(#FFFED8);
  
  imgs[0].applyRotationForce(0.0);
  imgs[1].applyRotationForce(-0.010);
  
  for (FImage img : imgs)
  {
    img.update();
    img.draw();
  } 
}

void mousePressed()
{
  for (int i=0; i<imgs.length; i++)
  {
    imgs[i] = new FImage();
  }
}

