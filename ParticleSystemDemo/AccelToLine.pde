class AccelToLine extends AccelerationOp {
  PVector line_seg;
  PVector line_perp;
  PVector r;
  float d1;
  float d;
  PVector b;
  float t;

  AccelToLine() {
    line_seg = PVector.sub(p1, p2);
    line_perp = new PVector(line_seg.y, -line_seg.x);
    r = PVector.sub(p1, a);
    d1 = line_seg.x * r.y- r.x * line_seg.y;
    d = abs(d1)/ line_seg.mag();
    // D IS THE DISTANCE BETWEEN THE POINT AND THE LINE
    if (d1 > 0)
      d = d*-1;

    line_perp.normalize();
    line_perp.mult(d);

    b = new PVector(a.x + line_perp.x, a.y +line_perp.y);
    t = (b.x/(p2.x - p1.x)) - (p1.x/ (p2.x-p1.x));
    if (t<0) {
      b.x = p1.x;
      b.y = p1.y;
    }
    else if ( t> 1) {
      b.x = p2.x;
      b.y = p2.y;
    }
  }


  void process( ArrayList particles ) {
    
     for (int i = 0; i < particles.size(); i++) {
       //
    line_seg = PVector.sub(p1, p2);
    line_perp = new PVector(line_seg.y, -line_seg.x);
    r = PVector.sub(p1, a);
    d1 = line_seg.x * r.y- r.x * line_seg.y;
    d = abs(d1)/ line_seg.mag();
    // D IS THE DISTANCE BETWEEN THE POINT AND THE LINE
    if (d1 > 0)
      d = d*-1;

    line_perp.normalize();
    line_perp.mult(d);

    b = new PVector(a.x + line_perp.x, a.y +line_perp.y);
    t = (b.x/(p2.x - p1.x)) - (p1.x/ (p2.x-p1.x));
    if (t<0) {
      b.x = p1.x;
      b.y = p1.y;
    }
    else if ( t> 1) {
      b.x = p2.x;
      b.y = p2.y;
    }
       //
     Particle p = (Particle)particles.get(i);
     a = p.location;
    PVector rush = PVector.sub( b, a );// I originally had this backwards and was getting a bizarre nova effect. Not germane though.
    rush.normalize();
    rush.mult(10);
    p.velocity = rush;
     }
  }
}

