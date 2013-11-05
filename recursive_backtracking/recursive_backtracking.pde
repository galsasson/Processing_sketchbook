
State drawState;

void setup()
{
  size(1100, 720);
  frameRate(30);
}

void draw()
{
  background(200);

  if (drawState != null) {
    drawState.draw();
  }
}

Thread thread = null;
Solver solver = null;

void keyPressed()
{
  if (solver == null)
  {
    solver = new Solver();
    thread = new Thread(solver);
    thread.start();
  }
  else {
    solver.suspend = !solver.suspend;
  }
}

class Solver implements Runnable
{
  boolean suspend = false;
  
  public Solver()
  {
  }
  
  public void run()
  {
    State initialState = new State();
    initialState.initStart();

    if (!recursiveSolve(initialState))
    {
      println("no solution!");
    }
  }

  boolean recursiveSolve(State state)
  {
    while(suspend)
    {
      try {
        Thread.sleep(10);
      }
      catch(Exception e) {
      }
    }
    
    drawState = state;
    try {
      Thread.sleep(500);
    }
    catch(Exception e) {
    }

    if (!state.isLegal())
      return false;

    switch(state.nextStep)
    {
    case LOAD_FROM_RIGHT:
      {
        // select two animals from the right side and put on the boat
        for (int i=0; i<state.rightAnimals.size(); i++) {
          for (int j=i+1; j<state.rightAnimals.size(); j++) {
            State newState = new State(state);

            // add animal i and j to the boat and remove from right side
            Animal a1 = newState.rightAnimals.get(i);
            Animal a2 = newState.rightAnimals.get(j);          
            newState.boatAnimals.add(a1);
            newState.boatAnimals.add(a2);
            newState.rightAnimals.remove(a1);
            newState.rightAnimals.remove(a2);

            newState.nextStep = GO_LEFT;
            if (recursiveSolve(newState)) {
              return true;
            }
          }
        }
        return false;
      }
    case GO_LEFT:
      {
        // unload the boat animals on the left side
        State newState = new State(state);

        newState.leftAnimals.addAll(newState.boatAnimals);
        newState.boatAnimals.clear();

        if (newState.complete())
        {
          println("yay");
          drawState = newState;
          return true;
        }

        newState.nextStep = LOAD_FROM_LEFT;
        return recursiveSolve(newState);
      }
    case LOAD_FROM_LEFT:
      {
        // select one animal from left side and put on the boat
        for (int i=0; i<state.leftAnimals.size(); i++)
        {
          State newState = new State(state);

          Animal a = newState.leftAnimals.get(i);
          newState.boatAnimals.add(a);
          newState.leftAnimals.remove(a);

          newState.nextStep = GO_RIGHT;
          if (recursiveSolve(newState)) {
            return true;
          }
        }
        // select two animals from left side and put on the boat
        for (int i=0; i<state.leftAnimals.size(); i++) {
          for (int j=i+1; j<state.leftAnimals.size(); j++)
          {
            State newState = new State(state);

            Animal a1 = newState.leftAnimals.get(i);
            Animal a2 = newState.leftAnimals.get(j);
            newState.boatAnimals.add(a1);
            newState.boatAnimals.add(a2);
            newState.leftAnimals.remove(a1);
            newState.leftAnimals.remove(a2);

            newState.nextStep = GO_RIGHT;
            if (recursiveSolve(newState)) {
              return true;
            }
          }
        }
        return false;
      }
    case GO_RIGHT:
      {
        State newState = new State(state);

        // unload boat animal on the right side
        newState.rightAnimals.addAll(newState.boatAnimals);
        newState.boatAnimals.clear();

        newState.nextStep = LOAD_FROM_RIGHT;
        return recursiveSolve(newState);
      }
    }

    return false;
  }
}

