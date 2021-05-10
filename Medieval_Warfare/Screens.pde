
int tutorialPage = 0;

void StartScreen() {
  image(startScreen, width/2, height/2); //Shows the start screen image
  //println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
  textAlign(CENTER);
  fill(125, 100);

  image(startButton, 180, 440); //Start Game Button
  image(tutorialButton, width - 180, 440); //Tutorial Button
  if (mouseY >= 403 && mouseY <= 483) {
    if (mouseX >= 120 && mouseX <= 241) { //Start Game Button
      rect(120, 400, 120, 80); //Highlighted Start Game Button

      if (mousePressed) { //Starts the Game
        stage = 3;
        lastSpecialUsed = millis();
        enemyTroopDeployCoolDown = millis();
      }
    }


    if (mouseX >= width-240 && mouseX <= width-119) { //Tutorial Button
      rect(width - 120, 400, -120, 80); //Highlighted Tutorial Button
      if (mousePressed) { //Starts the Tutorial
        stage = 2;
      }
    }
  }
}






void Tutorial() {
  boolean mouseHand = false;


  pushMatrix();
  textAlign(CENTER, TOP);
  fill(0, 0, 0);
  textSize(20);

  switch(tutorialPage) {
  case 0:
    image(tutorialPage0, width/2, height/2); //Shows the first page of the Tutorial
    break;

  case 1:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial
    text("Player Health", 240, 112);
    text("Enemy Health", 558, 115);
    text("Settings", 625, 390);
    text("Highlighted Troop", 346, 325);
    text("Troop", 422, 360);
    text("Troop Upgrade", 234, 400);

    textAlign(LEFT, CENTER);

    text("Highlighted Troop Upgrade", 97, 276);
    text("Current Lane", 195, 172);

    break;

  case 2:
    image(tutorialPage2, width/2, height/2); //Shows the third page of the  Tutorial
    break;
  }
  popMatrix();
  if (mouseY >= 48 && mouseY <= 88 && stage == 2) {
    if (mouseX >= 55 && mouseX <= 75 && tutorialPage != 0) {
      mouseHand = true;
      if (mousePressed) {
        tutorialPage--;
        mousePressed = false;
      }
    }    
    if (mouseX >= 724 && mouseX <= 744) {
      mouseHand = true;
      if (mousePressed && tutorialPage != 2) {
        tutorialPage++;
        mousePressed = false;
      } else if (mousePressed && tutorialPage == 2) {
        stage = 1;
        tutorialPage = 0;
        mousePressed = false;
      }
    }
  }

  if (mouseHand && stage == 2) {
    cursor(HAND);
  } else {
    cursor(ARROW);
    mouseHand = false;
  }
}




void GamingScreen() {
  image(map, width/2, height/2); //Shows the playground, boxes and banners
  //imageMode(CORNER);
  image(Special, posSpecial.x, posSpecial.y); //Shows the Special fire trail.
  //imageMode(CENTER);
  image(castles, width/2, height/2);
  pushMatrix();
  strokeWeight(2);

  if (specialMoving) {
    posSpecial.x += 2;
  }

  fill(0, 255, 0);
  rect(width, 1, width/2/enemyCastleHP*-currentEnemyCastleHP, 38); //Shows Enemy castle health bar

  fill(0, 255, 0);
  rect(0, 1, width/2/friendlyCastleHP*currentFriendlyCastleHP, 38); //Shows Friendly castle health bar

  strokeWeight(4);
  noFill();
  rect(width/2, 1, width/2-1, 38); //Shows Enemy castle health boarder
  rect(0, 1, width/2, 38); //Shows Friendly castle health boarder
  //strokeWeight(10);
  popMatrix();

  if ((millis()/1000 - lastSpecialUsed/1000) < specialCoolDown/1000) { //Checks if special is ready, if not shows remaining time
    image(specialButton, width/3*2 - 20, 80);
    pushMatrix();
    fill(120, 180);
    strokeWeight(0);
    rectMode(CORNER);
    rect(width/3*2 + 75 - 20, 80 - 65/2, 5*-(specialCoolDown/1000 + lastSpecialUsed/1000 - millis()/1000), 65);
    strokeWeight(4);
    noFill();
    rect(width/3*2 - 75 - 20, 80 - 65/2, 150, 65);
    fill(255);
    popMatrix();
  } else { //If ready shows "Special Ready!"
    //text("Special Ready!", width/3*2, 90);
    image(specialButton, width/3*2 - 20, 80);
    strokeWeight(4);
    noFill();
    rect(width/3*2 - 75 - 20, 80 - 65/2, 150, 65);
    fill(255);
  }

  h.selector(h.row);
  h.sendTroopAndUpgrades();

  f.PassiveGold();

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

    if (ft.size() == 0) {// && !ft.get(i).friendlyOccupied && !ft.get(i).friendlyInFront) { //Enemies should always move if there is no Friendlies
      et.get(i).occupied = false;
    }

    if (et.get(i).pos.y == posSpecial.y && et.get(i).pos.x <= posSpecial.x + 358 && et.get(i).pos.x >= posSpecial.x - 358) { //Checks if enemy troops are inside the special ability
      et.get(i).currentHP -= 1*et.get(i).maxHP/100;                                                                         //And if they are, they will take damage over time
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

  f.EnemySpawning();


  image(fKnight, 255, 541); //Shows the image of the troops in the boxes below.
  image(fArcher, 340, 541);
  image(fMage, 425, 541);
  image(fCavalry, 510, 541);
  image(fGiant, 595, 541);

  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 30); //Makes the font to Verdena and the size to 30.
  textFont(goldenIncome);
  fill(255);

  text("Gold: " + f.playerGoldCount + "  " + f.enemyGoldCount, width/3, 90); //Writes the current amount of gold

  textSize(12); //Changes the size to 12
  fill(0);

  text("Knight", 255, 493); //Writes the names of the troops above the boxes
  text("Archer", 340, 493); 
  text("Mage", 425, 493);
  text("Cavalry", 510, 493);
  text("Giant", 595, 493);

  textSize(16); //Changes the size to 16
  text((int)friendlyKnightWorth, 255, 590); //Writes the cost of the troops above the boxes
  text((int)friendlyArcherWorth, 340, 590);
  text((int)friendlyMageWorth, 425, 590);
  text((int)friendlyCavalryWorth, 510, 590);
  text((int)friendlyGiantWorth, 595, 590);
  fill(255);
  textSize(20); //Changes the size to 20

  if (currentFriendlyCastleHP <= 0) {  //When the Friendly Castle dies, loads losing screen 
    won = false;
    stage = 4;
  } else if (currentEnemyCastleHP <= 0) {  //When the Enemy Castle dies, loads winning screen
    won = true;
    stage = 4;
  }
  textAlign(LEFT);
  h.options();
}



void EndScreen() {
  if (!won) {  //If player lost, show losing screen
    image(lossScreen, width/2, height/2); //Shows the LossScreen
  } else if (won) {  //If player won, show winning screen
    image(winScreen, width/2, height/2); //Shows the WinScreen
  }

  if (restart) {
    et.clear(); //Deletes all enemy troops
    ft.clear(); //Deletes all friendly troops

    f.playerGoldCount = 1000; //Resets player gold
    f.enemyGoldCount = 1000; //Resets enemy gold

    friendlyKnightLevel = 1; //Resets troop lvl's back to 1
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
    
    currentEnemyCastleHP = 1000; //Resets Castle HP
    currentFriendlyCastleHP = 1000;

    enemyTroopDeployCoolDown = millis(); //Resets Troop spawning

    stage = 3; //Restarts Game on GamingScreen
    lastSpecialUsed = millis(); //Resets the special timer
    posSpecial.x = -316; //Resets special
    specialMoving = false; 

    h.row = 1;

    restart = false;
  }
}
