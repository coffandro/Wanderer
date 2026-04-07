/* Unused while we follow Herbi instructions */
class Hunter extends Vehicle {
  Hunter(float x, float y) {
    super(x, y);
  }

  void hunterKill(Herbi target) {
    for (int i = 0; i < wanderers.length; i++) {
      if (wanderers[i] == target) {
        PVector _pos = wanderers[i].position.copy();
        
        wanderers[i] = new Hunter(_pos.x, _pos.y);
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
