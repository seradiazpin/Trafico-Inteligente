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
    if(debugP){
      color c;
      if(value >=0 && value <=10){
        c = color(255);
      }else if(value >=10 && value <= 20){
        c = color(50,0,0);
      }else{
        c = color(100,0,0);
      }
      fill(c);
      stroke(0);
      pushMatrix();
      translate(location.x, location.y);
      ellipse(0, 0, 10, 10);
      popMatrix();
    }
  }

}