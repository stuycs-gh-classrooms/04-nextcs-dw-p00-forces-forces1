class Orb {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  boolean isFixed;

  Orb(PVector position, float mass) {
    this.position = position.copy();
    this.velocity = new PVector(0, 0);
    this.acceleration = new PVector(0, 0);
    this.mass = mass;
    this.isFixed = false;
  }

  void applyForce(PVector force) {
    if (isFixed) return;
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  void update() {
    if (isFixed) return;
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0); // reset after each update
  }

  void checkEdges(boolean wallBounce) {
    if (!wallBounce || isFixed) return;

    if (position.x < 0 || position.x > width) {
      velocity.x *= -1;
      position.x = constrain(position.x, 0, width);
    }

    if (position.y < 0 || position.y > height) {
      velocity.y *= -1;
      position.y = constrain(position.y, 0, height);
    }
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    fill(isFixed ? color(255, 100, 100) : color(100, 150, 255));
    ellipse(position.x, position.y, mass * 2, mass * 2);
  }
}
