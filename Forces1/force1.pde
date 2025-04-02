void setupGravitySim() {
  orbs.clear();
  // Fixed central orb
  Orb center = new Orb(new PVector(width/2, height/2), 0);
  center.isFixed = true;
  orbs.add(center);
  
  // Add orbiting orbs
  for (int i = 0; i < 5; i++) {
    float angle = TWO_PI * i / 5;
    PVector pos = new PVector(width/2 + cos(angle) * 150, height/2 + sin(angle) * 150);
    PVector vel = new PVector(-sin(angle), cos(angle)).mult(2);
    Orb orb = new Orb(pos, 10);
    orb.velocity = vel;
    orbs.add(orb);
  }
}

void applyGravity() {
  Orb center = orbs.get(0);
  for (int i = 1; i < orbs.size(); i++) {
    Orb orb = orbs.get(i);
    PVector dir = PVector.sub(center.position, orb.position);
    float distance = dir.mag();
    float G = 1;
    dir.normalize();
    float forceMag = G * center.mass * orb.mass / (distance * distance);
    PVector force = dir.mult(forceMag);
    orb.applyForce(force);
  }
}
