class Block{
  PathBlock partOne;
  PathBlock partTwo;
  boolean isBulding = false;
  Block(PVector initP, PVector finalP){
      this.partOne = new PathBlock(initP,finalP,true);
      this.partTwo = new PathBlock(finalP,initP,false);
  }
  
  Block(boolean isBulding){
      this.isBulding = isBulding;
  }
  
}