class HUD {
  int selectorX, selectorY, selectorInitY; //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int optionsRotation;

  HUD () {
    selectorX = 31;     //initial coords for the selector
    selectorInitY = 92; //(pretty specific due to the design of the map)
  }


  void selector(int row) {  //"selector" is the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void renderHighlight() {
    image(fKnight, 255, 541);  //shows the image of the player's troops in their boxes on screen
    image(fArcher, 340, 541);  //"
    image(fMage, 425, 541);    //"
    image(fCavalry, 510, 541); //"
    image(fGiant, 595, 541);   //"

    textAlign(CENTER);
    fill(255);

    textFont(goldenIncome);
    fill(255);
    textSize(30);
    text("Gold: " + f.goldCount, width/3, 90); //displays the current amount of gold
    
    textSize(12);
    fill(0);
    text("Knight", 255, 493);  //displays the names of the troops above the boxes
    text("Archer", 340, 493);  //"
    text("Mage", 425, 493);    //"
    text("Cavalry", 510, 493); //"
    text("Giant", 595, 493);   //"
    
    textSize(16);
    text(20, 255, 590);  //displays the cost of the troops above the boxes
    text(25, 340, 590);  //"
    text(40, 425, 590);  //"
    text(70, 510, 590);  //"
    text(100, 595, 590); //"
  }


  void sendTroop() {
    if (mouseY >= 504 && mouseY <= 597) {
      if (mouseX >= 218 && mouseX <= 292) {
        cursor(HAND); //to show that this area is clickable
        image(highlight, 255, 539); //the highlighted box
        if (mousePressed && f.goldCount >= 20 && (millis() - f.deploymentCD >= f.deployDelay)) { //if box is clicked on, and player has enough gold:
          f.deployTroop(1); //add a new troop - troop depends on the box that was clicked
        }
      } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
        cursor(HAND);
        image(highlight, 340, 539);
        if (mousePressed && f.goldCount >= 25 && (millis() - f.deploymentCD >= f.deployDelay)) { //("25" is the cost of deploying the troop)
          f.deployTroop(2);
        }
      } else if (mouseX >= 388 && mouseX <= 462) {
        cursor(HAND);
        image(highlight, 425, 539);
        if (mousePressed && f.goldCount >= 40 && (millis() - f.deploymentCD >= f.deployDelay)) {
          f.deployTroop(3);
        }
      } else if (mouseX >= 473 && mouseX <= 547) {
        cursor(HAND);
        image(highlight, 510, 539);
        if (mousePressed && f.goldCount >= 70 && (millis() - f.deploymentCD >= f.deployDelay)) {
          f.deployTroop(4);
        }
      } else if (mouseX >= 558 && mouseX <= 631) {
        cursor(HAND);
        image(highlight, 595, 539);
        if (mousePressed && f.goldCount >= 100 && (millis() - f.deploymentCD >= f.deployDelay)) {
          f.deployTroop(5);
        }
      } else {         //"
        cursor(ARROW); //"
      }                //stops cursor from being a hand outside the bounds of a box
    } else {           //"
      cursor(ARROW);   //"
    }
  }
  
  
  void options() {
    pushMatrix();
    if (mouseX >= 708 && mouseX <= 755 && mouseY >= 517 && mouseY <= 563) {
      optionsRotation += 1;
    }
    translate(732, 541);
    rotate(optionsRotation/8);
    image(options, 0, 0);
    popMatrix();
  }
}
