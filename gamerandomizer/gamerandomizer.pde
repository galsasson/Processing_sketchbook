/* @pjs preload="img/game1.png"; */
/* @pjs preload="img/game2.png"; */
/* @pjs preload="img/game3.png"; */
/* @pjs preload="img/game4.png"; */
/* @pjs preload="img/game5.png"; */

/* @pjs font="img/futura.ttf"; */

ArrayList<PImage> images;
boolean go;
int currentGame;

void setup()
{
  size(500, 500);
  smooth();
  frameRate(15);
  
  go = false;
  currentGame = 0;
  
  images = new ArrayList<PImage>();
  images.add(loadImage("img/game1.jpg"));
  images.add(loadImage("img/game2.jpg"));
  images.add(loadImage("img/game3.jpg"));
}

void draw()
{
  background(0);
  
  image(images.get(currentGame), 0, 0, 500, 500);
  
  if (go)
  {
    currentGame = (++currentGame)%images.size();
  }
}

void mousePressed()
{
  go = !go;
}
