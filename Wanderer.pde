import ddf.minim.*;

Object objects[];
boolean debug = false;

void setup() {
  size(640, 360);

  objects = new Object[100];
  for (int i = 0; i < objects.length; i++) {
    objects[i] = new Herbi(random(0, width), random(0, height));
  }
}

void draw() {
  background(255);
  for (int a = 0; a < objects.length; a++) {
    objects[a].run();
  }
}

void mousePressed() {
  debug = !debug;
}
