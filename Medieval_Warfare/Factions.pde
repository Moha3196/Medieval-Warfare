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

  int numberOfMaxIndexes;
  void EnemySpawning() {
    int[] friendliesInLane = new int[6];
    for (int i = 0; i < 6; i++) { //Counts how many friendly troops there is in every lane
      int lanePosY = 92 + (60 * (i+1));
      for (int j = 0; j < ft.size(); j++) {
        if (ft.get(j).pos.y == lanePosY) {
          friendliesInLane[i]++;
        }
      }
    }

    int[] indexNumbersOfMaxValues = indexesOfMaxValues(friendliesInLane);
    int[] lanesWithHighestNumberOfFriendlyTroops = new int[numberOfMaxIndexes];

    for (int i = 0; i < lanesWithHighestNumberOfFriendlyTroops.length; i++) {
      lanesWithHighestNumberOfFriendlyTroops[i] = indexNumbersOfMaxValues[i];
    }

    int randomLaneSelector = (int)random(0, lanesWithHighestNumberOfFriendlyTroops.length);
    int selectedLane = lanesWithHighestNumberOfFriendlyTroops[randomLaneSelector];
    int enemySpawnY = 92 + (60 * (selectedLane + 1)); //Sets the troop y-position according to the lane 
    
    //if (millis() - enemyTroopDeployCoolDown >= delayTime*4 && ft.size() > 0) { //Spawns enemy troops on the lane with highest amount of enemies.
    if (millis() - enemyTroopDeployCoolDown >= delayTime*4){ //Spawns enemy troops on the lane with highest amount of enemies.
      switch(selectedLane) {
      case 0:
        et.add(new EKnight(enemyKnightLevel, enemySpawnY));
        enemyTroopDeployCoolDown = millis();
        break;

      case 1:
        et.add(new EArcher(enemyKnightLevel, enemySpawnY));
        enemyTroopDeployCoolDown = millis();
        break; 

      case 2:
      et.add(new EMage(enemyKnightLevel, enemySpawnY));
      enemyTroopDeployCoolDown = millis();
        break;

      case 3:
      et.add(new ECavalry(enemyKnightLevel, enemySpawnY));
      enemyTroopDeployCoolDown = millis();
        break;

      case 4:
      et.add(new EGiant(enemyKnightLevel, enemySpawnY));
      enemyTroopDeployCoolDown = millis();
        break;

      case 5:
      enemyTroopDeployCoolDown = millis();
        break;
      }
    }

    //println(lanesWithHighestNumberOfFriendlyTroops);
    //println("");
    //println("");
    //println("");
    //println("");
  }

  int[] indexesOfMaxValues(int[] chosenArray) { //Fuction that finds all the indexes with the highest Value
    int maxValue = chosenArray[0];
    int maxIndex = 0;
    int[] MaxIndexes = new int[chosenArray.length]; //The array we are gonna store the indexes of max value in

    for (int i = 1; i < chosenArray.length; i++) { //For loop to find the highest value in the Array we are looking in
      if (chosenArray[i] > maxValue) {
        maxIndex = i;
        maxValue = chosenArray[i];
      }
    }

    int countOfMaxIndexes = 0;
    for (int i = 0; i < chosenArray.length; i++) { //For loop that checks every index value, and sees if the value is equal to the max value, and if it is
      if (chosenArray[i] == maxValue) {            //then it stores the index in a new Array
        MaxIndexes[countOfMaxIndexes] = i;
        countOfMaxIndexes++;
      }
    }

    numberOfMaxIndexes = countOfMaxIndexes;

    return MaxIndexes; //Returns the an array with the index numbers
  }
}
