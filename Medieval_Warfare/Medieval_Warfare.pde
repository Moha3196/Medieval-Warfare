ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, swordsman, giant, archer, mage, cavalry, options;
int troopDeplpoyCoolDown;
int delayTime = 1000;
int passiveGoldCoolDown;
int passiveGoldDelayTime = 800;
PFont goldenIncome;
int friendlyCastleHP = 100;
int currentFriendlyCastleHP;
int enemyCastleHP = 100;
int currentEnemyCastleHP;
int lastTimeAttacked;

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
  image(map, width/2, height/2);

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
  strokeWeight(10);
  popMatrix();

  h.selector(h.row);
  h.sendTroop();
  h.options();
  f.PassiveGold();

  for (int i = 0; i < ft.size(); i++) {  //runs the different functions for friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();
    if (ft.get(i).isDead) {
      ft.remove(ft.get(i));
      //println(ft.size());
    }
  }

  for (int i = 0; i < et.size(); i++) {  //runs the different functions for enemy troops
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
  text("Magician", 358, 493);
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
  if (keyCode == ENTER) { //Makes an enemy swordsman troop... Used for testing
    et.add(new ESwordsman());
    f.goldCount += 20;
  }
}
