import beads.*;

AudioContext ac;
String filePrefix = "data/synth_samples/samp";

//Sample s;
//
PlaybackLine pLine;
ArrayList<SampleClip> clips;
ArrayList<Filter> filters;

int filterRate = 50; 

void setup()
{
  size(600, 600);
  smooth();
  frameRate(30);
  colorMode(HSB, 360, 255, 255);
  
  ac = new AudioContext();

  pLine = new PlaybackLine(width/2);
  clips = new ArrayList<SampleClip>();
  filters = new ArrayList<Filter>();
  
  for (int i=0; i<12; i++)
  {
    String filename = sketchPath(filePrefix + i + ".wav");
    try {
      Sample s = new Sample(filename);
      SampleClip sc = new SampleClip(ac, pLine, s, 0, s.getLength());
      sc.pos = new PVector(0, i*((height-100)/12)+100);//new PVector(random(0, width), i*height/12);
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

  ArrayList<Filter> filtersToDelete = new ArrayList<Filter>();
  
  for (int i=0; i<clips.size(); i++) {
    // check if filters overlap with sample clips
    for (Filter f : filters)
    {
      if (clips.get(i).contains(f.pos.x, f.pos.y)) {
        // apply the filter to this sample clip
        clips.get(i).applyFilter(f);
        filtersToDelete.add(f);
      }
    }
    
    clips.get(i).update();
    clips.get(i).draw();
  }
  
  // create new filters
  if (frameCount%filterRate == 0) {
    filters.add(new Filter(random(width), 0));
  }
  
  for (Filter f : filters)
  {
    if (f.update()) {
      f.draw();
    }
    else {
      filtersToDelete.add(f);
    }
  }
  
  for (int i=0; i<filtersToDelete.size(); i++)
  {
    filters.remove(filtersToDelete.get(i));
  }
}

void keyPressed()
{
  println(keyCode);
  
  if (keyCode == 32)
  {
    for (SampleClip sc : clips)
    {
      sc.pause();
    }
  }
  else if (keyCode == 82)  // r
  {
    for (SampleClip sc : clips)
    {
      sc.randomize();
    }
  }
  else if (keyCode == 70) // f
  {
    filterRate -= 1;
  }
//  else if (keyCode
}
