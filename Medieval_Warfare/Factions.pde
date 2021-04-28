class Factions {
  float playerCurrHP, enemyCurrHP, playerMaxHP, enemyMaxHP;
  int goldCount, passiveGoldRate, passiveGoldCD;
  int deploymentCD, deployDelay; //these will be universal for both factions
  
  Factions() {
    playerMaxHP = 1000;
    enemyMaxHP = 1000;
    playerCurrHP = 1000;
    enemyCurrHP = 1000;
    goldCount = 10000; //this is how much the player starts with (it's high while I'm testing of course)
    passiveGoldRate = 2000;
    deployDelay = 1000;
  }
  
  
  void passiveGold(){
    if(millis() - passiveGoldCD >= passiveGoldRate){ //Generates 20 gold every half second
      goldCount += 20;
      passiveGoldCD = millis();
    }
  }
  
  
  void deployTroop(int troopID) { //deploys specific troop according to input, then sets allegiance, 
    switch(troopID) {
      case 1:
        t.add(new Knight(1));
        break;
      
      case 2:
        t.add(new Archer(1));
        break;
      
      case 3:
        t.add(new Mage(1));
        break;
      
      case 4:
        t.add(new Cavalry(1));
        break;
      
      case 5:
        t.add(new Giant(1));
        break;
    }
    
    //t.get(t.size()-1).allegiance = 1; //"t.get(t.size()-1)" is the last troop in the array, and since a new troop was *just* added, the latest troop must also be last
    mousePressed = false; //stop the program from spamming troops in the blink of an eye
    f.deploymentCD = millis(); //reset cooldown for deploying troops
  }
}
