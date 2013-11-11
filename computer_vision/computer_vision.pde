
import processing.video.*;

int numPixels;
Capture video;
int[] backgroundPixels;
int[] oldBackDiff;
PImage backDiff;
PImage movementImg;

PVector pos;

int videoWidth = 320;
int videoHeight = 240;
int rightLine = videoWidth-videoWidth/4;
int leftLine = videoWidth/4;

Ball ball;

void setup() {
  size(640, 480);
  
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  video = new Capture(this, videoWidth, videoHeight);
  backDiff = new PImage(videoWidth/2, videoHeight/2, RGB);
  movementImg = new PImage(videoWidth/2, videoHeight/2, RGB);
  
  // Start capturing the images from the camera
  video.start(); 
  
  numPixels = video.width * video.height;
  // Create an array to store the previously captured frame
  backgroundPixels = new int[numPixels];
  oldBackDiff = new int[numPixels/4];
//  loadPixels();

  ball = new Ball(width/2, height-100);
}

void draw() {
  background(255);
  
  // mirrot the video
  pushMatrix();
  scale(-1, 1);
  image(video, -320, 0);
  popMatrix();
  
  image(backDiff, 320, 0);
  image(movementImg, 480, 0);
  
  ball.update();
  ball.draw();
}


void captureEvent(Capture c)
{
  c.read();
  c.loadPixels();
  backDiff.loadPixels();
  movementImg.loadPixels();
  
  int rightMovement=0;
  int leftMovement=0;

  for (int y=0; y<videoHeight; y+=2)
  {
    for (int x=0; x<videoWidth; x+=2)
    {
      int i = x + y*videoWidth;
      int ii = x/2 + (y/2)*(videoWidth/2);
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
      
      if (diffSum > 80) {
        backDiff.pixels[ii] = 255;
      }
      else {
        backDiff.pixels[ii] = 0;
      }
      
      if (oldBackDiff[ii] != backDiff.pixels[ii])
      {
        movementImg.pixels[ii] = 255;
        if (x < leftLine) {
          leftMovement++;
        }
        else if (x > rightLine) {
          rightMovement++;
        }
      }
      else {
        movementImg.pixels[ii] = 0;
      }
      
      // save a copy ot the background subtraction      
      oldBackDiff[ii] = backDiff.pixels[ii];
    }
  }

  backDiff.updatePixels();
  movementImg.updatePixels();
  
  // handle movement
  if (rightMovement > 200) {
    println("right = " + rightMovement);
    float force = map(rightMovement, 0, 500, 1, 5);
    ball.applyForce(new PVector(force, -force*2));
  }
  
  if (leftMovement > 200) {
    println("* left = " + leftMovement);    
    float force = map(leftMovement, 0, 500, 1, 5);
    ball.applyForce(new PVector(-force, -force*2));
  }
  
//  video.mask(backDiff);
  
}

void keyPressed()
{
  video.loadPixels();
  arraycopy(video.pixels, backgroundPixels);
}
