class Troop {
  PVector pos = new PVector();  //a starting position
  PVector vel = new PVector(1, 1);  //a velocity/heading
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance;  //allegiance defines the troop's faction (player or enemy)
  color c;  //temporary - only used to give temp troops (circles) different colors to distinguish them
  
  Troop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
  }
  
  
  void render() {
    pushMatrix();
    fill(c);  //temporary - only used for the temp colors
    circle(pos.x, pos.y, 30);
    popMatrix();
  }
  
  void update() {
    
  }
  
  
  void checkCollision() {
    
    
  }
  
  void collision() {
    
  }
  void spawnTrooper(){
  }
  
}



class Swordsman extends Troop {
  
  Swordsman() {
    super();
    c = color(0, 255, 0);
    
  }
  
  void collision() {
    
  }
}
