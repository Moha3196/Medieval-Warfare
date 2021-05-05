class HUD {
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int optionsRotation;
  boolean mouseHand=false;

  HUD () {
    selectorX = 31;      //initial coords for the selector
    selectorInitY = 92;  //(pretty specific due to size of display window)
  }


  void selector(int row) {  //"selector" is the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void sendTroopAndUpgrades() {
    if (mouseY >= 504 && mouseY <= 597) {
      if (mouseX >= 218 && mouseX <= 292) {
        mouseHand=true;
        image(highlight, 255, 539); //the highlighted box
        if (mousePressed && f.playerGoldCount >= 20 && (millis() - troopDeployCoolDown >= delayTime)) { //if box is clicked on, and player has enough gold:
          ft.add(new FKnight(friendlyKnightLevel)); //add a new troop - depends on the box that was clicked
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
        mouseHand=true;
        image(highlight, 340, 539);
        if (mousePressed && f.playerGoldCount >= 25 && (millis() - troopDeployCoolDown >= delayTime)) { //("25" is the cost of deploying the troop)
          ft.add(new FArcher(friendlyArcherLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 388 && mouseX <= 462) {
        mouseHand=true;
        image(highlight, 425, 539);
        if (mousePressed && f.playerGoldCount >= 40 && (millis() - troopDeployCoolDown >= delayTime)) {
          ft.add(new FMage(friendlyMageLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 473 && mouseX <= 547) {
        mouseHand=true;
        image(highlight, 510, 539);
        if (mousePressed && f.playerGoldCount >= 70 && (millis() - troopDeployCoolDown >= delayTime)) {
          ft.add(new FCavalry(friendlyCavalryLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 558 && mouseX <= 631) {
        image(highlight, 595, 539);        
        mouseHand=true;
        if (mousePressed && f.playerGoldCount >= 100 && (millis() - troopDeployCoolDown >= delayTime)) {
          ft.add(new FGiant(friendlyGiantLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      }
    }

    if (mouseX >= 59 && mouseX <= 199) {
      if (mouseY >= 516 && mouseY <= 531) {
        mouseHand=true;
        image(upgradeHighlight, 129, 524); //the highlighted box

        if (mousePressed && f.playerGoldCount >= 20*pow(2, friendlyKnightLevel)) {
          f.playerGoldCount -= 20*pow(2, friendlyKnightLevel);
          friendlyKnightLevel += 1;
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
        }
      } else if (mouseY >= 532 && mouseY <= 547) { //same deal as above, but for different troops
        mouseHand=true;
        image(upgradeHighlight, 129, 540);

        if (mousePressed && f.playerGoldCount >= 25*pow(2, friendlyArcherLevel)) {
          f.playerGoldCount -= 25*pow(2, friendlyArcherLevel);
          friendlyArcherLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 548 && mouseY <= 563) {
        mouseHand=true;
        image(upgradeHighlight, 129, 556);

        if (mousePressed && f.playerGoldCount >= 40*pow(2, friendlyMageLevel)) {
          f.playerGoldCount -= 40*pow(2, friendlyMageLevel);
          friendlyMageLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 564 && mouseY <= 579) {
        mouseHand=true;
        image(upgradeHighlight, 129, 572);

        if (mousePressed && f.playerGoldCount >= 70*pow(2, friendlyCavalryLevel)) {
          f.playerGoldCount -= 70*pow(2, friendlyCavalryLevel);
          friendlyCavalryLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 580 && mouseY <= 595) {
        mouseHand=true;
        image(upgradeHighlight, 129, 588);

        if (mousePressed && f.playerGoldCount >= 100*pow(2, friendlyGiantLevel)) {
          f.playerGoldCount -= 100*pow(2, friendlyGiantLevel);
          friendlyGiantLevel += 1;
          mousePressed = false;
        }
      }
    }
    pushMatrix();

    textAlign(LEFT, BOTTOM);
    fill(0, 0, 0);
    textSize(13);
    text("Upgrade to:", 69, 513);
    textSize(12);
    text("LVL " + (friendlyKnightLevel+1) + " Knight: " + int(20*pow(2, friendlyKnightLevel)), 69, 532); // Nice
    text("LVL " + (friendlyArcherLevel+1) + " Archer: " + int(25*pow(2, friendlyArcherLevel)), 69, 548);
    text("LVL " + (friendlyMageLevel+1) + " Mage: " + int(40*pow(2, friendlyMageLevel)), 69, 564);
    text("LVL " + (friendlyCavalryLevel+1) + " Cavalry: " + int(70*pow(2, friendlyCavalryLevel)), 69, 580);
    text("LVL " + (friendlyGiantLevel+1) + " Giant: " + int(100*pow(2, friendlyGiantLevel)), 69, 596);
  
    textSize(15);
    text("E", 618, 67); 
    text("N", 618, 79); 
    text("E", 618, 91); 
    text("M", 618, 103); 
    text("Y", 619, 115); 

    textSize(11);
    text("Knight  LVL " + (knightLevel), 639, 62); 
    text("Archer  LVL " + (archerLevel), 639, 75); 
    text("Mage    LVL " + (mageLevel), 639, 88); 
    text("Cavalry LVL " + (cavalryLevel), 639, 101); 
    text("Giant    LVL " + (giantLevel), 639, 114); 
    popMatrix();

    if (mouseHand && stage==3) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
    mouseHand=false;
  }

  void options() {
    pushMatrix();
    //println(mouseY);
    //println(mouseX);
    if (mouseX >= 708 && mouseX <= 755 && mouseY >= 517 && mouseY <= 563) {
      optionsRotation += 1;
    }
    translate(732, 541);
    rotate(optionsRotation/8);
    image(options, 0, 0);
    popMatrix();
  }
}
