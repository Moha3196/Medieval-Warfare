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
      int lanePosY = 92 + (60 * (i+1)); //Y-Position of the lanes
      for (int j = 0; j < ft.size(); j++) {
        if (ft.get(j).pos.y == lanePosY) { //Checks if the friendly troop is on the current lane, and if it is, then it gets added to the Array
          friendliesInLane[i]++;
        }
      }
    }

    int[] indexNumbersOfMaxValues = indexesOfMaxValues(friendliesInLane); //Array that stores the highest lanes in it by using the indexesOfMaxValues function
    int[] lanesWithHighestNumberOfFriendlyTroops = new int[numberOfMaxIndexes]; //Made a new Array that would only contain the specific amount of lanes
    //with highest amount, since the indexNumbersOfMaxValues has a lot of 
    for (int i = 0; i < lanesWithHighestNumberOfFriendlyTroops.length; i++) {   //empty places after
      lanesWithHighestNumberOfFriendlyTroops[i] = indexNumbersOfMaxValues[i];
    }

    int randomLaneSelector = (int)random(0, lanesWithHighestNumberOfFriendlyTroops.length);
    int selectedLane = lanesWithHighestNumberOfFriendlyTroops[randomLaneSelector];
    int enemySpawnY = 92 + (60 * (selectedLane + 1)); //Sets the troop y-position according to the lane 

    int ESelectedUnit = 0;
    int ChosenUnitCost = 0;
    boolean EUnitSelected = false;
    if (EUnitSelected == false) {
      ESelectedUnit = (int)random(0, 5);
      switch(ESelectedUnit) {
      case 0:
        EUnitSelected = true;
        ChosenUnitCost = 20;
        break;
      case 1:
        EUnitSelected = true;
        ChosenUnitCost = 25;
        break;
      case 2:
        EUnitSelected = true;
        ChosenUnitCost = 40;
        break;
      case 3:
        EUnitSelected = true;
        ChosenUnitCost = 70;
        break;
      case 4:
        EUnitSelected = true;
        ChosenUnitCost = 100;
        break;
      }
    }

    if (EUnitSelected == true && enemyGoldCount >= ChosenUnitCost && millis() - enemyTroopDeployCoolDown >= enemySpawnDelayTime) { //Spawns enemy troops on the lane with highest amount of enemies.
      switch(ESelectedUnit) {
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
      }
    }
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
    for (int i = 0; i < chosenArray.length; i++) { //For loop that checks every index value, and sees if the value is equal to the max value,
      if (chosenArray[i] == maxValue) {            //and if it is, then it stores the index in a new Array
        MaxIndexes[countOfMaxIndexes] = i;
        countOfMaxIndexes++;
      }
    }

    numberOfMaxIndexes = countOfMaxIndexes;

    return MaxIndexes; //Returns the an array with the index numbers
  }
}
