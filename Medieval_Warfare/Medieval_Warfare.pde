ArrayList<Troop> t = new ArrayList<Troop>();
Factions f = new Factions();
HUD h  = new HUD();

PImage map, selector, highlight, knight, giant, archer, mage, cavalry;
PFont goldenIncome;

boolean drawStuff = false;

void setup() {
  size(800, 600);
  frameRate(60);
  
  knight = loadImage("Knight.png");
  knight.resize(60, 60); //temporary - used until actual troop images are made

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
  
  goldenIncome = createFont("Verdana", 20);
  
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
  
  //runs the different functions for troops
  for (int i = 0; i < t.size(); i++) {
    t.get(i).update();
    if (t.size() > 1) { //a troop can't collide, of there is nobody else to collide with
      t.get(i).checkCollision();
    }
    
    if (t.get(i).isDead || t.get(i).pos.x < 0 || t.get(i).pos.x > width) { //checks if a troop is dead - if so, it's removed
      t.remove(t.get(i));  //done as the last thing to avoid index exceptions
    }
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
  if (key == '½') {
    noLoop();
  }
  if (keyCode == ENTER) { //debugging
    loop();
  }
  if (keyCode == ' ') { //for testing & debugging collision between troops
    t.add(new Knight());
    t.get(t.size()-1).allegiance = 0;
    t.get(t.size()-1).pos.x = width - (h.selectorX + 20);
    t.get(t.size()-1).speed.x *= -1;
    t.get(t.size()-1).reach *= -1;
  }
}
