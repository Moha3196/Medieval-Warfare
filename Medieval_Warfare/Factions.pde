class Factions {
  int playerGoldCount = 1000;
  int enemyGoldCount = 1000;

  Factions() {
  }

  void PassiveGold() {
    if (millis() - passiveGoldCoolDown >= passiveGoldDelayTime) { //Generates 20 gold every 0.8 seconds
      playerGoldCount += 5;
      passiveGoldCoolDown = millis();
    }
  }

  void Special() {
    posSpecial.x = -316;
    posSpecial.y = h.selectorY;
  }
}
