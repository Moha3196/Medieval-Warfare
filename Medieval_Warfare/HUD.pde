class HUD {
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int optionsRotation;
  boolean mouseHand = false;
  boolean settingsOpen = false;
  int difficulty = 1;


  HUD () {
    selectorX = 31;      //initial coords for the selector
    selectorInitY = 92;  //(pretty specific due to size of display window)
  }


  void selector(int row) {  //"selector" is the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void sendTroopAndUpgrades() {
    //for (int j = 0; j < 6; j++) {
    //  int lanePosY = 92 + (60 * (j+1));
      //if (lanePosY == selectorInitY && !friendlyTroopsStillInSpawn[j]) {
        if (mouseY >= 504 && mouseY <= 597) {
          if (mouseX >= 218 && mouseX <= 292) {
            mouseHand = true;
            image(highlight, 255, 539); //the highlighted box
            //if (mousePressed && f.playerGoldCount >= friendlyKnightWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime && lanePosY == selectorInitY && !friendlyTroopsStillInSpawn[j])) { //if box is clicked on, and player has enough gold:
            if (mousePressed && f.playerGoldCount >= friendlyKnightWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime)) { //if box is clicked on, and player has enough gold:
              ft.add(new FKnight(friendlyKnightLevel)); //add a new troop - depends on the box that was clicked
              mousePressed = false; //stop the program from spamming troops in the blink of an eye
              friendlyTroopDeployCoolDown = millis();
            }
          } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
            mouseHand = true;
            image(highlight, 340, 539);
            if (mousePressed && f.playerGoldCount >= friendlyArcherWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime)) { //("25" is the cost of deploying the troop)
              ft.add(new FArcher(friendlyArcherLevel));
              mousePressed = false;
              friendlyTroopDeployCoolDown = millis();
            }
          } else if (mouseX >= 388 && mouseX <= 462) {
            mouseHand = true;
            image(highlight, 425, 539);
            if (mousePressed && f.playerGoldCount >= friendlyMageWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime)) {
              ft.add(new FMage(friendlyMageLevel));
              mousePressed = false;
              friendlyTroopDeployCoolDown = millis();
            }
          } else if (mouseX >= 473 && mouseX <= 547) {
            mouseHand = true;
            image(highlight, 510, 539);
            if (mousePressed && f.playerGoldCount >= friendlyCavalryWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime)) {
              ft.add(new FCavalry(friendlyCavalryLevel));
              mousePressed = false;
              friendlyTroopDeployCoolDown = millis();
            }
          } else if (mouseX >= 558 && mouseX <= 631) {
            image(highlight, 595, 539);        
            mouseHand = true;
            if (mousePressed && f.playerGoldCount >= friendlyGiantWorth && (millis() - friendlyTroopDeployCoolDown >= delayTime)) {
              ft.add(new FGiant(friendlyGiantLevel));
              mousePressed = false;
              friendlyTroopDeployCoolDown = millis();
            }
          }
        }
      //}
    //}

    if (mouseX >= 59 && mouseX <= 199) {
      if (mouseY >= 516 && mouseY <= 531) {
        mouseHand=true;
        image(upgradeHighlight, 129, 524); //the highlighted box

        if (mousePressed && f.playerGoldCount >= 20*pow(2, friendlyKnightLevel)) {
          f.playerGoldCount -= 20*pow(2, friendlyKnightLevel);
          friendlyKnightLevel += 1;
          friendlyKnightWorth *= 1.5;
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
        }
      } else if (mouseY >= 532 && mouseY <= 547) { //same deal as above, but for different troops
        mouseHand=true;
        image(upgradeHighlight, 129, 540);

        if (mousePressed && f.playerGoldCount >= 35*pow(2, friendlyArcherLevel)) {
          f.playerGoldCount -= 35*pow(2, friendlyArcherLevel);
          friendlyArcherLevel += 1;
          friendlyArcherWorth *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 548 && mouseY <= 563) {
        mouseHand=true;
        image(upgradeHighlight, 129, 556);

        if (mousePressed && f.playerGoldCount >= 50*pow(2, friendlyMageLevel)) {
          f.playerGoldCount -= 50*pow(2, friendlyMageLevel);
          friendlyMageLevel += 1;
          friendlyMageWorth *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 564 && mouseY <= 579) {
        mouseHand=true;
        image(upgradeHighlight, 129, 572);

        if (mousePressed && f.playerGoldCount >= 70*pow(2, friendlyCavalryLevel)) {
          f.playerGoldCount -= 70*pow(2, friendlyCavalryLevel);
          friendlyCavalryLevel += 1;
          friendlyCavalryWorth *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 580 && mouseY <= 595) {
        mouseHand=true;
        image(upgradeHighlight, 129, 588);

        if (mousePressed && f.playerGoldCount >= 100*pow(2, friendlyGiantLevel)) {
          f.playerGoldCount -= 100*pow(2, friendlyGiantLevel);
          friendlyGiantLevel += 1;
          friendlyGiantWorth *= 1.5;
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
    text("LVL " + (friendlyKnightLevel+1) + " Knight: " + int(20*pow(2, friendlyKnightLevel)), 69, 532); //Shows prices for troop upgrades
    text("LVL " + (friendlyArcherLevel+1) + " Archer: " + int(35*pow(2, friendlyArcherLevel)), 69, 548);
    text("LVL " + (friendlyMageLevel+1) + " Mage: " + int(50*pow(2, friendlyMageLevel)), 69, 564);
    text("LVL " + (friendlyCavalryLevel+1) + " Cavalry: " + int(70*pow(2, friendlyCavalryLevel)), 69, 580);
    text("LVL " + (friendlyGiantLevel+1) + " Giant: " + int(100*pow(2, friendlyGiantLevel)), 69, 596);

    textSize(15);
    text("E", 618, 67); 
    text("N", 618, 79); 
    text("E", 618, 91); 
    text("M", 618, 103); 
    text("Y", 619, 115); 

    textSize(11);
    text("Knight  LVL " + (enemyKnightLevel), 639, 62); //Shows Enemy troop levels in 
    text("Archer  LVL " + (enemyArcherLevel), 639, 75); 
    text("Mage    LVL " + (enemyMageLevel), 639, 88); 
    text("Cavalry LVL " + (enemyCavalryLevel), 639, 101); 
    text("Giant    LVL " + (enemyGiantLevel), 639, 114); 
    popMatrix();

    if (mouseHand && stage == 3) {
      cursor(HAND);
    } else {
      cursor(ARROW);
    }
    mouseHand = false;
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

    if  (mousePressed && mouseButton == LEFT) {
      if (mouseX >= 708 && mouseX <= 755 && mouseY >= 517 && mouseY <= 563) {
        settingsOpen = true;
        specialCoolDownBeforeOptions = millis() - lastSpecialUsed;
        enemyLevelingCoolDownBeforeOptions = millis() - enemyLevelingCoolDown;
      }
    }

    if (settingsOpen == true) {
      fill(150);
      rect(width/2-150, height/2-170, 300, 345);
      rect(width/2-140, height/2-160, 280, 70); //Resume Button
      rect(width/2-140, height/2-75, 280, 70);  //Volume Button
      rect(width/2-140, height/2+10, 280, 70);  //Difficulty Button
      rect(width/2-140, height/2+95, 280, 70);  //End Button
      textSize(40);
      fill(0);
      text("Resume", width/2-80, height/2-110);
      textSize(35);
      text("Volume:" + (int)(vol*100) + "%", width/2-125, height/2-25);
      textSize(30);

      if (difficulty == 1) { //changes the text for the difficulty button through a mouseClicked in main
        text("Difficulty:Easy", width/2-125, height/2+55);
      } else if (difficulty == 2) {
        text("Difficulty:Normal", width/2-125, height/2+55);
      } else if (difficulty == 3) {
        text("Difficulty:Hard", width/2-125, height/2+55);
      }
      textSize(50);
      text("End", width/2-45, height/2+150);


      if  (mousePressed && mouseButton == LEFT) {
        if (mouseX >= 260 && mouseX <= 540 && mouseY >= 140 && mouseY <= 210) { //resume Button
          settingsOpen = false;
          lastSpecialUsed = millis() - specialCoolDownBeforeOptions;
          enemyLevelingCoolDown = millis() - enemyLevelingCoolDownBeforeOptions;
        }
      }

      if  (mousePressed && mouseButton == LEFT) {
        if (mouseX >= 260 && mouseX <= 540 && mouseY >= 394 && mouseY <= 464) { //end Button

          stage = 1; // Resets everything and puts you back to the startscreen 

          ft.clear();
          et.clear();

          f.playerGoldCount = 600;
          f.enemyGoldCount = 600;

          currentEnemyCastleHP = 1000; //Resets Castle HP
          currentFriendlyCastleHP = 1000;

          friendlyKnightLevel = 1;
          friendlyArcherLevel = 1;
          friendlyMageLevel = 1;
          friendlyCavalryLevel = 1;
          friendlyGiantLevel = 1;

          enemyKnightLevel = 1;
          enemyArcherLevel = 1;
          enemyMageLevel = 1;
          enemyCavalryLevel = 1;
          enemyGiantLevel = 1;

          friendlyKnightWorth = 20; //Resets the cost of the troops above the boxes
          friendlyArcherWorth = 35;
          friendlyMageWorth = 50;
          friendlyCavalryWorth = 70;
          friendlyGiantWorth = 100;

          lastSpecialUsed = millis(); //Resets the special timer
          enemyLevelingCoolDown = millis(); //Resets Enemy Upgrade Timer
          posSpecial.x = -316; //Resets special
          specialMoving = false;     
          row = 1;

          settingsOpen = false;
        }
      }
    }
  }
}
