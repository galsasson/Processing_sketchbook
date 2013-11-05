
ArrayList<Arc> arcs;

void build()
{
  arcs = new ArrayList<Arc>();
  
  int n=400;
  for (int i=0; i<n; i++)
  {
    arcs.add(new Arc());
  }
}

void keyPressed() {
  if (key==' ') build();
}

