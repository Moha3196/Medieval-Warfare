class EnemyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, reach; //allegiance defines the troop's faction (player or enemy)
  float damage, maxHP, currentHP;
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  boolean occupied = false; //Boolean to check if in Combat
  boolean enemyOccupied = false; //Booleans to check if there is enemy troops not moving infront
  boolean enemyInFront = false; //Booleans to check if there is enemy troops moving infront
  boolean isDead = false; //Boolean to check if troop is dead
  float statsUpgrade = 1;
  int worth;
  int troopLevel; //Shows the current troop lvl
  FriendlyTroop currentFriendlyTroop; //Object used to save the currentFriendlyTroop that the EnemyTroop is fighting
  EnemyTroop enemyTroopInFront; //Object used to save the FriendlyTroop infront of the current FriendlyTroop 


  EnemyTroop () {
    pos.x = width - h.selectorX - 20;
    pos.y = h.selectorY;
    isDead = false;
  }


  void update() {
    if (!occupied && !enemyOccupied && !enemyInFront) {
      pos.add(speed);
    }
    pushMatrix();
    translate(pos.x, pos.y);
    scale(-1, 1);
    image(troop, 0, 0);
    popMatrix();

    if (currentHP > 0) {
      pushMatrix();
      strokeWeight(1);
      fill(255, 0, 0);
      rect(pos.x - 20, pos.y - 40, 40, 7);
      fill(0, 255, 0);
      rect(pos.x - 20, pos.y - 40, 40/maxHP*currentHP, 7);
      strokeWeight(4);
      popMatrix();
    }
  }


  void checkCollision() {
    if (pos.x <= 0 + 75 + reach && pos.x > 0) { //Checks collision with Friendly castle
      speed.x = 0;
      if (millis() - lastTimeAttacked >= attackSpeed*1000) {
        currentFriendlyCastleHP -= damage;
        lastTimeAttacked = millis();
      }
    }

    for (int i = 0; i < et.size(); i++) {
      if (pos.x <= et.get(i).pos.x + 30 + 15
        && pos.x > et.get(i).pos.x
        && pos.y == et.get(i).pos.y
        && !occupied 
        && !enemyOccupied
        && !enemyInFront
        && !et.get(i).occupied
        && !et.get(i).enemyOccupied
        && !et.get(i).enemyInFront
        && !et.get(i).isDead) { //Checks if there is an enemy troop are infront 
        enemyTroopInFront = et.get(i); 
        enemyInFront = true;
      } else if (enemyInFront) {
        if (enemyTroopInFront.isDead || pos.x > enemyTroopInFront.pos.x + 30 + 15) {
          enemyInFront = false;
        }
      }

      if (pos.x <= et.get(i).pos.x + 30 + 15 
        && pos.x > et.get(i).pos.x
        && pos.y == et.get(i).pos.y 
        && !occupied 
        && !enemyOccupied
        && (et.get(i).occupied
        || et.get(i).enemyOccupied)
        && !et.get(i).isDead) { //Checks collision with friendly troops
        enemyTroopInFront = et.get(i); 
        enemyOccupied = true;
      } else if (enemyOccupied) {
        if (enemyTroopInFront.isDead || pos.x > enemyTroopInFront.pos.x + 30 + 15) {
          enemyOccupied = false;
          occupied = false;
        }
      }
    }

    for (int i = 0; i < ft.size(); i++) {
      if (pos.x <= ft.get(i).pos.x + 30 + reach 
        && pos.y == ft.get(i).pos.y 
        && !occupied 
        && !ft.get(i).isDead) { //Checks collision with friendly troops, if there is changes occupied to be true
        currentFriendlyTroop = ft.get(i); 
        occupied = true;
      } else if (occupied) { 
        if (currentFriendlyTroop.isDead) {
          occupied = false;
        }

        if (currentFriendlyTroop.currentHP > 0) {
          if (millis() - lastTimeAttacked >= attackSpeed*1000) { //Attack speed is multiplied by 1000 because the millis()
            currentFriendlyTroop.currentHP -= damage;            //runs in milli seconds while attack speed is in seconds
            lastTimeAttacked = millis();
          }
        } else {
          occupied = false;
          f.enemyGoldCount += currentFriendlyTroop.worth*1.5;
          for (int j = 0; j < et.size(); j++) {
            if (et.get(j).pos.y == pos.y) {
              et.get(j).occupied = false;
              et.get(j).enemyOccupied = false;
            }
          }
          currentFriendlyTroop.isDead = true;
          for (int j = 0; j < ft.size(); j++) {
            if (ft.get(j).pos.y == pos.y) {
              ft.get(j).friendlyOccupied = false;
            }
          }
        }
      }
    }
  }

  void collision() {
  }
}



class EKnight extends EnemyTroop {

  EKnight(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = eKnight;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    damage = 5 * statsUpgrade;
    maxHP = 20 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    worth = 20;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
  }


  void collision() {
  }
}


class EArcher extends EnemyTroop {

  EArcher(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eArcher;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    attackSpeed = 0.5;
    damage = 2 * statsUpgrade;
    maxHP = 15 * statsUpgrade;
    currentHP = maxHP;
    reach = 150;
    worth = 25;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class EMage extends EnemyTroop {

  EMage(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eMage;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    damage = 8 * statsUpgrade;
    maxHP = 15 * statsUpgrade;
    currentHP = maxHP;
    reach = 80;
    worth = 40;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class ECavalry extends EnemyTroop {

  ECavalry(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eCavalry;
    speed.x = -0.9;
    speedBeforeContact = speed.x;
    damage = 4 * statsUpgrade;
    maxHP = 50 * statsUpgrade;
    currentHP = maxHP;
    reach = 30;
    worth = 70;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class EGiant extends EnemyTroop {

  EGiant(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eGiant;
    speed.x = -0.3;
    speedBeforeContact = speed.x;
    attackSpeed = 2;
    damage = 10 * statsUpgrade;
    maxHP = 70 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    worth = 100;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}
