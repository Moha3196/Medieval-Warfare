class Factions {
  int playerGoldCount = 600;
  int enemyGoldCount = 600;
  int passiveGoldCD; //The timer for gaining gold.
  int passiveGoldDelay = 1300; //The delay time for gaining gold.
  
  float fCastleHP = 1000; //Total HP for friendly castle
  float eCastleHP = 1000; //Total HP for enemy castle
  
  float fCastleCurrHP; //Current HP for friendly castle
  float eCastleCurrHP; //Current HP for enemy castle
  
  int fDeployCD; //The timer for deploying friendly troops.
  int delayTime = 1000; //The delay time for deploying troops.

  int eDeployCD; //The cooldown for deploying enemy troops
  int eSpawnDelay = 4000; //The delay between deployment
  int eLevelingCD; //The cooldown for (potentially) upgrading
  int eLevelingCD_PreOptions; //The cooldown for enemy upgrading before options menu was opened.
  int eLevelingDelay = 15000; //The delay between each attempt at upgrading an enemy troop
  
  int[] fTroopLevels = new int[5]; //to store the levels of different troops
  int[] eTroopLevels = new int[5]; //(index 0 = knight, 1 = archer, and so on)
  
  int[] fTroopPrices = new int[5]; //to store the prices of the different troops
  int[] eTroopPrices = new int[5]; //(index values are the same as for the level arrays)

  int numberOfMaxIndexes;
  float multiplier = 1; //a multiplier for the difficulty


  Factions() {
    fCastleCurrHP = fCastleHP;
    eCastleCurrHP = eCastleHP;
    
    for (int i = 0; i < 5; i++) { //stores the levels of all troops, which are all 1 in the beginning
      fTroopLevels[i] = 1;
      eTroopLevels[i] = 1;
    }
    
    fTroopPrices[0] = 20;  //stores the initial values of player's troops
    fTroopPrices[1] = 35;  //"
    fTroopPrices[2] = 50;  //"
    fTroopPrices[3] = 70;  //"
    fTroopPrices[4] = 100; //"
    
    for (int i = 0; i < 5; i++) { //for-loop to copy over prices from player's troops to the enemy's troops
      eTroopPrices[i] = fTroopPrices[i];
    }
    
    passiveGoldCD = millis();
    eDeployCD = millis();
    eLevelingCD = millis();
  }


  void passiveGold() {
    if (millis() - passiveGoldCD >= passiveGoldDelay) { //Generates 5 gold every 1.3 seconds
      playerGoldCount += 5;
      enemyGoldCount += 5;
      passiveGoldCD = millis();
    }
  }

  void special() {
    specialPos.x = -316;
    specialPos.y = h.selectorY;
  }


  void EnemyLeveling() {
    int eSelectedUnit = 0;
    float ChosenUnitUpgradeCost = 0;
    boolean eUnitSelected = false;
    if (eUnitSelected == false) {
      eSelectedUnit = (int)random(0, 5);

      switch(eSelectedUnit) { //Chooses a random troop then changes the "ChosenUnitUpgradeCost" to the chosen troop upgrade cost
      case 0:
        eUnitSelected = true;
        ChosenUnitUpgradeCost = 20*pow(2, eTroopLevels[0]);
        break;
        
      case 1:
        eUnitSelected = true;
        ChosenUnitUpgradeCost = 35*pow(2, eTroopLevels[1]);
        break;
        
      case 2:
        eUnitSelected = true;
        ChosenUnitUpgradeCost = 50*pow(2, eTroopLevels[2]);
        break;
        
      case 3:
        eUnitSelected = true;
        ChosenUnitUpgradeCost = 70*pow(2, eTroopLevels[3]);
        break;
        
      case 4:
        eUnitSelected = true;
        ChosenUnitUpgradeCost = 100*pow(2, eTroopLevels[4]);
        break;
      }
    }

    if (eUnitSelected == true && enemyGoldCount >= ChosenUnitUpgradeCost && millis() - eLevelingCD >= eLevelingDelay) {
      switch(eSelectedUnit) { //Upgrades enemy troops
      case 0:
        eTroopLevels[0]++;
        eLevelingCD = millis();
        eUnitSelected = false;
        break;

      case 1:
        eTroopLevels[1]++;
        eLevelingCD = millis();
        eUnitSelected = false;
        break; 

      case 2:
        eTroopLevels[2]++;
        eLevelingCD = millis();
        eUnitSelected = false;
        break;

      case 3:
        eTroopLevels[3]++;
        eLevelingCD = millis();
        eUnitSelected = false;
        break;

      case 4:
        eTroopLevels[4]++;
        eLevelingCD = millis();
        eUnitSelected = false;
        break;
      }
    }
  }


  void CheckIfTroopsInSpawn() {
    for (int i = 0; i < 6; i++) {
      int fTroopsInSpawn = 0;
      int eTroopsInSpawn = 0;
      int lanePosY = 92 + (60 * (i+1));
      for (int j = 0; j < ft.size(); j++) {
        if (lanePosY == ft.get(j).pos.y && h.selectorX + 60 >= ft.get(j).pos.x) { //Checks if there still is friendly troops in spawn
          fTroopsInSpawn++;
        }
      }
      if (fTroopsInSpawn > 0) { //If there is changes the boolean to true
      
        friendliesInSpawn[i] = true;
      } else {
        friendliesInSpawn[i] = false;
      }
      
      for (int j = 0; j < et.size(); j++) { 
        if (lanePosY == et.get(j).pos.y && width - h.selectorX - 60 <= et.get(j).pos.x) { //Checks if there still is enemie troops in spawn
          eTroopsInSpawn++;
        }
      }
      if (eTroopsInSpawn > 0) { //If there is changes the boolean to true
        enemiesInSpawn[i] = true;
      } else {
        enemiesInSpawn[i] = false;
      }
    }
  }


  void EnemySpawning() {
    int[] friendliesInLane = new int[6];
    float[] fLaneCombatPower = new float[6];
    boolean[] fUnhinderedAssault = new boolean[6]; //used for troops attacking the castle without resistance
    int totalLanePower = 0; 

    for (int i = 0; i < 6; i++) { //Counts how many friendly troops there is in every lane
      int resistance = 0;
      int[] notAttacking = new int[6];
      int lanePosY = 92 + (60 * (i+1)); //Y-Position of the lanes
      int enemiesInLane = 0;

      for (int f = 0; f < ft.size(); f++) {
        if (ft.get(f).pos.y == lanePosY) { //Checks if the friendly troop is on the current lane, and if it is, then it gets added to the Array
          friendliesInLane[i]++;
          fLaneCombatPower[i] += ft.get(f).maxHP * ft.get(f).damage / ft.get(f).attackFreq; //Calculates Combat Power
        }

        for (int e = 0; e < et.size(); e++) {
          if (et.get(e).pos.y == lanePosY) { //Checks if there is enemies in the lane
            enemiesInLane++;
          }
        }

        if (!ft.get(f).attackingCastle && ft.get(f).pos.y == lanePosY) { //Checks if the friendly troop is not attacking castle
          notAttacking[i]++;
        } else if (ft.get(f).attackingCastle && ft.get(f).pos.y == lanePosY && enemiesInLane == 0) { //Checks if friendly troop is attacking castle and there is no enemies defending
          notAttacking[i] = 0;
        } else if (ft.get(f).attackingCastle && ft.get(f).pos.y == lanePosY && enemiesInLane > 0) { //Checks if friendly troop is attacking castle and there is enemies defending
          resistance++;
        }
      }

      if (notAttacking[i] > 0 || friendliesInLane[i] == 0) { //If there is no friendly troops in lane or if the troop isnt attaking castle, sets boolean to false
        fUnhinderedAssault[i] = false;
      } else if (notAttacking[i] == 0 && enemiesInLane == 0) { //If the troop is attacking but there is no resistance, sets boolean to true
        fUnhinderedAssault[i] = true;
      } else if (resistance > 0) { //If the troop is attacking and there is resistance, sets boolean to false
        fUnhinderedAssault[i] = false;
      }
      fLaneCombatPower[i] += 50;
      totalLanePower += fLaneCombatPower[i]; //Defines the total combat power of all lanes

      resistance = 0; //Resets Resistance
    }

    float[] indexNumbersOfMaxCombatValues = indexesOfMaxValues(fLaneCombatPower);
    float[] priorityLanes = new float[numberOfMaxIndexes];
    for (int i = 0; i < priorityLanes.length; i++) {
      priorityLanes[i] = indexNumbersOfMaxCombatValues[i];
    }

    ArrayList<Integer> lanesWithNoResistance = new ArrayList<Integer>();
    for (int i = 0; i < 6; i++) { //Converts the indexes of the lanes with no resistance to another array
      if (fUnhinderedAssault[i]) {
        lanesWithNoResistance.add(i);
      }
    }

    int lanePicker = round(random(0, totalLanePower)); //Picks a random number between 0 and the totalLanePower

    int randomLaneSelector;
    int selectedLane = 0;
    if (lanesWithNoResistance.size() == 0) { //If there is no attack on castle then focus lane with highest combat power
      for (int i = 0; i < fLaneCombatPower.length; i++) {
        int checkedLanesTotalPower = 0;
        for (int j = 0; j < i; j++) {
          checkedLanesTotalPower += fLaneCombatPower[j]; //totalfLaneCombatPower of lanes already checked
        }       

        if (checkedLanesTotalPower < lanePicker && fLaneCombatPower[i] + checkedLanesTotalPower > lanePicker) {
          selectedLane = i; //Selects the lane
          break;
        }
      }
      //randomLaneSelector = (int)random(0, priorityLanes.length);
      //selectedLane = (int)priorityLanes[randomLaneSelector];
    } else { //Sends troops to defend against castle attack 
      randomLaneSelector = (int)random(0, lanesWithNoResistance.size());
      selectedLane = lanesWithNoResistance.get(randomLaneSelector);
    }

    int enemySpawnY = 92 + (60 * (selectedLane + 1)); //Sets the troop y-position according to the lane 

    int eSelectedUnit = 0;
    float chosenUnitCost = 0;
    boolean eUnitSelected = false;
    if (eUnitSelected == false) {
      eSelectedUnit = (int)random(0, 5);

      switch(eSelectedUnit) { //Chooses a random troop then changes the "chosenUnitCost" to the chosen troop cost
      case 0:
        eUnitSelected = true;
        chosenUnitCost = eTroopPrices[0];
        break;
        
      case 1:
        eUnitSelected = true;
        chosenUnitCost = eTroopPrices[1];
        break;
        
      case 2:
        eUnitSelected = true;
        chosenUnitCost = eTroopPrices[2];
        break;
        
      case 3:
        eUnitSelected = true;
        chosenUnitCost = eTroopPrices[3];
        break;
        
      case 4:
        eUnitSelected = true;
        chosenUnitCost = eTroopPrices[4];
        break;
      }
    }

    if (eUnitSelected == true && enemyGoldCount >= chosenUnitCost && millis() - eDeployCD >= eSpawnDelay && !enemiesInSpawn[selectedLane]) {
      switch(eSelectedUnit) { //Spawns enemy troops on the selected lane
      case 0:
        et.add(new EKnight(eTroopLevels[0], enemySpawnY));
        eDeployCD = millis();
        eUnitSelected = false;
        break;

      case 1:
        et.add(new EArcher(eTroopLevels[1], enemySpawnY));
        eDeployCD = millis();
        eUnitSelected = false;
        break; 

      case 2:
        et.add(new EMage(eTroopLevels[2], enemySpawnY));
        eDeployCD = millis();
        eUnitSelected = false;
        break;

      case 3:
        et.add(new ECavalry(eTroopLevels[3], enemySpawnY));
        eDeployCD = millis();
        eUnitSelected = false;
        break;

      case 4:
        et.add(new EGiant(eTroopLevels[4], enemySpawnY));
        eDeployCD = millis();
        eUnitSelected = false;
        break;
      }
    }
  }


  float[] indexesOfMaxValues(float[] chosenArray) { //Fuction that finds all the indexes with the highest Value
    float maxValue = chosenArray[0];
    //float maxIndex = 0;
    float[] MaxIndexes = new float[chosenArray.length]; //The array we are gonna store the indexes of max value in

    for (int i = 1; i < chosenArray.length; i++) { //For loop to find the highest value in the Array we are looking in
      if (chosenArray[i] > maxValue) {
        //maxIndex = i;
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


  void setDifficulty(int value) {
    switch(value) {
    case 1:
      multiplier = 1;
      break;

    case 2:
      multiplier = 1.5;
      break;

    case 3:
      multiplier = 2;
      break;
    }
  }
}
