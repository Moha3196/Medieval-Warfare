class Factions {
  int goldCount, passiveGoldRate, passiveGoldCD;
  int deploymentCD, deployRate; //these will be universal for both factions
  
  Factions() {
    goldCount = 0;
    passiveGoldRate = 2000;
    deployRate = 1000;
  }
  
  
  void PassiveGold(){
    if(millis() - passiveGoldCD >= passiveGoldRate){ //Generates 20 gold every half second
      goldCount += 20;
      passiveGoldCD = millis();
    }
  }
  
}
