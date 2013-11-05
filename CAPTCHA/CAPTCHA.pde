
Nail[] n = new Nail[20];

ArrayList<Nail> stream;

void setup()
{
  size(1280, 800);
  smooth();

  stream = new ArrayList<Nail>();
  frameRate(60);
}

void draw()
{
//  translate(width/2, height/2);
//  scale((float)mouseY/height, (float)mouseY/height);
  background(0);
  
  if (frameCount % 10 == 0)
  {
  for (int i=0; i<8; i++)
  {
    stream.add(new Nail(30 /*+(int)random(20)*/, height/2 - i*20, 12));
  }
  }
  
  ArrayList<Nail> toDelete = new ArrayList<Nail>();
  
  for (Nail n : stream)
  {
    n.update();
    n.draw();
    if (!n.verifyBounds()) {
      toDelete.add(n);
    }
  }
  
  for (int i=0; i<toDelete.size(); i++)
  {
    Nail n = toDelete.get(i);
    stream.remove(n);
  }
}
