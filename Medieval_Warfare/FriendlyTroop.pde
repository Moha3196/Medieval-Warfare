class FriendlyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, reach; //allegiance defines the troop's faction (player or enemy)
  float damage, maxHP, currentHP;
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  boolean occupied = false; //Boolean to check if in Combat
  boolean friendlyOccupied = false; //Booleans to check if there is friendly troops not moving infront
  boolean friendlyInFront = false; //Booleans to check if there is friendly troops moving infront
  boolean attackingCastle = false; //Boolean to check if troop is attacking castle
  boolean isDead = false; //Boolean to check if troop is dead
  float statsUpgrade = 1;
  float worth;
  int troopLevel; //Shows the current troop lvl
  EnemyTroop currentEnemyTroop; //Object used to save the currentEnemyTroop that the FriendlyTroop is fighting
  FriendlyTroop friendlyTroopInFront; //Object used to save the EnemyTroop infront of the current EnemyTroop 

  FriendlyTroop () {
    pos.x = h.selectorX + 20;
    pos.y = h.selectorY;
    isDead = false;
  }


  void update() {
    if (!occupied && !friendlyOccupied && !friendlyInFront && !attackingCastle && !h.settingsOpen) {
      pos.add(speed);
    }
    image(troop, pos.x, pos.y);

    if (currentHP > 0) {
      pushMatrix();
      strokeWeight(1);
      fill(255, 0, 0);
      rect(pos.x - 20, pos.y - 40, 40, 7); //Shows the red damaged health bar
      fill(0, 255, 0);
      rect(pos.x - 20, pos.y - 40, 40/maxHP*currentHP, 7); //Shows green health bar
      strokeWeight(4);
      popMatrix();
    }
  }


  void checkCollision() {
    if (pos.x >= width - 75 - reach && pos.x < width) { //Checks collision with Enemy castle
      attackingCastle = true;
      if (millis() - lastTimeAttacked >= attackSpeed*1000 && attackingCastle) {
        currentEnemyCastleHP -= damage;
        lastTimeAttacked = millis();
      }
    }
    

    for (int i = 0; i < ft.size(); i++) {
      if (pos.x >= ft.get(i).pos.x - 30 - 15
        && pos.x < ft.get(i).pos.x
        && pos.y == ft.get(i).pos.y
        && !occupied 
        && !friendlyOccupied
        && !friendlyInFront
        && !ft.get(i).occupied
        && !ft.get(i).friendlyOccupied
        && !ft.get(i).friendlyInFront
        && !ft.get(i).isDead) { //Checks if there is an friendly troop are infront 
        friendlyTroopInFront = ft.get(i); 
        friendlyInFront = true;
      } else if (friendlyInFront) {
        if (friendlyTroopInFront.isDead || pos.x < friendlyTroopInFront.pos.x - 30 - 15) {
          friendlyInFront = false;
        }
      }

      if (pos.x >= ft.get(i).pos.x - 30 - 15 
        && pos.x < ft.get(i).pos.x
        && pos.y == ft.get(i).pos.y 
        && !occupied 
        && !friendlyOccupied
        && (ft.get(i).occupied
        || ft.get(i).friendlyOccupied
        || ft.get(i).attackingCastle)
        && !ft.get(i).isDead) { //Checks collision with friendly troops
        friendlyTroopInFront = ft.get(i); 
        friendlyOccupied = true;
      } else if (friendlyOccupied) {
        if (friendlyTroopInFront.isDead || pos.x < friendlyTroopInFront.pos.x - 30 - 15) {
          friendlyOccupied = false;
          occupied = false;
        }
      }
    }

    for (int i = 0; i < et.size(); i++) {
      if (pos.x >= et.get(i).pos.x - 30 - reach 
        && pos.y == et.get(i).pos.y 
        && !occupied
        && !attackingCastle
        && !et.get(i).isDead) { //Checks collision with enemy troops, if there is changes occupied to be true
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
          f.playerGoldCount += currentEnemyTroop.worth*1.5;
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

  FKnight(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = fKnight;
    speed.x = 0.5;
    speedBeforeContact = speed.x;
    attackSpeed = 1;
    damage = 4 * statsUpgrade;
    maxHP = 25 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    worth = friendlyKnightWorth;
    f.playerGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class FArcher extends FriendlyTroop {

  FArcher(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = fArcher;
    speed.x = 0.5;
    speedBeforeContact = speed.x;
    attackSpeed = 1;
    damage = 4 * statsUpgrade;
    maxHP = 20 * statsUpgrade;
    currentHP = maxHP;
    reach = 150;
    worth = friendlyArcherWorth;
    f.playerGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class FMage extends FriendlyTroop {

  FMage(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = fMage;
    speed.x = 0.5;
    speedBeforeContact = speed.x;
    attackSpeed = 2.5;
    damage = 15 * statsUpgrade;
    maxHP = 25 * statsUpgrade;
    currentHP = maxHP;
    reach = 80;
    worth = friendlyMageWorth;
    f.playerGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class FCavalry extends FriendlyTroop {

  FCavalry(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = fCavalry;
    speed.x = 0.9;
    speedBeforeContact = speed.x;
    attackSpeed = 1.5;
    damage = 5 * statsUpgrade;
    maxHP = 50 * statsUpgrade;
    currentHP = maxHP;
    reach = 30;
    worth = friendlyCavalryWorth;
    f.playerGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}


class FGiant extends FriendlyTroop {

  FGiant(int lvl) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = fGiant;
    speed.x = 0.3;
    speedBeforeContact = speed.x;
    attackSpeed = 2;
    damage = 10 * statsUpgrade;
    maxHP = 75 * statsUpgrade;
    currentHP = maxHP;
    reach = 10;
    worth = friendlyGiantWorth;
    f.playerGoldCount -= worth;
    troopLevel = lvl;
  }

  void collision() {
  }
}
