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
    if (mouseX >= 152 && mouseX <= 237) {  //Swordsman's box
      if (mouseY >= 657 && mouseY <= 742) {
        cursor(HAND);
      }
    }
    
    else if (mouseX >= 245 && mouseX <= 330) {  //Swordsman's box
      if (mouseY >= 750 && mouseY <= 835) {
        cursor(HAND);
      }
    }
    
    else if (mouseX >= 338 && mouseX <= 423) {  //Swordsman's box
      if (mouseY >= 843 && mouseY <= 928) {
        cursor(HAND);
      }
    }
    
   else if (mouseX >= 431 && mouseX <= 514) {  //Swordsman's box
      if (mouseY >= 936 && mouseY <= 1021) {
        cursor(HAND);
      }
    }
    
   else if (mouseX >= 524 && mouseX <= 607) {  //Swordsman's box
      if (mouseY >= 1029 && mouseY <= 1114) {
        cursor(HAND);
      }
    }
    else {
      cursor(ARROW);
    }
  }
  
  void highlightBox(int box) {
    if (box == 1 && highlighted) {
      image(highlight, 194, 699);
    }
    
    if (box == 2 && highlighted) {
      image(highlight, 287, 699);
    }
    
    if (box == 3 && highlighted) {
      
    }
    
    if (box == 4 && highlighted) {
      
    }
    
    if (box == 5 && highlighted) {
      
    }
  }
  
}
