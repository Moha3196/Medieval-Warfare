class Troop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(0, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach;  //allegiance defines the troop's faction (player or enemy)

  Troop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
  }


  void update() {
    pos.add(speed);
    image(troop, pos.x, pos.y);
  }


  void checkCollision() {
  }

  void collision() {
  }
}



class Swordsman extends Troop {

  Swordsman() {
    super();
    troop = swordsman;
    hp = 20;
    f.goldCount -= 20;
  }


  void collision() {
  }
}


class Archer extends Troop {

  Archer() {
    super();
    troop = archer;
    hp = 15;
    f.goldCount -= 25;
  }

  void collision() {
  }
}


class Mage extends Troop {

  Mage() {
    super();
    troop = mage;
    hp = 15;
    f.goldCount -= 40;
  }

  void collision() {
  }
}


class Cavalry extends Troop {

  Cavalry() {
    super();
    troop = cavalry;
    hp = 50;
    f.goldCount -= 70;
  }

  void collision() {
  }
}


class Giant extends Troop {

  Giant() {
    super();
    troop = giant;
    hp = 70;
    f.goldCount -= 100;
  }

  void collision() {
  }
}
