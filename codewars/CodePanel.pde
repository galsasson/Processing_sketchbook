
int LINES = 27;

public class CodePanel
{
  PVector pos;
  PVector size;
  PVector cursorPos;
  ArrayList<String> lines;
  int viewY;
  
  PFont font;

  Cursor cursor;
  Turtle turtle;
  
  public CodePanel(float x, float y, float w, float h)
  {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    font = loadFont("Inconsolata-14.vlw");
    
    viewY = 0;
    
    lines = new ArrayList<String>();
    
    lines.add(new String("Welcome to space, good luck!"));
    lines.add(new String("? "));
    cursorPos = new PVector(2, 1);
    PVector screenPos = getCursorScreenPos(cursorPos); 
    cursor = new Cursor(screenPos.x, screenPos.y);
  }
  
  public void setTurtle(Turtle t)
  {
    turtle = t;
  }
  
  private PVector getCursorScreenPos(PVector c)
  {
    textFont(font, 14);
    
    int end;
    if ((int)cursorPos.x > lines.get((int)cursorPos.y).length())
      end = lines.get((int)cursorPos.y).length();
    else
      end = (int)cursorPos.x;
      
    float x = 10 + textWidth(lines.get((int)cursorPos.y).substring(0, end));
    
    float y = 20 + (cursorPos.y - viewY)*14;
    
    return new PVector(x, y);
  }
  
  public void keyPressed(int keyCode)
  {
    if ((keyCode >= 48 && keyCode <= 90) ||
        keyCode == 32)
    {
      char[] k = new char[1];
      k[0] = (char)keyCode;
      String kString = new String(k);
      
      // add char to cursor position
      String l = lines.get((int)cursorPos.y);
      
      String start = l.substring(0, (int)cursorPos.x);
      String end = l.substring((int)cursorPos.x, l.length());
      
      lines.set((int)cursorPos.y, start + kString + end);
      cursorPos.x++;
    }
    else if (keyCode == 8)  // backspace
    {
      if (cursorPos.x > 2)
      {
        String l = lines.get((int)cursorPos.y);
        String start = l.substring(0, (int)cursorPos.x);
        String end = l.substring((int)cursorPos.x, l.length());
        
        start = start.substring(0, start.length()-1);
        lines.set((int)cursorPos.y, start + end);
        cursorPos.x--;
      }
    }
    else if (keyCode == 13 || keyCode == 10)  // enter
    {
      // send the current line to the turtle
      String str = lines.get((int)cursorPos.y);
      turtle.processString(str.substring(2, str.length()));
      
      if (cursorPos.y == lines.size()-1)
      {
        lines.add(new String("? "));
        cursorPos.y++;
        cursorPos.x = 2;
      }
    }
    else if (keyCode == 37)  // left
    {
      if (cursorPos.x > 2)
        cursorPos.x--;
      else if (cursorPos.y > 1)
      {
        cursorPos.y--;
        cursorPos.x = lines.get((int)cursorPos.y).length();
      }
    }
    else if (keyCode == 38)  // up
    {
      if (cursorPos.y > 1)
        cursorPos.y--;
      if (cursorPos.x > lines.get((int)cursorPos.y).length())
        cursorPos.x = lines.get((int)cursorPos.y).length();
    }
    else if (keyCode == 39)  // right
    {
      if (cursorPos.x < lines.get((int)cursorPos.y).length())
        cursorPos.x++;
      else
      {
        if (cursorPos.y < lines.size()-1)
        {
          cursorPos.y++;
          cursorPos.x = 2;
        }
      }
    }
    else if (keyCode == 40)  // down
    {
      if (cursorPos.y < lines.size()-1)
      {
        cursorPos.y++;
        if (cursorPos.x > lines.get((int)cursorPos.y).length())
          cursorPos.x = lines.get((int)cursorPos.y).length();
      }
    }
    
      
    if (cursorPos.y > viewY+LINES-1)
      viewY++;
    else if (cursorPos.y < viewY+1)
      viewY--;
      
    cursor.setPos(getCursorScreenPos(cursorPos));
    println(keyCode);
  }
  
  public void update()
  {
    cursor.update();
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(50);
    strokeWeight(2);
    noFill();
    rect(0, 0, size.x, size.y);
    
    fill(50);
    textFont(font, 14);
    for (int i=0, l=viewY; i<LINES && l<lines.size(); i++, l++)
      text(lines.get(l), 10, 20 + i*14);
    
    cursor.draw();
    
    popMatrix();
  }
}
