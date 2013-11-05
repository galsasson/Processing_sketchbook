
class ScreenGetReady extends Screen
{
  boolean next = false;
  
  public ScreenGetReady()
  {
  }
  
  public void draw()
  {
    background(230);
    fill(80);
    textFont(font, 28);
    text(resultStr, 20, 60);
    text("You have 20 seconds to solve the next puzzle,", 20, 120); 
    text("Click 'Go!' when you're ready.", 20, 150);

    text("Score: 0/"+score, 20, height-20);

    stroke(0);
    noFill();
    strokeWeight(2);
    rect(width/2-100, height-100, 200, 50, 5, 5, 5, 5);
    fill(0);
    text("Go!", width/2-21, height-66);
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
    return next;
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
