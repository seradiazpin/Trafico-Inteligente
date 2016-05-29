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
  
  boolean condition(double val,int a, int b){
    return val >=a && val <=b;
  }
  
  void render() {
  // Simpler boid is just a circle
  //System.out.println(value);
    if(debugP){
      color c;
      if(value<=0){
        c = color(255);
      }else if(condition(value,0,40)){
        c = color(0,250,0);
      }else if(condition(value,40,80)){
        c = color(0,225,0);
      }else if(condition(value,80,120)){
        c = color(0,200,0);
      }else if(condition(value,120,160)){
        c = color(0,175,0);
      }else if(condition(value,160,200)){
        c = color(0,100,0);
      }else if(condition(value,200,240)){
        c = color(125,125,0);
      }else if(condition(value,240,280)){
        c = color(150,100,0);
      }else if(condition(value,280,320)){
        c = color(175,75,0);
      }else if(condition(value,320,360)){
        c = color(200,50,0);
      }else if(condition(value,360,400)){
        c = color(225,25,0);
      }else{
        c = color(255,0,0);
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