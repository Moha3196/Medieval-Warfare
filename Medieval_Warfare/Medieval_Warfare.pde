ArrayList<Troop> t = new ArrayList<Troop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, castles, selector, highlight, options, upgradeHighlight, specialBox, specialEffect;
PImage startScreen, winScreen, lossScreen, tutorialPage0, tutorialPage1, tutorialPage2;
PImage fKnight, fArcher, fMage, fCavalry, fGiant;
PImage eKnight, eGiant, eArcher, eMage, eCavalry;

PFont goldenIncome;

boolean drawStuff = false;

void setup() {
  size(800, 600);
  frameRate(60);

  startScreen = loadImage("MEDIEVAL_WARFARE_LOGO.png");
  tutorialPage0 = loadImage("TutorialPage0.png");
  tutorialPage1 = loadImage("TutorialPage1.png");
  tutorialPage2 = loadImage("TutorialPage2.png");
  winScreen = loadImage("Win Screen.jpg");
  lossScreen = loadImage("Loss Screen.jpg");

  tutorialPage0.resize(width, height);
  tutorialPage1.resize(width, height);
  tutorialPage2.resize(width, height);
  winScreen.resize(width, height);
  lossScreen.resize(width, height);

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

  eKnight = loadImage("EnemieKnight.png");
  eArcher = loadImage("EnemieArcher.png");
  eMage = loadImage("EnemieMage.png");
  eCavalry = loadImage("EnemieCavalry.png");
  eGiant = loadImage("EnemieGiant.png");
  eKnight.resize(60, 60);
  eArcher.resize(60, 60);
  eMage.resize(60, 60);
  eCavalry.resize(60, 60);
  eGiant.resize(60, 60);

  map       = loadImage("Medievalbackground.png");
  castles   = loadImage("Castles.png");
  selector  = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");
  upgradeHighlight = loadImage("upgradeHighlight box.png");
  options   = loadImage("options.png");

  specialEffect = loadImage("Fire_trail_special.png"); //the fire that's placed on a lane, when special is used
  specialBox = loadImage("Fire_trail_special.png"); //the fire shown on the Special button/cooldown box
  specialBox.resize(150, 65);

  goldenIncome = createFont("Verdana", 20);
  textFont(goldenIncome);

  f.deploymentCD = millis();
  f.passiveGoldCD = millis();

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2);
  h.selector(h.row);
  h.sendTroop();
  f.passiveGold();
  h.renderHighlight();
  h.options();

  //runs the different functions for troops
  for (int i = 0; i < t.size(); i++) {
    t.get(i).update();
    //if (t.size() > 1) { //a troop can't collide, of there is nobody else to collide with
      t.get(i).checkCollision();
    //} else if (t.size() == 1) {
      t.get(i).inCombat = false;
      t.get(i).isWaiting = false;
    //}

    if (t.get(i).isDead || t.get(i).pos.x < 0 || t.get(i).pos.x > width) { //checks if a troop is dead - if so, it's removed
      t.remove(t.get(i)); //done as the last thing to avoid Out-of-Bounds exceptions
    }
  }

  println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
}



void mousePressed() {
}

void keyPressed() {
  if (keyCode == UP || keyCode == 'W') { //to change the selected row (marked with the arrow)
    h.row -= 1;

    if (h.row <= 0) { //used for wrap-around for the selector
      h.row = 6;
    }
  }
  if (keyCode == DOWN || keyCode == 'S') {
    h.row += 1;

    if (h.row >= 7) {
      h.row = 1;
    }
  }
  //if (key == '½') {
  //  noLoop();
  //}
  //if (keyCode == ENTER) { //debugging
  //  loop();
  //}
  switch(key) { //THIS ENTIRE SWITCH-STATEMENT IS FOR DEBUGGING/TESTING - REMOVE LATER

  case '1': //for some reason the cases don't work, unless apostrophies are used
    t.add(new Knight(0));
    break;

  case '2':
    t.add(new Archer(0));
    break;

  case '3':
    t.add(new Mage(0));
    break;

  case '4':
    t.add(new Cavalry(0));
    break;

  case '5':
    t.add(new Giant(0));
    break;
  }
}
