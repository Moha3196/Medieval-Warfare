

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
      if (mousePressed){ //Starts the Game
        stage = 3;
      }
    }
    if (mouseX >= width-240 && mouseX <= width-119) { //Tutorial Button
      fill(125);
      rect(width - 120, 400, -120, 80); //Tutorial Button
      fill(0);
      text("Tutorial", width - 180, 445);
      if (mousePressed){ //Starts the Tutorial
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
}




void GamingScreen() {
  image(map, width/2, height/2); //Shows the playground, boxes and banners

  pushMatrix();
  strokeWeight(2);

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

  for (int i = 0; i < ft.size(); i++) {  //runs the different functions for Friendly troops
    ft.get(i).update();
    ft.get(i).checkCollision();
    if (ft.get(i).isDead) {
      ft.remove(ft.get(i));
    }
  }

  for (int i = 0; i < et.size(); i++) {  //runs the different functions for Enemy troops
    et.get(i).update();
    et.get(i).checkCollision();
    if (et.get(i).isDead) {
      et.remove(et.get(i));
    }
  }

  image(knight, 255, 541); //Shows the image of the troops in the boxes below.
  image(archer, 340, 541);
  image(mage, 425, 541);
  image(cavalry, 510, 541);
  image(giant, 595, 541);

  textAlign(CENTER);
  goldenIncome = createFont("Verdana", 30); //Makes the font to Verdena and the size to 30.
  textFont(goldenIncome);
  fill(255);

  text("Gold: " + f.goldCount, width/3, 90); //Writes the current amount of gold
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
}


void EndScreen() {
}