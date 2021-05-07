class HUD {
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int optionsRotation;
  boolean mouseHand=false;
  boolean settingsOpen = false;
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
        if (mousePressed && f.goldCount >= 20 && (millis() - troopDeployCoolDown >= delayTime) && settingsOpen == false) { //if box is clicked on, and player has enough gold:
          ft.add(new FKnight(knightLevel)); //add a new troop - depends on the box that was clicked
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
        mouseHand=true;
        image(highlight, 340, 539);
        if (mousePressed && f.goldCount >= 25 && (millis() - troopDeployCoolDown >= delayTime)&& settingsOpen == false) { //("25" is the cost of deploying the troop)
          ft.add(new FArcher(archerLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 388 && mouseX <= 462) {
        mouseHand=true;
        image(highlight, 425, 539);
        if (mousePressed && f.goldCount >= 40 && (millis() - troopDeployCoolDown >= delayTime)&& settingsOpen == false) {
          ft.add(new FMage(mageLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 473 && mouseX <= 547) {
        mouseHand=true;
        image(highlight, 510, 539);
        if (mousePressed && f.goldCount >= 70 && (millis() - troopDeployCoolDown >= delayTime)&& settingsOpen == false) {
          ft.add(new FCavalry(cavalryLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      } else if (mouseX >= 558 && mouseX <= 631) {
        image(highlight, 595, 539);        
        mouseHand=true;
        if (mousePressed && f.goldCount >= 100 && (millis() - troopDeployCoolDown >= delayTime)&& settingsOpen == false) {
          ft.add(new FGiant(giantLevel));
          mousePressed = false;
          troopDeployCoolDown = millis();
        }
      }
    }

    if (mouseX >= 59 && mouseX <= 199) {
      if (mouseY >= 516 && mouseY <= 531) {
        mouseHand=true;
        image(upgradeHighlight, 129, 524); //the highlighted box

        if (mousePressed && f.goldCount >= 20*pow(2, knightLevel)) {
          f.goldCount -= 20*pow(2, knightLevel);
          knightLevel += 1;
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
        }
      } else if (mouseY >= 532 && mouseY <= 547) { //same deal as above, but for different troops
        mouseHand=true;
        image(upgradeHighlight, 129, 540);

        if (mousePressed && f.goldCount >= 25*pow(2, archerLevel)) {
          f.goldCount -= 25*pow(2, archerLevel);
          archerLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 548 && mouseY <= 563) {
        mouseHand=true;
        image(upgradeHighlight, 129, 556);

        if (mousePressed && f.goldCount >= 40*pow(2, mageLevel)) {
          f.goldCount -= 40*pow(2, mageLevel);
          mageLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 564 && mouseY <= 579) {
        mouseHand=true;
        image(upgradeHighlight, 129, 572);

        if (mousePressed && f.goldCount >= 70*pow(2, cavalryLevel)) {
          f.goldCount -= 70*pow(2, cavalryLevel);
          cavalryLevel += 1;
          mousePressed = false;
        }
      } else if (mouseY >= 580 && mouseY <= 595) {
        mouseHand=true;
        image(upgradeHighlight, 129, 588);

        if (mousePressed && f.goldCount >= 100*pow(2, giantLevel)) {
          f.goldCount -= 100*pow(2, giantLevel);
          giantLevel += 1;
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
    text("LVL " + (knightLevel+1) + " Knight: " + int(20*pow(2, knightLevel)), 69, 532); // Nice
    text("LVL " + (archerLevel+1) + " Archer: " + int(25*pow(2, archerLevel)), 69, 548);
    text("LVL " + (mageLevel+1) + " Mage: " + int(40*pow(2, mageLevel)), 69, 564);
    text("LVL " + (cavalryLevel+1) + " Cavalry: " + int(70*pow(2, cavalryLevel)), 69, 580);
    text("LVL " + (giantLevel+1) + " Giant: " + int(100*pow(2, giantLevel)), 69, 596);
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

    if  (mousePressed && mouseButton == LEFT) {
      if (mouseX >= 708 && mouseX <= 755 && mouseY >= 517 && mouseY <= 563) {
        settingsOpen = true;
        println("imgay");
      }
    }

    if (settingsOpen == true) {
      fill(150);
      rect(width/2-150, height/2-170, 300, 345);
      rect(width/2-140, height/2-160, 280, 70);  //Resume Button

      rect(width/2-140, height/2-75, 280, 70);  //Volume Button
      rect(width/2-140, height/2+10, 280, 70);  //Difficulty Button
      rect(width/2-140, height/2+95, 280, 70);  //End Button
      textSize(40);
      fill(0);
      text("Resume", width/2-80, height/2-110);
      text("Volume:100", width/2-120, height/2-25);
      textSize(35);
      text("Difficulty:Hard", width/2-125, height/2+55);
      textSize(50);
      text("End", width/2-45, height/2+150);
      if  (mousePressed && mouseButton == LEFT) {
        if (mouseX >= 260 && mouseX <= 540 && mouseY >= 140 && mouseY <= 210) { //resume Button

          settingsOpen = false;
        }
      }
      if  (mousePressed && mouseButton == LEFT) {
        if (mouseX >= 260 && mouseX <= 540 && mouseY >= 394 && mouseY <= 464) { //end Button

          stage = 1; // Resets everything and puts you  back to the startscreen 
          ft.clear();
          et.clear();
          f.goldCount = 1000;
          knightLevel = 1;
          archerLevel = 1;
          mageLevel = 1;
          cavalryLevel = 1;
          giantLevel = 1;
          lastSpecialUsed = millis();          
          row = 1;

//special running
          settingsOpen = false;
        }
      }
    }
  }
}
