
class SampleClip
{
  Sample sample;
  float start;
  float end;
  PVector pos;
  PVector size;
  PVector vel;
  float volume[];
  
  SamplePlayer sp;
  Gain gain;
  Glide rateValue;
  Glide posValue;
  
  boolean isPlaying;
  
  PlaybackLine pLine;
  
  boolean isPicked;
  
  int velChangeCounter = 1500;
  
  public SampleClip(AudioContext ac, PlaybackLine pLine, Sample s, float st, float e)
  {
    this.pLine = pLine;
    sample = s;
    start = st;
    end = e;
    float length = (end-start)/32;
    pos = new PVector(50, 30);
    vel = new PVector(1, 0);//random(0.2, 30), 0);
    size = new PVector(length, 30);
    isPlaying = false;
    
    sp = new SamplePlayer(ac, sample);
    sp.setPosition(start);
    sp.setKillOnEnd(false);
    gain = new Gain(ac, 1, 0.4f);
    gain.addInput(sp);
    
    rateValue = new Glide(ac, 0, 0);
    sp.setRate(rateValue);
    
    // get the volume for drawing
    volume = new float[(int)length];
    float[] frame = new float[1];
    for (int i=0; i<(int)length; i++)
    {
      s.getFrameCubic((int)map(i,0,(int)length, start, end), frame);
      volume[i] = frame[0];
    }
  }
  
  public void update()
  {
    pos.add(vel);
    
    checkBounds();
    
    // check for playback
    if (!isPlaying) {
      if (pos.x < pLine.x &&
          pos.x + size.x > pLine.x) {
        if (vel.x > 0) {
          sp.setToEnd();
          rateValue.setValue(-vel.x);
          sp.pause(false);
        }
        else {
          sp.setPosition(0);
          rateValue.setValue(vel.x*-1);
          sp.pause(false);
        }
        isPlaying = true;
      }
    }
    else {
      if (pos.x > pLine.x ||
          pos.x + size.x < pLine.x) {
        sp.pause(true);
        isPlaying = false;
      }
    }
  }
  
  public void randomize()
  {
    int s = (int)random(2, 7);
    vel.x = pow(s, 2);    
  }
  
  public void pause()
  {
    vel = new PVector(0, 0);
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    stroke(255);
    fill(150);
    rect(0, 0, size.x, size.y);
    
    stroke(50);
    if (isPlaying)
    {
      stroke(100, 255, 255);
      line(pLine.x-pos.x, 0, pLine.x-pos.x, size.y);
    }
   
    // draw the sample
    for (int i=1; i<volume.length; i++)
    {
      line(i, size.y/2-volume[i]*70, i, size.y/2+volume[i]*70);
    } 
    
    popMatrix();
  }
  
  public Gain getGain()
  {
    return gain;
  }
  
  private void checkBounds()
  {
    if (pos.x+size.x > width) {
      pos.x = width-size.x-1;
      vel.x *= -1;
    }
    else if (pos.x < 0) {
      pos.x = 0;
      vel.x *= -1;
    }
    
    if (pos.y+size.y > height) {
      pos.y = height-size.y-1;
      vel.y *= -1;
    }
    else if (pos.y < 0) {
      pos.y = 0;
      vel.y *= -1;
    }
  }
}
