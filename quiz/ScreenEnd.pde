
class ScreenEnd extends Screen
{
  boolean next = false;
  
  public ScreenEnd()
  {
  }
  
  public void draw()
  {
    background(230);
    fill(80);
    textFont(font, 28);
    text(resultStr, 20, 60);
    text("Thank you for participating in this experiment!", 20, 120); 
    text("Real results:", 20, 200);
    text("The computer lied to you: 3 times", 60, 240);
    text("but only because you lied to him first.", 60, 280);
  }
  
  public void mouseClicked(int x, int y)
  {
    if (x > width/2-100 && x < width/2+100 &&
        y > height-100 && y < height-50) {
          next = true;
        }
  }
  
  public boolean goToNext()
  {
    return false;
  }
  
    public int getSelection()
  {
    return -1;
  }
  
  public int getPage()
  {
    return -1;
  }

  
  
}
