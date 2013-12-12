import beads.*;
import java.net.*;
import java.io.*;

AudioContext ac;

UGen mic;
SentientSender sender;

void setup()
{
  size(500, 500);
  frameRate(30);
  
  sender = new SentientSender("128.122.151.163", 5000);
  sender.startSession("ptest4");
  
  ac = new AudioContext();
  
  mic = ac.getAudioInput();
  ac.out.addInput(mic);
  ac.start();
}

float max=-1000;
float min=1000;

void draw()
{
  background(0);
  
  float amp = getMaxAmplitude();
  sender.addNewData((int)(amp*100));
  fill(255);
  float y = map(amp, 0, 1, height, 0);
  ellipse(width/2, y, 20, 20);
  
  drawWaveForm();
  //println(amp);
}

void drawWaveForm()
{
  loadPixels();
  //set the background
  //scan across the pixels
  for(int i = 0; i < width; i++)
  {
    // for each pixel, work out where in the current audio
    // buffer we are
    int buffIndex = i * ac.getBufferSize() / width;
    // then work out the pixel height of the audio data at
    // that point
    int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) *
                  height / 2);
    //draw into Processing's convenient 1-D array of pixels
    pixels[vOffset * height + i] = color(255);
  }
  // paint the new pixel array to the screen
  updatePixels();
}

float getMaxAmplitude()
{
  float max=-1000;
  
  for (int i=0; i<ac.getBufferSize(); i++)
  {
    float val = ac.out.getValue(0, i);
    if (abs(val) > max) {
      max = abs(val);
    }
  }
  
  return max;
}

