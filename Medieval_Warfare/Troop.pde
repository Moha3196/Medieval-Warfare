class Troop {
  PVector pos = new PVector();  //a starting position
  PVector speed = new PVector();  //the speed of a troop - not constant for all troops
  PImage troop;  //the image of the troop we deploy - defined in each sub-class
  int allegiance, hp, damage, reach, attackCD, attackFreq; //allegiance defines the troop's faction (player = 1, enemy = 0)
  boolean isDead, inCombat;
  
  int killCounter; //debugging

  Troop () {
    pos.x = h.selectorX + 20; //places new troop on the battlefield, instead of the selector,
    pos.y = h.selectorY;      //but still on the correct lane
    attackCD = millis(); //the milliseconds it takes before each attack - every troop has one
    attackFreq = 1000; //how often a troop can attack - lower means more frequent and vice versa
    isDead = false;
    inCombat = false;
    
    killCounter = 0;
  }

  void update() {
    //if (currOpponent.isDead) {
    //  inCombat = false;
    //}
    if (!inCombat) {
      pos.add(speed);
    } else {
      println("Is opponent dead? " + currOpponent.isDead);
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
    //text(killCounter, pos.x, pos.y-60);
    text(hp, pos.x, pos.y - 40); //debugging - healthbar will be added later
    //if (allegiance == 1) {
    //  text(millis()-attackCD, pos.x -30, pos.y + 40); //debugging
    //} else {
    //  text(millis()-attackCD, pos.x + 30, pos.y + 40); //debugging
    //}
    if (drawStuff) {
      //line(pos.x, pos.y, reach, pos.y);
    }
  }


  void checkCollision() { //checks if another troop is within current troop's reach/range
    for (int i = 0; i < t.size(); i++) {
      if (this != t.get(i)) { //should only check other troops, and not itself too
        //line(this.pos.x, this.pos.y, this.pos.x + this.reach, this.pos.y);
        if (this.pos.y == t.get(i).pos.y) {
          //if (t.get(i).pos.x >= this.pos.x && t.get(i).pos.x <= this.pos.x + this.reach) {
          if (this.pos.x + this.reach >= t.get(i).pos.x - 30 && this.pos.x + this.reach <= t.get(i).pos.x + 30) { //only troops on the same lane can collide with each other

            //println("within range");
            //println("reach: " + (this.pos.x + this.reach));
            //println("left side: " + (this.pos.x - 30));
            //println("middle: " + this.pos.x);

            if (this.allegiance == t.get(i).allegiance) { //checks if other troop is on current troop's side:
              //beginCombat(this, t.get(i)); //if so, runs collision for meeting a fellow friendly
            } else {
              beginCombat(this, t.get(i)); //if not - calls collision/combat function for the two opposing troops
              //println();
              println("In combat...");
              println();
            }
          } else { //NOTES: if this else is on the "pos.x..." if, then only last enemy troop will engage an opponent, while all others simply never seem to run "beginCombat()"
            this.inCombat = false; //this fixes troops not escaping combat, if they themselves didn't kill the opponent, but lets other troops altz on through the opponent...
          } //if the only two troops deployed enter combat, and both have "inCombat = true", then spawning another troop will set it to false for both **BUT THEY WILL CONTINUE TO DAMAGE EACH OTHER**
        }
      }
    }
  }

  void beginCombat(Troop ally, Troop opponent) { //only exists here, so sub-classes recognize the function
    ally.inCombat = true; //used to stop ally from continuing forward
    currOpponent = opponent;
    if (millis() - ally.attackCD >= attackFreq) { //if ally is ready to attack (i.e. cooldown has passed):
      opponent.hp -= ally.damage;
      ally.attackCD = millis(); //resets attack cooldown
      //println("Ally atkCD: " + ally.attackCD);         //debugging
      //println("Opponent atkCD: " + opponent.attackCD); //debugging

      if (opponent.hp <= 0) {
        opponent.isDead = true; //marks troop as dead, so it's removed at the end of draw()
        ally.inCombat = false;
        ally.killCounter++;
      }
    }
  }
}



class Knight extends Troop {

  Knight() {
    super(); //basically copies the info from the super-class' constructor to this one
    troop = knight; //defines current image to display for the troop
    speed.x = 0.9;
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
    speed.x = 1;
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
    speed.x = 1;
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
    speed.x = 1.7;
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
    speed.x = 0.6;
    reach = 30;
    damage = 10;
    hp = 70;
    f.goldCount -= 100;
  }

  //void beginCombat(Troop unit) {
  //}
}
