// Multiplies a general magnitude by a level spat out from noise. Adjusted to allow values [-1,1]
// Because the effective "perlin space" (which I have bound) doesn't follow the particle system, it doesn't necessarily have to be full of particles.
// This op stains and kills particles outside of the effective "perlin space"... ("effective perlin space box?")

class PerlinTranslation extends VelocityOp {
  
  PVector center;
  float magnitude;
  float perlinLevel;
  
  float derivVelo;
  
  PerlinTranslation() {
    center = new PVector( width/2, height/2 );
    magnitude = 3.0;
    perlinLevel = 0.95;
    derivVelo = magnitude * perlinLevel;
  }
  
  
  void process( ArrayList particles ) {
    for (int i = 0; i < particles.size(); i++) {
      Particle p = (Particle)particles.get(i);
      perlinLevel = (noise(p.location.x, p.location.y)* 2 )-1;
      derivVelo = magnitude * perlinLevel;
      p.location.y = p.location.y + derivVelo;
      p.location.x = p.location.x + derivVelo;
      if ((p.location.x > (width * 5/8))||(p.location.x < (width * 3/8))){
        p.age = p.lifetime +1;//KILL
        p.clr = color(255,0,0);
      }else if ((p.location.y > (height * 5/8))||(p.location.y < (height * 3/8))){
        p.age = p.lifetime +1;//KILL
        p.clr = color(255,0,0);
      }
      else{
      
      }
    }
  }
}
