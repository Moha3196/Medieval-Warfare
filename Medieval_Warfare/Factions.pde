class Factions {
  int goldCount = 0;
  
  Factions() {
    
  }
  
  
  
  void PassiveGold(){
    if(millis() - passiveGoldCoolDown >= passiveGoldDelayTime){ //Generates 20 gold every half second
      goldCount += 20;
      passiveGoldCoolDown = millis();
    }
  }
  
}
