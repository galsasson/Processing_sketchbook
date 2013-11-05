
String url="http://www.galsasson.com/applications/get_status.php";
PImage[] image = new PImage[13];
PImage background;

void setup()
{
  size(1280, 800);
  smooth();
  background(255);
  
  background = loadImage("images/background.jpg");
  for (int i=0; i<13; i++)
  {
    image[i] = loadImage("images/img-"+(i+1)+".png");
  }
  
  frameRate(1);
}

void draw()
{
  background(255);
  String[] rawText = loadStrings(url);
  println(rawText);
  
  String everything = join(rawText, "");
  
  everything = trim(everything);
  println(everything);
  
  String[] count = split(everything, ',');
  
  tint(255, 255, 255, 255);
  image(background, 120, 0);
  
  for (int i=0; i<count.length; i++)
  {
    if (!count[i].equals("")) {
      // display the sentence
      float a = map(Integer.parseInt(count[i]), 0, 6, 0, 255);
      tint(255, 255, 255, a);
      image(image[i],120,0);
    }
  }
}
