class Vehicle {
  PVector position;
  PVector velocity;
  PVector acceleration;

  float r;
  float wandertheta;
  float maxforce;
  float maxspeed;

  float wanderR = 25;
  float wanderD = 80;
  float sensorRange = wanderR + wanderD;

  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    position = new PVector(x, y);

    r = 6;
    wandertheta = 0;
    maxspeed = 2;
    maxforce = 0.05;
  }

  void run() {
    update();
    borders();
    display();
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);

    position.add(velocity);

    // reset acceleration every frame
    acceleration.mult(0);
  }

  void wander() {
    float change = 0.3;
    wandertheta += random(-change, change);

    PVector circlepos = velocity.copy();
    circlepos.normalize();
    circlepos.mult(wanderD);
    circlepos.add(position);

    float h = velocity.heading();

    PVector circleOffset = new PVector(wanderR * cos(wandertheta + h), wanderR * sin(wandertheta + h));
    PVector target = PVector.add(circlepos, circleOffset);
    seek(target);

    if (debug) drawWanderStuff(position, circlepos, target, wanderR);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, position);

    desired.normalize();
    desired.mult(maxspeed);

    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);

    applyForce(steer);
  }

  void drawShape() {
    fill(127);
    stroke(0);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
  }

  void display() {
    float theta = velocity.heading() + radians(90);

    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    drawShape();
    popMatrix();
  }

  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }
}

// A method just to draw the circle associated with wandering
void drawWanderStuff(PVector position, PVector circle, PVector target, float rad) {
  stroke(0);
  noFill();
  ellipseMode(CENTER);
  ellipse(circle.x, circle.y, rad*2, rad*2);
  ellipse(target.x, target.y, 4, 4);
  line(position.x, position.y, circle.x, circle.y);
  line(circle.x, circle.y, target.x, target.y);
}
