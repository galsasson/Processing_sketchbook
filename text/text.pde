PFont arial10;

float roadWidth;
float houseWidth;

void setup()
{
  size(800, 400);
  frameRate(15);
  
  arial10 = loadFont("ArialHebrew-10.vlw");
  textFont(arial10, 10);
  String s = "כביש";
  roadWidth = textWidth(s);
  
  textFont(arial10, 16);
  s = "בית";
  houseWidth = textWidth(s);
}


void draw()
{
  background(255);
  fill(0);
  
  
  textFont(arial10,10);
  for (int y=0; y<100; y+=7)
    for (int x=0; x<width; x+=roadWidth)
    {
      text("כביש", x, 300+y);
    }
    
  textFont(arial10, 16);
  for (int y=0;y<200; y+=14)
    for (int x=0; x<3; x++)
    {
      text("בית", 50+x*(houseWidth+4), 100+y);
    }
}
