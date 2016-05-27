// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// Path Following

class Path {
  // A Path is an arraylist of points (PVector objects)
  ArrayList<PVector> points;
  ArrayList<Pheromone> pheromones;
  // A path has a radius, i.e how far is it ok for the boid to wander off
  float radius;

  Path() {
    // Arbitrary radius of 20
    radius = 10;
    points = new ArrayList<PVector>();
    pheromones = new ArrayList<Pheromone>();
  }
  
  

  // Add a point to the path
  void addPoint(float x, float y) {
    PVector point = new PVector(x, y);
    points.add(point);
    pheromones.add(new Pheromone(new PVector(x,y),0));
  }

  void addPointVector(PVector point) {
    points.add(point);
    pheromones.add(new Pheromone(point,0));
  }
  // Draw the path
  void display() {
    strokeJoin(ROUND);
    
    // Draw thick line for radius
    stroke(175);
    strokeWeight(radius*2);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    // Draw thin line for center of path
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    for(Pheromone ph:pheromones){
        ph.render();
    }
    
    endShape(CLOSE);
  }
  
  boolean hasPoint(PVector p){
    return points.contains(p);
  }
}