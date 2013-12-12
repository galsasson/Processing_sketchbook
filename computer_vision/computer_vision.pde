
import processing.video.*;

int numPixels;
Capture video;
int[] backgroundPixels;
int[] oldBackDiff;
PImage backDiff;
//PImage movementImg;

PVector pos;

int videoWidth = 320;
int videoHeight = 240;
int rightLine = videoWidth-videoWidth/4;
int leftLine = videoWidth/4;
int topLine = videoHeight/2;
int bottomLine = videoHeight;

VideoBox videoBox;

float moveFactor = 0.45;

void setup() {
  size(videoWidth*3, videoHeight*3);
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, videoWidth, videoHeight);
  backDiff = new PImage(videoWidth, videoHeight, ALPHA);
//  movementImg = new PImage(videoWidth, videoHeight, ALPHA);
  
  // Start capturing the images from the camera
  video.start();
  
  numPixels = video.width * video.height;
  // Create an array to store the previously captured frame
  backgroundPixels = new int[numPixels];
  oldBackDiff = new int[numPixels];
//  loadPixels();

  videoBox = new VideoBox(width/2, height-100, video, backDiff);
}

void draw() {
  background(255);
  
//  video.mask(backDiff);
//
//  // mirrot the video
//  pushMatrix();
//  scale(-1, 1);
//  image(video, -videoWidth, 0);
//  popMatrix();
  
//  image(backDiff, videoWidth, 0);
//  image(movementImg, videoWidth*2, 0);
  
  videoBox.update();
  videoBox.draw();
}


void captureEvent(Capture c)
{
  c.read();
  c.loadPixels();
  backDiff.loadPixels();
//  movementImg.loadPixels();
  
  int rightMovement=0;
  int leftMovement=0;

  for (int y=0; y<videoHeight; y+=1)
  {
    for (int x=0; x<videoWidth; x+=1)
    {
      int i = x + y*videoWidth;
//      int ii = x/2 + (y/2)*(videoWidth/2);
      color currColor = video.pixels[i];
      color backColor = backgroundPixels[i];
      // Extract the red, green, and blue components from current pixel
      int currR = (currColor >> 16) & 0xFF; // Like red(), but faster
      int currG = (currColor >> 8) & 0xFF;
      int currB = currColor & 0xFF;
      // Extract red, green, and blue components from previous pixel
      int prevR = (backColor >> 16) & 0xFF;
      int prevG = (backColor >> 8) & 0xFF;
      int prevB = backColor & 0xFF;
      // Compute the difference of the red, green, and blue values
      int diffR = abs(currR - prevR);
      int diffG = abs(currG - prevG);
      int diffB = abs(currB - prevB);

      int diffSum = diffR + diffG + diffB;
      
      // handle middle and sides
      if (y>topLine && y<bottomLine)
      {
        if (diffSum > 50) {
          backDiff.pixels[i] = 255;
        }
        else {
          if (x>leftLine && x<rightLine) {
            backDiff.pixels[i] = 255;
          }
          else {
            backDiff.pixels[i] = 0;
          }
        }
      }
      else {
        backDiff.pixels[i] = 0;
      }
      
      if (oldBackDiff[i] != backDiff.pixels[i])
      {
//        movementImg.pixels[i] = 255;
        if (x < leftLine) {
          leftMovement++;
        }
        else if (x > rightLine) {
          rightMovement++;
        }
      }
      else {
//        movementImg.pixels[i] = 0;
      }
      
      // save a copy ot the background subtraction      
      oldBackDiff[i] = backDiff.pixels[i];
    }
  }

  backDiff.updatePixels();
//  movementImg.updatePixels();
  
  // handle movement
  if (rightMovement*moveFactor > 200) {
    println("right = " + rightMovement);
    float force = map(rightMovement*moveFactor, 0, 500, 1, 5);
    videoBox.applyForce(new PVector(force, -force*2));
  }
  
  if (leftMovement*moveFactor > 200) {
    println("* left = " + leftMovement);    
    float force = map(leftMovement*moveFactor, 0, 500, 1, 5);
    videoBox.applyForce(new PVector(-force, -force*2));
  }
  
  
}

void keyPressed()
{
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}
