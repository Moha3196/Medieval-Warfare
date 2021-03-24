class EnemyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach; //allegiance defines the troop's faction (player or enemy)
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  boolean occupied = false;
  boolean isDead = false;


  EnemyTroop () {
    pos.x = width - h.selectorX + 20;
    pos.y = h.selectorY;
    isDead = false;
  }


  void update() {
    if (!occupied) {
      pos.add(speed);
    }
    pushMatrix();
    translate(pos.x, pos.y);
    scale(-1, 1);
    image(troop, 0, 0);
    popMatrix();
  }


  void checkCollision() {
    if (pos.x <= 0 + 75 + reach && pos.x > 0) { //Checks collision with Friendly castle
      speed.x = 0;
      if (millis() - lastTimeAttacked >= attackSpeed*1000) {
        currentFriendlyCastleHP -= damage;
        lastTimeAttacked = millis();
      }
    }
    //int i = ft.size()-1; i > 0; i--
    for (int i = 0; i < ft.size(); i++) {
      if (pos.x <= ft.get(i).pos.x + 30 + reach 
          && pos.y == ft.get(i).pos.y 
          && occupied == false 
          && ft.get(i).isDead == false) { //Checks collision with friendly troops
        //speed.x = 0;
        occupied = true;
      } else if (occupied) { 
        if (ft.get(i).isDead) {
          occupied = false;
        }
        
        if (ft.get(i).hp >= 0) {
          if (millis() - lastTimeAttacked >= attackSpeed*1000) { //Attack speed is multiplied by 1000 because the millis()
            ft.get(i).hp -= damage;                              //runs in milli seconds while attack speed is in seconds
            lastTimeAttacked = millis();
          }
        } else {
          occupied = false;
          for (int j = 0; j < et.size(); j++) {
            if (et.get(j).pos.y == pos.y)
              et.get(j).occupied = false;
          }
          ft.get(i).isDead = true;
        }
      }
    }
  }

  void collision() {
  }
}



class ESwordsman extends EnemyTroop {

  ESwordsman() {
    super();
    troop = swordsman;
    speed.x = -1.2;
    speedBeforeContact = speed.x;
    damage = 5;
    hp = 20;
    reach = 10;
    f.goldCount -= 20;
  }


  void collision() {
  }
}


class EArcher extends EnemyTroop {

  EArcher() {
    super();
    troop = archer;
    speed.x = -0.9;
    speedBeforeContact = speed.x;
    damage = 2;
    attackSpeed = 0.5;
    hp = 15;
    reach = 150;
    f.goldCount -= 25;
  }

  void collision() {
  }
}


class EMage extends EnemyTroop {

  EMage() {
    super();
    troop = mage;
    speed.x = -0.9;
    speedBeforeContact = speed.x;
    damage = 8;
    hp = 15;
    reach = 80;
    f.goldCount -= 40;
  }

  void collision() {
  }
}


class ECavalry extends EnemyTroop {

  ECavalry() {
    super();
    troop = cavalry;
    speed.x = -1.5;
    speedBeforeContact = speed.x;
    damage = 4;
    hp = 50;
    reach = 30;
    f.goldCount -= 70;
  }

  void collision() {
  }
}


class EGiant extends EnemyTroop {

  EGiant() {
    super();
    troop = giant;
    speed.x = -0.6;
    speedBeforeContact = speed.x;
    damage = 10;
    attackSpeed = 2;
    hp = 70;
    reach = 10;
    f.goldCount -= 100;
  }

  void collision() {
  }
}
