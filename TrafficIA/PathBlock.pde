class PathBlock{

  PVector initP;
  PVector finalP;
  ArrayList<Pheromone> pheromones;
  
  PathBlock(PVector initP, PVector finalP, boolean dir){
    if(dir){
      this.initP = new PVector(initP.x+11,initP.y);
      this.finalP = new PVector(finalP.x+11,finalP.y);
    }else{
      this.initP = new PVector(initP.x-11,initP.y);
      this.finalP = new PVector(finalP.x-11,finalP.y);
    }
    //pheromones = new ArrayList<Pheromone>();
    //initPheromones();
  }
  
  void initPheromones(){
    if(initP.x == finalP.x){
      float delta = (finalP.y-initP.y)/10.0;
      System.out.println("Figura x->"+delta);
      for(float i = initP.y;i<= finalP.y;i=i+delta){
        pheromones.add(new Pheromone(new PVector(initP.x,i),0));
      }
    }else if(initP.y == finalP.y){
      float delta = (finalP.x-initP.x)/10.0;
      System.out.println("Figura y->"+delta);
      for(float i = initP.x;i<= finalP.x;i=i+delta){
        pheromones.add(new Pheromone(new PVector(i,initP.y),0));
      }
    }
  }
  /*
  void render(){
    for(Pheromone p:pheromones){
      p.render();
    }
  }*/
}