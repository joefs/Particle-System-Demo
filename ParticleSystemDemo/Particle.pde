// No Change
class Particle {
  PVector location;
  PVector velocity;
  float diameter;
  color clr;
  int lifetime;
  int age;
  
  
  Particle() {
    location = new PVector( 0, 0 );
    velocity = new PVector( 0, 0 );
    diameter = 12.0;
    clr = color( 255, 255, 255, 255 );
    lifetime = 120;
    age = 0;
  }

  
  void process() {
    location.add( velocity );
    age++;
    
    float t = (float)age / (float)lifetime;
    float a = map( t, 0.5, 1.0, 255, 0 );
    clr = color( red(clr), green(clr), blue(clr), a );
    nonWrap();
  }
  
  
  void render() {
    pushMatrix();
    translate( location.x, location.y );
    noStroke();
    fill( clr );
    ellipse( 0, 0, diameter, diameter );
    popMatrix();
  }
  
  void nonWrap(){
    if ((location.x > (width))||(location.x < (0))){
        age = lifetime +1;
      }
      if ((location.y > (height))||(location.y < (0))){
        age = lifetime +1;
      }
  }
  
}
