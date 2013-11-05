import themidibus.*;

MidiBus myBus;

int channel = 0;
int pitch = 40;
int velocity = 127;

int[] orientalPitches = {36, 37, 40, 41, 42, 45, 46, 48};
int[] orientalScale = {0, 1, 4, 5, 6, 9, 10};

void setup()
{
  size(400, 400);
  frameRate(60);
  
  MidiBus.list();
  
  myBus = new MidiBus(this, 0, 0);
}

void draw()
{
  background(0);
}

void mousePressed()
{
  
  pitch = mouseY%orientalPitches.length;
  myBus.sendNoteOn(channel, orientalPitches[pitch], velocity);
}

void mouseReleased()
{
  myBus.sendNoteOff(channel, orientalPitches[pitch], velocity);
}

