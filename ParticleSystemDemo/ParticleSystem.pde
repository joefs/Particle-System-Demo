// Experimented with different forms of particle generation, life time and such but mostly the same.
// I did however source colors from an image and had the particles generate in a rectangle where the image would be.
class ParticleSystem {
  PVector location;
  float diameter;
  int meanParts;  // mean number of particles to generate 
  int varParts;   // variance of particles to generate
  float meanSpeed;
  float varSpeed;
  int meanLifetime;
  int varLifetime;
  color meanColor;
  color varColor;
  float meanSize;
  float varSize;
  ArrayList particles;
  ArrayList accelOps;
  ArrayList velocityOps;
  
  
  ParticleSystem( float initX, float initY, float initDiameter ) {
    location = new PVector( initX, initY );
    diameter = initDiameter;
    meanParts = 100;
    varParts = 2;
    meanSpeed = 0.0;
    varSpeed = 0.0;
    meanLifetime = 20;
    varLifetime = 10;
    meanColor = color( 0, 200, 0, 255 );
    varColor = color( 0, 50, 0, 0 );
    meanSize = 4.0;
    varSize = 2.0;
    particles = new ArrayList();
    accelOps = new ArrayList();
    velocityOps = new ArrayList();
  }
  
  
  void kill() {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get( i );
      if (p.age >= p.lifetime) {
        particles.remove(i);
        i--;
      }
    }
  }
  
  
  void generate() {
   // if (frameCount > 1) return;
    int numParticles = int( (float)meanParts + random( -1.0, 1.0 ) * (float)varParts);
    for (int i = 0; i < numParticles; i++) {
      createParticle();
    }
  }
  
  
  void createParticle() {
    // make a new particle
    Particle p = new Particle();
    /*
    // Generation in a circle
    // assign values to various particle attributes
    
    float r = random( 0.0, diameter/4 );  // this was for creating particles inside the circle
    float a = random( 0.0, TWO_PI );
    float x = r * cos( a );
    float y = r * sin( a );
    */
    
    // Generation in a rectangle
    float radi2 = 1.4142/4; // radical 2 divided by 4 creates the bounds so as to be in a circumscribed square
    
    float x = random( diameter * radi2 * -1, diameter * radi2 );
    float y = random( diameter * radi2 * -1, diameter * radi2);
    
    
    //
    p.location.x = location.x + x;
    p.location.y = location.y + y;
    p.velocity.x = x;
    p.velocity.y = y;
    p.velocity.normalize();
    p.velocity.mult( meanSpeed + random( -1, 1 ) * varSpeed );
    p.lifetime = int( (float)meanLifetime + random( -1, 1 ) * (float)varLifetime );
    p.diameter = meanSize + random( -1.0, 1.0 ) * varSize;
    //
    //constrain(mouseX, 30, 70);
    
    int deriv_x = constrain((181 + (int)x), 0, 361);
    int deriv_y = constrain((181 + (int)y), 0, 361);
    
    int loc = deriv_x + deriv_y *img.width;
    color pix = img.pixels[loc];
    
    p.clr = img.pixels[loc];
    
    //
    /*
    float c_red = red( meanColor ) + random( -1, 1 ) * red( varColor );
    float c_green = green( meanColor ) + random( -1, 1 ) * green( varColor );
    float c_blue = blue( meanColor ) + random( -1, 1 ) * blue( varColor );
    float c_alpha = alpha( meanColor ) + random( -1, 1 ) * alpha( varColor );
    p.clr = color( c_red, c_green, c_blue, c_alpha );
    */
    
    
    // add the particle to the system
    particles.add( p );
  }
  
  
  void process() {
    for (int i = 0; i < accelOps.size(); i++) {
      AccelerationOp op = (AccelerationOp)accelOps.get(i);
      op.process( particles );
    }
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get( i );
      p.process();
    }
    for (int i = 0; i < velocityOps.size(); i++) {
      VelocityOp op = (VelocityOp)velocityOps.get(i);
      op.process( particles );
    }
  }
  
  
  void render() {
    stroke(255, 126, 0);
    strokeWeight( 1 );
    noFill();
    ellipse( location.x, location.y, diameter, diameter );
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get( i );
      p.render();
    }
  }
  
}
