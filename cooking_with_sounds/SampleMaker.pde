import javax.sound.sampled.AudioFormat;

class SampleMaker
{
  AudioContext ac;
  Sample sample;
  AudioFormat af;
  RecordToSample rts;
  float length;
  PVector pos;
  float prevX;
  
  public SampleMaker(float x, float y, AudioContext ac)
  {
    pos = new PVector(x, y);
    this.ac = ac;
    try {
      af = new AudioFormat(44100.0f, 16, 1, true, true);
      sample = new Sample(af, 44100);
      rts = new RecordToSample(ac, sample, RecordToSample.Mode.INFINITE);
      rts.pause(true);
    }
    catch (Exception e) {
      println("error creating new sample");
    }
    
    rts.addInput(ac.getAudioInput());
    ac.out.addDependent(rts);
    
    length = 0;
  }
  
  public void setPos(float x, float y)
  {
    pos.x = x;
    pos.y = y;
  }
  
  public void play()
  {
    SamplePlayer sp = new SamplePlayer(ac, sample);
    ac.out.addInput(sp);
    sp.start();
  }
  
  public void start()
  {
    rts.start();
  }
  
  public void stop()
  {
    rts.pause(true);
  }
  
  public Sample getSample()
  {
    return sample;
  }
  
  public void update()
  {
    length += 0.1;
  }
  
  public void draw()
  {
    pushMatrix();
    translate(pos.x, pos.y);
    
    noStroke();
    fill(200, 50, 50);
    ellipse(0, 0, length, length);
    
    popMatrix();
  }
  
}
