class Wind extends AccelerationOp {
  PVector location;
  PVector direction;
  float force;
  float strength;

  Wind() {
    location = new PVector( width - 20, height/2 );
    direction = new PVector( -1.0, 0.0 );
    direction.normalize();
    force = 5;
    strength = 500.0;
  }


  void process( ArrayList particles ) {
    PVector wind = PVector.mult( direction, force );
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get(i);
      float distance = location.dist( p.location );
      float m = map( distance, 0, strength, 1.0, 0.0 );
      m = constrain( m, 0.0, 1.0 );
      PVector wind_effect = PVector.mult( wind, m );
      p.velocity.add( wind_effect );
    }
  }
}

