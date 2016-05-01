boolean debug = false;


// A path object (series of connected points)
ArrayList<Path> pathsL = new ArrayList<Path>();
Block [][]blocks;

// Two vehicles
ArrayList<Vehicle> vehicles;

void setup() {
  size(1020,720);
  int streetSize = 10;
  int blockSize = 120;
  blocks = new Block[streetSize][streetSize];
  for (int i = 0; i < streetSize; i++) {
    for (int j = 0; j < streetSize; j++) {
      if(i%2 == 0 && j%2 ==2){
        blocks[i][j] = new Block(true);
      }else{
        blocks[i][j] = new Block(new PVector(blockSize*j+90,blockSize*i+20),new PVector(blockSize*j+90,blockSize*(i+1)+20));
      }
    }
  }
  // Call a function to generate new Path object
  //System.out.println(blocks[3][3].isBulding);
  
  for (int i = 0; i < streetSize; i++) {
    if(i%2 != 0){
       newPathHor(blocks[i]);
       newPathVer(getColumn(blocks, i));
    }
    //System.out.println("HOLA"+i);
  }
  
  // We are now making random vehicles and storing them in an ArrayList
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 12; i++) {
    int pathx = (int)random(1);
    int pathy = (int)random(5);
    pathx = (int)random(3);
    while(pathy %2 == 0){
      pathy = (int)random(5);
    }
    PVector initPosition = blocks[0][1].partOne.initP;
    switch(pathx){
      case 0:
        initPosition = blocks[0][pathy].partOne.initP;
        break;
      case 1:
        initPosition = blocks[pathy][0].partOne.initP;
        break;
      case 2:
        initPosition = blocks[streetSize-1][pathy].partOne.initP;
        break;
      case 3:
        initPosition = blocks[pathy][streetSize-1].partOne.initP;
        break;
    }
    newVehicle(initPosition.x,initPosition.y);
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

void newPathVer(Block [] block) {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  Path path = new Path();
  Path path2 = new Path();
  for(Block x:block){
    path.addPointVector(x.partOne.initP);
    path.addPointVector(x.partOne.finalP);
    
    path2.addPointVector(x.partTwo.initP);
    path2.addPointVector(x.partTwo.finalP);
  }
  pathsL.add(path);
  pathsL.add(path2);
}

void newPathHor(Block [] block) {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  Path path = new Path();
  Path path2 = new Path();
  for(Block x:block){
    path.addPointVector(x.partTwo.finalP);
    path.addPointVector(x.partOne.initP);
    
    path2.addPoint(x.partTwo.initP.x,x.partTwo.initP.y-98);
    path2.addPoint(x.partOne.finalP.x,x.partOne.finalP.y-98);
    
  }
  pathsL.add(path);
  pathsL.add(path2);
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