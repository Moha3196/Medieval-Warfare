ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
FKnight friendlyKnight;
Factions f = new Factions();
HUD h  = new HUD();

import processing.sound.*;
SoundFile music;
Sound m;
float vol;

PVector posSpecial = new PVector();

PImage map, castles, selector, highlight, options, upgradeHighlight, SpecialVisiualBox, Special, arrow;
PImage startScreen, winScreen, lossScreen, tutorialPage0, tutorialPage1, tutorialPage2, tutorialButton, startButton, quitButton, specialButton, playAgainButton;
PImage fKnight, fGiant, fArcher, fMage, fCavalry;
PImage eKnight, eGiant, eArcher, eMage, eCavalry;

boolean won, specialMoving;

PFont goldenIncome;

int friendlyKnightLevel = 1, friendlyArcherLevel = 1, friendlyMageLevel = 1, friendlyCavalryLevel = 1, friendlyGiantLevel = 1; //Sets friendly troop levels to 1
int enemyKnightLevel = 1, enemyArcherLevel = 1, enemyMageLevel = 1, enemyCavalryLevel = 1, enemyGiantLevel = 1; //Sets enemy troop levels to 1

float friendlyKnightWorth = 20, friendlyArcherWorth = 35, friendlyMageWorth = 50, friendlyCavalryWorth = 70, friendlyGiantWorth = 100; //Sets friendly troop prices
float enemyKnightWorth = 20, enemyArcherWorth = 35, enemyMageWorth = 50, enemyCavalryWorth = 70, enemyGiantWorth = 100; //Sets enemy troop prices

int stage = 1; //Used to switch screens

int friendlyTroopDeployCoolDown; //The timer for deploying friendly troops.
int delayTime = 1000; //The delay time for deploying troops.

int enemyLevelingCoolDown; //The timer for leveling enemy troops.
int enemyLevelingCoolDownBeforeOptions; //The timer for enemy leveling before option was opened.
int enemyLevelingDelayTime = 15000; //The delay time for leveling enemy troops.

int enemyTroopDeployCoolDown; //The timer for deploying enemy troops.
int enemySpawnDelayTime = 4000; //The delay time for deploying troops.

int specialCoolDown = 30000; //The timer for special.
int specialCoolDownBeforeOptions; //The timer for special before option was opened.
int lastSpecialUsed; //The last time special was used

int passiveGoldCoolDown; //The timer for gaining gold.
int passiveGoldDelayTime = 1300; //The delay time for gaining gold.

float friendlyCastleHP = 1000; //Total HP for friendly castle
float currentFriendlyCastleHP; //Current HP for friendly castle

float enemyCastleHP = 1000; //Total HP for enemy castle
float currentEnemyCastleHP; //Current HP for enemy castle

int lastTimeAttacked; //The timer for attacking.

boolean restart = false; //Value for restarting game 

void setup() {
  size(800, 600);
  frameRate(60);
  music = new SoundFile(this, "Medieval_Music.mp3");
  m = new Sound(this);
  music.loop();
  vol = 0.1;
  m.volume(vol);
  posSpecial.x = -316;
  posSpecial.y = 200;

  currentFriendlyCastleHP = friendlyCastleHP;
  currentEnemyCastleHP = enemyCastleHP;

  friendlyTroopDeployCoolDown = millis();
  passiveGoldCoolDown = millis();
  lastTimeAttacked = millis();

  startScreen = loadImage("MEDIEVAL_WARFARE_LOGO.png");
  tutorialPage0 = loadImage("TutorialPage0.png");
  tutorialPage0.resize(width, height); //Resizes the Tutorial so it fits the boarder

  tutorialPage1 = loadImage("TutorialPage1.png");
  tutorialPage1.resize(width, height); //Resizes the Tutorial so it fits the boarder

  tutorialPage2 = loadImage("TutorialPage2.png");
  tutorialPage2.resize(width, height); //Resizes the Tutorial so it fits the boarder

  arrow = loadImage("Arrow.png");
  winScreen = loadImage("Win Screen.jpg");
  winScreen.resize(width, height); //Resizes the WinScreen so it fits the boarder

  lossScreen = loadImage("Loss Screen.jpg");
  lossScreen.resize(width, height); //Resizes the LossScreen so it fits the boarder

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
  castles   = loadImage("Castles.png");
  selector  = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");
  upgradeHighlight = loadImage("upgradeHighlight box.png");
  options   = loadImage("options.png");

  Special = loadImage("Fire_trail_special.png");

  tutorialButton = loadImage("Tutorial.png");
  startButton = loadImage("start button.png");
  quitButton = loadImage("quitButton.png");
  playAgainButton = loadImage("playAgainButton.png");
  specialButton = loadImage("Special button.png");

  SpecialVisiualBox = loadImage("Fire_trail_special.png");
  SpecialVisiualBox.resize(150, 65);

  goldenIncome = createFont("Verdana", 30); //Makes the font to Verdena and the size to 30.
  textFont(goldenIncome);

  imageMode(CENTER);
}


void draw() {
  if (!h.settingsOpen) {
    switch(stage) { //Stages is used to switch between screens
    case 1:
      StartScreen();
      break; 

    case 2:
      Tutorial();
      break;

    case 3:
      GamingScreen();
      break; 

    case 4:
      EndScreen();
      break;
    }
  } else {
    h.options();
  }
  m.volume(vol);

  //println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
}

void mouseClicked() {
  if  (mouseButton == LEFT && h.settingsOpen == true && mouseX >= 260 && mouseX <= 540 && mouseY >= 310 && mouseY <= 380) {//difficulty button
    if (h.difficulty <= 2) {
      h.difficulty++;
      f.setDifficulty(h.difficulty);
    } else {
      h.difficulty = 1;
    }
  } else if (mouseButton == RIGHT && h.settingsOpen == true && mouseX >= 260 && mouseX <= 540 && mouseY >= 310 && mouseY <= 380) {//difficulty button
    if (h.difficulty >= 2) {
      h.difficulty--;
      f.setDifficulty(h.difficulty);
    } else {
      h.difficulty = 3;
    }
  }
  if  (mouseButton == LEFT && mouseX >= 260 && mouseX <= 540 && mouseY >= 225 && mouseY <= 295) { //Volume button
    if (vol < 1) {
      vol += 0.1;
    }
  } else if (mouseButton == RIGHT && mouseX >= 260 && mouseX <= 540 && mouseY >= 225 && mouseY <= 295) {
    if (vol >= 0.1) {
      vol -= 0.1;
    }
  }
}



void mousePressed() {
}

void keyPressed() {
  if (keyCode == UP || key == 'w') { //to change the selected row (marked with the arrow)
    h.row -= 1;

    if (h.row <= 0) { //used for wrap-around for the selector
      h.row = 6;
    }
  }
  if (keyCode == DOWN || key == 's') {
    h.row += 1;

    if (h.row >= 7) {
      h.row = 1;
    }
  }
  if (keyCode == ENTER && millis() - enemyTroopDeployCoolDown >= lastSpecialUsed) { //Makes an enemy Knight troop... Used for testing
    et.add(new EKnight(enemyKnightLevel, h.selectorY));
    f.playerGoldCount += 20;
    enemyTroopDeployCoolDown = millis();
  }

  if (keyCode == 'F') { //Makes an friendly Knight troop... Used for testing
    //h.selectorX = 100;
    ft.add(new FKnight(friendlyKnightLevel));
    //h.selectorX = 31;
    f.playerGoldCount += 20;
    friendlyTroopDeployCoolDown = millis();
  }

  if (keyCode == ' ' && millis() - specialCoolDown >= lastSpecialUsed && stage == 3) { //Uses Special
    f.Special();
    specialMoving = true;
    lastSpecialUsed = millis();
  }

  if (keyCode == 'R') { //Restarts game
    restart = true;
  }

  if (keyCode == '1') { //Makes an enemy Knight troop... Used for testing
    et.add(new EKnight(enemyKnightLevel, h.selectorY));
    f.enemyGoldCount += 20;
  }
  if (keyCode == '2') { //Makes an enemy Archer troop... Used for testing
    et.add(new EArcher(enemyArcherLevel, h.selectorY));
    f.enemyGoldCount += 25;
  }
  if (keyCode == '3') { //Makes an enemy Mage troop... Used for testing
    et.add(new EMage(enemyMageLevel, h.selectorY));
    f.enemyGoldCount += 40;
  }
  if (keyCode == '4') { //Makes an enemy Cavalry troop... Used for testing
    et.add(new ECavalry(enemyCavalryLevel, h.selectorY));
    f.enemyGoldCount += 70;
  }
  if (keyCode == '5') { //Makes an enemy Giant troop... Used for testing
    et.add(new EGiant(enemyGiantLevel, h.selectorY));
    f.enemyGoldCount += 100;
  }
  if (keyCode == 'U') { //Upgrades all friendly Troop... Used for testing
    friendlyKnightLevel += 1;
    friendlyArcherLevel += 1;
    friendlyMageLevel += 1;
    friendlyCavalryLevel += 1;
    friendlyGiantLevel += 1;
  }

  if (keyCode == 'I') { //Upgrades all friendly Troop... Used for testing
    enemyKnightLevel += 1;
    enemyArcherLevel += 1;
    enemyMageLevel += 1;
    enemyCavalryLevel += 1;
    enemyGiantLevel += 1;
  }
}
