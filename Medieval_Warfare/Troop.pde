class Troop {
  Troop currFoe; //declares a Troop for each Troop, so that the Troop being collided with has somewhere to be stored

  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector();  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach, attackCD, attackFreq, bounds; //allegiance defines the troop's faction (player = 1, enemy = 0)
  boolean isDead, inCombat, isWaiting;

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
    if (allegiance == 0) {
      scale(-1, 1);
    } else {
      scale(1, 1);
    }

    image(troop, 0, 0); //"troop" is defined in each subclass
    popMatrix();
    //text("waiting? " + isWaiting, pos.x, pos.y - 80);
    //text("combat? " + inCombat, pos.x, pos.y - 60);
    text(hp, pos.x, pos.y - 40); //debugging - healthbar will be added later
    circle(pos.x, pos.y, 10);
    circle(pos.x - bounds, pos.y, 15);
    circle(pos.x + bounds, pos.y, 15);
  }


  void checkCollision() { //checks if another troop is within current troop's reach/range
    for (int i = 0; i < t.size(); i++) {
      if (this != t.get(i) && this.pos.y == t.get(i).pos.y) { //should only check other troops, and not itself too and should only check on troop's own lane, not others
        if (this.pos.x + this.reach >= t.get(i).pos.x - 30 && this.pos.x + this.reach <= t.get(i).pos.x + 30) { //checks if another troop is within the current troop's range
          if (this.allegiance != t.get(i).allegiance) { //checks if other troop is current troop's enemy:
            beginCombat(this, t.get(i)); //if so - calls collision/combat function for the two opposing troops
            this.inCombat = true;
          } else {  //if not, they must be allies
            startWaiting(this.allegiance, this, t.get(i));
          }
        } else if (this.currFoe == null || this.currFoe.isDead) {
          this.inCombat = false;
        }
      }

      if (this.allegiance == 1) {
        if (this.pos.x >= width - this.bounds && this.pos.x <= width) { //checks if player's troops have reached enemy's base:
          this.inCombat = true;
        }
      } else {
        if (this.pos.x >= 0 && this.pos.x <= this.bounds) { //checks if enemy's troops have reached player's base
          this.inCombat = true;
        }
      }
    }
  }

  void startWaiting(int faction, Troop ally1, Troop ally2) { //function for collision between allied troops - collision depends on which faction's troops are colliding, so
    if (faction == 1) { //if it's the player's troops that are colliding:
      //if (ally1.pos.x >= ally2.pos.x - 60 && ally1.pos.x <= ally2.pos.x + 60) {
      if (ally1.pos.x >= ally2.pos.x - ally2.bounds && ally1.pos.x <= ally2.pos.x + ally2.bounds) {
        if (ally1.pos.x < ally2.pos.x) { //check if the first troop is ahead, since only the troop behind should stop moving
          ally1.isWaiting = true;
        }
      } else {
        ally1.isWaiting = false;
      }
    } else { //if not the player's troops, then must be the enemy's
      if (ally1.pos.x <= ally2.pos.x + 30 && ally1.pos.x >= ally2.pos.x - 30) {
        if (ally2.pos.x < ally1.pos.x) { //check if the second troop is ahead (since enemy's troops walk backwards, comparred to player's troops)
          ally1.isWaiting = true;
        }
      } else {
        ally1.isWaiting = false;
      }
    }
  }

  void beginCombat(Troop ally, Troop opponent) { //only exists here, so sub-classes recognize the function
    currFoe = opponent;

    if (millis() - ally.attackCD >= attackFreq) { //if ally is ready to attack (i.e. cooldown has passed):
      opponent.hp -= ally.damage;
      ally.attackCD = millis(); //resets attack cooldown

      if (opponent.hp <= 0) {
        opponent.isDead = true; //marks troop as dead, so it's removed at the end of draw()
        ally.inCombat = false;
      }
    }
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
    hp = 20;
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
    hp = 15;
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
    } else {
      troop = eMage;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 8;
    hp = 15;
    f.goldCount -= 40;
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
    } else {
      troop = eCavalry;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 5;
    hp = 50;
    f.goldCount -= 70;
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
    } else {
      troop = eGiant;
      pos.x = width - (h.selectorX + 20);
      speed.x *= -1;
      reach *= -1;
    }
    allegiance = faction;
    damage = 10;
    hp = 70;
    f.goldCount -= 100;
  }
}
