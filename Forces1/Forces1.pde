Orb orbs[];
FixedOrb earth;

//other variables
int NUM_ORBS = 5;
int MAX_SIZE = 60;
int MAX_MASS = 100;
int MIN_SIZE = 10;

float gconstant;
boolean moving;
boolean bounce;

int mode;
// 0 = Gravity, 1 = Spring, 2 = Drag, 3 = Repulsion, 4 = Buoyancy
float waterLevel = 400;
Zone[] dragZones;

void setup() {
  size(600, 600);
  gconstant = 1;
  moving = false;
  bounce = false;
  initSimulation(); 
}
//setup
  void draw() {
  background(255);

  if (mode == 0) earth.display();
  if (mode == 2) {
    for (Zone z : dragZones) z.display();
  }
  if (mode == 4) {
    fill(100, 150, 255, 80);
    rect(0, waterLevel, width, height - waterLevel);
  }

  for (Orb o : orbs) o.display();
  if (!moving) return;
 
  if (mode == 0) {
    for (Orb o : orbs) o.applyForce(o.getGravity(earth, gconstant));
  }

  if (mode == 1) {
    for (int i = 0; i < orbs.length - 1; i++) {
      PVector spring = PVector.sub(orbs[i+1].center, orbs[i].center);
      float x = spring.mag() - 100;
      spring.normalize().mult(0.05 * x);
      orbs[i].applyForce(spring);
      orbs[i+1].applyForce(spring.mult(-1));
    }
  }

  if (mode == 2) {
    for (Orb o : orbs) {
      for (Zone z : dragZones) {
        if (z.contains(o)) o.applyForce(o.getDragForce(z.dragCoeff));
      }
    }
  }

  if (mode == 3) {
    for (int i = 0; i < orbs.length; i++) {
      for (int j = 0; j < orbs.length; j++) {
        if (i != j) {
          PVector repulsion = orbs[i].center.copy().sub(orbs[j].center);
          float dist = constrain(repulsion.mag(), 10, 100);
          float strength = 5000 / (dist * dist);
          repulsion.normalize().mult(strength);
          orbs[i].applyForce(repulsion);
        }
      }
    }
  }

  if (mode == 4) {
    for (Orb o : orbs) {
      PVector buoy = o.getBuoyancyForce(waterLevel, 0.03);
      o.applyForce(buoy);
    }
  }

  for (Orb o : orbs) o.move(bounce);
}


//draw

void keyPressed() {
  if (key == ' ') {
    moving = !moving;
  }
  if (key == 'b') {
    bounce = !bounce;
  }
  if (key >= '0' && key <= '4') {
    mode = key - '0';
    initSimulation();
    moving = false;
  }
}




  void initSimulation() {
  orbs = new Orb[NUM_ORBS];

  if (mode == 0) {
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = new Orb();
    }
    earth = new FixedOrb(width/2, height/2, 40, 1000);
  }

  if (mode == 1) {
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = new Orb(80 + i * 80, height/2, 20, 20);
    }
  }

  if (mode == 2) {
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = new Orb();
    }
    dragZones = new Zone[2];
    dragZones[0] = new Zone(0, 0, width, height/2, 0.01, color(200, 255, 200));
    dragZones[1] = new Zone(0, height/2, width, height/2, 0.1, color(255, 200, 200));
  }

  if (mode == 3 || mode == 4) {
    for (int i = 0; i < orbs.length; i++) {
      orbs[i] = new Orb();
    }
  }

}//makeOrbs

//Simulation 1: Oribital Gravity

//Simulation 2: Spring Simulation

//Simulation 3: Drag Zones

//Simulation 4: Repulsion

//Simulation 5: Water Buoyancy 
