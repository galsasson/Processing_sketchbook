
PFont font;
PFont fontSmall;

float textWidth;

int dpi = 600;
PVector paperSizeInch = new PVector(8.5, 11);
PVector cardSizeInch = new PVector(2, 2);


PVector paperSizePixels = PVector.mult(paperSizeInch, dpi);
PVector cardSizePixels = PVector.mult(cardSizeInch, dpi);
int cardsX = (int)(paperSizePixels.x/cardSizePixels.x);
int cardsY = (int)(paperSizePixels.y/cardSizePixels.y);

int pushLeft = (int)((paperSizePixels.x - (cardsX*cardSizePixels.x)) / 2);
int pushTop = (int)((paperSizePixels.y - (cardsY*cardSizePixels.y)) / 2);

void setup()
{
  size((int)paperSizePixels.x, (int)paperSizePixels.y);
//  smooth();
  
  font = loadFont("ShareTech-Regular-100.vlw");
  fontSmall = loadFont("ShareTech-Regular-80.vlw");
  
  noLoop();
  draw();
}

void draw()
{
//  translate(width/5, height/5);
//  scale(0.15);
  randomSeed(2);
  
  
  for (int i=0; i<11; i++)
  {
    background(255);
  
    pushMatrix();  
    translate(pushLeft, pushTop);
  
    for (int x=0; x<cardsX; x++)
    {
      for (int y=0; y<cardsY; y++)
      {
        drawFront(x*cardSizePixels.x, y*cardSizePixels.y);
        drawBack(x*cardSizePixels.x, y*cardSizePixels.y);
      } 
    }  
    String filename = "front" + i + ".png";
    save(filename);
    
    popMatrix();
  }
//  background(255);
//  for (int x=0; x<cardsX; x++)
//  {
//    for (int y=0; y<cardsY; y++)
//    {
//      drawBack(x*cardSizePixels.x, y*cardSizePixels.y);
//    } 
//  }  
//  save("back.png");
}

void drawFront(float x, float y)
{
  pushMatrix();
  translate(x, y);
  
  // draw outlines
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(0, 0, cardSizePixels.x, cardSizePixels.y);
  
  fill(200);
  stroke(200);
  
  textFont(font, 100);
  String str = "GAL  @  GALSASSON.COM";
  float dy = cardSizePixels.x/2 - textWidth(str)/2 + 100;
  text(str, cardSizePixels.x/2 - textWidth(str)/2, dy);
  
  textFont(fontSmall, 80);
  str = "1 646 512 1996";
  text(str, cardSizePixels.x/2 - textWidth(str)/2, cardSizePixels.y-dy+100);
  
  popMatrix();
}

void drawBack(float x, float y)
{
  pushMatrix();
  translate(x, y);
  
  // draw outlines
  noFill();
  stroke(0);
  strokeWeight(1);
  rect(0, 0, cardSizePixels.x, cardSizePixels.y);
  
  noFill();
  stroke(0);
  strokeWeight(5);
  
  int numberOfPoints = (int)random(10, 30);
  ArrayList<PVector> shape = getRandomShape(cardSizePixels.x - 600, cardSizePixels.y - 600, numberOfPoints);
  PVector center = getShapeCenter(shape);
  
  pushMatrix();
  translate(cardSizePixels.x/2, cardSizePixels.y/2);
  translate(-center.x, -center.y);
  beginShape();
  for (int i=0; i<shape.size(); i++)
  {
    vertex(shape.get(i).x, shape.get(i).y);
  }
  endShape();
  popMatrix();
  
  popMatrix();
}

ArrayList<PVector> getRandomShape(float w, float h, int pNum)
{
  ArrayList<PVector> shape = new ArrayList<PVector>();
  
  PVector point = new PVector(random(-w/2, w/2), random(-h/2, h/2));
  point.x += random(-10, 10);
  point.y += random(-10, 10);
  for (int i=0; i<pNum; i++)
  {
    shape.add(point.get());
    if (i%2 == 0) {
      point.x = random(-w/2, w/2);
      point.y += random(-10, 10);
    }
    else {
      point.y = random(-h/2, h/2);
      point.x += random(-10, 10);
    }
  }
  // close shape
  shape.add(shape.get(0).get());
  
  return shape;
}

PVector getShapeCenter(ArrayList<PVector> shape)
{
  float minX = 10000, minY = 10000, maxX = -10000, maxY = -10000;
  
  for (PVector p : shape)
  {
    if (p.x < minX) {
      minX = p.x;
    } else if (p.x > maxX) {
      maxX = p.x;
    }
    
    if (p.y < minY) {
      minY = p.y;
    } else if (p.y > maxY) {
      maxY = p.y;
    }
  }
  
  return new PVector((minX + maxX) / 2, (minY + maxY) / 2);
}

