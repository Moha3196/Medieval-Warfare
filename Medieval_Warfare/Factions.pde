class Factions {
  int goldCount = 200;
  
  Factions() {
    
  }
  
  
  
  void PassiveGold(){
    if(millis() - passiveGoldCoolDown >= passiveGoldDelayTime){ //Generates 20 gold every 0.8 seconds
      goldCount += 20;
      passiveGoldCoolDown = millis();
    }
  }
  
}
