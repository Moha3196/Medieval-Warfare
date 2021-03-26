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
        if (mousePressed && f.goldCount >= 20 && (millis() - troopDeplpoyCoolDown >= delayTime)) { //if box is clicked on, and player has enough gold:
          ft.add(new FKnight(knightLevel)); //add a new troop - depends on the box that was clicked
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
        mouseHand=true;
        image(highlight, 340, 539);
        if (mousePressed && f.goldCount >= 25 && (millis() - troopDeplpoyCoolDown >= delayTime)) { //("25" is the cost of deploying the troop)
          ft.add(new FArcher(archerLevel));
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 388 && mouseX <= 462) {
        mouseHand=true;
        image(highlight, 425, 539);
        if (mousePressed && f.goldCount >= 40 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FMage(mageLevel));
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 473 && mouseX <= 547) {
        mouseHand=true;
        image(highlight, 510, 539);
        if (mousePressed && f.goldCount >= 70 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FCavalry(cavalryLevel));
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 558 && mouseX <= 631) {
        image(highlight, 595, 539);        
        mouseHand=true;
        if (mousePressed && f.goldCount >= 100 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FGiant(giantLevel));
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      }
    }

    if (mouseX >= 62 && mouseX <= 152) {
      if (mouseY >= 516 && mouseY <= 531) {
        mouseHand=true;
        image(upgradeHighlight, 107, 524); //the highlighted box

        if (mousePressed && f.goldCount >= 20) { //if box is clicked on, and player has enough gold:

          mousePressed = false; //stop the program from spamming troops in the blink of an eye
        }
      } else if (mouseY >= 532 && mouseY <= 547) { //same deal as above, but for different troops
        mouseHand=true;
        image(upgradeHighlight, 107, 540);

        if (mousePressed && f.goldCount >= 25) { //("25" is the cost of deploying the troop)

          mousePressed = false;
        }
      } else if (mouseY >= 548 && mouseY <= 563) {
        mouseHand=true;
        image(upgradeHighlight, 107, 556);

        if (mousePressed && f.goldCount >= 40) {

          mousePressed = false;
        }
      } else if (mouseY >= 564 && mouseY <= 579) {
        mouseHand=true;
        image(upgradeHighlight, 107, 572);

        if (mousePressed && f.goldCount >= 70) {

          mousePressed = false;
        }
      } else if (mouseY >= 580 && mouseY <= 595) {
        mouseHand=true;
        image(upgradeHighlight, 107, 588);

        if (mousePressed && f.goldCount >= 100) {

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
    text("Level"+ /*(swordsmanlevel+1)+*/": ", 69, 532); // Nice
    text("Level"+ /*(swordsmanlevel+1)+*/": ", 69, 548);
    text("Level"+ /*(swordsmanlevel+1)+*/": ", 69, 564);
    text("Level"+ /*(swordsmanlevel+1)+*/": ", 69, 580);
    text("Level"+ /*(swordsmanlevel+1)+*/": ", 69, 596);
    popMatrix();


    if (mouseHand) {
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
