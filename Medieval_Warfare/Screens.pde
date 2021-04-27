
int tutorialPage = 0;

void StartScreen() {
  image(startScreen, width/2, height/2); //Shows the start screen image
  //println("mouseX: " + mouseX + "   mouseY: " + mouseY);  //for testing (finding approximate coordinates)
  textAlign(CENTER);
  textSize(18);
  fill(255);
  rect(120, 400, 120, 80); //Start Game Button
  fill(0);
  text("Start Game", 180, 445);

  fill(255);
  rect(width - 120, 400, -120, 80); //Tutorial Button
  fill(0);
  text("Tutorial", width - 180, 445);

  if (mouseY >= 403 && mouseY <= 483) {
    if (mouseX >= 120 && mouseX <= 241) { //Start Game Button
      fill(125);
      rect(120, 400, 120, 80); //Start Game Button
      fill(0);
      text("Start Game", 180, 445);
      if (mousePressed) { //Starts the Game
        stage = 3;
        lastSpecialUsed = millis();
      }
    }
    if (mouseX >= width-240 && mouseX <= width-119) { //Tutorial Button
      fill(125);
      rect(width - 120, 400, -120, 80); //Tutorial Button
      fill(0);
      text("Tutorial", width - 180, 445);
      if (mousePressed) { //Starts the Tutorial
        stage = 2;
      }
    }
  } else {
    fill(255);
    rect(120, 400, 120, 80); //Start Game Button
    fill(0);
    text("Start Game", 180, 445);

    fill(255);
    rect(width - 120, 400, -120, 80); //Tutorial Button
    fill(0);
    text("Tutorial", width - 180, 445);
  }
}




void Tutorial() {
  boolean mouseHand = false;


  pushMatrix();
  textAlign(CENTER, TOP);
  fill(0, 0, 0);
  textSize(28);

  switch(tutorialPage) {
  case 0:
    image(tutorialPage0, width/2, height/2); //Shows the first page of the Tutorial
    break;

  case 1:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial
    image(arrow, 245, 125);
    text("Player Health", 240, 185);



    textAlign(LEFT, CENTER);

 
    //text("Current Lane", 195, 172);

    break;

  case 2:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial
    image(arrow, 558, 125);
    text("Enemy Health", 558, 185);
    break;

  case 3:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial
    pushMatrix();
    translate(650, 450);
    rotate(0.75*PI);
    image(arrow, 0, 0);
    popMatrix();
    text("Settings", 620, 365);
    break;

  case 4:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial

    pushMatrix();
    translate(346, 410);
    rotate(PI);
    image(arrow, 0, 0);
    popMatrix();
    text("Troop", 346, 315);
    break;

  case 5:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial

    pushMatrix();
    translate(270, 485);
    rotate(PI);
    image(arrow, 0, 0);
    popMatrix();
    text("Troop Cost", 270, 390);
    break;
  case 6:
    image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial

    pushMatrix();
    translate(180, 450);
    rotate(PI);
    image(arrow, 0, 0);
    popMatrix();
    text("Troop Upgrade", 180, 355);
    break;
  case 7:
   image(tutorialPage1, width/2, height/2); //Shows the second page of the Tutorial

    pushMatrix();
    translate(150, 170);
    
    rotate(1.5*PI);
    image(arrow, 0, 0);
   
    popMatrix();
     image(selector, 67, 167);
   text("Current Lane", 195, 100);
    break;

  case 8:
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
      if (mousePressed && tutorialPage != 8) {
        tutorialPage++;
        mousePressed = false;
      } else if (mousePressed && tutorialPage == 8) {
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
  image(fireTrailSpecial, posSpecial.x, posSpecial.y); //Shows the Special fire trail.
  //imageMode(CENTER);
  image(castles, width/2, height/2);
  pushMatrix();
  strokeWeight(2);

  if (specialMoving) {
    posSpecial.x ++;
  }
  if (posSpecial.x == 400) {
    specialMoving = false;
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

  h.selector(h.row);
  h.sendTroopAndUpgrades();
  h.options();
  f.PassiveGold();

  for (int i = 0; i < ft.size(); i++) { //runs the different functions for Friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();
    if (ft.get(i).isDead) {
      ft.remove(ft.get(i));
    }
  }

  for (int i = 0; i < et.size(); i++) { //runs the different functions for Enemy troops
    et.get(i).update();
    et.get(i).checkCollision();

    if (et.get(i).pos.y == h.selectorY && et.get(i).pos.x <= posSpecial.x + 358) {
      et.get(i).currentHP -= 0.1;
    }

    if (et.get(i).isDead) {
      et.remove(et.get(i));
    }
  }


  image(fKnight, 255, 541); //Shows the image of the troops in the boxes below.
  image(fArcher, 340, 541);
  image(fMage, 425, 541);
  image(fCavalry, 510, 541);
  image(fGiant, 595, 541);

  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 30); //Makes the font to Verdena and the size to 30.
  textFont(goldenIncome);
  fill(255);

  text("Gold: " + f.goldCount, width/3, 90); //Writes the current amount of gold
  if ((millis()/1000 - lastSpecialUsed/1000) < specialCoolDown/1000) { //Checks if special is ready, if not shows remaining time
    //text(specialCoolDown/1000 + lastSpecialUsed/1000 - millis()/1000, width/3*2, 90);
    image(fireTrailSpecialVisiualBox, width/3*2, 80);
    pushMatrix();
    fill(120, 180);
    strokeWeight(0);
    rectMode(CORNER);
    rect(width/3*2+75, 80-32.5, 5*-(specialCoolDown/1000 + lastSpecialUsed/1000 - millis()/1000), 65);
    strokeWeight(4);
    noFill();
    rect(width/3*2-75, 80-32.5, 150, 65);
    fill(255);
    popMatrix();
  } else { //If ready shows "Special Ready!"
    //text("Special Ready!", width/3*2, 90);
    image(fireTrailSpecialVisiualBox, width/3*2, 80);
    strokeWeight(4);
    noFill();
    rect(width/3*2-75, 80-32.5, 150, 65);
    fill(255);
  }
  textSize(12); //Changes the size to 12
  fill(0);


  text("Knight", 255, 493); //Writes the names of the troops above the boxes
  text("Archer", 340, 493); 
  text("Mage", 425, 493);
  text("Cavalry", 510, 493);
  text("Giant", 595, 493);



  textSize(16); //Changes the size to 16
  text(20, 255, 590); //Writes the cost of the troops above the boxes
  text(25, 340, 590);
  text(40, 425, 590);
  text(70, 510, 590);
  text(100, 595, 590);
  fill(255);
  textSize(20); //Changes the size to 20

  if (currentFriendlyCastleHP <= 0) {  //When the Friendly Castle dies, loads losing screen 
    won = false;
    stage = 4;
  } else if (currentEnemyCastleHP <= 0) {  //When the Enemy Castle dies, loads winning screen
    won = true;
    stage = 4;
  }
}


void EndScreen() {
  if (!won) {  //If player lost, show losing screen
    image(lossScreen, width/2, height/2); //Shows the LossScreen
  } else if (won) {  //If player won, show winning screen
    image(winScreen, width/2, height/2); //Shows the WinScreen
  }

  if (restart) {
    for (int i = 0; i < et.size(); i++) { //Deletes all enemy troops
      et.remove(et.get(i));
    }
    for (int i = 0; i < ft.size(); i++) { //Deletes all friendly troops
      ft.remove(ft.get(i));
    }

    f.goldCount = 1000; //Resets gold

    knightLevel = 1; //Resets troop lvl's back to 1
    archerLevel = 1;
    mageLevel = 1;
    cavalryLevel = 1;
    giantLevel = 1;

    currentEnemyCastleHP = 1000; //Resets Castle HP
    currentFriendlyCastleHP = 1000;

    stage = 3; //Restarts Game on GamingScreen
    lastSpecialUsed = millis();

    restart = false;
  }
}
