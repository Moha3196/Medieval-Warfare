ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
FKnight friendlyKnight;
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, swordsman, giant, archer, mage, cavalry, options;
PFont goldenIncome;

int knightLevel = 1, archerLevel = 1, mageLevel = 1, cavalryLevel = 1, giantLevel = 1; //Sets the troop levels to 1

int troopDeplpoyCoolDown; //The timer for deploying troops.
int delayTime = 1000; //The delay time for deploying troops.

int passiveGoldCoolDown; //The timer for gaining gold.
int passiveGoldDelayTime = 800; //The delay time for gaining gold.

int friendlyCastleHP = 100; //Total HP for friendly castle
int currentFriendlyCastleHP; //Current HP for friendly castle

int enemyCastleHP = 100; //Total HP for enemy castle
int currentEnemyCastleHP; //Current HP for enemy castle

int lastTimeAttacked; //The timer for attacking.

void setup() {
  size(800, 600);
  frameRate(60);
  
  currentFriendlyCastleHP = friendlyCastleHP;
  currentEnemyCastleHP = enemyCastleHP;
  
  troopDeplpoyCoolDown = millis();
  passiveGoldCoolDown = millis();
  lastTimeAttacked = millis();

  swordsman = loadImage("Swordsman.png");
  swordsman.resize(60, 60);

  giant = loadImage("Giant.png");
  giant.resize(60, 60);

  archer = loadImage("Archer.png");
  archer.resize(60, 60);

  mage = loadImage("Mage.png");
  mage.resize(60, 60);

  cavalry = loadImage("Cavalry.png");
  cavalry.resize(60, 60);

  map       = loadImage("Medievalbackground.png");
  selector  = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");
  options   = loadImage ("options.png");

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2); //Shows the playground, boxes and banners

  pushMatrix();
  strokeWeight(2);

  fill(0, 255, 0);
  rect(width, 1, width/2/enemyCastleHP*-currentEnemyCastleHP, 38); //Shows Enemy castle health bar

  fill(0, 255, 0);
  rect(0, 1, width/2/friendlyCastleHP*currentFriendlyCastleHP, 38); //Shows Friendly castle health bar

  strokeWeight(4);
  noFill();
  rect(width/2, 1, width/2-1, 38); //Shows Enemy castle health boarder
  rect(0, 1, width/2, 38); //Shows Friendly castle health boarder
  //strokeWeight(10);
  popMatrix();

  h.selector(h.row);
  h.sendTroop();
  h.options();
  f.PassiveGold();

  for (int i = 0; i < ft.size(); i++) {  //runs the different functions for Friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();
    if (ft.get(i).isDead) {
      ft.remove(ft.get(i));
    }
  }

  for (int i = 0; i < et.size(); i++) {  //runs the different functions for Enemy troops
    et.get(i).update();
    et.get(i).checkCollision();
    if (et.get(i).isDead) {
      et.remove(et.get(i));
    }
  }

  image(swordsman, 188, 541); //Shows the image of the troops in the boxes below.
  image(archer, 273, 541);
  image(mage, 358, 541);
  image(cavalry, 443, 541);
  image(giant, 528, 541);
  
  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 20); //Makes the font to Verdena and the size to 20.
  textFont(goldenIncome);
  fill(255);

  text("Gold: " + f.goldCount, 65, 510); //Writes the current amount of gold
  textSize(12);
  fill(0);

  text("Knight", 188, 493); //Writes the names of the troops above the boxes
  text("Archer", 273, 493); 
  text("Mage", 358, 493);
  text("Cavalry", 443, 493);
  text("Giant", 528, 493);



  textSize(16);
  text(20, 188, 590); //Writes the cost of the troops above the boxes
  text(25, 273, 590);
  text(40, 358, 590);
  text(70, 443, 590);
  text(100, 528, 590);
  fill(255);
  textSize(20);

  //println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
}



void mousePressed() {
}

void keyPressed() {
  if (keyCode == UP) { //to change the selected row (marked with the arrow)
    h.row -= 1;

    if (h.row <= 0) { //used for wrap-around for the selector
      h.row = 6;
    }
  }
  if (keyCode == DOWN) {
    h.row += 1;

    if (h.row >= 7) {
      h.row = 1;
    }
  }
  if (keyCode == ENTER) { //Makes an enemy Knight troop... Used for testing
    et.add(new EKnight());
    f.goldCount += 20;
  }
  if (keyCode == '1') { //Makes an enemy Knight troop... Used for testing
    et.add(new EKnight());
    f.goldCount += 20;
  }
  if (keyCode == '2') { //Makes an enemy Archer troop... Used for testing
    et.add(new EArcher());
    f.goldCount += 25;
  }
  if (keyCode == '3') { //Makes an enemy Mage troop... Used for testing
    et.add(new EMage());
    f.goldCount += 40;
  }
  if (keyCode == '4') { //Makes an enemy Cavalry troop... Used for testing
    et.add(new ECavalry());
    f.goldCount += 70;
  }
  if (keyCode == '5') { //Makes an enemy Giant troop... Used for testing
    et.add(new EGiant());
    f.goldCount += 100;
  }
  if (keyCode == 'U') { //Upgrades the friendly Knight... Used for testing
    knightLevel += 1;
  }
}
