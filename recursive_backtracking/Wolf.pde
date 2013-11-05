
class Wolf extends Animal
{
  PImage img;
  
  public Wolf()
  {
    super();
    type = "wolf";
    img = loadImage("wolf.png");
  }
  
  public void draw(float x, float y)
  {
    pushMatrix();
    translate(x, y);
    
    image(img, 0, 0);
    
    popMatrix();
  }
  
}
