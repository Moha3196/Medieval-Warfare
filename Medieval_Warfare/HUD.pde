class HUD {
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int box = 0;
  boolean highlighted = false;
  int[][] boxes;

  HUD () {
    selectorX = 31;       //initial coords for the selector
    selectorInitY = 92;  //"

    boxes = new int[5][5];
  }

  void initBoxes() { //very ugly function (sorry). Needed to make working with box coords and specific boxes nicer and more clean
    boxes[0][1] = 1; //"
    boxes[0][2] = 2; //"
    boxes[0][3] = 3; //defines the number of each
    boxes[0][4] = 4; //"
    boxes[0][5] = 5; //"
    boxes[1][0] = 152; // "
    boxes[2][0] = 657; // Coords for box 1
    boxes[3][0] = 237; // "
    boxes[4][0] = 742; // "
    boxes[1][1] = 245; //"
    boxes[2][1] = 750; //Coords for box 2
    boxes[3][1] = 330; //"
    boxes[4][1] = 835; //"
    boxes[1][2] = 338; // "
    boxes[2][2] = 843; // Coords for box 3
    boxes[3][2] = 423; // "
    boxes[4][2] = 928; // "
    boxes[1][3] = 431; //"
    boxes[2][3] = 936; //Coords for box 4
    boxes[3][3] = 516; //"
    boxes[4][3] = 1021; //"
    boxes[1][4] = 524; // "
    boxes[2][4] = 1029; // Coords for box 5
    boxes[3][4] = 607; // "
    boxes[4][4] = 1114; // "
  }


  void selector(int row) {  //the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void troopHitBox() {
    if (mouseY >= 515 && mouseY <= 589) {
      imageMode(CORNER);
      if (mouseX >= 151 && mouseX <= 225) {         //Swordsman's box
        cursor(HAND);
        image(highlight, 151, 515);
      } else if (mouseX >= 236 && mouseX <= 310) {  //Swordsman's box
        cursor(HAND);
        image(highlight, 236, 515);
      } else if (mouseX >= 321 && mouseX <= 395) {  //Swordsman's box
        cursor(HAND);
        image(highlight, 321, 515);
      } else if (mouseX >= 406 && mouseX <= 480) {  //Swordsman's box
        cursor(HAND);
        image(highlight, 406, 515);
      } else if (mouseX >= 491 && mouseX <= 565) {  //Swordsman's box
        cursor(HAND);
        image(highlight, 491, 515);
      } else {
        cursor(ARROW);
      }
      imageMode(CENTER);
    } else {
      cursor(ARROW);
    }
  }
}
