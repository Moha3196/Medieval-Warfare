class Troop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach;  //allegiance defines the troop's faction (player or enemy)
  color c;  //temporary - only used to give temp troops (circles) different colors to distinguish them
  
  Troop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
  }
  
  
  void update() {
    pushMatrix();
    fill(c); //temporary - only used for the temp colors
    pos.add(speed);
    circle(pos.x, pos.y, 30);
    popMatrix();
  }
  
  
  void checkCollision() {
    
    
  }
  
  void collision() {
    
  }
}



class Swordsman extends Troop {
  
  Swordsman() {
    super();
    c = color(0, 255, 0); //for the temp color of troops - not needed when troops have been drawn
    hp = 20;
    f.goldCount -= 20;
  }
  
  void collision() {
    
  }
}


class Archer extends Troop {
  
  Archer() {
    super();
    c = color(255, 255, 0);
    hp = 15;
    f.goldCount -= 25;
  }
  
  void collision() {
    
  }
}


class Mage extends Troop {
  
  Mage() {
    super();
    c = color(0, 0, 255);
    hp = 15;
    f.goldCount -= 40;
  }
  
  void collision() {
    
  }
}


class Cavalry extends Troop {
  
  Cavalry() {
    super();
    c = color(255, 0, 255);
    hp = 50;
    f.goldCount -= 70;
  }
  
  void collision() {
    
  }
}


class Giant extends Troop {
  
  Giant() {
    super();
    c = color(0, 0, 0);
    hp = 70;
    f.goldCount -= 100;
  }
  
  void collision() {
    
  }
}
