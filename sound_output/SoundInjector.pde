int PLAY_SHH = 0;
int STOP_SHH = 1;
int PLAY_WAVE = 2;
int STOP_WAVE = 3;

class InjectorMessage
{
  long time;
  int task;
  
  public InjectorMessage(int task, long time)
  {
    this.task = task;
    this.time = time;
  }
}

class SoundInjector extends Thread
{
  AudioContext ac;
  ArrayList<InjectorMessage> msgs;
  
  boolean isRunning;
  
  public SoundInjector(AudioContext ac)
  {
    this.ac = ac;
    msgs = new ArrayList<InjectorMessage>();
  }
  
  public void addMessage(int task, long time)
  {
    long currentTime = System.currentTimeMillis();

    // put the message in the que to be handled by the thread
    msgs.add(new InjectorMessage(task, time));
  }
  
  public void run()
  {
    isRunning = true;
    while (isRunning)
    {
      ArrayList<InjectorMessage> toDelete = new ArrayList<InjectorMessage>();
      
      long time = System.currentTimeMillis();
      for (int i=0; i<msgs.size() ;i++)
      {
        InjectorMessage msg = msgs.get(i);
        if (msg.time <= time) {
          // handle the message
          handleMessage(msg.task);
          
          // mark the message for deletion
          toDelete.add(msg);
        }
      }
      
      for (InjectorMessage msg : toDelete)
      {
        msgs.remove(msg);
      }

      try {      
        Thread.sleep(20);
      }
      catch (Exception e) {}
    }
  }
  
  public void handleMessage(int task)
  {
      switch(task)
      {
        case 0:  // PLAY_SHH
          injectShh();
          println("injecting shh");
          break;
        
        case 1:  // STOP_SHH
          ambProc.activate();
          break;
        
        case 2:  // PLAY_WAVE
          println("injecting wave");
          injectWave();
          break;
          
        case 3:  // STOP_WAVE
          ambProc.activate();
          break;
      }
  }
  
  private void injectShh()
  {
    Noise noise = new Noise(ac);
//    noise.pause(true);
    
    // setup low-pass filter
    Envelope filterEnv = new Envelope(ac, 0.0);
    filterEnv.addSegment(0.05, 5000);
    filterEnv.addSegment(900, 5000);
    filterEnv.addSegment(2000, 100);
    filterEnv.addSegment(2000, 1000);
    filterEnv.addSegment(900, 100);
    filterEnv.addSegment(0.0, 5000);
    LPRezFilter filter = new LPRezFilter(ac, filterEnv, 0.9);
    filter.addInput(noise); 
    
    // setup gain evelope
    Envelope gainEnv = new Envelope(ac, 0.0);
    gainEnv.addSegment(0.1, 5000);
    gainEnv.addSegment(0.5, 5000);
    gainEnv.addSegment(0.05, 5000);
    gainEnv.addSegment(0.05, 10000);
    gainEnv.addSegment(0.0, 10000);
    Gain gain = new Gain(ac, 1, gainEnv);
    gain.addInput(filter);
    
    ac.out.addInput(gain);
  }
  
  private void injectWave()
  {
    Noise noise = new Noise(ac);
//    noise.pause(true);
    
    // setup low-pass filter
    Envelope filterEnv = new Envelope(ac, 0.0);
    filterEnv.addSegment(0.05, 5000);
    filterEnv.addSegment(900, 5000);
    filterEnv.addSegment(900, 100);
    filterEnv.addSegment(0.0, 5000);
    LPRezFilter filter = new LPRezFilter(ac, filterEnv, 0.9);
    filter.addInput(noise); 
    
    // setup gain evelope
    Envelope gainEnv = new Envelope(ac, 0.0);
    gainEnv.addSegment(0.1, 5000);
    gainEnv.addSegment(0.5, 5000);
    gainEnv.addSegment(0.05, 5000);
    gainEnv.addSegment(0.05, 10000);
    gainEnv.addSegment(0.0, 2000);
    Gain gain = new Gain(ac, 1, gainEnv);
    gain.addInput(filter);
    
    ac.out.addInput(gain);
  }
  
  
}

