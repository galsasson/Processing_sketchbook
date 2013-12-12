import beads.*;

AudioContext ac;

PLine line = null;
ArrayList<PLine> allLines = null;
Pot pot;
SineMaker sineMaker;
Tool tool;
PotScanner scanner;

int mode = 0;
SampleMaker sampleMaker = null;

void setup()
{
  size(800,800);
  smooth();
  
  ac = new AudioContext();
  
  allLines = new ArrayList<PLine>();
  pot = new Pot(width/2, height/2, 500, 500);
  tool = new Tool(440, pot.pos);
  scanner = new PotScanner(pot, ac);
  
  ac.start();
}

void draw()
{
  background(230, 230, 230);
  
  // tool
  tool.setPos(mouseX, mouseY);
  tool.draw(mode);
  
  // pot
  pot.updateLines(allLines);
  pot.updateSamples();
  pot.draw();
  
  // draw lines
  for (PLine line : allLines)
  {
    line.draw();
  }
  
  // draw current line
  if (line != null)
  {
    pot.pullVerts(line);
    pot.rotateVerts(line);
    line.draw();
  }
  
  // draw sample maker
  if (sampleMaker != null)
  {
    sampleMaker.update();
    sampleMaker.draw();
  }
  
  // handle pot scanner
  scanner.scan();
  
  // handle mouse
  if (mousePressed)
  {
    if (mode==0)
    {
      if (line == null)
      {
        float freq = map(mouseY, 0, height, 50, 1400);
        line = new PLine(map(freq, 50, 1400, pot.size.x/2-12, 30));
        sineMaker = new SineMaker(mouseX, mouseY, pot.pos, freq);  // tweak[50,800]
      }
      sineMaker.update(line);
    }
    else if (mode==1)
    {
      if (sampleMaker == null)
      {
        sampleMaker = new SampleMaker(mouseX, mouseY, ac);
        sampleMaker.start();
      }
    }
  }
}

void mouseReleased()
{
  if (mode == 0)
  {
    if (line != null)
    {
      allLines.add(line);
      line = null;
      sineMaker = null;
    }
  }
  else if (mode == 1)
  {
    // take sample from SampleMaker and attach to pot
    sampleMaker.stop();
    pot.takeSample(sampleMaker);
    sampleMaker = null;
  }
}

void mouseDragged()
{
  if (mode==0)
  {
    if (sineMaker != null)
    {
      sineMaker.setPos(mouseX, mouseY);
    }
  }
  else if (mode==1)
  {
    if (sampleMaker != null)
    {
      sampleMaker.setPos(mouseX, mouseY);
    }
  }
}

void keyPressed()
{
  if (key == '1') {
    mode = 0;
  }
  else if (key == '2') {
    mode = 1;
  }
  else if (key == 'z') {
    if (allLines.size() > 0) {
      allLines.remove(0);
    }
  }
  else if (key == 'x') {
    pot.removeOneSample();
  }
  else if (keyCode == 32)
  {
    allLines.clear();
    pot.clearSamples();
  }
}
