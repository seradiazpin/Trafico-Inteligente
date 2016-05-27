class Block{
  //Tiene dos caminos el que va de una direccion y el que va de otra direccion
  PathBlock partOne;
  PathBlock partTwo;
  //Para ver si es un 'edificio', una posicion no valida
  boolean isBulding = false;
  Block(PVector initP, PVector finalP){
      this.partOne = new PathBlock(initP,finalP,true);
      this.partTwo = new PathBlock(finalP,initP,false);
  }
  
  Block(boolean isBulding){
      this.isBulding = isBulding;
  }
  
}