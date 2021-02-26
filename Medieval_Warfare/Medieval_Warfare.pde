ArrayList<Troop> t;
HUD h;

PImage map, selector, highlight;


void setup() {
  size(1000, 750);
  frameRate(60);

  t = new ArrayList<Troop>();
  h = new HUD();

  map = loadImage("Medievalbackground.png");
  selector = loadImage("Selector.png");
  highlight = loadImage("Highlighted box.png");

  imageMode(CENTER);
}


void draw() {
  image(map, width/2, height/2);
  h.selector(h.row);
  h.troopHitBox();
  h.highlightBox(h.box);

  for (int i = 0; i < t.size(); i++) {  //runs the different functions for troops
    t.get(i).render();
    t.get(i).update();
    t.get(i).checkCollision();
  }


  println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
}


void keyPressed() {
  if (keyCode == UP) {
    h.row -= 1;

    if (h.row <= 0) {
      h.row = 6;
    }
  }

  if (keyCode == DOWN) {
    h.row += 1;

    if (h.row >= 7) {
      h.row = 1;
    }
  }

  if (key == ' ') {
  }
}


void mousePressed() {
  //if (mouseX >= 118 && mouseX <= 202) {  //Swordsman's box
  //  if (mouseY >= 652 && mouseY <= 739 && !h.highlighted) {
  //    println("cyka");
  //    h.box = 1;
  //    h.highlighted = true;
  //  }
  //}
  
  //if (mouseX >= 160 && mouseX <= 252) {  //____'s box
  //  if (mouseY >= 652 && mouseY <= 739 && !h.highlighted) {
  //    println("cyka");
  //    h.box = 1;
  //    h.highlighted = true;
  //  }
  //}
  
  //if (mouseX >= 160 && mouseX <= 252) {  //____'s box
  //  if (mouseY >= 652 && mouseY <= 739 && !h.highlighted) {
  //    println("cyka");
  //    h.box = 1;
  //    h.highlighted = true;
  //  }
  //}
  
  //if (mouseX >= 160 && mouseX <= 252) {  //____'s box
  //  if (mouseY >= 652 && mouseY <= 739 && !h.highlighted) {
  //    println("cyka");
  //    h.box = 1;
  //    h.highlighted = true;
  //  }
  //}
  
  //if (mouseX >= 160 && mouseX <= 252) {  //____'s box
  //  if (mouseY >= 652 && mouseY <= 739 && !h.highlighted) {
  //    println("cyka");
  //    h.box = 1;
  //    h.highlighted = true;
  //  }
  //}
}
