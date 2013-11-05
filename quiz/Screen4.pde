
class Screen4 extends Screen
{
  RadioButton choices[] = new RadioButton[4];
  boolean next;
  Ball balls[] = new Ball[10];
  
  public Screen4()
  {
    for (int i=0; i<4; i++) {
      choices[i] = new RadioButton(30, 120 + i*50);
    }
    
    for (int i=0; i<2; i++) {
      balls[i] = new Ball(random(width), random(height), color(255, 0, 0));
    }
    for (int i=2; i<4; i++) {
      balls[i] = new Ball(random(width), random(height), color(0, 0, 255));
    }
    for (int i=4; i<6; i++) {
      balls[i] = new Ball(random(width), random(height), color(0, 255, 0));
    }
    for (int i=6; i<10; i++) {
      balls[i] = new Ball(random(width), random(height), color(255, 255, 0));
    }
  }
  
  void draw()
  {
    background(230);
    
    for (int i=0; i<balls.length; i++) {
      balls[i].update();
      balls[i].draw();
    }
    
    fill(80);
    textFont(font, 28);
    text("What is the most common ball color?", 20, 60);

    textFont(font, 20);
    text("yellow.", 60, 127);
    text("green.", 60, 177);
    text("red.", 60, 227);
    text("blue.", 60, 277);
    
    textFont(font, 28);
    text("Score: 0/"+score, 20, height-20);

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
    text("Submit", width/2-37, height-68);
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
            resultStr = "Wrong! It was green.";
            if (choices[1].checked) {
              resultStr = "Wrong! It was red.";
            }
            score++;
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
    return 4;
  }

  
}
