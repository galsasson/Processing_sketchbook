
class CircularBuffer
{
  int numElem;
  float[] elements;
  int head;
  
  public CircularBuffer(int ne, float initWith)
  {
    numElem = ne;
    elements = new float[numElem];
    for (int i=0; i<elements.length; i++)
    {
      elements[i] = initWith;
    }
    
    head = 0;
  }
  
  public void write(float val)
  {
    elements[head++] = val;
    head = head%elements.length;
  }
  
  public void clear()
  {
    for (int i=0; i<elements.length; i++)
    {
      elements[i] = 0;
    }
  }
  
  public float getAvg()
  {
    float avg=0;
    for (int i=0; i<elements.length; i++)
    {
      avg += elements[i];
    }
    avg /= numElem;
    
    return avg;
  }
  
}
