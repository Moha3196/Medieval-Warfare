ArrayList<Troop> t;
HUD h;

PImage Baggrund;


void setup() {
  size(1000, 750);
  frameRate(60);
  
  t = new ArrayList<Troop>();
  h = new HUD();
  
  Baggrund = loadImage("Medievalbackground.png");
  
  imageMode(CENTER);
}


void draw() {
  image(Baggrund, width/2, height/2);
  h.selector(h.row);
  
  for (int i = 0; i < t.size(); i++) {  //runs the different functions for troops
    
  }
  
  
  //println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
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
}
