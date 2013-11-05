
int score=0;

String resultStr = "";

PFont font;
int currentScreen = 0;
Screen screens[] = new Screen[8];

int userID;

void setup()
{
  size(800, 600);
  smooth();
  
  userID = (int)random(MAX_INT);
  
  font = loadFont("Helvetica-28.vlw");
  screens[0] = new Screen1();
  screens[1] = new ScreenGetReady();
  screens[2] = new Screen2();
  screens[3] = new ScreenGetReady();
  screens[4] = new Screen3();
  screens[5] = new ScreenGetReady();
  screens[6] = new Screen4();
  screens[7] = new ScreenEnd();
  
  // write access to the first screen
  loadStrings("http://galsasson.com/ygwyg/insert.php?id=user"+userID+"&page=0&selection=0"); 
}

void draw()
{
  screens[currentScreen].update();
  screens[currentScreen].draw();
  
  if (screens[currentScreen].goToNext()) {
    int page = screens[currentScreen].getPage();
    if (page != -1) {
      int selection = screens[currentScreen].getSelection();
      String req = "http://galsasson.com/ygwyg/insert.php?id=user"+userID+"&page="+page+"&selection="+selection;
      String res[] = loadStrings(req); 
    }
    currentScreen++;
  }
}

void mousePressed()
{
  screens[currentScreen].mouseClicked(mouseX, mouseY);
}

class Screen
{
  public Screen() {}
  public void draw() {}
  public void update() {}
  public boolean goToNext() {return false;}
  public int getSelection() {return -1;}
  public int getPage() {return -1;}
  public void mouseClicked(int x, int y) {}
}

class Ball
{
  PVector pos;
  PVector vel;
  color col;
  
  public Ball(float x, float y, color c)
  {
    pos = new PVector(x, y);
    vel = new PVector(random(5), random(5));
    col = c;
  }
  
  public void update()
  {
    pos.add(vel);
    
    if (pos.x < 0 || pos.x > width) {
      vel.x *= -1;
    }
    if (pos.y < 0 || pos.y > height) {
      vel.y *= -1;
    }
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    fill(col);
    noStroke();
    ellipse(0, 0, 40, 40);
    
    popMatrix();
  }
}

class RadioButton
{
  boolean checked;
  PVector pos;
  
  public RadioButton(float x, float y)
  {
    checked = false;
    pos = new PVector(x, y);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noFill();
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, 20, 20);
    
    if (checked) {
      fill(0);
      ellipse(0, 0, 8, 8);
    }
    
    popMatrix();
  }
  
  public boolean hit(int x, int y)
  {
    PVector p = new PVector(x, y);
    if (p.dist(pos) < 15) {
      return true;
    }
    
    return false;
  }
}


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

class Screen2 extends Screen
{
  RadioButton choices[] = new RadioButton[4];
  boolean next;
  Ball balls[] = new Ball[7];
  
  public Screen2()
  {
    for (int i=0; i<4; i++) {
      choices[i] = new RadioButton(30, 120 + i*50);
    }
    
    for (int i=0; i<7; i++) {
      balls[i] = new Ball(random(width), random(height), color(242, 147, 25));
    }
  }
  
  void draw()
  {
    background(230);
    
    for (int i=0; i<7; i++) {
      balls[i].update();
      balls[i].draw();
    }
    
    fill(80);
    textFont(font, 28);
    text("How many balls do you see on screen?", 20, 60);

    textFont(font, 20);
    text("4 bouncing balls.", 60, 127);
    text("5 bouncing balls.", 60, 177);
    text("6 bouncing balls.", 60, 227);
    text("7 bouncing balls.", 60, 277);
    
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
            resultStr = "Wrong! there were 6 bouncing balls. Try the next one.";
            if (choices[2].checked) {
              resultStr = "Wrong! there were 5 bouncing balls. Try the next one.";
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
    return 2;
  }

  
}

class Screen3 extends Screen
{
  RadioButton choices[] = new RadioButton[4];
  boolean next;
  Ball balls[] = new Ball[7];
  
  public Screen3()
  {
    for (int i=0; i<4; i++) {
      choices[i] = new RadioButton(30, 120 + i*50);
    }
    
    for (int i=0; i<3; i++) {
      balls[i] = new Ball(random(width), random(height), color(255, 0, 0));
    }
    for (int i=3; i<7; i++) {
      balls[i] = new Ball(random(width), random(height), color(0, 0, 255));
    }
  }
  
  void draw()
  {
    background(230);
    
    for (int i=0; i<7; i++) {
      balls[i].update();
      balls[i].draw();
    }
    
    fill(80);
    textFont(font, 28);
    text("How many BLUE balls do you see on screen?", 20, 60);

    textFont(font, 20);
    text("2 balls.", 60, 127);
    text("3 balls.", 60, 177);
    text("4 balls.", 60, 227);
    text("5 balls.", 60, 277);
    
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
            resultStr = "Wrong! there were 5 BLUE balls. Try the next one.";
            if (choices[2].checked) {
              resultStr = "Wrong! there were 3 BLUE balls. Try the next one.";
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
    return 3;
  }

  
}

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

