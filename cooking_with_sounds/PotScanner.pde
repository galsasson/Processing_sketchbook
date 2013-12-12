
class PotScanner
{
  Pot pot;
  AudioContext ac;
  WavePlayer[] wps;
  Gain[] gains;
  Glide[] gainGlides;
  boolean[] active;
  int size;
  
  public PotScanner(Pot pot, AudioContext ac)
  {
    this.pot = pot;
    this.ac = ac;
    
    size = ((int)pot.pos.y - ((int)pot.pos.y-(int)pot.size.y/2+10)) / 2; 
    wps = new WavePlayer[size];
    gainGlides = new Glide[size];
    gains = new Gain[size];
    active = new boolean[size];
    for (int i=0; i<size; i++)
    {
      wps[i] = new WavePlayer(ac, map(i,0,size,50,1400), Buffer.SINE);
      gainGlides[i] = new Glide(ac, 0.0, 50);
      gains[i] = new Gain(ac, 1, gainGlides[i]);
      gains[i].addInput(wps[i]);
      ac.out.addInput(gains[i]);
      active[i] = false;
    }
  }
  
  public void scan()
  {
    loadPixels();
    stroke(0);
    
    int x = (int)pot.pos.x;
    int yStart = (int)pot.pos.y-(int)pot.size.y/2+10;
    for (int i=0; i<size; i++)
    {
      int p = pixels[x + (yStart+i*2)*width];
      if (red(p) != 230) {
        if (!active[i]) {
          gainGlides[i].setValue(0.03f);
          active[i] = true;
        }
      }
      else if (active[i]) {
        gainGlides[i].setValue(0.0f);
        active[i] = false;
      }
      
      strokeWeight(0.5);
      stroke(10, 10, 10);
      point(x, yStart+i*2);    
    }

  }
}
