class FriendlyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, reach; //allegiance defines the troop's faction (player or enemy)
  float damage, maxHP, currentHP;
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  boolean occupied = false;
  boolean isDead = false;
  float statsUpgrade = 1;


  FriendlyTroop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
    isDead = false;
  }


  void update() {
    if (!occupied) {
      pos.add(speed);
    }
    image(troop, pos.x, pos.y);

    pushMatrix();
    strokeWeight(1);
    fill(255, 0, 0);
    rect(pos.x - 20, pos.y - 40, 40, 7);
    fill(0, 255, 0);
    rect(pos.x - 20, pos.y - 40, 40/maxHP*currentHP, 7);
    strokeWeight(4);
    popMatrix();
  }


  void checkCollision() {
    if (pos.x >= width - 75 - reach && pos.x < width) { //Checks collision with Enemy castle
      speed.x = 0;
      if (millis() - lastTimeAttacked >= attackSpeed*1000) {
        currentEnemyCastleHP -= damage;
        lastTimeAttacked = millis();
      }
    }

    for (int i = 0; i < et.size(); i++) {
      if (pos.x >= et.get(i).pos.x - 30 - reach 
        && pos.y == et.get(i).pos.y 
        && occupied == false 
        && et.get(i).isDead == false) { //Checks collision with enemy troops
        occupied = true;
      } else if (occupied) { 
        if (et.get(i).isDead) {
          occupied = false;
        }

        if (et.get(i).currentHP > 0) {
          if (millis() - lastTimeAttacked >= attackSpeed*1000) { //Attack speed is multiplied by 1000 because the millis()
            et.get(i).currentHP -= damage;                      //runs in milli seconds while attack speed is in seconds
            lastTimeAttacked = millis();
          }
        } else {
          occupied = false;
          for (int j = 0; j < ft.size(); j++) {
            if (ft.get(j).pos.y == pos.y) {
              ft.get(j).occupied = false;
            }
          }
          et.get(i).isDead = true;
        }
      }
    }
  }

  void collision() {
  }
}



class FKnight extends FriendlyTroop {

  FKnight(float lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl == 2) {
      statsUpgrade = 1.5;
    } else if (lvl == 3) {
      statsUpgrade = 2.25;
    }
    troop = knight;
    speed.x = 1.2;
    speedBeforeContact = speed.x;
    damage = 5 * statsUpgrade;
    maxHP = 20 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    f.goldCount -= 20;
  }

  void collision() {
  }
}


class FArcher extends FriendlyTroop {

  FArcher(float lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl == 2) {
      statsUpgrade = 1.5;
    } else if (lvl == 3) {
      statsUpgrade = 2.25;
    }
    troop = archer;
    speed.x = 0.9;
    speedBeforeContact = speed.x;
    attackSpeed = 0.5;
    damage = 2 * statsUpgrade;
    maxHP = 15 * statsUpgrade;
    currentHP = maxHP;
    reach = 150;
    f.goldCount -= 25;
  }

  void collision() {
  }
}


class FMage extends FriendlyTroop {

  FMage(float lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl == 2) {
      statsUpgrade = 1.5;
    } else if (lvl == 3) {
      statsUpgrade = 2.25;
    }
    troop = mage;
    speed.x = 0.9;
    speedBeforeContact = speed.x;
    damage = 8 * statsUpgrade;
    maxHP = 15 * statsUpgrade;
    currentHP = maxHP;
    reach = 80;
    f.goldCount -= 40;
  }

  void collision() {
  }
}


class FCavalry extends FriendlyTroop {

  FCavalry(float lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl == 2) {
      statsUpgrade = 1.5;
    } else if (lvl == 3) {
      statsUpgrade = 2.25;
    }
    troop = cavalry;
    speed.x = 1.5;
    speedBeforeContact = speed.x;
    damage = 4 * statsUpgrade;
    maxHP = 50 * statsUpgrade;
    currentHP = maxHP;
    reach = 30;
    f.goldCount -= 70;
  }

  void collision() {
  }
}


class FGiant extends FriendlyTroop {

  FGiant(float lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl == 2) {
      statsUpgrade = 1.5;
    } else if (lvl == 3) {
      statsUpgrade = 2.25;
    }
    troop = giant;
    speed.x = 0.6;
    speedBeforeContact = speed.x;
    attackSpeed = 2;
    damage = 10 * statsUpgrade;
    maxHP = 70 * statsUpgrade;
    currentHP = 70;
    reach = 10;
    f.goldCount -= 100;
  }

  void collision() {
  }
}
