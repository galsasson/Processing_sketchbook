

class AmbienceProcessor extends Thread
{
  boolean isRunning;
  
  AudioContext ac;
  UGen mic;
  boolean micActive;
  
  CircularBuffer volumeBuffer;
  
  public AmbienceProcessor(AudioContext ac, UGen mic)
  {
    this.ac = ac;
    this.mic = mic;
    micActive = true;
    
    volumeBuffer = new CircularBuffer(25, 0);
  }
  
  public void run()
  {
    isRunning = true;
    
    while (isRunning)
    {
      // check current mic volume
      if (micActive) {
        volumeBuffer.write(getMaxVolume());
      }
      else {
        volumeBuffer.write(0);
      }

      try {
        Thread.sleep(20);
      }
      catch(Exception e) {}
    }
  }
  
  public void deactivate()
  {
    micActive = false;
    volumeBuffer.clear();  
  }
  
  public void activate()
  {
    micActive = true;
  }
  
  public float getCurrentVolume()
  {
    return volumeBuffer.getAvg();
  }
  
  private float getMaxVolume()
  {
    float max = 0;
    
    for (int i=0; i<ac.getBufferSize(); i++)
    {
      float val = mic.getValue(0, i);
      if (abs(val) > max) {
        max = abs(val);
      }
    }
    
    return max;
  }
  
  public void draw(float x, float y, float w, float h)
  {
    fill(100);
    float level = map(getCurrentVolume(), 0, 1, 0, h);
    rect(x, y+h-level, w, level);
    noFill();
    stroke(255);
    line(x, y+h, x+w, y+h);
    line(x, y, x+w, y);
//    ellipse(width/2, y, 20, 20);
  }
}
