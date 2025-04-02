void setupDragSim() {
  orbs.clear();
  for (int i = 0; i < 6; i++) {
    PVector pos = new PVector(random(width), random(height));
    Orb orb = new Orb(pos, 10);
    orb.velocity = PVector.random2D().mult(2);
    orbs.add(orb);
  }
}

void applyDrag() {
  for (Orb orb : orbs) {
    float dragCoef = (orb.position.x < width/2) ? 0.02 : 0.1;
    PVector drag = orb.velocity.copy();
    drag.mult(-1);
    drag.normalize();
    float speed = orb.velocity.mag();
    drag.mult(dragCoef * speed * speed);
    orb.applyForce(drag);
  }
}
