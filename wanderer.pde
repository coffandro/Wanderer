import ddf.minim.*;

Vehicle wanderers[];
boolean debug = false;

void setup() {
  size(640, 360);

  wanderers = new Vehicle[100];
  for (int i = 1; i < wanderers.length; i++) {
    wanderers[i] = new Herbi(random(0, width), random(0, height));
  }
  wanderers[0] = new Hunter(random(0, width), random(0, height));
}

void draw() {
  background(255);

  int counter = 0;
  for (int a = 0; a < wanderers.length; a++) {
    if (wanderers[a].getClass() == Hunter.class) {
      counter++;
      for (int b = 0; b < wanderers.length; b++) {
        if (!(wanderers[b].getClass() == Hunter.class)) {
          if (wanderers[b].position.dist(wanderers[a].position) < wanderers[a].r) {
            Hunter hunter = (Hunter)wanderers[a];
            hunter.hunterKill((Herbi)wanderers[b]);
            continue;
          } else if (wanderers[b].position.dist(wanderers[a].position) < wanderers[a].sensorRange) {
            wanderers[a].seek(wanderers[b].position);
            continue;
          }
        }
      }
    }

    wanderers[a].wander();
    wanderers[a].run();
  }

  if (counter == wanderers.length) {
    exit();
  }
}

void mousePressed() {
  debug = !debug;
}
