

class Screen1 extends Screen
{
  RadioButton choices[] = new RadioButton[4];
  boolean next;
  
  public Screen1()
  {
    for (int i=0; i<4; i++) {
      choices[i] = new RadioButton(30, 120 + i*50);
    }
  }
  
  void draw()
  {
    background(230);
    fill(80);
    textFont(font, 28);
    text("How did you hear about this game?", 20, 60);

    textFont(font, 20);
    text("From a banner ad.", 60, 127);
    text("Google (or other search engine).", 60, 177);
    text("Newspaper ad.", 60, 227);
    text("TV or radio.", 60, 277);
    
    boolean okToStart = false;
    for (int i=0; i<4; i++) {
      choices[i].draw();
      if (choices[i].checked) {
        okToStart = true;
      }
    }
    
    // start game button
    noFill();
    if (okToStart) {
      stroke(0);
    }
    else {
      stroke(200);
    }
    strokeWeight(2);
    rect(width/2-100, height-100, 200, 50, 5, 5, 5, 5);
    if (okToStart) {
      fill(0);
    }
    else {
      fill(200);
    }
    text("start the game!", width/2-67, height-68);
  }
  
  public void mouseClicked(int x, int y)
  {
    // check for radio buttons
    for (int i=0; i<4; i++) {
      if (choices[i].hit(x, y)) {
        // clear all and select this one
        for (int j=0; j<4; j++) {
          choices[j].checked = false;
        }
        choices[i].checked = true;
      }
    }
    
    if (x > width/2-100 && x < width/2+100 &&
        y > height-100 && y < height-50) {
          boolean okToStart = false;
          for (int i=0; i<4; i++) {
            if (choices[i].checked) {
              okToStart = true;
            }
          }
          
          if (okToStart) {
            next = true;
          }
        }
  }
  
  public boolean goToNext()
  {
    return next;
  }
  
  public int getSelection()
  {
    for (int i=0; i<4; i++)
    {
      if (choices[i].checked) {
        return i;
      }
    }
    
    return -1;
  }
  
  public int getPage()
  {
    return 1;
  }

}
