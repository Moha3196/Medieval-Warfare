ArrayList<Troop> t = new ArrayList<Troop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, swordsman, giant, archer, mage, cavalry;
int troopDeplpoyCoolDown;
int delayTime = 1000;
int passiveGoldCoolDown;
int passiveGoldDelayTime = 800;
PFont goldenIncome;

void setup() {
  size(800, 600);
  frameRate(60);
  troopDeplpoyCoolDown = millis();
  passiveGoldCoolDown = millis();

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

  map = loadImage("Medievalbackground.png");
  selector = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2);
  h.selector(h.row);
  h.sendTroop();
  f.PassiveGold();

  for (int i = 0; i < t.size(); i++) {  //runs the different functions for troops
    t.get(i).update();
    t.get(i).checkCollision();
  }
  
  image(swordsman, 188, 552); //Shows the image of the troops in the boxes below.
  image(archer, 273, 552);
  image(mage, 358, 552);
  image(cavalry, 443, 552);
  image(giant, 528, 552);
  
  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 20); //Makes the font to Verdena and the size to 20.
  textFont(goldenIncome);
  fill(255);
  
  text("Gold: " + f.goldCount, 65, 510); //Writes the current amount of gold
  
  text(20, 188, 510); //Writes the cost of the troops above the boxes
  text(25, 273, 510);
  text(40, 358, 510);
  text(70, 443, 510);
  text(100, 528, 510);

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
}
