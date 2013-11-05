final int GO_LEFT = 0;
final int LOAD_FROM_LEFT = 1;
final int GO_RIGHT = 2;
final int LOAD_FROM_RIGHT = 3;

class State
{
  ArrayList<Animal> rightAnimals;
  ArrayList<Animal> leftAnimals;
  ArrayList<Animal> boatAnimals;

  int nextStep;

  ArrayList<State> prevStates;

  PVector boxSize;

  public State()
  {
    rightAnimals = new ArrayList<Animal>();
    leftAnimals = new ArrayList<Animal>();
    boatAnimals = new ArrayList<Animal>();

    prevStates = new ArrayList<State>();

    nextStep = LOAD_FROM_RIGHT;

    boxSize = new PVector(600, 600);
  }

  public State(State s)
  {
    rightAnimals = new ArrayList<Animal>();
    leftAnimals = new ArrayList<Animal>();
    boatAnimals = new ArrayList<Animal>();

    prevStates = new ArrayList<State>();

    rightAnimals.addAll(s.rightAnimals);
    leftAnimals.addAll(s.leftAnimals);
    boatAnimals.addAll(s.boatAnimals);

    prevStates.addAll(s.prevStates);
    prevStates.add(s);

    nextStep = s.nextStep;

    boxSize = new PVector(600, 600);
  }

  public void initStart()
  {
    rightAnimals.add(new Sheep());
    rightAnimals.add(new Sheep());
    rightAnimals.add(new Sheep());
    rightAnimals.add(new Wolf());
    rightAnimals.add(new Wolf());
    rightAnimals.add(new Wolf());
  }

  public boolean isLegal()
  {
    if (!isLegalList(rightAnimals))
      return false;
    if (!isLegalList(leftAnimals))
      return false;
    if (!isLegalList(boatAnimals))
      return false;

    // if we were in this state already return false
    int val = getValue();
    for (State s : prevStates)
    {
      if (s.getValue() == val) {
        return false;
      }
    }

    return true;
  }

  public boolean complete()
  {
    if (leftAnimals.size() == 6)
      return true;

    return false;
  }

  public boolean isLegalList(ArrayList<Animal> animals)
  {
    int wolves=0;
    int sheep=0;
    for (Animal a : animals) {
      if (a.type.equals("wolf")) {
        wolves++;
      }
      if (a.type.equals("sheep")) {
        sheep++;
      }
    }

    if (sheep==0) {
      return true;
    }
    else
      return sheep>=wolves;
  }


  public void draw()
  {
    pushMatrix();
    scale(0.3);
    PVector pos = new PVector();

    // draw previous states
    for (State s : prevStates)
    {
      pushMatrix();
      translate(pos.x, pos.y);
      noFill();
      rect(0, 0, boxSize.x, boxSize.y);

      float y = 0;
      for (Animal a : s.rightAnimals)
      {
        a.draw(boxSize.x-100, y);
        y+=100;
      }
      y=0;
      for (Animal a : s.leftAnimals)
      {
        a.draw(10, y);
        y+=100;
      }
      y=200;
      for (Animal a : s.boatAnimals)
      {
        a.draw(boxSize.x/2, y);
        y+=100;
      }
      if (s.nextStep == GO_LEFT)
      {
        drawLeftArrow(boxSize.x/2, 400f);
      }
      else if (s.nextStep == GO_RIGHT)
      {
        drawRightArrow(boxSize.x/2, 400f);
      }

      popMatrix();


      pos.x += boxSize.x;
      if (pos.x >= boxSize.x*6) {
        pos.y += boxSize.y;
        pos.x = 0;
      }
    }

    // draw current state
    pushMatrix() ;
    translate(pos.x, pos.y);
    noFill();
    rect(0, 0, boxSize.x, boxSize.y);
    float y = 0;
    for (Animal a : rightAnimals)
    {
      a.draw(boxSize.x-100, y);
      y+=100;
    }
    y=0;
    for (Animal a : leftAnimals)
    {
      a.draw(10, y);
      y+=100;
    }
    y=200;
    for (Animal a : boatAnimals)
    {
      a.draw(boxSize.x/2, y);
      y+=100;
    }
    if (nextStep == GO_LEFT)
    {
      drawLeftArrow(boxSize.x/2, 400f);
    }
    else if (nextStep == GO_RIGHT)
    {
      drawRightArrow(boxSize.x/2, 400f);
    }

    popMatrix();

    popMatrix();
  }

  public int getValue()
  {
    int leftWolves=0;
    int leftSheep=0;
    int rightWolves=0;
    int rightSheep=0;
    int boatWolves=0;
    int boatSheep=0;

    for (Animal a : leftAnimals)
    {
      if (a.type.equals("wolf")) {
        leftWolves++;
      } 
      else {
        leftSheep++;
      }
    }

    for (Animal a : rightAnimals)
    {
      if (a.type.equals("wolf")) {
        rightWolves++;
      } 
      else {
        rightSheep++;
      }
    }

    for (Animal a : boatAnimals)
    {
      if (a.type.equals("wolf")) {
        boatWolves++;
      } 
      else {
        boatSheep++;
      }
    }

    return (nextStep*1000000 + leftWolves*100000 + leftSheep*10000 + boatWolves*1000 + boatSheep*100 + rightWolves*10 + rightSheep);
  }

  void drawLeftArrow(float x, float y)
  {
    stroke(0);
    strokeWeight(5);
    line(x-100, y, x+100, y);
    line(x-100, y, x-50, y-30);
    line(x-100, y, x-50, y+30);
  }

  void drawRightArrow(float x, float y)
  {
    stroke(0);
    strokeWeight(5);
    line(x-100, y, x+100, y);
    line(x+100, y, x+50, y-30);
    line(x+100, y, x+50, y+30);
  }
}

