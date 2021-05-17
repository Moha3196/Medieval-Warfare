class HUD {
  int stage;
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;
  int optionsRotation;
  boolean mouseHand = false;
  boolean settingsOpen = false;
  int difficulty = 1;


  HUD () {
    stage = 1; //Used to switch screens
    selectorX = 31;     //initial coords for the selector
    selectorInitY = 92; //(pretty specific due to size of display window)
  }


  void selector(int row) {  //"selector" is the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void sendTroopAndUpgrades() {
    for (int j = 0; j < 6; j++) {
      int lanePosY = 92 + (60 * (j+1));
      if (mouseY >= 504 && mouseY <= 597) {
        if (mouseX >= 218 && mouseX <= 292) {
          mouseHand = true;
          image(highlight, 255, 539); //the highlighted box
          if (mousePressed && f.playerGoldCount >= f.fTroopPrices[0] && (millis() - f.fDeployCD >= f.delayTime && lanePosY == selectorY && !friendliesInSpawn[j])) { //if box is clicked on, and player has enough gold:
            ft.add(new FKnight(f.fTroopLevels[0])); //add a new troop - depends on the box that was clicked
            mousePressed = false; //stop the program from spamming troops in the blink of an eye
            f.fDeployCD = millis();
          }
        } else if (mouseX >= 303 && mouseX <= 377) { //same deal as above, but for different troops
          mouseHand = true;
          image(highlight, 340, 539);
          if (mousePressed && f.playerGoldCount >= f.fTroopPrices[1] && (millis() - f.fDeployCD >= f.delayTime && lanePosY == selectorY && !friendliesInSpawn[j])) { //("25" is the cost of deploying the troop)
            ft.add(new FArcher(f.fTroopLevels[1]));
            mousePressed = false;
            f.fDeployCD = millis();
          }
        } else if (mouseX >= 388 && mouseX <= 462) {
          mouseHand = true;
          image(highlight, 425, 539);
          if (mousePressed && f.playerGoldCount >= f.fTroopPrices[2] && (millis() - f.fDeployCD >= f.delayTime && lanePosY == selectorY && !friendliesInSpawn[j])) {
            ft.add(new FMage(f.fTroopLevels[2]));
            mousePressed = false;
            f.fDeployCD = millis();
          }
        } else if (mouseX >= 473 && mouseX <= 547) {
          mouseHand = true;
          image(highlight, 510, 539);
          if (mousePressed && f.playerGoldCount >= f.fTroopPrices[3] && (millis() - f.fDeployCD >= f.delayTime && lanePosY == selectorY && !friendliesInSpawn[j])) {
            ft.add(new FCavalry(f.fTroopLevels[3]));
            mousePressed = false;
            f.fDeployCD = millis();
          }
        } else if (mouseX >= 558 && mouseX <= 631) {
          image(highlight, 595, 539);        
          mouseHand = true;
          if (mousePressed && f.playerGoldCount >= f.fTroopPrices[4] && (millis() - f.fDeployCD >= f.delayTime && lanePosY == selectorY && !friendliesInSpawn[j])) {
            ft.add(new FGiant(f.fTroopLevels[4]));
            mousePressed = false;
            f.fDeployCD = millis();
          }
        }
      }
    }

    if (mouseX >= 59 && mouseX <= 199) {
      if (mouseY >= 516 && mouseY <= 531) {
        mouseHand = true;
        image(upgradeHighlight, 129, 524); //the highlighted box

        if (mousePressed && f.playerGoldCount >= 20*pow(2, f.fTroopLevels[0])) {
          f.playerGoldCount -= 20*pow(2, f.fTroopLevels[0]);
          f.fTroopLevels[0] += 1;
          f.fTroopPrices[0] *= 1.5;
          mousePressed = false; //stop the program from spamming troops in the blink of an eye
        }
      } else if (mouseY >= 532 && mouseY <= 547) { //same deal as above, but for different troops
        mouseHand = true;
        image(upgradeHighlight, 129, 540);

        if (mousePressed && f.playerGoldCount >= 35*pow(2, f.fTroopLevels[1])) {
          f.playerGoldCount -= 35*pow(2, f.fTroopLevels[1]);
          f.fTroopLevels[1] += 1;
          f.fTroopPrices[1] *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 548 && mouseY <= 563) {
        mouseHand = true;
        image(upgradeHighlight, 129, 556);

        if (mousePressed && f.playerGoldCount >= 50*pow(2, f.fTroopLevels[2])) {
          f.playerGoldCount -= 50*pow(2, f.fTroopLevels[2]);
          f.fTroopLevels[2] += 1;
          f.fTroopPrices[2] *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 564 && mouseY <= 579) {
        mouseHand = true;
        image(upgradeHighlight, 129, 572);

        if (mousePressed && f.playerGoldCount >= 70*pow(2, f.fTroopLevels[3])) {
          f.playerGoldCount -= 70*pow(2, f.fTroopLevels[3]);
          f.fTroopLevels[3] += 1;
          f.fTroopPrices[3] *= 1.5;
          mousePressed = false;
        }
      } else if (mouseY >= 580 && mouseY <= 595) {
        mouseHand = true;
        image(upgradeHighlight, 129, 588);

        if (mousePressed && f.playerGoldCount >= 100*pow(2, f.fTroopLevels[4])) {
          f.playerGoldCount -= 100*pow(2, f.fTroopLevels[4]);
          f.fTroopLevels[4] += 1;
          f.fTroopPrices[4] *= 1.5;
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
    text("LVL " + (f.fTroopLevels[0]+1) + " Knight: " + int(20 * pow(2, f.fTroopLevels[0])), 69, 532); //Shows prices for troop upgrades
    text("LVL " + (f.fTroopLevels[1]+1) + " Archer: " + int(35 * pow(2, f.fTroopLevels[1])), 69, 548);
    text("LVL " + (f.fTroopLevels[2]+1) + " Mage: " + int(50 * pow(2, f.fTroopLevels[2])), 69, 564);
    text("LVL " + (f.fTroopLevels[3]+1) + " Cavalry: " + int(70 * pow(2, f.fTroopLevels[3])), 69, 580);
    text("LVL " + (f.fTroopLevels[4]+1) + " Giant: " + int(100 * pow(2, f.fTroopLevels[4])), 69, 596);

    textSize(15);
    text("E", 618, 67); 
    text("N", 618, 79); 
    text("E", 618, 91); 
    text("M", 618, 103); 
    text("Y", 619, 115); 

    textSize(11);
    text("Knight  LVL " + (f.eTroopLevels[0]), 639, 62); //Shows Enemy troop levels in 
    text("Archer  LVL " + (f.eTroopLevels[1]), 639, 75); 
    text("Mage    LVL " + (f.eTroopLevels[2]), 639, 88); 
    text("Cavalry LVL " + (f.eTroopLevels[3]), 639, 101); 
    text("Giant    LVL " + (f.eTroopLevels[4]), 639, 114); 
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
        specialCD_PreOptions = millis() - lastSpecialUsed;
        f.eLevelingCD_PreOptions = millis() - f.eLevelingCD;
      }
    }

    if (settingsOpen) {
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
          lastSpecialUsed = millis() - specialCD_PreOptions;
          f.eLevelingCD = millis() - f.eLevelingCD_PreOptions;
        }
      }

      if  (mousePressed && mouseButton == LEFT) {
        if (mouseX >= 260 && mouseX <= 540 && mouseY >= 394 && mouseY <= 464) { //end Button
          restart();
          settingsOpen = false;
        }
      }
    }
  }
  
  
  void restart() {
    ft.clear(); //Removes all troops to prepare for the next game
    et.clear(); //"
    
    h.stage = 1; //Restarts Game on the start screen
    h.row = 1;
    
    f.eCastleCurrHP = 1000; //Resets Castle HP
    f.fCastleCurrHP = 1000; //"
    
    f.playerGoldCount = 600; //Resets faction's gold
    f.enemyGoldCount = 600;  //"
    
    for (int i = 0; i < 5; i++) { //stores the levels of all troops, which are all 1 in the beginning
      f.fTroopLevels[i] = 1;
      f.eTroopLevels[i] = 1;
    }
    
    f.fTroopPrices[0] = 20;  //stores the initial values of player's troops
    f.fTroopPrices[1] = 35;  //"
    f.fTroopPrices[2] = 50;  //"
    f.fTroopPrices[3] = 70;  //"
    f.fTroopPrices[4] = 100; //"
    
    for (int i = 0; i < 5; i++) { //for-loop to copy over prices from player's to enemy's troops
      f.eTroopPrices[i] = f.fTroopPrices[i];
    }

    f.eDeployCD = millis(); //Resets Troop spawning
    f.eLevelingCD = millis();
    lastSpecialUsed = millis();
    
    specialPos.x = -316;   //Resets special,
    specialMoving = false; //and stops it from moving
  }
}
