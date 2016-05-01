class PathBlock{

  PVector initP;
  PVector finalP;
  
  PathBlock(PVector initP, PVector finalP, boolean dir){
    if(dir){
      this.initP = new PVector(initP.x+11,initP.y);
      this.finalP = new PVector(finalP.x+11,finalP.y);
    }else{
      this.initP = new PVector(initP.x-11,initP.y);
      this.finalP = new PVector(finalP.x-11,finalP.y);
    }
  }
}