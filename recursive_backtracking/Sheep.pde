
class Sheep extends Animal
{
  PImage img;
  
  public Sheep()
  {
    type = "sheep";
    img = loadImage("sheep.png");
  }
  
  public void draw(float x, float y)
  {
    pushMatrix();
    translate(x, y);
    
    image(img, 0, 0);
    
    popMatrix();
  }
  
}
