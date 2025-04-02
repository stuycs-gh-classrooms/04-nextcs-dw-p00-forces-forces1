ArrayList<Orb> orbs;
int currentSim = 1;
boolean isMoving = true;
boolean wallBounce = true;

void setup() {
  size(800, 600);
  orbs = new ArrayList<Orb>();
  setupSimulation(currentSim);
}

void draw() {
  background(255);

  // Apply forces
  if (isMoving) {
    switch(currentSim) {
      case 1: applyGravity(); break;
      case 2: applySpringForces(); break;
      case 3: applyDrag(); break;
    }
  }

  // Update and display all orbs
  for (Orb orb : orbs) {
    if (isMoving) orb.update();
    orb.checkEdges(wallBounce);
    orb.display();
  }

  // Display simulation info
  fill(0);
  textSize(14);
  text("Sim: " + currentSim + 
       " | Movement: " + (isMoving ? "On" : "Off") + 
       " | Wall Bounce: " + (wallBounce ? "On" : "Off"), 10, height - 10);
}

void keyPressed() {
  if (key == '1' || key == '2' || key == '3') {
    currentSim = int(key - '0');
    setupSimulation(currentSim);
  }
  if (key == ' ') isMoving = !isMoving;
  if (key == 'b') wallBounce = !wallBounce;
}

void setupSimulation(int sim) {
  switch(sim) {
    case 1: setupGravitySim(); break;
    case 2: setupSpringSim(); break;
    case 3: setupDragSim(); break;
  }
}
