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
  boolean friendlyOccupied = false;
  boolean isDead = false;
  float statsUpgrade = 1;
  EnemyTroop currentEnemyTroop; //Object used to save the currentEnemyTroop that the FriendlyTroop is fighting
  FriendlyTroop friendlyTroopInFront; //Object used to save the EnemyTroop infront of the current EnemyTroop 

  FriendlyTroop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
    isDead = false;
  }


  void update() {
    if (!occupied && !friendlyOccupied) {
      pos.add(speed);
    }
    image(troop, pos.x, pos.y);

    pushMatrix();
    strokeWeight(1);
    fill(255, 0, 0);
    rect(pos.x - 20, pos.y - 40, 40, 7); //Shows the red damaged health bar
    fill(0, 255, 0);
    rect(pos.x - 20, pos.y - 40, 40/maxHP*currentHP, 7); //Shows green health bar
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

    for (int i = 0; i < ft.size(); i++) {
      if (pos.x >= ft.get(i).pos.x - 30 - reach 
        && pos.y == ft.get(i).pos.y 
        && occupied == false 
        && friendlyOccupied == false
        && (ft.get(i).occupied == true
        || ft.get(i).friendlyOccupied == true)
        && ft.get(i).isDead == false) { //Checks collision with friendly troops
        friendlyTroopInFront = ft.get(i); 
        friendlyOccupied = true;
      } else if (friendlyOccupied) {
        println(friendlyTroopInFront.isDead);
        if (friendlyTroopInFront.isDead) {
          println("DEAD");
          friendlyOccupied = false;
          occupied = false;
        }
      }
    }

    for (int i = 0; i < et.size(); i++) {
      if (pos.x >= et.get(i).pos.x - 30 - reach 
        && pos.y == et.get(i).pos.y 
        && occupied == false 
        && et.get(i).isDead == false) { //Checks collision with enemy troops, if there is changes occupied to be true
        currentEnemyTroop = et.get(i); 
        occupied = true;
      } else if (occupied) { 
        if (currentEnemyTroop.isDead) {
          occupied = false;
        }

        if (currentEnemyTroop.currentHP > 0) {
          if (millis() - lastTimeAttacked >= attackSpeed*1000) { //Attack speed is multiplied by 1000 because the millis()
            currentEnemyTroop.currentHP -= damage;               //runs in milli seconds while attack speed is in seconds
            lastTimeAttacked = millis();
          }
        } else {
          occupied = false;
          for (int j = 0; j < ft.size(); j++) {
            if (ft.get(j).pos.y == pos.y) {
              ft.get(j).occupied = false;
              ft.get(j).friendlyOccupied = false;
            }
          }
          currentEnemyTroop.isDead = true;
          for (int j = 0; j < et.size(); j++) {
            if (et.get(j).pos.y == pos.y) {
              et.get(j).enemyOccupied = false;
            }
          }
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
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
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
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
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
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
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
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
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
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = giant;
    speed.x = 0.6;
    speedBeforeContact = speed.x;
    attackSpeed = 2;
    damage = 10 * statsUpgrade;
    maxHP = 70 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    f.goldCount -= 100;
  }

  void collision() {
  }
}
