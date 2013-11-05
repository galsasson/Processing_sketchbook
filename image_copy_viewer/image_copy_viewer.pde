

int DISPLAY_COLS=5;

ArrayList<Paint> paintings;

int scrollY = 0;

float scaleFactor = 1;

void setup()
{
  size(840, 840);
  smooth();

  scaleFactor = 1 / ((float)DISPLAY_COLS/2);
  paintings = new ArrayList<Paint>();
  frameRate(30);
  
  for (int i=0; i<84; i++)
  {
    println("parsing drawing: " + i);

    // load local
    String file = "painting" + i + ".xml";
//    // load from server
//    String file = "http://ec2-54-200-99-48.us-west-2.compute.amazonaws.com/getdata.php?index="+i;
    
    parseResultsFile(file, i);
  }
}

void draw()
{ 
  background(0);
  scale(scaleFactor, scaleFactor);
  translate(0, scrollY);
  
  int x=0, y=0;
  for (int i=0; i<paintings.size(); i++)
  {
    pushMatrix();
    translate((i%DISPLAY_COLS)*420, (i/DISPLAY_COLS)*420);
    // drawing pad
    noStroke();
    fill(200);
    rect(10, 10, 400, 400);
    // draw user painting
    paintings.get(i).draw(frameCount*5);
    popMatrix();
  }
}

void parseResultsFile(String filename, int index)
{
  XML xml = loadXML(filename);
  
//  saveXML(xml, saveFile);
  
  XML[] paints = xml.getChildren("paint");
  
  for (int i=0; i<paints.length; i++)
  {
    Paint paint = new Paint(10, 10);
    XML[] strokes = paints[i].getChildren("stroke");
    for (int j=0; j<strokes.length; j++)
    {
      GStroke stroke = new GStroke(10, 10);
      XML[] points = strokes[j].getChildren("point");
      for (int k=0; k<points.length; k++)
      {
        int x = points[k].getInt("x");
        int y = points[k].getInt("y");
        int frame = points[k].getInt("frame");
        stroke.addPoint(x, y, frame);
      }
      paint.addStroke(stroke);
    }
    paintings.add(paint);
  }
}

void mouseWheel(MouseEvent event) {
  scrollY -= event.getAmount()*3;
  if (scrollY > 0) {
    scrollY = 0;
  }
}

