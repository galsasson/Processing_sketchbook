import processing.core.*; 
import processing.xml.*; 

import themidibus.*; 

import themidibus.*; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class miditype2 extends PApplet {

 //Import the library

MidiBus myBus; // The MidiBus

int[] keys;

Piece piece;

int state = 0;

public void setup() {
  size(400,200);
  smooth();
  background(10);
  frameRate(30);
  
  keys = new int[91];
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  
  piece = new Piece();
    
}

public void draw() {
    background(240);
    
    if (state==0)
    {
      textSize(16);
      fill(0xff0a0a0a);
      text("Press space to start", width/2 - 
            textWidth("Press space to start")/2, 100);
    }
    else if (state==1)
    {
      piece.draw();
    }
}

public void keyPressed()
{
  if (state == 0)      // before start
  {
    if (keyCode==32)
          state=1;
  }
  else if (state==1)  // running
  {
    if (keyCode>90) return;
  
    if (keys[keyCode]==0) {
          int pitch = piece.getNotePitch(keyCode);
          println("pitch = " + pitch);
  	  myBus.sendNoteOn(0, pitch, 100); // Send a Midi noteOn
          keys[keyCode]=pitch;
    }
  }
    
  println((int)keyCode);
}

public void keyReleased()
{
  if (state==0)
  {
  }
  else if (state==1)
  {
    if (keyCode>90) return;
  
    if (keys[keyCode] > 0) {
    	  myBus.sendNoteOff(0, keys[keyCode], 100); // Send a Midi noteOff
          keys[keyCode]=0;
    }
  }
  
}

class Piece
{
  ArrayList notes;
  String typeString;
  float phraseWidth;
  int typeCounter;
  
  PFont font;
  
  ArrayList balls;
  
  Piece()
  {
    font = loadFont("Serif-24.vlw");
    textFont(font, 24);
    
    int[] notesArr = {41, 36, 41, 36, 41, 36, 41, 45, 48,
                      46, 43, 46, 43, 46, 43, 40, 43, 36};
    int[] timesArr = {6, 2, 6, 2, 2, 2, 2, 2, 16,
                      6, 2, 6, 2, 2, 2, 2, 2, 16};

    setupSong(notesArr, timesArr);
  }
  
  public int getNotePitch(int kCode)
  {
    int nextCode = getKeyCode(typeString.charAt(typeCounter));
    
    if (nextCode == kCode) {
      Note note = (Note)notes.get(typeCounter);
      if (typeCounter < notes.size()-1)
              typeCounter++;
      return note.pitch;
    }
    else {
      return 80;
    }
  }
  
  public void setupSong(int[] notesArr, int[] timesArr)
  {
    notes = new ArrayList();
    balls = new ArrayList();
    
    typeString = "play this if you can";
    phraseWidth = textWidth(typeString);
    typeCounter = 0;
    
    for (int i=0; i<notesArr.length; i++)
    {
      notes.add(new Note(notesArr[i], timesArr[i]*75+2000));
      PVector charPos = getCharAtPosition(i);
      balls.add(new Ball(charPos.x, charPos.y, timesArr[i]*75+2000));
    }
    
  }
  
  public void draw()
  {
    pushMatrix();
    
    textSize(24);
    strokeWeight(2);
    translate(30, height/2);
    
    // draw already typed
    String str = typeString.substring(0, typeCounter);
    if (textWidth(str) > 0)
    {
      fill(0xff888888);
      stroke(0xff888888);
      text(str, 0, 0);
      line(0, 5, textWidth(str), 5);
    }
    
    // draw rest of phrase
    String str2 = 
          typeString.substring(typeCounter, typeString.length());
    if (textWidth(str2) > 0)
    {
      fill(0xff0a0a0a);
      stroke(0xff0a0a0a);
      text(str2, textWidth(str), 0);
      line(textWidth(str), 5, textWidth(typeString), 5);      
    }
    
    // draw balls
    for (int i=0; i<balls.size(); i++)
    {
      Ball ball = (Ball)balls.get(i);
      ball.tick(33);
      //ball.draw();
    }
 
    popMatrix();
  }

  private PVector getCharAtPosition(int at)
  {
    PVector charPosition = new PVector();
    
    String firstStr = typeString.substring(0, at);
    String secondStr = typeString.substring(0, at+1);
    charPosition.x = -phraseWidth/2 +
                      (textWidth(secondStr)+textWidth(firstStr)) / 
                      2 + 5;
                      
    charPosition.y = 60;
    
    return charPosition;
  }
  
  private int getKeyCode(char ch)
  {
    switch(ch)
    {
      case ' ':
        return 32; // ????
      case 'a':
        return 65;
      case 'b':
        return 66;
      case 'c':
        return 67;
      case 'd':
        return 68;
      case 'e':
        return 69;
      case 'f':
        return 70;
      case 'g':
        return 71;
      case 'h':
        return 72;
      case 'i':
        return 73;
      case 'j':
        return 75;
      case 'k':
        return 75;
      case 'l':
        return 76;
      case 'm':
        return 77;
      case 'n':
        return 78;
      case 'o':
        return 79;
      case 'p':
        return 80;
      case 'q':
        return 81;
      case 'r':
        return 82;
      case 's':
        return 83;
      case 't':
        return 84;
      case 'u':
        return 85;
      case 'v':
        return 86;
      case 'w':
        return 87;
      case 'x':
        return 88;
      case 'y':
        return 89;
      case 'z':
        return 90;
    }
    
    return -1;
  }  
}

class Ball
{
  float positionX, positionY;
  float velocityX, velocityY;
  float accelX, accelY;
  float mass;
  
  float targetX, targetY;
  float time;
  
  Ball(float targetX, float targetY, long timeMs)
  {
    this.targetX = targetX;
    this.targetY = targetY;
    this.time = (float)timeMs/1000;
    
    // calculate
    mass = 10;
    accelX = 0;
    accelY = mass*-10;
    
    positionX = targetX;
    positionY = targetY - accelY*pow(time, 2);
    
    println("positonY["+timeMs+"] = "+positionY);
  }
  
  public void tick(long timeElapsedMs)
  {
    float timeElapsed = (float)timeElapsedMs/1000;
    positionX = targetX;
    
    positionY = positionY +
                 velocityY*timeElapsed +
                 accelY*pow(timeElapsed, 2);
                
    velocityY = velocityY + accelY*timeElapsed;
    
    if (positionY<targetY) positionY = targetY;
  }
  
  public void draw()
  {
    fill(0x66ffffff);
    stroke(0x99ffffff);
    
    pushMatrix();
    translate(positionX, positionY);
    ellipse(-5, -5, 10, 10);
    
    popMatrix();
  }
}

class Note
{
  int pitch;
  long time;
  
  Note(int pitch, long time)
  {
    this.pitch = pitch;
    this.time = time;
  }  
}

  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#FFFFFF", "miditype2" });
  }
}
