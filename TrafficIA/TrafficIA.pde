boolean debug = false;


//Lista de caminos.
ArrayList<Path> pathsL = new ArrayList<Path>();
//Matriz en la cual se manejaran las cosas de las calles.
Block [][]blocks;
//Tamaño de las "Ciudad" N X N.
int streetSize = 9;
//Lista de los vehiculos(Agentes).
ArrayList<Vehicle> vehicles;

void setup() {
  size(920,750);
  initStreet();
  initPaths();
  initVehicle();
}

void initStreet(){
  int blockSize = 120;
  blocks = new Block[streetSize][streetSize];
  for (int i = 0; i < streetSize; i++) {
    for (int j = 0; j < streetSize; j++) {
      if(i%2 == 0 && j%2 ==2){
        blocks[i][j] = new Block(true);
      }else{
        blocks[i][j] = new Block(new PVector(blockSize*j+10,blockSize*i+10),new PVector(blockSize*j+10,blockSize*(i+1)+10));
      }
    }
  }
  
}

void initPaths(){
  for (int i = 0; i < streetSize; i++) {
    if(i%2 != 0){
       newPathHor(blocks[i]);
       newPathVer(getColumn(blocks, i));
    }
  }
}

void initVehicle(){
  // Se colocan los vehiculos en alguna posicion de inicio valida.
  
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < 120; i++) {
    int pathx = (int)random(1);
    int pathy = (int)random(5);
    pathx = (int)random(4);
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
    int pathR = (int)random(pathsL.size());
    newVehicle(initPosition.x,initPosition.y,pathsL.get(pathR));
    
  }

}


void draw() {
  background(255);
  // Muestra los caminos
  for(Path p:pathsL){
      p.display();
  }
  
  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles,v.initPath);
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }

  // Instructions
  fill(0);
  textAlign(CENTER);
  text("Hit 'd' to toggle debugging lines.\nClick the mouse to generate new vehicles.",width/2,height-20);
}

void newPathVer(Block [] block) {
  // Crea los dos carriles que tiene los caminos en este caso los caminos verticales
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
  // Crea los dos carriles que tiene los caminos en este caso los caminos horizontales
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


void newVehicle(float x, float y,Path init) {
  float maxspeed = random(2,5);
  float maxforce = 0.3;
  color c = color(random(0,255),random(0,255),random(0,255));
  vehicles.add(new Vehicle(new PVector(x,y),maxspeed,maxforce,c,init));
}

void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
}

void mousePressed() {
  int pathR = (int)random(pathsL.size());
  newVehicle(mouseX,mouseY,pathsL.get(pathR));
}


public static Block[] getColumn(Block[][] array, int index){
    Block[] column = new Block[array[0].length]; // Here I assume a rectangular 2D array! 
    for(int i=0; i<column.length; i++){
       column[i] = array[i][index];
    }
    return column;
}