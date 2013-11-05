
int score=0;

String resultStr = "";

PFont font;
int currentScreen = 0;
Screen screens[] = new Screen[8];

int userID;

void setup()
{
  size(800, 600);
  smooth();
  
  userID = (int)random(MAX_INT);
  
  font = loadFont("Helvetica-28.vlw");
  screens[0] = new Screen1();
  screens[1] = new ScreenGetReady();
  screens[2] = new Screen2();
  screens[3] = new ScreenGetReady();
  screens[4] = new Screen3();
  screens[5] = new ScreenGetReady();
  screens[6] = new Screen4();
  screens[7] = new ScreenEnd();
  
  // write access to the first screen
  loadStrings("http://galsasson.com/ygwyg/insert.php?id=user"+userID+"&page=0&selection=0"); 
}

void draw()
{
  screens[currentScreen].update();
  screens[currentScreen].draw();
  
  if (screens[currentScreen].goToNext()) {
    int page = screens[currentScreen].getPage();
    if (page != -1) {
      int selection = screens[currentScreen].getSelection();
      String req = "http://galsasson.com/ygwyg/insert.php?id=user"+userID+"&page="+page+"&selection="+selection;
      String res[] = loadStrings(req); 
    }
    currentScreen++;
  }
}

void mousePressed()
{
  screens[currentScreen].mouseClicked(mouseX, mouseY);
}

class Screen
{
  public Screen() {}
  public void draw() {}
  public void update() {}
  public boolean goToNext() {return false;}
  public int getSelection() {return -1;}
  public int getPage() {return -1;}
  public void mouseClicked(int x, int y) {}
}
