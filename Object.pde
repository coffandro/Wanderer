class Object {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float maxspeed;

  void calcPosition() {
    velocity.add(acceleration); // Accel from previous frame
    velocity.limit(maxspeed);

    position.add(velocity);

    // reset acceleration every frame
    acceleration.mult(0);
  }
  
  void update() {
  
  }

  void run() {
    calcPosition();
    update();
    display();
  }
  
  void drawShape() {}
  
  void display() {
    float theta = velocity.heading() + radians(90);

    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);

    drawShape();
    popMatrix();
  }
}
