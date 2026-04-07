import ddf.minim.*;

Vehicle wanderers[];
boolean debug = false;
PImage sprite1, sprite2;

Minim minim;
AudioPlayer killSound;

void setup() {
  size(640, 360);

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);
  
  sprite1 = loadImage("data/sprite.png");
  sprite2 = loadImage("data/haack.png");
  imageMode(CENTER);

  wanderers = new Vehicle[100];
  for (int i = 0; i < wanderers.length; i++) {
    wanderers[i] = new Vehicle(random(0, width), random(0, height));
  }
  wanderers[0].isHunter = true;

  killSound = minim.loadFile("data/ololoo.mp3");
}

void draw() {
  background(255);
  
  int counter = 0;
  for (int a = 0; a < wanderers.length; a++) {
    if (wanderers[a].isHunter) {
      counter++;
      for (int b = 0; b < wanderers.length; b++) {
        if (!wanderers[b].isHunter) {
          if (wanderers[b].position.dist(wanderers[a].position) < wanderers[a].r) {
            wanderers[a].hunterKill(wanderers[b]);
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
