void setupSpringSim() {
  orbs.clear();
  for (int i = 0; i < 5; i++) {
    PVector pos = new PVector(100 + i * 60, height / 2);
    Orb orb = new Orb(pos, 10);
    if (i == 0) orb.isFixed = true; // First orb fixed
    orbs.add(orb);
  }
}

void applySpringForces() {
  float k = 0.1; // Spring constant
  float restLength = 60;
  for (int i = 0; i < orbs.size() - 1; i++) {
    Orb a = orbs.get(i);
    Orb b = orbs.get(i + 1);
    PVector spring = PVector.sub(b.position, a.position);
    float stretch = spring.mag() - restLength;
    spring.normalize();
    PVector force = spring.mult(-k * stretch);
    if (!a.isFixed) a.applyForce(force);
    if (!b.isFixed) b.applyForce(force.mult(-1));
  }
}
