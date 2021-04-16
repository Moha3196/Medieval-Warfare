ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
FKnight friendlyKnight;
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, options, upgradeHighlight, startScreen, winScreen, lossScreen, tutorial;
PImage fKnight, fGiant, fArcher, fMage, fCavalry;
PImage eKnight, eGiant, eArcher, eMage, eCavalry;

boolean won;

PFont goldenIncome;

int knightLevel = 1, archerLevel = 1, mageLevel = 1, cavalryLevel = 1, giantLevel = 1; //Sets the troop levels to 1

int stage = 1; //Used to switch screens

int troopDeplpoyCoolDown; //The timer for deploying troops.
int delayTime = 1000; //The delay time for deploying troops.

int passiveGoldCoolDown; //The timer for gaining gold.
int passiveGoldDelayTime = 800; //The delay time for gaining gold.

float friendlyCastleHP = 10; //Total HP for friendly castle
float currentFriendlyCastleHP; //Current HP for friendly castle

float enemyCastleHP = 10; //Total HP for enemy castle
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
  tutorial = loadImage("Tutorial.png");
  winScreen = loadImage("Win Screen.jpg");
  winScreen.resize(width, height); //Resizes the EndScreen so it fits the boarder
  
  lossScreen = loadImage("Loss Screen.jpg");
  lossScreen.resize(width, height); //Resizes the EndScreen so it fits the boarder

  fKnight = loadImage("FriendlyKnight.png");
  fKnight.resize(60, 60);

  fGiant = loadImage("FriendlyGiant.png");
  fGiant.resize(60, 60);

  fArcher = loadImage("FriendlyArcher.png");
  fArcher.resize(60, 60);

  fMage = loadImage("FriendlyMage.png");
  fMage.resize(60, 60);

  fCavalry = loadImage("FriendlyCavalry.png");
  fCavalry.resize(60, 60);
  
  eKnight = loadImage("EnemieKnight.png");
  eKnight.resize(60, 60);

  eGiant = loadImage("EnemieGiant.png");
  eGiant.resize(60, 60);

  eArcher = loadImage("EnemieArcher.png");
  eArcher.resize(60, 60);

  eMage = loadImage("EnemieMage.png");
  eMage.resize(60, 60);

  eCavalry = loadImage("EnemieCavalry.png");
  eCavalry.resize(60, 60);

  map       = loadImage("Medievalbackground.png");
  selector  = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");
  upgradeHighlight = loadImage("upgradeHighlight box.png");
  options   = loadImage ("options.png");

  imageMode(CENTER);
}


void draw() {
  if (stage == 1) { //Stages is used to switch between screens
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
  if (keyCode == ENTER && millis() - troopDeplpoyCoolDown >= delayTime) { //Makes an enemy Knight troop... Used for testing
    et.add(new EKnight());
    f.goldCount += 20;
    troopDeplpoyCoolDown = millis();
  }
  
  if (keyCode == 'F') { //Makes an friendly Knight troop... Used for testing
    //h.selectorX = 100;
    ft.add(new FKnight(knightLevel));
    //h.selectorX = 31;
    f.goldCount += 20;
    troopDeplpoyCoolDown = millis();
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
