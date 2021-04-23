class Factions {
  int goldCount = 1000;

  Factions() {
  }



  void PassiveGold() {
    if (millis() - passiveGoldCoolDown >= passiveGoldDelayTime) { //Generates 20 gold every 0.8 seconds
      //goldCount += 20;
      passiveGoldCoolDown = millis();
    }
  }

  void Special() {
    //posSpecial.x = 500;
    posSpecial.y = h.selectorY;
    
    for (int i = 0; i < et.size(); i++) { //Runs the special in the selected lane and "Kills" all enemies on the lane
      if (et.get(i).pos.y == h.selectorY && et.get(i).pos.y <= posSpecial.x + 358) {
        et.get(i).currentHP -= 1;
      }
    }
  }
}
