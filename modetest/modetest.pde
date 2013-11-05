
int tmpArray[] = {1, 2, 3, 4};

void setup()
{
  int setupArray[][] = {{9, 8}, {7, 6}};
  size(480, 200);
  colorMode(RGB, 255, 255, 255);
  background(90, 19, 93);
  noStroke();
}

void draw()
{
  background(0);
  float size = random(54.4, 72.2);
  
  int tmpArrayLocal[] = {4, 3, 2, 1}; 
  
  strokeWeight(5);
  // comment comment 5.4 comment comment
  color a = color(#0dc646);
  stroke(a, 141);
  fill(66, 96, 133, 255);
  ellipse(268.2, 78, size*2.1, size*2.1);

  stroke(#258adf);
  color c = color(0xa8);
  fill(c);
  ellipse(268, 77, size*0.8, size*0.8);
  
  fill(0x8810efb3, 255);
  stroke(196, 37, 37);
  ellipse(268, 77, size*1.3, size*1.3);
}


