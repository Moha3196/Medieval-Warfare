class Troop {
  Troop currFoe; //declares a Troop for each Troop, so that the Troop being collided with has somewhere to be stored

  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector();  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, currHP, maxHP, damage, reach, attackCD, attackFreq, bounds; //allegiance defines the troop's faction (player = 1, enemy = 0)
  boolean isDead, inCombat, isWaiting;
  //float holder; //only used to hold a value temporarily - used in attackCastle()

  Troop () {
    pos.x = h.selectorX + 20; //places new troop on the battlefield, instead of the selector,
    pos.y = h.selectorY;      //but still on the correct lane
    attackCD = millis(); //the milliseconds it takes before each attack - every troop has one
    attackFreq = 1000; //how often a troop can attack - lower means more frequent and vice versa
    isDead = false;
    inCombat = false;
    isWaiting = false;
  }

  void update() {
    if (!inCombat && !isWaiting) { //troop can't move if in combat or waiting
      pos.add(speed);
    }

    pushMatrix();
    translate(pos.x, pos.y);
    if (allegiance == 0) { //if an enemy troop is being drawn/rendered:
      scale(-1, 1); //flip it with scale
    } else { //if it's a friendly troop:
      scale(1, 1); //leave it be
    }

    image(troop, 0, 0); //"troop" is the troop-image to render - it's defined in each subclass
    popMatrix();

    strokeWeight(1);
    fill(255, 0, 0);
    rect(pos.x - 20, pos.y - 40, 40, 7); //Shows the red part of the health bar (indicates how much damage the troop has taken)
    fill(0, 255, 0);
    rect(pos.x - 20, pos.y - 40, (40 * currHP)/maxHP, 7); //Shows green health bar (indicates the troops' remaining HP)
    
    fill(0);
    text("" + isWaiting, pos.x, pos.y - 80); //debugging
    text("" + inCombat, pos.x, pos.y - 60);   //"
    text(currHP, pos.x, pos.y - 40);                    //"
    //circle(pos.x, pos.y, 10);                         //"
    //circle(pos.x - bounds, pos.y, 15);                //"
    //circle(pos.x + bounds, pos.y, 15);                //"
  }


  void checkCollision() { //checks if another troop is within current troop's reach/range
    for (int i = 0; i < t.size(); i++) {
      if (this.currFoe == null || this.currFoe.isDead) { //no opponent means no combat
        this.inCombat = false;
        //this.isWaiting = true; //for some reason the code just seems to use this value at all times if I define it here >:/
      }
      if (this != t.get(i) && this.pos.y == t.get(i).pos.y) { //should only check other troops, and not itself too and should only check on troop's own lane, not others
        //if (dist(this.pos.x, this.pos.y, t.get(i).pos.x, t.get(i).pos.y) <= abs(this.bounds)) {
        if (this.pos.x + this.reach >= t.get(i).pos.x - 60 && this.pos.x + this.reach <= t.get(i).pos.x + 60) { //checks if another troop is within the current troop's range
          if (this.allegiance != t.get(i).allegiance) { //checks if other troop is current troop's enemy:
            beginCombat(this, t.get(i)); //if so - calls collision/combat function for the two opposing troops
            this.inCombat = true;
            this.isWaiting = false;
          } else if (friendlyCollision(this, t)) { //if not, they must be allies
            startWaiting(this.allegiance, this, t.get(i));
            println("ran wait func");
          } else /*if (t.size() == 1)*/ {
            this.isWaiting = false;
            println("did not run wait func");
          }
        } /*else /*if (this.currFoe == null || this.currFoe.isDead) {
          this.inCombat = false;
        } else if (t.size() == 1) {
          this.isWaiting = false;
        }*/
      }
      
      if (this.allegiance == 1) {
        if (this.pos.x >= width - this.bounds - this.reach && this.pos.x <= width) { //checks if enemy's base is within player's troops' reach:
          f.enemyCurrHP = attackCastle(f.enemyCurrHP, this); //if so, damages the enemy's castle
          if (this.pos.x >= width - this.bounds && this.pos.x <= width) { //once player's troop reaches enemy's base:
            this.inCombat = true; //begins combat to stop the troop from advancing further
          }
        }
      } else {
        if (this.pos.x >= 0 && this.pos.x <= this.bounds - this.reach) {
          f.playerCurrHP = attackCastle(f.playerCurrHP, this); //damages the player's castle
          if (this.pos.x >= 0 && this.pos.x <= this.bounds) {
            this.inCombat = true;
          }
        }
      }
    }
  }
  
  boolean friendlyCollision(Troop ally1, ArrayList<Troop> allyList) {
    for (int i = 0; i < allyList.size(); i++) {
      if (ally1 != allyList.get(i)) {
        if (dist(ally1.pos.x, pos.y, allyList.get(i).pos.x, allyList.get(i).pos.y) <= abs(ally1.bounds)) { 
          return true;
        }
      }
    }
    return false; //if no troop is within the bounds, return false to avoid stopping
  }

  void startWaiting(int faction, Troop ally1, Troop ally2) { //function for collision between allied troops - collision depends on which faction's troops are colliding, so
    if (faction == 1) { //if it's the player's troops that are colliding:
      if (ally1.pos.x >= ally2.pos.x - 50 && ally1.pos.x <= ally2.pos.x + 50) {
        //if (ally1.pos.x >= ally2.pos.x - ally2.bounds && ally1.pos.x <= ally2.pos.x + ally2.bounds) {
        if (ally1.pos.x < ally2.pos.x) { //check if the first troop is ahead, since only the troop behind should stop moving
          ally1.isWaiting = true;
          //ally2.isWaiting = false;
        }
      } else if (ally2.isDead) {
        ally1.isWaiting = false;
      }
    } else { //if not the player's troops, then must be the enemy's
      if (ally1.pos.x <= ally2.pos.x + 50 && ally1.pos.x >= ally2.pos.x - 50) {
        if (ally2.pos.x < ally1.pos.x) { //check if the second troop is ahead (since enemy's troops walk backwards, comparred to player's troops)
          ally1.isWaiting = true;
          //ally2.isWaiting = false;
        }
      } else if (ally2.isDead) {
        ally1.isWaiting = false;
      }
    }
  }

  void beginCombat(Troop ally, Troop opponent) { //only exists here, so sub-classes recognize the function
    currFoe = opponent;

    if (millis() - ally.attackCD >= attackFreq) { //if ally is ready to attack (i.e. cooldown has passed):
      opponent.currHP -= ally.damage; //damaged the opponent
      ally.attackCD = millis(); //resets attack cooldown

      if (opponent.currHP <= 0) {
        opponent.isDead = true; //marks troop as dead, so it's removed at the end of draw()
        ally.inCombat = false;
      }
    }
  }

  float attackCastle(float factionHP, Troop attacker) { //a function that takes the current HP-value of a castle and returns the value, after it has been damaged/reduced
    if (millis() - attacker.attackCD >= attackFreq) { //checks if the attacker is ready to attack (i.e. cooldown has passed):
      factionHP -= attacker.damage;
      attacker.attackCD = millis(); //resets attack cooldown

      if (factionHP <= 0) {
        //opponent.isDead = true; //marks troop as dead, so it's removed at the end of draw()
        attacker.inCombat = false;
      }
    }
    return factionHP; //returns the new HP-value - assuming it changed during this check
  }
}



class Knight extends Troop {

  Knight(int faction) {
    super(); //basically copies the info from the super-class' constructor to this one
    speed.x = 0.5;
    reach = 30;
    bounds = 72;
    if (faction == 1) { //determines which faction the troop being constructed belongs to
      troop = fKnight;
      f.goldCount -= 20; //withdraws the cost of this troop from players gold - ONLY FOR TESTING
    } else {
      troop = eKnight;
      pos.x = width - (h.selectorX + 20); //places troop on the other side of the map, i.e. at enemy's base, and at the same distance from the castle as player's troops are placed
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 5;
    maxHP = 20;  //sets the limit for this troops HP-value
    currHP = 20; //troop should start
  }
}


class Archer extends Troop {

  Archer(int faction) {
    super();
    speed.x = 0.5;
    reach = 70;
    bounds = 65;
    if (faction == 1) {
      troop = fArcher;
      f.goldCount -= 25;
    } else {
      troop = eArcher;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 5;
    maxHP = 15;
    currHP = 15;
  }
}


class Mage extends Troop {

  Mage(int faction) {
    super();
    speed.x = 0.5;
    reach = 70;
    bounds = 72;
    if (faction == 1) {
      troop = fMage;
      f.goldCount -= 40;
    } else {
      troop = eMage;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 8;
    maxHP = 15;
    currHP = 15;
  }
}


class Cavalry extends Troop {

  Cavalry(int faction) {
    super();
    speed.x = 0.9;
    reach = 30;
    bounds = 73;
    if (faction == 1) {
      troop = fCavalry;
      f.goldCount -= 70;
    } else {
      troop = eCavalry;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 5;
    maxHP = 50;
    currHP = 50;
  }
}


class Giant extends Troop {

  Giant(int faction) {
    super();
    speed.x = 0.3;
    reach = 30;
    bounds = 70;
    if (faction == 1) {
      troop = fGiant;
      f.goldCount -= 100;
    } else {
      troop = eGiant;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 10;
    maxHP = 70;
    currHP = 70;
  }
}
