import processing.sound.*;

ArrayList<FriendlyTroop> ft; //an arraylist for storing the player's troops,
ArrayList<EnemyTroop> et;    //and an arraylist for the enemy's troops
Factions f;
HUD h;
Sound m; //only needed so we can use volume()
SoundFile music;

float vol; //variable for the volume

PVector specialPos = new PVector();

PImage map, castles, selector, highlight, upgradeHighlight, options; //map & HUD images
PImage startScreen, winScreen, lossScreen, tutorialPage0, tutorialPage1, tutorialPage2, arrow; //different screen images
PImage tutorialButton, startButton, quitButton, playAgainButton; //just buttons
PImage difficultyEasy, difficultyNormal, difficultyHard, special, specialButton; //difficulty and special images

PImage fKnight, fGiant, fArcher, fMage, fCavalry; //troop images
PImage eKnight, eGiant, eArcher, eMage, eCavalry; //"

boolean won, specialMoving;
boolean[] friendliesInSpawn = new boolean[6];
boolean[] enemiesInSpawn= new boolean[6];

PFont goldenIncome;

int specialCD = 30000; //The timer for special.
int specialCD_PreOptions; //The timer for special before option was opened.
int lastSpecialUsed; //The last time special was used

void setup() {
  size(800, 600);
  frameRate(60);

  ft = new ArrayList<FriendlyTroop>();
  et = new ArrayList<EnemyTroop>();
  f = new Factions();
  h  = new HUD();
  m = new Sound(this);
  music = new SoundFile(this, "Medieval_Music.mp3");
  
  music.loop();
  vol = 0.1;
  m.volume(vol);

  specialPos.x = -316; //Special is given coords outside player's view
  specialPos.y = 200;  //"

  map       = loadImage("Medievalbackground.png");
  castles   = loadImage("Castles.png");
  selector  = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");
  upgradeHighlight = loadImage("UpgradeHighlight box.png");
  options   = loadImage("Options.png");

  startScreen = loadImage("MEDIEVAL_WARFARE_LOGO.png");
  winScreen = loadImage("Win Screen.jpg");
  lossScreen = loadImage("Loss Screen.jpg");
  tutorialPage0 = loadImage("TutorialPage0.png");
  tutorialPage1 = loadImage("TutorialPage1.png");
  tutorialPage2 = loadImage("TutorialPage2.png");
  arrow = loadImage("Arrow.png");
  winScreen.resize(width, height);
  lossScreen.resize(width, height);
  tutorialPage0.resize(width, height);
  tutorialPage1.resize(width, height);
  tutorialPage2.resize(width, height);

  tutorialButton = loadImage("Tutorial.png");
  startButton = loadImage("startButton.png");
  quitButton = loadImage("quitButton.png");
  playAgainButton = loadImage("playAgainButton.png");

  difficultyEasy = loadImage("difficultyEasy.png");
  difficultyNormal = loadImage("difficultyNormal.png");
  difficultyHard = loadImage("difficultyHard.png");

  fKnight = loadImage("FriendlyKnight.png");
  fArcher = loadImage("FriendlyArcher.png");
  fMage = loadImage("FriendlyMage.png");
  fCavalry = loadImage("FriendlyCavalry.png");
  fGiant = loadImage("FriendlyGiant.png");
  fKnight.resize(60, 60);
  fArcher.resize(60, 60);
  fMage.resize(60, 60);
  fCavalry.resize(60, 60);
  fGiant.resize(60, 60);

  eKnight = loadImage("EnemyKnight.png");
  eArcher = loadImage("EnemyArcher.png");
  eMage = loadImage("EnemyMage.png");
  eCavalry = loadImage("EnemyCavalry.png");
  eGiant = loadImage("EnemyGiant.png");
  eKnight.resize(60, 60);
  eArcher.resize(60, 60);
  eMage.resize(60, 60);
  eCavalry.resize(60, 60);
  eGiant.resize(60, 60);

  special = loadImage("Special.png");
  specialButton = loadImage("Special button.png");

  goldenIncome = createFont("Verdana", 30); //Adds a 'Verdena' font and sets the size to 30.
  textFont(goldenIncome);

  f.fDeployCD = millis();     //variables for cooldowns (CD's)

  imageMode(CENTER); //used for pictures, to make positions easier to work with
}


void draw() {
  if (!h.settingsOpen) { //practially pauses the game, if settings is open
    switch(h.stage) { //a switch-statement for switching screens, since this is more efficient
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
  } else {       //if settings menu is not up, make sure to continue options() func call,otherwise the game stops since you can't close the menu again
    h.options(); //otherwise the game stops since you can't close the menu again
  }

  m.volume(vol);
}

void mouseClicked() {
  if  (mouseButton == LEFT && h.settingsOpen == true && mouseX >= 260 && mouseX <= 540 && mouseY >= 310 && mouseY <= 380) {//difficulty button in settings
    if (h.difficulty <= 2) {
      h.difficulty++;
    } else {
      h.difficulty = 1;
    }
    f.setDifficulty(h.difficulty);
  } else if (mouseButton == RIGHT && h.settingsOpen == true && mouseX >= 260 && mouseX <= 540 && mouseY >= 310 && mouseY <= 380) {//difficulty button in settings, right click
    if (h.difficulty >= 2) {
      h.difficulty--;
    } else {
      h.difficulty = 3;
    }
    f.setDifficulty(h.difficulty);
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

  if  (mouseButton == LEFT && mouseX >= 250 && mouseX <= 550 && mouseY >= 510 && mouseY <= 570) {//difficulty button
    if (h.difficulty <= 2 && h.stage == 1) {
      h.difficulty++;
    } else if (h.stage ==1) {
      h.difficulty = 1;
    }
    f.setDifficulty(h.difficulty);
  }//
  else if (mouseButton == RIGHT && mouseX >= 250 && mouseX <= 550 && mouseY >= 510 && mouseY <= 570) {//difficulty button in settings, right click
    if (h.difficulty >= 2 && h.stage == 1) {
      h.difficulty--;
    } else if (h.stage == 1) {
      h.difficulty = 3;
    }
    f.setDifficulty(h.difficulty);
  }
}


void keyPressed() {
  if (h.stage == 3) {
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

    if (keyCode == ' ' && millis() - specialCD >= lastSpecialUsed) { //Uses Special if cooldown has passed
      f.special();
      specialMoving = true;
      lastSpecialUsed = millis();
    }
  }
}
