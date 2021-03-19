ArrayList<Troop> t = new ArrayList<Troop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, swordsman, giant, archer, mage, cavalry;


void setup() {
  size(800, 600);
  frameRate(60);
  swordsman = loadImage("Swordsman.png");
  swordsman.resize(60, 60);
  
  giant = loadImage("Giant.png");
  giant.resize(60, 60);
  
  archer = loadImage("Archer.png");
  archer.resize(60, 60);
  
  mage = loadImage("Mage.png");
  mage.resize(60, 60);
  
  cavalry = loadImage("Cavalry.png");
  cavalry.resize(60,60);
  
  map = loadImage("Medievalbackground.png");
  selector = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2);
  h.selector(h.row);
  h.sendTroop();

  for (int i = 0; i < t.size(); i++) {  //runs the different functions for troops
    t.get(i).update();
    t.get(i).checkCollision();
  }

  println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
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
