class Factions {
  int goldCount = 1000;
  
  Factions() {
    
  }
  
  
  
  void PassiveGold(){
    if(millis() - passiveGoldCoolDown >= passiveGoldDelayTime){ //Generates 20 gold every 0.8 seconds
      goldCount += 20;
      passiveGoldCoolDown = millis();
    }
  }
  
}
