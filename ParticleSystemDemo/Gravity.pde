// Unused
class Gravity extends AccelerationOp {
  
  float strength;
  
  Gravity() {
    strength = 0.01;
  }
  
  
  void process( ArrayList particles ) {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get(i);
      p.velocity.y += strength;
    }
  }
}

