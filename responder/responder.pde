import processing.net.*;


FImage[] imgs;

SentientReceiver receiver;

void setup()
{
  size(400, 400);
  smooth();
  frameRate(60);
  
  //receiver = new SentientReceiver("192.168.1.253");
  getMood("ptest3", "Sound", "J-Room", System.currentTimeMillis()-10000);
  
  imgs = new FImage[2];
  for (int i=0; i<imgs.length; i++)
  {
    imgs[i] = new FImage();
  }
}


void draw()
{
  background(#FFFED8);
  
  imgs[0].applyRotationForce(0.0);
  imgs[1].applyRotationForce(-0.010);
  
  for (FImage img : imgs)
  {
    img.update();
    img.draw();
  } 
}

void mousePressed()
{
  for (int i=0; i<imgs.length; i++)
  {
    imgs[i] = new FImage();
  }
}

Client client;
void getMood(String session, String measure, String entity, long time)
{
  String[] res = loadStrings("http://128.122.151.163:3000/SessionResult/?"+
    "session="+session+
    "&measure="+measure+
    "&entity="+entity+
    "&starttime="+time+
    "&resolution=100");
  
  for (int i=0; i<res.length; i++)
  {
    println(res[i]);
  }
}

