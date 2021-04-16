class Troop {
  Troop currFoe; //declares a Troop for each Troop, so that the Troop being collided with has somewhere to be stored

  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector();  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach, attackCD, attackFreq; //allegiance defines the troop's faction (player = 1, enemy = 0)
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
    if (inCombat == false && isWaiting == false) {
      pos.add(speed);
    }

    pushMatrix();
    translate(pos.x, pos.y);
    if (allegiance == 0) {
      scale(-1, 1);
    } else {
      scale(1, 1);
    }
    image(troop, 0, 0);
    popMatrix();
    text("" + inCombat, pos.x, pos.y - 60);
    text(hp, pos.x, pos.y - 40); //debugging - healthbar will be added later
  }


  void checkCollision() { //checks if another troop is within current troop's reach/range
    for (int i = 0; i < t.size(); i++) {
      if (this != t.get(i)) { //should only check other troops, and not itself too
        if (this.pos.y == t.get(i).pos.y) {
          if (this.pos.x + this.reach >= t.get(i).pos.x - 30 && this.pos.x + this.reach <= t.get(i).pos.x + 30 /*&& t.get(i).isDead == false*/) { //only troops on the same lane can collide with each other

            //println("within range");
            //println("reach: " + (this.pos.x + this.reach));
            //println("left side: " + (this.pos.x - 30));
            //println("middle: " + this.pos.x);
            
            
            if (this.allegiance != t.get(i).allegiance) { //checks if other troop is current troop's enemy:

              beginCombat(this, t.get(i)); //if so - calls collision/combat function for the two opposing troops
            } else if (this.pos.x < t.get(i).pos.x - 30) { //if not, they must be friendlies, therefore checks who's ahead of who and lets the troop ahead continue, but stops the one behind
              this.isWaiting = true;
              t.get(i).isWaiting = false;
            //} else {
            //  this.isWaiting = true;
            //  t.get(i).isWaiting = false;
            }
          } else /*if (this.inCombat)*/if (this.currFoe == null || this.currFoe != null && this.currFoe.isDead) {
            this.inCombat = false;
            this.isWaiting = false;
          }
        }
      }
    }
  }

  void beginCombat(Troop ally, Troop opponent) { //only exists here, so sub-classes recognize the function
    ally.inCombat = true; //used to stop ally from continuing forward
    currFoe = opponent;

    if (millis() - ally.attackCD >= attackFreq) { //if ally is ready to attack (i.e. cooldown has passed):
      opponent.hp -= ally.damage;
      ally.attackCD = millis(); //resets attack cooldown
      //println("Ally atkCD: " + ally.attackCD);         //debugging
      //println("Opponent atkCD: " + opponent.attackCD); //debugging

      if (opponent.hp <= 0) {
        opponent.isDead = true; //marks troop as dead, so it's removed at the end of draw()
        ally.inCombat = false;
      }
    }
  }
}



class Knight extends Troop {

  Knight() {
    super(); //basically copies the info from the super-class' constructor to this one
    troop = knight; //defines current image to display for the troop
    speed.x = 0.5;
    reach = 30;
    damage = 5;
    hp = 20;
    f.goldCount -= 20; //withdraws the cost of this troop from players gold
  }


  //void beginCombat(Troop unit) {
  //}
}


class Archer extends Troop {

  Archer() {
    super();
    troop = archer;
    speed.x = 0.5;
    reach = 70;
    damage = 5;
    hp = 15;
    f.goldCount -= 25;
  }

  //void beginCombat(Troop unit) {
  //}
}


class Mage extends Troop {

  Mage() {
    super();
    troop = mage;
    speed.x = 0.5;
    reach = 70;
    damage = 8;
    hp = 15;
    f.goldCount -= 40;
  }

  //void beginCombat(Troop unit) {
  //}
}


class Cavalry extends Troop {

  Cavalry() {
    super();
    troop = cavalry;
    speed.x = 0.9;
    reach = 30;
    damage = 5;
    hp = 50;
    f.goldCount -= 70;
  }

  //void beginCombat(Troop unit) {
  //}
}


class Giant extends Troop {

  Giant() {
    super();
    troop = giant;
    speed.x = 0.3;
    reach = 30;
    damage = 10;
    hp = 70;
    f.goldCount -= 100;
  }

  //void beginCombat(Troop unit) {
  //}
}
