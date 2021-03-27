ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
FKnight friendlyKnight;
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, options, upgradeHighlight, startScreen, endScreen;
PImage knight, giant, archer, mage, cavalry;

PFont goldenIncome;

int knightLevel = 1, archerLevel = 1, mageLevel = 1, cavalryLevel = 1, giantLevel = 1; //Sets the troop levels to 1

int stage = 1;

int troopDeplpoyCoolDown; //The timer for deploying troops.
int delayTime = 1000; //The delay time for deploying troops.

int passiveGoldCoolDown; //The timer for gaining gold.
int passiveGoldDelayTime = 800; //The delay time for gaining gold.

float friendlyCastleHP = 1000; //Total HP for friendly castle
float currentFriendlyCastleHP; //Current HP for friendly castle

float enemyCastleHP = 1000; //Total HP for enemy castle
float currentEnemyCastleHP; //Current HP for enemy castle

int lastTimeAttacked; //The timer for attacking.

void setup() {
  size(800, 600);
  frameRate(60);

  currentFriendlyCastleHP = friendlyCastleHP;
  currentEnemyCastleHP = enemyCastleHP;

  troopDeplpoyCoolDown = millis();
  passiveGoldCoolDown = millis();
  lastTimeAttacked = millis();
  
  startScreen = loadImage("MEDIEVAL_WARFARE_LOGO.png");

  knight = loadImage("Knight.png");
  knight.resize(60, 60);

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
  upgradeHighlight = loadImage("upgradeHighlight box.png");
  options   = loadImage ("options.png");

  imageMode(CENTER);
}


void draw() {
  if (stage == 1) {
    StartScreen();
  } else if (stage == 2) {
    Tutorial();
  } else if (stage == 3) {
    GamingScreen();
  } else if (stage == 4) {
    EndScreen();
  }
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
    archerLevel += 1;
    mageLevel += 1;
    cavalryLevel += 1;
    giantLevel += 1;
  }
}
