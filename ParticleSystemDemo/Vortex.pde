// Pretty much unchanged.

class Vortex extends VelocityOp {
  
  PVector center;
  float magnitude;
  float tightness;
  
  Vortex() {
    center = new PVector( width/2, height/2 );
    magnitude = 5.0;
    tightness = 0.95;
  }
  
  
  void process( ArrayList particles ) {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get(i);
      
      float distanceToCenter = center.dist( p.location );
      float theta = magnitude / pow( distanceToCenter, tightness );
      
      PVector tmp = PVector.sub( p.location, center );
      float x = tmp.x * cos( theta ) - tmp.y * sin( theta );
      float y = tmp.x * sin( theta ) + tmp.y * cos( theta );
      p.location.x = center.x + x;
      p.location.y = center.y + y;
    }
  }
}
