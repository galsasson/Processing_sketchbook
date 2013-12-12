import beads.*;
import java.net.*;
import java.io.*;


AudioContext ac;

UGen mic;
Gain inputGain;
AmbienceProcessor ambProc;
SoundInjector injector;
SentientReceiver emotionListener;

boolean fakeEmotion = true;

void setup()
{
  size(500, 500);
  frameRate(30);
  
  emotionListener = new SentientReceiver("128.122.151.163", "galtest2");
  emotionListener.start();
  
  ac = new AudioContext();
  
  mic = ac.getAudioInput();
  // the mic input gain is silent, we only listen to the mic
  inputGain = new Gain(ac, 1, 0);
  inputGain.addInput(mic);
  ac.out.addInput(inputGain);
  
  injector = new SoundInjector(ac);
  ambProc = new AmbienceProcessor(ac, mic);

  ac.start();
  ambProc.start();
  injector.start();
}

void draw()
{
  background(0);
  
  float amp = ambProc.getCurrentVolume();
  
  /* handle system emotions and trigger sounds accordingly */
  if (emotionListener.getCurrentEmotion().equals("Nervous")) 
  { 
    if (amp > 0.2) {
      ambProc.deactivate();
      injector.addMessage(PLAY_WAVE, System.currentTimeMillis());
      injector.addMessage(STOP_WAVE, System.currentTimeMillis()+20000);
    }
  }
  else if (emotionListener.getCurrentEmotion().equals("Agitated")) 
  { 
    if (amp > 0.2) {
      ambProc.deactivate();
      injector.addMessage(PLAY_SHH, System.currentTimeMillis());
      injector.addMessage(STOP_SHH, System.currentTimeMillis()+20000);
    }
  }

  ambProc.draw(0, height/2+10, width, height/2-20);
  
  drawWaveForm(0, 0, width, height/2);
}

void drawWaveForm(int x, int y, int w, int h)
{
  noFill();
  stroke(255);
  rect(x, y, w, h);
  
  loadPixels();
  //set the background
  //scan across the pixels
  for(int i = 0; i < w; i++)
  {
    // for each pixel, work out where in the current audio
    // buffer we are
    int buffIndex = i * ac.getBufferSize() / w;
    // then work out the pixel height of the audio data at
    // that point
    int vOffset = (int)((1 + mic.getValue(0, buffIndex)) *
                  h / 2);
    //draw into Processing's convenient 1-D array of pixels
    pixels[y*width + x + vOffset * height + i] = color(255);
  }
  // paint the new pixel array to the screen
  updatePixels();
}

float getMaxAmplitude()
{
  float max=-1000;
  
  for (int i=0; i<ac.getBufferSize(); i++)
  {
    float val = mic.getValue(0, i);
    if (abs(val) > max) {
      max = abs(val);
    }
  }
  
//  double a = Math.log10(1);
//  double b = Math.log10(0);
//  double lin = Math.log10(max);
//  println("a = " + a + ", b = " + b);
//  println(max + " = " + lin);
//  return (float)lin;
  return max;
}

