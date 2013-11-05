import beads.*;

AudioContext ac;

ArrayList players;
ArrayList gains;
ArrayList gainGlides;

Glide frequencyGlide;

float baseNote = 130.8;

void setup()
{
  size(500, 500);
  
  players = new ArrayList();
  gains = new ArrayList();
  gainGlides = new ArrayList();
  
  // initialize our AudioContext
  ac = new AudioContext();

  // create a WavePlayer
  // attach the frequency to frequencyGlide
  players.add(new WavePlayer(ac, baseNote, Buffer.SINE));
  players.add(new WavePlayer(ac, baseNote*2+(random(5)-2.5), Buffer.SINE));
  players.add(new WavePlayer(ac, baseNote*3+(random(10)-5), Buffer.SINE));
  players.add(new WavePlayer(ac, baseNote*4+(random(20)-10), Buffer.SINE));

  gainGlides.add(new Glide(ac, 0.0, 50));
  gainGlides.add(new Glide(ac, 0.0, 50));
  gainGlides.add(new Glide(ac, 0.0, 50));
  gainGlides.add(new Glide(ac, 0.0, 50));

  gains.add(new Gain(ac, 1, (Glide)gainGlides.get(0)));
  gains.add(new Gain(ac, 1, (Glide)gainGlides.get(1)));
  gains.add(new Gain(ac, 1, (Glide)gainGlides.get(2)));
  gains.add(new Gain(ac, 1, (Glide)gainGlides.get(3)));
  // create frequency glide object
  // give it a starting value of 20 (Hz)
  // and a transition time of 50ms
//  frequencyGlide = new Glide(ac, 20, 50);

  // create a Gain object
  // this time, we will attach the gain amount to the glide 
  // object created above

  // connect the WavePlayer output to the Gain input
  for (int i=0 ;i<players.size(); i++)
  {
    Gain g = (Gain)gains.get(i);
    WavePlayer wp = (WavePlayer)players.get(i);
    g.addInput(wp);

  // connect the Gain output to the AudioContext
    ac.out.addInput(g);
  }

  // start audio processing
  ac.start();

  background(0); // set the background to black
  text("The mouse X-Position controls volume.", 100, 100);
  text("The mouse Y-Position controls frequency.", 100, 120);
}

void draw()

{
  // update the gain based on the position of the mouse 
  // cursor within the Processing window
  ArrayList distances = new ArrayList();
  distances.add(sqrt(pow(mouseX, 2) + pow(mouseY, 2)));
  distances.add(sqrt(pow(width-mouseX, 2) + pow(mouseY, 2)));
  distances.add(sqrt(pow(width-mouseX, 2) + pow(height-mouseY, 2)));
  distances.add(sqrt(pow(mouseX, 2) + pow(height-mouseY, 2)));
  
  for (int i=0;i<4;i++)
  {
    Glide g = (Glide)gainGlides.get(i);
    float gain = 0;
    float distance = (Float)distances.get(i);
    if (distance<500) gain = (500 - distance) / 500;
    
    println(i + ": " + distance + "=" + gain);
    
    g.setValue((500 - (Float)distances.get(i)) / 500);
  }

  // update the frequency based on the position of the mouse 
  // cursor within the Processing window
//  frequencyGlide.setValue(261);
}



