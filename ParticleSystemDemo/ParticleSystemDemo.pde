// Name: Joe Spiro
// Date: 10/10/2012
// Class: AME 598 Fall Semester
// Description: Demos 4 ops which can be toggled on and off (and otherwise modified in some cases) with button or mouse presses
//              Many Status... (Stati?) Are displayed at the bottom of the sketch.

/*
OPTIONS TAKEN
A. Particles are generated based on the content of an image. (1.5X)
B. Translated by Perlin Noise within a rectangle. (1.25X)
C. Accelerate towards a line.
*/



ParticleSystem ps;
PImage img;         // Source image
// Booleans indicating the status of the different toggles/ ops
boolean windOn;
boolean perlOn;
boolean accel2LineOn;
boolean vortOn;

PVector p1;
PVector p2;
PVector a;

void setup() {
  size( 600, 600);
  smooth();
  img = loadImage("fish.jpg");// The Image the particle system sources for color data (its an album cover)
  ps = new ParticleSystem( width/2, height/2, 512 );
  // State variables for the different operations.
  windOn = false;
  perlOn = false;
  accel2LineOn = false;
  vortOn = false;
  // Default placements for the line ends
  p1 = new PVector(0, 50);
  p2 = new PVector(50, 0);
  a = new PVector (300, 100);
}


void draw() {
  background( 0 );

  ps.generate();
  ps.kill();
  ps.process(); 
  ps.render();
  if (accel2LineOn) {// Only display the implicit line segment if its having a material effect on particles
    stroke(255, 255, 255, 100);
    strokeWeight(30);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  displayStatus();// Displays states
}


void mouseDragged() {// relocates the particle system
  ps.location.x = mouseX;
  ps.location.y = mouseY;
}

void keyPressed() {// Toggles for acceleration and velocity opps as well as the location of the line (directed by its endpoints)
  if (key == 'w' || key == 'W') {
    if (windOn) {
      windOn = false;
      for (int i = 0; i < ps.accelOps.size(); i++) {
        AccelerationOp p = (AccelerationOp)ps.accelOps.get( i );
        ps.accelOps.remove(i);
        i--;
      }
    }
    else {
      windOn = true;
      Wind w = new Wind();
      ps.accelOps.add( w );
    }
  }
  if (key == 'p' || key == 'P') {
    if (perlOn) {
      perlOn = false;
      for (int i = 0; i < ps.velocityOps.size(); i++) {
        VelocityOp p = (VelocityOp)ps.velocityOps.get( i );
        ps.velocityOps.remove(i);
        i--;
      }
    }
    else {
      perlOn = true;
      PerlinTranslation p = new PerlinTranslation();
      ps.velocityOps.add( p );
    }
  }
  if (key == '1') {
    p1 = new PVector(mouseX, mouseY);
    if ((p1.x==p2.x)&&(p1.y==p2.y)) {// To ensure against 0 magnitude lines (These didn't cause processing to crash but did cause odd behaviours)
      p1.x++;
      p1.y++;
    }
  }
  if (key == '2') {
    p2 = new PVector(mouseX, mouseY);
    if ((p1.x==p2.x)&&(p1.y==p2.y)) {// To ensure against 0 magnitude lines
      p2.x++;
      p2.y++;
    }
  }
  if (key == 'a' || key == 'A') {
    if (accel2LineOn) {
      accel2LineOn = false;
      for (int i = 0; i < ps.accelOps.size(); i++) {
        AccelerationOp p = (AccelerationOp)ps.accelOps.get( i );
        ps.accelOps.remove(i);
        i--;
      }
    }
    else {
      accel2LineOn = true;
      AccelToLine alp = new AccelToLine();
      ps.accelOps.add( alp );
    }
  }
  if (key == 'v' || key == 'V') {
    if (vortOn) {
      vortOn = false;
      for (int i = 0; i < ps.velocityOps.size(); i++) {
        VelocityOp p = (VelocityOp)ps.velocityOps.get( i );
        ps.velocityOps.remove(i);
        i--;
      }
    }
    else {
      vortOn = true;
      Vortex vac = new Vortex();
      ps.velocityOps.add( vac );
    }
  }
}

void displayStatus() {// A method that displays the status/ toggle states of the sketch and particle system (pretty clinical)
  String[] vault = new String[8];
  vault[0] = "Wind On? " + windOn + " (Click 'W' to toggle.)";
  vault[1] = "Perl On? " + perlOn + " (Click 'P' to toggle.)";
  vault[2] = "accel2Line On? " + accel2LineOn + " (Click 'A' to toggle.)";
  vault[3] = "Vortex On? " + vortOn + " (Click 'V' to toggle.)";
  vault[4] = "Point 1 at " + p1 + " [Move by pressing 1]";
  vault[5] = "Point 2 at " + p2 + " [Move by pressing 2]";
  vault[6] = "The following two only apply while accel2line is on.";
  vault[7] = "The center of the Particle System is at" + ps.location;
  fill(0, 0, 255);
  for (int i = 0; i< vault.length; i++) {
    if (i>3) {
      fill(255, 0, 0);
    }
    text(vault[i], 0, height-20-(12*i));
  }
}

