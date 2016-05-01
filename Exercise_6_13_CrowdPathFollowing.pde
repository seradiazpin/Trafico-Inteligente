boolean debug = false;


// A path object (series of connected points)
ArrayList<Path> pathsL = new ArrayList<Path>();
Block [][]blocks;

// Two vehicles
ArrayList<Vehicle> vehicles;

void setup() {
  size(1020,720);
  int streetSize = 7;
  int blockSize = 120;
  blocks = new Block[streetSize][streetSize];
  for (int i = 0; i < streetSize; i++) {
    for (int j = 0; j < streetSize; j++) {
      if(i%2 == 0 && j%2 ==2){
        blocks[i][j] = new Block(true);
      }else{
        blocks[i][j] = new Block(new PVector(blockSize*j+100,blockSize*i+30),new PVector(blockSize*j+100,blockSize*(i+1)+30));
      }
    }
  }
  // Call a function to generate new Path object
  //System.out.println(blocks[3][3].isBulding);
  
  for (int i = 0; i < streetSize; i++) {
    if(i%2 != 0){
       pathsL.add(newPathHor(blocks[i]));
       pathsL.add(newPathVer(getColumn(blocks, i)));
    }
    //System.out.println("HOLA"+i);
  }
  
  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 12; i++) {
    newVehicle(random(width),random(height));
  }
}

void draw() {
  background(255);
  // Display the path
  for(Path p:pathsL){
      p.display();
  }
  

  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles,pathsL.get(4));
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }

  // Instructions
  fill(0);
  textAlign(CENTER);
  text("Hit 'd' to toggle debugging lines.\nClick the mouse to generate new vehicles.",width/2,height-20);
}

Path newPathVer(Block [] block) {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  Path path = new Path();
  float offset = 30;
  for(Block x:block){
    path.addPointVector(x.partOne.initP);
    path.addPointVector(x.partOne.finalP);
  }
  
  return path;
}

Path newPathHor(Block [] block) {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  Path path = new Path();
  float offset = 30;
  for(Block x:block){
    path.addPointVector(x.partTwo.finalP);
    path.addPointVector(x.partOne.initP);
    
  }
  
  return path;
}


void newVehicle(float x, float y) {
  float maxspeed = random(2,4);
  float maxforce = 0.3;
  color c = color(random(0,255),random(0,255),random(0,255));
  vehicles.add(new Vehicle(new PVector(x,y),maxspeed,maxforce,c));
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
}

void mousePressed() {
  newVehicle(mouseX,mouseY);
}


public static Block[] getColumn(Block[][] array, int index){
    Block[] column = new Block[array[0].length]; // Here I assume a rectangular 2D array! 
    for(int i=0; i<column.length; i++){
       column[i] = array[i][index];
    }
    return column;
}