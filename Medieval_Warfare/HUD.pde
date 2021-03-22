class HUD {
  int selectorX, selectorY, selectorInitY;  //coords for selector - the base is a stepping stone (see line 18)
  int row = 1;

  HUD () {
    selectorX = 31;      //initial coords for the selector
    selectorInitY = 92;  //(pretty specific due to size of display window)
  }


  void selector(int row) {  //"selector" is the arrow that indicates the selected lane
    selectorY = selectorInitY + (60 * row); //initial y-value is adjusted to place the selector within castle doors
    image(selector, selectorX, selectorY);
  }


  void sendTroop() {
    if (mouseY >= 515 && mouseY <= 589) {
      if (mouseX >= 151 && mouseX <= 225) {
        cursor(HAND); //to show that this area is clickable
        image(highlight, 188, 552); //the highlighted box
        image(swordsman, 188, 552);
        if (mousePressed && f.goldCount >= 20 && (millis() - troopDeplpoyCoolDown >= delayTime)) { //if box is clicked on, and player has enough gold:
            ft.add(new FSwordsman()); //add a new troop - depends on the box that was clicked
            mousePressed = false; //stop the program from spamming troops in the blink of an eye
            troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 236 && mouseX <= 310) { //same deal as above, but for different troops
        cursor(HAND);
        image(highlight, 273, 552);
        image(archer, 273, 552);
        if (mousePressed && f.goldCount >= 25 && (millis() - troopDeplpoyCoolDown >= delayTime)) { //("25" is the cost of deploying the troop)
          ft.add(new FArcher());
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 321 && mouseX <= 395) {
        cursor(HAND);
        image(highlight, 358, 552);
        image(mage, 358, 552);
        if (mousePressed && f.goldCount >= 40 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FMage());
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 406 && mouseX <= 480) {
        cursor(HAND);
        image(highlight, 443, 552);
        image(cavalry, 443, 552);
        if (mousePressed && f.goldCount >= 70 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FCavalry());
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else if (mouseX >= 491 && mouseX <= 565) {
        cursor(HAND);
        image(highlight, 528, 552);
        image(giant, 528, 552);
        if (mousePressed && f.goldCount >= 100 && (millis() - troopDeplpoyCoolDown >= delayTime)) {
          ft.add(new FGiant());
          mousePressed = false;
          troopDeplpoyCoolDown = millis();
        }
      } else {         //"
        cursor(ARROW); //"
      }                //stops cursor from being a hand outside the bounds of a box
    } else {           //"
      cursor(ARROW);   //"
    }
  }
}
