class EnemyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, reach; //allegiance defines the troop's faction (player or enemy)
  float damage, maxHP, currentHP;
  float attackFreq; //the attack speed of a troop - not constant for all troops
  int attackCD;
  boolean occupied = false; //Boolean to check if in Combat
  boolean enemyOccupied = false; //Boolean to check if there is enemy troops not moving infront
  boolean enemyInFront = false; //Boolean to check if there is enemy troops moving infront
  boolean attackingCastle = false; //Boolean to check if troop is attacking castle
  boolean isDead = false;
  float statsUpgrade;
  float worth;
  int troopLevel; //Shows the current troop lvl
  FriendlyTroop currFoe; //Object used to save the currFoe that the EnemyTroop is fighting. "curr" just means "current"
  EnemyTroop enemyAhead; //Object used to save the FriendlyTroop infront of the current FriendlyTroop 


  EnemyTroop () {
    pos.x = width - h.selectorX - 20;
    isDead = false;
    attackCD = millis();
  }


  void update() {
    if (!occupied && !enemyOccupied && !enemyInFront && !attackingCastle && !h.settingsOpen) {
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
      attackingCastle = true;
      if (millis() - attackCD >= attackFreq*1000 && attackingCastle) {
        f.fCastleCurrHP -= damage;
        attackCD = millis();
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
        enemyAhead = et.get(i); 
        enemyInFront = true;
      } else if (enemyInFront) {
        if (enemyAhead.isDead || pos.x > enemyAhead.pos.x + 30 + 15) {
          enemyInFront = false;
        }
      }

      if (pos.x <= et.get(i).pos.x + 30 + 15 
        && pos.x > et.get(i).pos.x
        && pos.y == et.get(i).pos.y 
        && !occupied 
        && !enemyOccupied
        && (et.get(i).occupied
        || et.get(i).enemyOccupied
        || et.get(i).attackingCastle)
        && !et.get(i).isDead) { //Checks collision with friendly troops
        enemyAhead = et.get(i); 
        enemyOccupied = true;
      } else if (enemyOccupied) {
        if (enemyAhead.isDead || pos.x > enemyAhead.pos.x + 30 + 15) {
          enemyOccupied = false;
          occupied = false;
        }
      }
    }

    for (int i = 0; i < ft.size(); i++) {
      if (pos.x <= ft.get(i).pos.x + 30 + reach 
        && pos.y == ft.get(i).pos.y 
        && !occupied
        && !attackingCastle
        && !ft.get(i).isDead) { //Checks collision with friendly troops, if there is changes occupied to be true
        currFoe = ft.get(i); 
        occupied = true;
      } else if (occupied) { 
        if (currFoe.isDead) {
          occupied = false;
        }

        if (currFoe.currentHP > 0) {
          if (millis() - attackCD >= attackFreq*1000) { //Attack speed is multiplied by 1000 because the millis()
            currFoe.currentHP -= damage;                //runs in milli seconds while attack speed is in seconds
            attackCD = millis();
          }
        } else {
          occupied = false;
          f.enemyGoldCount += currFoe.worth*1.5;
          for (int j = 0; j < et.size(); j++) {
            if (et.get(j).pos.y == pos.y) {
              et.get(j).occupied = false;
              et.get(j).enemyOccupied = false;
            }
          }
          currFoe.isDead = true;
          for (int j = 0; j < ft.size(); j++) {
            if (ft.get(j).pos.y == pos.y) {
              ft.get(j).friendlyOccupied = false;
            }
          }
        }
      }
    }
  }
}



class EKnight extends EnemyTroop {

  EKnight(int lvl, int yPos) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    } 
    troop = eKnight;
    speed.x = -0.5;
    attackFreq = 1;
    damage = 4 * statsUpgrade * f.multiplier;
    maxHP = 25 * statsUpgrade * f.multiplier;
    currentHP = maxHP;
    reach = 10;
    worth = f.eTroopPrices[0] * f.multiplier;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
    pos.y = yPos;
  }
}


class EArcher extends EnemyTroop {

  EArcher(int lvl, int yPos) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eArcher;
    speed.x = -0.5;
    attackFreq = 1;
    damage = 4 * statsUpgrade * f.multiplier;
    maxHP = 20 * statsUpgrade;
    currentHP = maxHP;
    reach = 100;
    worth = f.eTroopPrices[1] * f.multiplier;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
    pos.y = yPos;
  }
}


class EMage extends EnemyTroop {

  EMage(int lvl, int yPos) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eMage;
    speed.x = -0.5;
    attackFreq = 2;
    damage = 15 * statsUpgrade * f.multiplier;
    maxHP = 25 * statsUpgrade * f.multiplier;
    currentHP = maxHP;
    reach = 80;
    worth = f.eTroopPrices[2];
    f.enemyGoldCount -= worth * f.multiplier;
    troopLevel = lvl;
    pos.y = yPos;
  }
}


class ECavalry extends EnemyTroop {

  ECavalry(int lvl, int yPos) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eCavalry;
    speed.x = -0.9;
    attackFreq = 1.5;
    damage = 5 * statsUpgrade * f.multiplier;
    maxHP = 50 * statsUpgrade * f.multiplier;
    currentHP = maxHP;
    reach = 30;
    worth = f.eTroopPrices[3] * f.multiplier;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
    pos.y = yPos;
  }
}


class EGiant extends EnemyTroop {

  EGiant(int lvl, int yPos) {
    super();
    if (lvl == 1) {
      statsUpgrade = 1;
    } else if (lvl > 1) {
      statsUpgrade = 1.5 * (lvl-1);
    }
    troop = eGiant;
    speed.x = -0.3;
    attackFreq = 2;
    damage = 10 * statsUpgrade * f.multiplier;
    maxHP = 75 * statsUpgrade * f.multiplier;
    currentHP = maxHP;
    reach = 10;
    worth = f.eTroopPrices[4] * f.multiplier;
    f.enemyGoldCount -= worth;
    troopLevel = lvl;
    pos.y = yPos;
  }
}
