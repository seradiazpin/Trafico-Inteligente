class Pheromone{
  PVector location;
  double value;
  
  Pheromone(PVector location, double value){
    this.location = location;
    this.value = value;
  }
  
 void updatePheromone(double value){
    this.value = value;
  }
  
    void render() {
      // Simpler boid is just a circle
      color c = color(255);
      fill(c);
      stroke(0);
      pushMatrix();
      translate(location.x, location.y);
      ellipse(0, 0, 3, 3);
      popMatrix();
     }

}