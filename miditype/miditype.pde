import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

int[] keys;

int[] notes;

Piece piece;

String typeString = "where is your cat";
int typeCoutner = 0;

void setup() {
  size(400,400);
  background(0);
  frameRate(30);
  
  keys = new int[91];
  notes = new int[123];
  
  
  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.
  
  piece = new Piece();
    
}

void draw() {
    
}

void keyPressed()
{
  if (keyCode>90) return;
  
  if (keys[keyCode]==0) {
        int pitch = piece.getNotePitch(millis()-5000, keyCode);
        println("pitch = " + pitch);
  	myBus.sendNoteOn(0, pitch, 100); // Send a Midi noteOn
        keys[keyCode]=1;
  }
    
  println((int)keyCode);
}

void keyReleased()
{
  if (keyCode>90) return;
  
  if (keys[keyCode] == 1) {
  	myBus.sendNoteOff(0, 0, 100); // Send a Midi noteOff
        keys[keyCode]=0;
  }
  
}

class Piece
{
  ArrayList notes;
  
  Piece()
  {
    notes = new ArrayList();
    
    setupSong();
  }
  
  public int getNotePitch(long time, int kCode)
  {
    if (time<0) return -1;
    
    long closest = 9999999;
    int notePitch = -1;
    
    for (int i=0; i<notes.size(); i++)
    {
      Note note = (Note)notes.get(i);
      if (abs(note.start - time) <= closest)
      {
        closest = (long)abs(note.start - time);
        notePitch = note.pitch;
      }
      else
          break;
    }
    
    return notePitch;
  }
  
  public void setupSong()
  {
    notes.add(new Note(41, 84,  0, 600));
    notes.add(new Note(36, 67, 900, 300));
    notes.add(new Note(41, 84, 1200, 600));
    notes.add(new Note(36, 86, 2100, 300));
    notes.add(new Note(41, 75, 2400, 300));
    notes.add(new Note(36, 76, 2700, 300));
    notes.add(new Note(41, 75, 3000, 300));
    notes.add(new Note(45, 68, 3300, 300));
    notes.add(new Note(48, 73, 3600, 600));
  }
  
  public void draw()
  {
    pushMatrix();
    
    translate(150, 150);
    
    
    popMatrix();
  }
}

class Note
{
  int pitch;
  int kCode;
  long start;
  long end;
  
  Note(int pitch, int kCode, long start, long duration)
  {
    this.pitch = pitch;
    this.kCode = kCode;
    this.start = start;
    this.end = start + duration;
  }  
}

