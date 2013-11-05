import beads.*;

AudioContext ac;
String filePrefix = "data/synth_samples/samp";

//Sample s;
//
PlaybackLine pLine;
ArrayList<SampleClip> clips;

void setup()
{
  size(600, 450);
  smooth();
  frameRate(30);
  colorMode(HSB);
  
  ac = new AudioContext();

  pLine = new PlaybackLine(width/2);
  clips = new ArrayList<SampleClip>();
  
  for (int i=0; i<12; i++)
  {
    String filename = sketchPath(filePrefix + i + ".wav");
    try {
      Sample s = new Sample(filename);
      SampleClip sc = new SampleClip(ac, pLine, s, 0, s.getLength());
      sc.pos = new PVector(random(0, width), i*height/12);
      clips.add(sc);
      ac.out.addInput(sc.getGain());
    } catch (Exception e) {
      println("error loading file " + filename + ":" + e);
    }
  }
  
  ac.start();
}

void draw()
{
  background(60);
  
  pLine.draw();

  for (int i=0; i<clips.size(); i++) {
    clips.get(i).update();
    clips.get(i).draw();
  }
  
}

void keyPressed()
{
  if (keyCode == 32)
  {
    for (SampleClip sc : clips)
    {
      sc.pause();
    }
  }
  else if (keyCode == 82)
  {
    for (SampleClip sc : clips)
    {
      sc.randomize();
    }
  }
}
