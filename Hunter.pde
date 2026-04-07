/* Unused while we follow Herbi instructions */

/*
TODO: Move into function in Hunter from previous wanderers iteration loop in draw mainloop
 
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
 */
class Hunter extends Vehicle {
  Hunter(float x, float y) {
    super(x, y);
  }

  void hunterKill(Herbi target) {
    for (int i = 0; i < objects.length; i++) {
      if (objects[i] == target) {
        PVector _pos = objects[i].position.copy();

        objects[i] = new Hunter(_pos.x, _pos.y);
      }
    }
  }

  void drawShape() {
    fill(255, 0, 0);
    stroke(0);

    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
  }
}
