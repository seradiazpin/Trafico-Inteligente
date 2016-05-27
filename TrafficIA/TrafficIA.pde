import java.util.Collections;

//Constantes para mostrar informacion de debug
boolean debug = false;
boolean debugP = false;

//Lista de caminos.
ArrayList<Path> pathsL = new ArrayList<Path>();

//Matriz en la cual se manejaran las cosas de las calles.
Block [][]blocks;

//Tamaño de las "Ciudad" V X H.
int streetSizeV = 7;
int streetSizeH = 8;
int carNum = 30;

//Lista de los vehiculos(Agentes).
ArrayList<Vehicle> vehicles;

//Se inicializan todos los valores
void setup() {
  size(720, 750);
  initStreet();
  initPaths();
  initVehicle();
}

/*
* Inicializar calles, se llena la matriz de bloques, solo se llenan las posiciones que pueden ser validas
* %2 se ponen los puntos con una distancia de @blockSize
*/
void initStreet() {
  int blockSize = 120;
  blocks = new Block[streetSizeV][streetSizeH];
  for (int i = 0; i < streetSizeV; i++) {
    for (int j = 0; j < streetSizeH; j++) {
      if (i%2 == 0 && j%2 ==2) {
        blocks[i][j] = new Block(true);
      } else {
        blocks[i][j] = new Block(new PVector(blockSize*j-50, blockSize*i-50), new PVector(blockSize*j-50, blockSize*(i+1)-50));
      }
      //System.out.println("Bloq["+i+"]["+j+"]->"+blocks[i][j].isBulding);
    }
  }
}

/*
*Se inicializan los caminos con la informacion de la matriz de bloquez,
*las filas y columnas son caminos
*/
void initPaths() {
  for (int i = 0; i < streetSizeV; i++) {
    if (i%2 != 0) {
      newPathHor(blocks[i]);
      newPathVer(getColumn(blocks, i, streetSizeV));
    }
  }
}

/*
* Se inicializan los vehiculos en una pocicion inicial y se le asigna a la calle 
* que contiene esa posicion inicial.
*/
void initVehicle() {
  vehicles = new ArrayList<Vehicle>();
  for (int i = 0; i < carNum; i++) {
    PVector initPosition = initPosition();
    Path pathInit = new Path();
    for (Path p : pathsL) {
      if (p.hasPoint(initPosition)){
        pathInit = p;
      }
    }
    newVehicle(initPosition.x, initPosition.y, pathInit);
  }
}
/*
* Se genera una posicion inicial aleatoria en una posicion al comienzo de la via
*/
PVector initPosition(){
  int pathx = (int)random(1);
    int pathy = (int)random(streetSizeV);
    pathx = (int)random(4);
    while (pathy %2 == 0) {
      pathy = (int)random(streetSizeV);
    }
    PVector initPosition = blocks[0][1].partOne.initP;
      switch(pathx) {
      case 0:
        initPosition = blocks[0][pathy].partOne.initP;
        break;
      case 1:
        initPosition = blocks[pathy][0].partOne.initP;
        break;
      case 2:
        initPosition = blocks[streetSizeV-1][pathy].partOne.initP;
        break;
      case 3:
        initPosition = blocks[pathy][streetSizeV-1].partOne.initP;
        break;
      }
    return initPosition;
}


/*
* Se dibuja los componentes del programa
*/
void draw() {
  background(255);
  // Muestra los caminos
  for (Path p : pathsL) {
    p.display();
  }
  for (Vehicle v : vehicles) {
    // Path following and separation are worked on in this function
    v.applyBehaviors(vehicles, v.initPath);
    // Call the generic run method (update, borders, display, etc.)
    v.run();
  }

  // Instrucciones
  fill(0);
  textAlign(CENTER);
  text("Hit 'd' to toggle debugging lines.\nClick the mouse to generate new vehicles.", width/2, height-20);
  text("Hit 'p' to toggle pheromones.", width/2, height-40);
}

/*
* Genera dos carriles que tiene los caminos en este caso los caminos verticales
*/
void newPathVer(Block [] block) {
  Path path = new Path();
  Path path2 = new Path();
  for (Block x : block) {
    path.addPointVector(x.partOne.initP);
    path.addPointVector(x.partOne.finalP);

    path2.addPointVector(x.partTwo.initP);
    path2.addPointVector(x.partTwo.finalP);
  }
  pathsL.add(path);
  Collections.reverse(path2.points);
  pathsL.add(path2);
}

/*
* Genera dos carriles que tiene los caminos en este caso los caminos Horizontales
*/
void newPathHor(Block [] block) {
  Path path = new Path();
  Path path2 = new Path();
  for (Block x : block) {
    path.addPointVector(x.partTwo.finalP);
    path.addPointVector(x.partOne.initP);

    path2.addPoint(x.partTwo.initP.x, x.partTwo.initP.y-98);
    path2.addPoint(x.partOne.finalP.x, x.partOne.finalP.y-98);
  }
  pathsL.add(path);
  Collections.reverse(path2.points);
  pathsL.add(path2);
}

/*
* Crear un nuevo vehiculo al sistema
*/
void newVehicle(float x, float y, Path init) {
  float maxspeed = random(2, 5);
  float maxforce = 0.3;
  color c = color(random(0, 255), random(0, 255), random(0, 255));
  vehicles.add(new Vehicle(new PVector(x, y), maxspeed, maxforce, c, init));
}

/*
*Para activar las opciones de debugin
*/
void keyPressed() {
  if (key == 'd') {
    debug = !debug;
  }
  if(key == 'p'){
    debugP = !debugP;
  }
}

/*
* Crear un carro cuando se hace click
*/
void mousePressed() {
  int pathR = (int)random(pathsL.size());
  newVehicle(mouseX, mouseY, pathsL.get(pathR));
}

/*
* Obtener la columna de una matriz
*/
public static Block[] getColumn(Block[][] array, int index, int size) {
  Block[] column = new Block[size]; // Here I assume a rectangular 2D array!
  //System.out.println("length->"+array[0].length);
  for (int i=0; i<column.length; i++) {
    //System.out.println("Colum["+i+"]->array["+i+"]["+index+"]");
    column[i] = array[i][index];
  }
  return column;
}