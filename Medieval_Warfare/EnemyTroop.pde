class EnemyTroop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector(1, 0);  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, damage, reach; //allegiance defines the troop's faction (player or enemy)
  float maxHP, currentHP;
  float attackSpeed = 1; //the attack speed of a troop - not constant for all troops
  int lastTimeAttacked;
  float speedBeforeContact;
  boolean occupied = false; //Boolean to check if in Combat
  boolean enemyOccupied = false; //Booleans to check if there is enemy troops not moving infront
  boolean enemyInFront = false; //Booleans to check if there is enemy troops moving infront
  boolean isDead = false; //Boolean to check if troop is dead
  int worth;
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
        && occupied == false 
        && enemyOccupied == false
        && enemyInFront == false
        && et.get(i).occupied == false
        && et.get(i).enemyOccupied == false
        && et.get(i).enemyInFront == false
        && et.get(i).isDead == false) { //Checks if there is an enemy troop are infront 
        enemyTroopInFront = et.get(i); 
        enemyInFront = true;
      } else if (enemyInFront) {
        if (enemyTroopInFront.isDead || pos.x > enemyTroopInFront.pos.x + 30 + 15) {
          enemyInFront = false;
        }
      }
      
      if (pos.x <= et.get(i).pos.x + 30 + 15 
        && pos.y == et.get(i).pos.y 
        && occupied == false 
        && enemyOccupied == false
        && (et.get(i).occupied == true
        || et.get(i).enemyOccupied == true)
        && et.get(i).isDead == false) { //Checks collision with friendly troops
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
        && occupied == false 
        && ft.get(i).isDead == false) { //Checks collision with friendly troops, if there is changes occupied to be true
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

  EKnight() {
    super();
    troop = eKnight;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    damage = 5;
    maxHP = 20;
    currentHP = maxHP;
    reach = 10;
    worth = 20;
    f.goldCount -= worth;
  }


  void collision() {
  }
}


class EArcher extends EnemyTroop {

  EArcher() {
    super();
    troop = eArcher;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    damage = 2;
    attackSpeed = 0.5;
    maxHP = 15;
    currentHP = maxHP;
    reach = 150;
    worth = 25;
    f.goldCount -= worth;
  }

  void collision() {
  }
}


class EMage extends EnemyTroop {

  EMage() {
    super();
    troop = eMage;
    speed.x = -0.5;
    speedBeforeContact = speed.x;
    damage = 8;
    maxHP = 15;
    currentHP = maxHP;
    reach = 80;
    worth = 40;
    f.goldCount -= worth;
  }

  void collision() {
  }
}


class ECavalry extends EnemyTroop {

  ECavalry() {
    super();
    troop = eCavalry;
    speed.x = -0.9;
    speedBeforeContact = speed.x;
    damage = 4;
    maxHP = 50;
    currentHP = maxHP;
    reach = 30;
    worth = 70;
    f.goldCount -= worth;
  }

  void collision() {
  }
}


class EGiant extends EnemyTroop {

  EGiant() {
    super();
    troop = eGiant;
    speed.x = -0.3;
    speedBeforeContact = speed.x;
    damage = 10;
    attackSpeed = 2;
    maxHP = 70;
    currentHP = maxHP;
    reach = 10;
    worth = 100;
    f.goldCount -= worth;
  }

  void collision() {
  }
}
