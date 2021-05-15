class Factions {
  int playerGoldCount = 600;
  int enemyGoldCount = 600;
  int numberOfMaxIndexes;
  float multiplier = 1;

  Factions() {
  }

  void passiveGold() {
    if (millis() - passiveGoldCD >= passiveGoldDelay) { //Generates 5 gold every 1.3 seconds
      playerGoldCount += 5;
      enemyGoldCount += 5;
      passiveGoldCD = millis();
    }
  }

  void special() {
    posSpecial.x = -316;
    posSpecial.y = h.selectorY;
  }

  void EnemyLeveling() {
    int ESelectedUnit = 0;
    float ChosenUnitUpgradeCost = 0;
    boolean EUnitSelected = false;
    if (EUnitSelected == false) {
      ESelectedUnit = (int)random(0, 5);

      switch(ESelectedUnit) { //Chooses a random troop then changes the "ChosenUnitUpgradeCost" to the chosen troop upgrade cost
      case 0:
        EUnitSelected = true;
        ChosenUnitUpgradeCost = 20*pow(2, eKnightLevel);
        break;
      case 1:
        EUnitSelected = true;
        ChosenUnitUpgradeCost = 35*pow(2, eArcherLevel);
        break;
      case 2:
        EUnitSelected = true;
        ChosenUnitUpgradeCost = 50*pow(2, eMageLevel);
        break;
      case 3:
        EUnitSelected = true;
        ChosenUnitUpgradeCost = 70*pow(2, eCavalryLevel);
        break;
      case 4:
        EUnitSelected = true;
        ChosenUnitUpgradeCost = 100*pow(2, eGiantLevel);
        break;
      }
    }

    if (EUnitSelected == true && enemyGoldCount >= ChosenUnitUpgradeCost && millis() - eLevelingCD >= eLevelingDelay) {
      switch(ESelectedUnit) { //Upgrades enemy troops
      case 0:
        eKnightLevel++;
        eLevelingCD = millis();
        EUnitSelected = false;
        break;

      case 1:
        eArcherLevel++;
        eLevelingCD = millis();
        EUnitSelected = false;
        break; 

      case 2:
        eMageLevel++;
        eLevelingCD = millis();
        EUnitSelected = false;
        break;

      case 3:
        eCavalryLevel++;
        eLevelingCD = millis();
        EUnitSelected = false;
        break;

      case 4:
        eGiantLevel++;
        eLevelingCD = millis();
        EUnitSelected = false;
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
    float[] friendliesCombatPowerInLane = new float[6];
    boolean[] friendliesAttackingCastleWithNoResistance = new boolean[6];
    int totalLanePower = 0; 

    for (int i = 0; i < 6; i++) { //Counts how many friendly troops there is in every lane
      int resistance = 0;
      int[] notAttacking = new int[6];
      int lanePosY = 92 + (60 * (i+1)); //Y-Position of the lanes
      int enemiesInLane = 0;

      for (int f = 0; f < ft.size(); f++) {
        if (ft.get(f).pos.y == lanePosY) { //Checks if the friendly troop is on the current lane, and if it is, then it gets added to the Array
          friendliesInLane[i]++;
          friendliesCombatPowerInLane[i] += ft.get(f).maxHP * ft.get(f).damage / ft.get(f).attackSpeed; //Calculates Combat Power
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
        friendliesAttackingCastleWithNoResistance[i] = false;
      } else if (notAttacking[i] == 0 && enemiesInLane == 0 ) { //If the troop is attacking but there is no resistance, sets boolean to true
        friendliesAttackingCastleWithNoResistance[i] = true;
      } else if (resistance > 0) { //If the troop is attacking and there is resistance, sets boolean to false
        friendliesAttackingCastleWithNoResistance[i] = false;
      }
      friendliesCombatPowerInLane[i] += 50;
      totalLanePower += friendliesCombatPowerInLane[i]; //Defines the total combat power of all lanes

      resistance = 0; //Resets Resistance
    }

    float[] indexNumbersOfMaxCombatValues = indexesOfMaxValues(friendliesCombatPowerInLane);
    float[] lanesWithHighestCombatPower = new float[numberOfMaxIndexes];
    for (int i = 0; i < lanesWithHighestCombatPower.length; i++) {
      lanesWithHighestCombatPower[i] = indexNumbersOfMaxCombatValues[i];
    }

    ArrayList<Integer> lanesWithNoResistance = new ArrayList<Integer>();
    for (int i = 0; i < 6; i++) { //Converts the indexes of the lanes with not resistance to another array
      if (friendliesAttackingCastleWithNoResistance[i]) {
        lanesWithNoResistance.add(i);
      }
    }

    int lanePicker = round(random(0, totalLanePower)); //Picks a random number between 0 and the totalLanePower

    int randomLaneSelector;
    int selectedLane = 0;
    if (lanesWithNoResistance.size() == 0) { //If there is no attack on castle then focus lane with highest combat power
      for (int i = 0; i < friendliesCombatPowerInLane.length; i++) {
        int checkedLanesTotalPower = 0;
        for (int j = 0; j < i; j++) {
          checkedLanesTotalPower += friendliesCombatPowerInLane[j]; //totalfriendliesCombatPowerInLane of lanes already checked
        }       

        if (checkedLanesTotalPower < lanePicker && friendliesCombatPowerInLane[i] + checkedLanesTotalPower > lanePicker) {
          selectedLane = i; //Selects the lane
          break;
        }
      }
      //randomLaneSelector = (int)random(0, lanesWithHighestCombatPower.length);
      //selectedLane = (int)lanesWithHighestCombatPower[randomLaneSelector];
    } else { //Sends troops to defend against castle attack 
      randomLaneSelector = (int)random(0, lanesWithNoResistance.size());
      selectedLane = lanesWithNoResistance.get(randomLaneSelector);
    }

    int enemySpawnY = 92 + (60 * (selectedLane + 1)); //Sets the troop y-position according to the lane 

    int ESelectedUnit = 0;
    float ChosenUnitCost = 0;
    boolean EUnitSelected = false;
    if (EUnitSelected == false) {
      ESelectedUnit = (int)random(0, 5);

      switch(ESelectedUnit) { //Chooses a random troop then changes the "ChosenUnitCost" to the chosen troop cost
      case 0:
        EUnitSelected = true;
        ChosenUnitCost = eKnightWorth;
        break;
        
      case 1:
        EUnitSelected = true;
        ChosenUnitCost = eArcherWorth;
        break;
        
      case 2:
        EUnitSelected = true;
        ChosenUnitCost = eMageWorth;
        break;
        
      case 3:
        EUnitSelected = true;
        ChosenUnitCost = eCavalryWorth;
        break;
        
      case 4:
        EUnitSelected = true;
        ChosenUnitCost = eGiantWorth;
        break;
      }
    }

    if (EUnitSelected == true && enemyGoldCount >= ChosenUnitCost && millis() - eDeployCD >= eSpawnDelay && !enemiesInSpawn[selectedLane]) {
      switch(ESelectedUnit) { //Spawns enemy troops on the selected lane
      case 0:
        et.add(new EKnight(eKnightLevel, enemySpawnY));
        eDeployCD = millis();
        EUnitSelected = false;
        break;

      case 1:
        et.add(new EArcher(eArcherLevel, enemySpawnY));
        eDeployCD = millis();
        EUnitSelected = false;
        break; 

      case 2:
        et.add(new EMage(eMageLevel, enemySpawnY));
        eDeployCD = millis();
        EUnitSelected = false;
        break;

      case 3:
        et.add(new ECavalry(eCavalryLevel, enemySpawnY));
        eDeployCD = millis();
        EUnitSelected = false;
        break;

      case 4:
        et.add(new EGiant(eGiantLevel, enemySpawnY));
        eDeployCD = millis();
        EUnitSelected = false;
        break;
      }
    }
  }

  float[] indexesOfMaxValues(float[] chosenArray) { //Fuction that finds all the indexes with the highest Value
    float maxValue = chosenArray[0];
    float maxIndex = 0;
    float[] MaxIndexes = new float[chosenArray.length]; //The array we are gonna store the indexes of max value in

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
