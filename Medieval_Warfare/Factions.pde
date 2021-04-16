class Factions {
  int goldCount, passiveGoldRate, passiveGoldCD;
  int deploymentCD, deployRate; //these will be universal for both factions
  
  Factions() {
    goldCount = 10000;
    passiveGoldRate = 2000;
    deployRate = 1000;
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
        t.add(new Knight());
        break;
      
      case 2:
        t.add(new Archer());
        break;
      
      case 3:
        t.add(new Mage());
        break;
      
      case 4:
        t.add(new Cavalry());
        break;
      
      case 5:
        t.add(new Giant());
        break;
    }
    
    t.get(t.size()-1).allegiance = 1; //"t.get(t.size()-1)" is the last troop in the array, and since a new troop was *just* added, the latest troop must also be last
    mousePressed = false; //stop the program from spamming troops in the blink of an eye
    f.deploymentCD = millis(); //reset cooldown for deploying troops
  }
}
