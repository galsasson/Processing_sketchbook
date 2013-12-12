
class VideoBox extends Ball
{
  Capture capture;
  PImage backgroundMask;
  
  public VideoBox(float x, float y, Capture cap, PImage mask)
  {
    super(x, y);
    capture = cap;
    backgroundMask = mask;
  }
  
  public void draw()
  {
    capture.mask(backgroundMask);

    // mirrot the video
    pushMatrix();
    translate(pos.x, pos.y);
    scale(-1, 1);
    image(capture, 0, 0);
    popMatrix();
  }
  
  public void applyBounds()
  {
    if (pos.x < 0) {
      pos.x = 0;
    }
    else if (pos.x > width) {
      pos.x = width;
    }
    
    if (pos.y < 0) {
      pos.y = 0;
    }
    else if (pos.y > height - capture.height) {
      pos.y = height - capture.height;
    }
  } 
  
}
