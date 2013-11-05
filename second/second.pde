/* @pjs preload="screen2.png"; */


int startX = 50;
int startY = 50;

int resolutionX = 50;
//int resolutionY = 40;

float scaleX = 1;
float scaleY = 1;

Stage stage;

void setup()
{
  size(900,600);
  smooth();
frameRate(5);
  //noLoop();

  stage = new Stage("DSC_0020.JPG"); // חזק
  //stage = new Stage("DSC_0181.JPG");
//  stage = new Stage("youtube.png");
}

void draw()
{
  background(12);
  
  pushMatrix();
  translate(startX, startY);
  scale(scaleX, scaleY);
  
  stage.draw();
  popMatrix();
  //stage.tick();
}


void keyPressed()
{
  scaleX /= 2;
  scaleY /= 2;
  //scale(scaleX, scaleY);
  //draw();
  //stage.tick();
}

class Stage
{
  PImage img;
  PImage textureImg;
  ArrayList linesStart;
  int curveLength = 15;
  int stageWidth = resolutionX;
//  int stageHeight = resolutionY;
  
  int position;
  
  public Stage(String imageFile)
  {
    img = loadImage(imageFile);
    makeLowRes();
    
    textureImg = loadImage("texture.png");
    
    position = 0;
    
    linesStart = new ArrayList();
    for (int i=0 ; i<img.height; i++)
    {
      int begin = 0;
      if (i%2==1) begin = 9;
      linesStart.add(begin + random(2));
    }

  }
  
  private void makeLowRes()
  {
    /* scale down the image */
    float xScale = (float)resolutionX / img.width;
    if (xScale<1) 
    {
      float ySize = xScale*2*img.height;
      println("xScal = " + xScale + ", ySize = " + ySize);
      img.resize(resolutionX, (int)(xScale*2*img.height));
    }
    
    println("image = " + img.width +"x" + img.height);
    
    float threshold = 60;
    for (int j=0; j<img.height; j++)
    {
      color lastColor = img.get(0, j);
//      int colorCounter = 0;
      for (int i=1; i<img.width; i++)
      {
        color cColor = img.get(i, j);
        float diff = sqrt(
                      (float)pow(red(cColor)-red(lastColor),2) +
                      (float)pow(green(cColor)-green(lastColor),2) +
                      (float)pow(blue(cColor) - blue(lastColor),2));
        print("diff = " + diff + " ");
        if (/*colorCounter>=2 &&*/ diff > threshold) 
        {
          lastColor = cColor;
//          colorCounter=0;
        }

        img.set(i, j, lastColor);
//        colorCounter++;        
      }
      println("");
    }
    
    
    
  }
  
  public void tick()
  {
    position++;
  }
  
  public void draw()
  {
    float lineStart;
    float x;
    int y;
  
    println("start draw = " + millis());
  
    noFill(); 
  
    /* even horizontal lines */
    strokeWeight(7);
    for (int j=0; j<img.height; j+=2)
    {
      lineStart = (Float)linesStart.get(j);
      y = j*7;
    
      for (int i=0; i<stageWidth; i++)
      {
        stroke(img.get(i+position, j));
        x = lineStart + i*curveLength;
        bezier(x, y, 
               x + 3, y - 3, 
               x + 7, y - 3,
               x + 10, y);
      }
    }
  
    /* vertical strings */
    strokeWeight(0.8);
    stroke(240, 240, 240, 170);
    for (int i=1; i<stageWidth+1; i++)
    {
      line(i*curveLength, 0,
           i*curveLength, 7*img.height);
    }
  
    /* odd horizontal lines */
    strokeWeight(7);
    for (int j=1; j<img.height; j+=2)
    {
      lineStart = (Float)linesStart.get(j);
      y = j*7;
    
      for (int i=0; i<stageWidth; i++)
      {
        stroke(img.get(i+position, j));
        strokeWeight(7);
        x = lineStart + i*curveLength;
        bezier(x, y, 
               x + 3, y - 3, 
               x + 7, y - 3,
               x + 10, y);
      
        if (i==0) continue;
      
        stroke(240, 240, 240, 170);
        strokeWeight(0.8);
        line(x-curveLength-3, y-4, x-curveLength-3, y+3);
      }
    }
    
    tint(255, 110);
    image(textureImg, 0, -5, stageWidth*curveLength+5, img.height*7+2);
  
    println("end draw = " + millis());
  }
  
}



