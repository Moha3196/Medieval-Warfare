ArrayList<FriendlyTroop> ft = new ArrayList<FriendlyTroop>();
ArrayList<EnemyTroop> et = new ArrayList<EnemyTroop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, swordsman, giant, archer, mage, cavalry;
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

  map = loadImage("Medievalbackground.png");
  selector = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2);
  
  pushMatrix();
  fill(0, 255, 0);
  noStroke();
  rect(width/2, 0, width/2/enemyCastleHP*currentEnemyCastleHP, 40); //Shows Enemy castle health bar
  fill(255, 0, 0);
  rect(0, 0, width/2, 40); //Shows Red bar under the friendly castle health bar
  fill(0, 255, 0);
  rect(0, 0, width/2/friendlyCastleHP*currentFriendlyCastleHP, 40); //Shows Enemy castle health bar
  fill(0);
  stroke(10);
  line(width/2, 0, width/2, 40); //Line drawen in middle between the two health bars
  popMatrix();
  
  h.selector(h.row);
  h.sendTroop();
  f.PassiveGold();

  for (int i = 0; i < ft.size(); i++) {  //runs the different functions for friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();
    if(ft.get(i).hp <= 0){ //checks if the friendly troops are alive, and if they are dead it sends them out of the map.
      //ft.get(i).pos.x = 3000;
      //ft.get(i).pos.y = 3000;
      ft.get(i).speed.x = 0;
      ft.remove(ft.get(i));
    } 
  }
  
  for (int i = 0; i < et.size(); i++) {  //runs the different functions for enemy troops
    et.get(i).update();
    et.get(i).checkCollision();
    if(et.get(i).hp <= 0){ //checks if the enemy troops are alive, and if they are dead it sends them out of the map.
      //et.get(i).pos.x = -3000;
      //et.get(i).pos.y = 3000;
      et.get(i).speed.x = 0;
      et.remove(et.get(i));
    } 
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
  if (keyCode == ENTER) { //Makes an enemy swordsman troop... Used for testing
    et.add(new ESwordsman());
  }
}
