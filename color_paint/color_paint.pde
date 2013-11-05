
int N = 450;
WaterParticle[] particles;
Spring[][] springs;

float const_h = 30;

// double relaxation constants
float const_k = 0.004;
float const_k_near = 0.01;
float const_density = 10;


// spring constants
float const_alpha = 0;      // plasticity
float const_gamma = 0.1;
float const_k_spring = 0.3;

// viscosity constants
float const_beta = 0.1; // ?
float const_sigma = 0;

void setup()
{
  size(400, 400);
  smooth();
  noStroke();
 
  background(0, 0, 0); 
  frameRate(30);
  
  
  initAnimation();
}

void draw()
{
  iterate(8);
  
  pushMatrix();
  translate(50, 50);
  
  background(0, 0, 0);
  
  for (int i=0; i<N; i++)
  {
    particles[i].draw();
  }
  popMatrix();
}

void mousePressed()
{
  iterate(5);
}

void initAnimation()
{
  particles = new WaterParticle[N];
  
  for (int i=0; i<N; i++)
  {
    particles[i] = new WaterParticle(
            new PVector((i%25)*10, (i/25)*10),
            new PVector(0, 0));
  }
  
  springs = new Spring[N][N];
}

int prevTime = 0;

void iterate(float dt)
{
  float start = millis();
  
  /* setup delta time */
  /*if (prevTime==0) 
        dt = 1;
  else 
        dt = (millis() - dt) / 1000;
  prevTime = millis();
  */
  
  /* apply gravity */
  for (int i=0; i<N; i++)
  {
    particles[i].velocity.add(new PVector(0, 0, dt*10));
  }

  /* apply viscosity */
  applyViscosity(dt);
  
  for (int i=0; i<N; i++)
  {
    // save prev position
    particles[i].prevPos.set(particles[i].pos);
    
    // advance to predicted position
    particles[i].pos.add(PVector.mult(particles[i].velocity, dt));
  }
  
  ajustSprings(dt);
  
  applySpringsDisplacements(dt);
  
  doubleDensityRelaxation(dt);
  
  //resolveCollisions();
  
  for (int i=0; i<N; i++)
  {
    PVector.sub(particles[i].pos, particles[i].prevPos, particles[i].velocity);
    particles[i].velocity.div(dt);
  }
  
  float end = millis();
  
  println("interate time = " + (end - start));
}

void applyViscosity(float dt)
{
  for (int i=0; i<N; i++)
  {
    for (int j=i+1; j<N; j++)
    {
      PVector Vrij = PVector.sub(particles[j].pos, particles[i].pos);
      float rij = Vrij.mag();
      float q = rij / const_h;
      if (q<1)
      {
        PVector VrijNorm = PVector.div(Vrij, rij);
        // inward radial velocity
        float u = PVector.sub(particles[i].velocity, particles[j].velocity).dot(VrijNorm);
        if (u>0)
        {
          PVector I = PVector.mult(VrijNorm, dt * (1 - q) * (const_sigma*u + const_beta*pow(u,2)));
          I.div(2);
          particles[i].velocity.sub(I);
          particles[j].velocity.add(I);
        }
      }
    }
  }
}

void ajustSprings(float dt)
{
  for (int i=0; i<N; i++)
  {
    for (int j=i+1; j<N; j++)
    {
      PVector Vrij = PVector.sub(particles[j].pos, particles[i].pos);
      float rij = Vrij.mag();
      float q = rij / const_h;
      if (q<1)
      {
        if (springs[i][j]==null)
        {
          springs[i][j] = new Spring(const_h);
        }
        
        // tolerable deformation = yield ratio * rest length
        float d = const_gamma*springs[i][j].restLength;
        if (rij > springs[i][j].restLength + d)
              springs[i][j].restLength += dt*const_alpha*(rij - springs[i][j].restLength - d);
        else if (rij < springs[i][j].restLength - d)
              springs[i][j].restLength -= dt*const_alpha*(springs[i][j].restLength - d - rij);
      }
      
      if (springs[i][j] != null && springs[i][j].restLength > const_h)
            springs[i][j] = null;
    }
  }
}
  
void applySpringsDisplacements(float dt)
{
  for (int i=0; i<N; i++)
  {
    for (int j=i+1; j<N; j++)
    {
      if (springs[i][j] != null)
      {
        PVector Vrij = PVector.sub(particles[j].pos, particles[i].pos);
        float rij = Vrij.mag();
        PVector VrijNorm = PVector.div(Vrij, rij);
      
        PVector D = PVector.mult(VrijNorm, 
                        pow(dt,2) * 
                        const_k_spring * 
                        (1 - springs[i][j].restLength/const_h) *
                        (springs[i][j].restLength - rij));
        D.div(2);
        particles[i].pos.sub(D);
        particles[j].pos.add(D);
      }
    }
  }
}
  
void doubleDensityRelaxation(float dt)
{
  for (int i=0; i<N; i++)
  {
    float density = 0;
    float nearDensity = 0;
    
    // compute density and near-density
    for (int j=0; j<N; j++)
    {
      if (i==j) continue;

      PVector Vrij = PVector.sub(particles[j].pos, particles[i].pos);
      float rij = Vrij.mag();
      
      float q = rij/const_h;
      if (q<1)
      {
        density += pow(1-q, 2);
        nearDensity += pow(1-q, 3);
      }
    }
    
    // compute pressure and near pressure
    float pressure = const_k * (density - const_density);
    float nearPressure = const_k_near * nearDensity;
    PVector dx = new PVector();
    for (int j=0; j<N; j++)
    {
      if (i==j) continue;
      
      PVector Vrij = PVector.sub(particles[j].pos, particles[i].pos);
      float rij = Vrij.mag();
      PVector VrijNorm = PVector.div(Vrij, rij);
      
      float q = rij/const_h;
      if (q<1)
      {
        PVector D = PVector.mult(VrijNorm, 
                    pow(dt, 2) *
                    (pressure*(1-q) + nearPressure*pow(1-q, 2)));
        D.div(2);
        particles[j].pos.add(D);
        dx.sub(D);
      }
    }
    
    // update particle i
    particles[i].pos.add(dx);
  }
}
  
void resolveCollisions()
{
}

class WaterParticle
{
  PVector pos;
  PVector prevPos;
  PVector velocity;
  
  WaterParticle(PVector p, PVector v)
  {
    pos = p;
    velocity = v;
    
    prevPos = new PVector();
  }
  
  void draw()
  {
    fill(100, 100, 255);
    ellipse(pos.x, pos.y, 5, 5);
  }
}

class Spring
{
  float restLength;
  
  Spring(float l)
  {
    restLength = l;
  }
}

