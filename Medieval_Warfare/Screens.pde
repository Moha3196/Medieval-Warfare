int tutorialPage = 0;


void StartScreen() {
  image(startScreen, width/2, height/2); //Shows the start screen image
  textAlign(CENTER);
  fill(125, 100);
  image(startButton, 180, 440); //Start Game Button
  image(tutorialButton, width - 180, 440); //Tutorial Button

  if (mouseY >= 403 && mouseY <= 483) {
    if (mouseX >= 120 && mouseX <= 241) { //Start Game Button
      rect(120, 400, 120, 80); //Highlighted Start Game Button

      if (mousePressed) { //Starts the Game
        h.stage = 3;
        lastSpecialUsed = millis();
        f.eDeployCD = millis();
        f.eLevelingCD = millis();
      }
    }

    if (mouseX >= width-240 && mouseX <= width-119) { //Tutorial Button
      rect(width - 120, 400, -120, 80); //Highlighted Tutorial Button
      if (mousePressed) { //Starts the Tutorial
        h.stage = 2;
      }
    }
  }
  if (h.difficulty == 1) { //changes the text for the difficulty button through a mouseClicked in main
    image(difficultyEasy, width/2, 540);
  } else if (h.difficulty == 2) {
    image(difficultyNormal, width/2, 540);
  } else if (h.difficulty == 3) {
    image(difficultyHard, width/2, 540);
  }
  if (mouseY >= 510 && mouseY <= 570) {
    if (mouseX >= 250 && mouseX <= 550) { //Difficulty Button
      rect(250, 510, 300, 60); //Highlighted Difficulty Button
    }
  }
}


void Tutorial() {    //Explain the different features in the game
  boolean mouseHand = false;

  pushMatrix();
  textAlign(CENTER, TOP);
  fill(0, 0, 0);
  textSize(28);

  switch(tutorialPage) { //Switches between the different pages
    case 0://Shows the first page of the Tutorial
      image(tutorialPage0, width/2, height/2); 
  
      textSize(60); 
      text("Tutorial", width/2, 30);
  
      textSize(28);
      textAlign(LEFT, TOP);
      text("Use the left click key on a mouse to interact with most features in this game", width/3, 120, width/2+20, 150); //explains left click effect
  
      text("Use the up and down arrow to switch the current lane (lanes are explained later)", width/3, 270, width/2+20, 150); //explains up and down arrow effect
  
      text("Use the spacebar to activate the special ability, which does damage to enemies on a lane", width/3, 425, width/2+20, 150); //explains spacebar effect
      break;
  
    case 1://Shows the second page of the Tutorial
      image(tutorialPage1, width/2, height/2); 
      image(arrow, 245, 125);
      text("Player Health", 240, 185); 
      textAlign(LEFT, CENTER);
      break;
  
    case 2://Shows the third page of the Tutorial
      image(tutorialPage1, width/2, height/2); 
      image(arrow, 558, 125);
      text("Enemy Health", 558, 185);
      break;
  
    case 3://Shows the fourth page of the Tutorial
      image(tutorialPage1, width/2, height/2); 
      pushMatrix();
      translate(650, 450);
      rotate(0.75*PI);
      image(arrow, 0, 0);
      popMatrix();
      text("Settings", 620, 365);
  
      fill(255, 255, 255);
      rect(width/3-10, height/3, width/3+20, height/3+20);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("When you click the 'Settings' button the game pauses, and shows the settings menu", width/3-8, height/3-3, width/3+20, height/3+20); //explains settings effect
      break;
  
    case 4://Shows the fifth page of the Tutorial
      image(tutorialPage1, width/2, height/2); 
  
      pushMatrix();
      translate(346, 408);
      rotate(PI);
      image(arrow, 0, 0);
      popMatrix();
      text("Troop", 346, 315);
  
      fill(255, 255, 255);
      rect(width/3-60, height/4-5, width/3+120, height/5+50);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("When you click the 'troop' button a troop will spawn on the current lane    (lanes are explained later)", width/3-58, height/4-8, width/3+120, height/5+50); //explains troop effect
      break;
  
    case 5://Shows the sixth page of the Tutorial
      image(tutorialPage1, width/2, height/2); 
  
      pushMatrix();
      translate(270, 485);
      rotate(PI);
      image(arrow, 0, 0);
      popMatrix();
      text("Troop Cost", 270, 390);
  
      fill(255, 255, 255);
      rect(width/3-10, height/4, width/3+20, height/3-20);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("'Troop cost' is the amount of gold it requires to spawn the specific unit", width/3-8, height/4-3, width/3+20, height/3-20); //explains prices
      break;
  
    case 6: //Shows the seventh page of the Tutorial
      image(tutorialPage1, width/2, height/2);
  
      pushMatrix();
      translate(180, 450);
      rotate(PI);
      image(arrow, 0, 0);
      popMatrix();
      text("Troop Upgrade", 180, 355);
  
      fill(255, 255, 255);
      rect(width/3-10, height/5, width/3+20, height/3+20);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("'Troop upgrade' is used to upgrade units by clicking on the desired units upgrade", width/3-8, height/5-3, width/3+20, height/3+20); //explains upgrades
      break;
  
    case 7: //Shows the eight page of the Tutorial
      image(tutorialPage1, width/2, height/2);
  
      pushMatrix();
      translate(150, 170);
      rotate(1.5*PI);
  
      image(arrow, 0, 0);
  
      popMatrix();
  
      image(selector, 67, 167);
      text("Current Lane", 195, 100);
  
      fill(255, 255, 255);
      rect(width/3-10, height/3, width/3+20, height/4-10);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("'Current Lane' Shows which lane you're currently on", width/3-8, height/3-3, width/3+20, height/4-10); //explains current lane
  
      break;
      
    case 8: //Shows the ninth page of the Tutorial
      image(tutorialPage1, width/2, height/2);
  
      image(arrow, 400, 200);
      text("Ability Button", 400, 250);
  
      fill(255, 255, 255);
      rect(width/3-25, height/2, width/3+50, height/4-10);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("'Ability Button' Shows the cooldown left on ability use", width/3-23, height/2-3, width/3+50, height/4-10); //explains current lane
      break;
  
    case 9: //Shows the tenth page of the Tutorial
      image(tutorialPage1, width/2, height/2);
      image(tutorialPage2, width/2, height/2);
  
      image(arrow, 650, 200);
      text("Enemy level", 610, 250);
  
      fill(255, 255, 255);
      rect(width/3-10, height/2, width/3+20, height/4-10);
      fill(0, 0, 0);
      textAlign(LEFT, TOP);
      text("'Enemy level' Shows the current enemy level", width/3-8, height/2-3, width/3+20, height/4-10); //explains current lane
      break;
  }
  popMatrix();
  if (mouseY >= 48 && mouseY <= 88 && h.stage == 2) {
    if (mouseX >= 55 && mouseX <= 75 && tutorialPage != 0) {
      mouseHand = true;
      if (mousePressed) {
        tutorialPage--;
        mousePressed = false;
      }
    }    
    if (mouseX >= 724 && mouseX <= 744) {
      mouseHand = true;
      if (mousePressed && tutorialPage != 9) {
        tutorialPage++;
        mousePressed = false;
      } else if (mousePressed && tutorialPage == 9) {
        h.stage = 1;
        tutorialPage = 0;
        mousePressed = false;
      }
    }
  }

  if (mouseHand && h.stage == 2) {
    cursor(HAND);
  } else {
    cursor(ARROW);
    mouseHand = false;
  }
}



void GamingScreen() {
  image(map, width/2, height/2); //Shows the playground, boxes and banners
  image(special, specialPos.x, specialPos.y); //Shows the Special fire trail.
  image(castles, width/2, height/2);
  pushMatrix();
  strokeWeight(2);

  if (specialMoving) {
    specialPos.x += 2;
  }

  fill(0, 255, 0);
  rect(width, 1, (width/2)/f.eCastleHP * -f.eCastleCurrHP, 38); //Shows Enemy castle health bar

  fill(0, 255, 0);
  rect(0, 1, (width/2)/f.fCastleHP * f.fCastleCurrHP, 38); //Shows Friendly castle health bar

  strokeWeight(4);
  noFill();
  rect(width/2, 1, width/2-1, 38); //Shows Enemy castle health boarder
  rect(0, 1, width/2, 38); //Shows Friendly castle health boarder
  popMatrix();

  if ((millis()/1000 - lastSpecialUsed/1000) < specialCD/1000) { //Checks if special is ready, if not shows remaining time
    image(specialButton, width/3*2 - 20, 80);
    pushMatrix();
    fill(120, 180);
    strokeWeight(0);
    rectMode(CORNER);
    rect(width/3*2 + 75 - 20, 80 - 65/2, 5*-(specialCD/1000 + lastSpecialUsed/1000 - millis()/1000), 65);
    strokeWeight(4);
    noFill();
    rect(width/3*2 - 75 - 20, 80 - 65/2, 150, 65);
    fill(255);
    popMatrix();
  } else {
    image(specialButton, width/3*2 - 20, 80);
    strokeWeight(4);
    noFill();
    rect(width/3*2 - 75 - 20, 80 - 65/2, 150, 65);
    fill(255);
  }

  h.selector(h.row);
  h.sendTroopAndUpgrades();
  f.passiveGold();

  for (int i = 0; i < ft.size(); i++) { //runs the different functions for Friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();

    if (et.size() == 0) { //Friendlies should always move if there is no Enemies
      ft.get(i).occupied = false;
    }

    if (ft.get(i).currentHP <= 0) {
      ft.get(i).isDead = true;
    }

    if (ft.get(i).isDead) {
      ft.remove(ft.get(i));
    }
  }

  for (int i = 0; i < et.size(); i++) { //runs the different functions for Enemy troops
    et.get(i).update();
    et.get(i).checkCollision();

    if (ft.size() == 0) {//Enemies should always move if there is no Friendlies
      et.get(i).occupied = false;
    }

    if (et.get(i).pos.y == specialPos.y && et.get(i).pos.x <= specialPos.x + 358 && et.get(i).pos.x >= specialPos.x - 358) { //Checks if enemy troops are inside the special ability
      et.get(i).currentHP -= et.get(i).maxHP/100;                                                                            //And if they are, they will take damage over time
      if (et.get(i).currentHP <= 0) {
        f.playerGoldCount += et.get(i).worth*0.3;
        for (int j = 0; j < ft.size(); j++) {
          if (ft.get(j).pos.y == et.get(i).pos.y) {
            ft.get(j).occupied = false;
            ft.get(j).friendlyOccupied = false;
          }
        }
      }
    }

    if (et.get(i).currentHP <= 0) {
      et.get(i).isDead = true;
    }

    if (et.get(i).isDead) {
      et.remove(et.get(i));
    }
  }

  f.EnemyLeveling();
  f.EnemySpawning();
  f.CheckIfTroopsInSpawn();


  image(fKnight, 255, 541); //Shows the image of the troops in the boxes below.
  image(fArcher, 340, 541);
  image(fMage, 425, 541);
  image(fCavalry, 510, 541);
  image(fGiant, 595, 541);

  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 30); //Makes the font to Verdena and the size to 30.
  textFont(goldenIncome);
  fill(255);

  text("Gold: " + f.playerGoldCount, width/3, 90); //Writes the current amount of gold

  textSize(12); //Changes the size to 12
  fill(0);

  text("Knight", 255, 493); //Writes the names of the troops above the boxes
  text("Archer", 340, 493); 
  text("Mage", 425, 493);
  text("Cavalry", 510, 493);
  text("Giant", 595, 493);

  textSize(16); //Changes the size to 16
  text((int) f.fTroopPrices[0], 255, 590); //Writes the cost of the troops above the boxes
  text((int) f.fTroopPrices[1], 340, 590);
  text((int) f.fTroopPrices[2], 425, 590);
  text((int) f.fTroopPrices[3], 510, 590);
  text((int) f.fTroopPrices[4], 595, 590);
  fill(255);
  textSize(20); //Changes the size to 20

  if (f.fCastleCurrHP <= 0) {  //When the Friendly Castle dies, loads losing screen 
    won = false;
    h.stage = 4;
  } else if (f.eCastleCurrHP <= 0) {  //When the Enemy Castle dies, loads winning screen
    won = true;
    h.stage = 4;
  }
  textAlign(LEFT);
  h.options();
}



void EndScreen() {
  strokeWeight(4);
  if (!won) {  //If player lost, show losing screen
    image(lossScreen, width/2, height/2); //Shows the LossScreen
    fill(255);
    rect(width/2 - 180, 65, 360, 50);
    fill(0);
    text("You were defeated!", width/2, 100);
  } else if (won) {  //If player won, show winning screen
    image(winScreen, width/2, height/2); //Shows the WinScreen
    fill(255);
    rect(width/2 - 220, 65, 440, 50);
    fill(0);
    text("Congratulations! You won!", width/2, 100);
  }

  textAlign(CENTER);
  fill(125, 100);
  strokeWeight(2);

  image(playAgainButton, 310, 200); //play again Button
  image(quitButton, width - 310, 200); //quit Button
  if (mouseY >= 163 && mouseY <= 243) {
    if (mouseX >= 250 && mouseX <= 371) { //Play again Button
      rect(250, 160, 120, 80); //Highlighted Play again Button

      if (mousePressed) { //restarts the Game
        h.restart();
      }
    }

    if (mouseX >= width - 370 && mouseX <= width - 249) { //Exit Button
      rect(width - 250, 160, -120, 80); //Highlighted exit Button
      if (mousePressed) { //Exits the game
        exit();
      }
    }
  }
}
