

int DISPLAY_COLS=5;

ArrayList<Paint> paintings;

int currentPaint = 0;

void setup()
{
  size(420, 420);
  smooth();

  paintings = new ArrayList<Paint>(); 
  frameRate(10);
  
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
  
  noStroke();
  fill(200);
  rect(10, 10, 400, 400);

  paintings.get(currentPaint).draw();
  
  saveFrame("pngs/paint-"+currentPaint+".png");
  currentPaint++;
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

