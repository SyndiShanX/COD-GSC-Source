/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\_zombies_burgertown_spawning.gsc
************************************************************/

init() {
  level.spawninfo = spawnStruct();
  level.spawninfo.specialspawnsinfo = [];
  level.spawninfo.packremaining = 0;
  level.currentmaxenemycountfunc = [];
  var_0 = "mp/dlc2SpecialAISpawnTable.csv";
  var_1 = 0;
  var_2 = 1;
  var_3 = 2;
  var_4 = 3;
  var_5 = 4;
  var_6 = 5;
  var_7 = 6;
  var_8 = 7;
  var_9 = 8;
  var_10 = 9;
  var_11 = tablegetrowcount(var_0);

  for(var_12 = 0; var_12 < var_11; var_12++) {
    var_13 = tablelookupbyrow(var_0, var_12, var_1);
    var_14 = int(tablelookupbyrow(var_0, var_12, var_2));
    var_15 = int(tablelookupbyrow(var_0, var_12, var_3));
    var_16 = int(tablelookupbyrow(var_0, var_12, var_4));
    var_17 = int(tablelookupbyrow(var_0, var_12, var_5));
    var_18 = int(tablelookupbyrow(var_0, var_12, var_6));
    var_19 = int(tablelookupbyrow(var_0, var_12, var_7));
    var_20 = int(tablelookupbyrow(var_0, var_12, var_8));
    var_21 = int(tablelookupbyrow(var_0, var_12, var_9));
    var_22 = int(tablelookupbyrow(var_0, var_12, var_10));
    setupspecialspawninfo(var_13, var_14, var_15, var_16, var_17, var_18, var_19, var_20, var_21, var_22);
  }
}

setupspecialspawninfo(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level.spawninfo.specialspawnsinfo.size;
  level.spawninfo.specialspawnsinfo[var_10]["type"] = var_0;
  level.spawninfo.specialspawnsinfo[var_10]["startingRound"] = var_1;
  level.spawninfo.specialspawnsinfo[var_10]["startingCivilianRound"] = var_2;
  level.spawninfo.specialspawnsinfo[var_10]["probabilityIncrease"] = var_3;
  level.spawninfo.specialspawnsinfo[var_10]["currentProbability"] = 0;
  level.spawninfo.specialspawnsinfo[var_10]["roundCooldown"] = var_4;
  level.spawninfo.specialspawnsinfo[var_10]["currentRemainingCooldown"] = 0;
  level.spawninfo.specialspawnsinfo[var_10]["minPackSize"] = var_5;
  level.spawninfo.specialspawnsinfo[var_10]["maxPackSize"] = var_6;
  level.spawninfo.specialspawnsinfo[var_10]["packCooldown"] = var_7 * 1000;
  level.spawninfo.specialspawnsinfo[var_10]["nextValidSpawnTime"] = 0;
  level.spawninfo.specialspawnsinfo[var_10]["startingMaxActive"] = var_8;
  level.spawninfo.specialspawnsinfo[var_10]["startingTotalAllowed"] = var_9;
  level.spawninfo.specialspawnsinfo[var_10]["spawned"] = 0;
  level.spawninfo.specialspawnsinfo[var_10]["intro"] = 0;
}

initializespecialai() {
  for(var_0 = 0; var_0 < level.spawninfo.specialspawnsinfo.size; var_0++) {
    if(level.spawninfo.specialspawnsinfo[var_0]["spawned"]) {
      level.spawninfo.specialspawnsinfo[var_0]["currentProbability"] = 0;
      level.spawninfo.specialspawnsinfo[var_0]["currentRemainingCooldown"] = level.spawninfo.specialspawnsinfo[var_0]["roundCooldown"];
    } else {
      level.spawninfo.specialspawnsinfo[var_0]["currentRemainingCooldown"]--;

      if(level.spawninfo.specialspawnsinfo[var_0]["currentRemainingCooldown"] < 0) {
        level.spawninfo.specialspawnsinfo[var_0]["currentRemainingCooldown"] = 0;
      }
    }

    if(level.spawninfo.specialspawnsinfo[var_0]["startingRound"] > level.wavecounter) {
      var_1 = 0;
    } else {
      var_1 = int(min(100, level.spawninfo.specialspawnsinfo[var_0]["currentProbability"] + level.spawninfo.specialspawnsinfo[var_0]["probabilityIncrease"]));
    }

    level.spawninfo.specialspawnsinfo[var_0]["currentProbability"] = var_1;
    level.spawninfo.specialspawnsinfo[var_0]["totalSpawned"] = 0;
    level.spawninfo.specialspawnsinfo[var_0]["spawned"] = 0;
    level.spawninfo.packremaining = 0;
  }
}

spawnzombies(var_0, var_1) {
  level.spawninfo.numberspawned = 0;
  level.spawninfo.maxspecialai = calculatemaxspecialaicount();
  level.spawninfo.nextpossiblespecialaipack = 0;
  initializespecialai();

  if(level.nextcivilianround == level.wavecounter + 1) {
    level thread upcomingcivilianroundnotification(var_0);
  }

  var_2 = spawnnumberofzombies(var_0, var_1);
}

getmodifiedmaxenemycount(var_0) {
  if(level.roundtype != "zombie_melee_goliath") {
    return var_0;
  }

  var_1 = var_0 - 2;

  if(var_1 < 0) {
    var_1 = 0;
  }

  return var_1;
}

spawnzombiescivilianround(var_0, var_1) {
  level.spawninfo.numberspawned = 0;
  level.spawninfo.specialairange = calculatecivilianspecialairange();
  level.spawninfo.nextpossiblespecialaipack = randomintrange(level.spawninfo.specialairange["min"], level.spawninfo.specialairange["max"]);
  initializespecialai();
  var_2 = spawnnumberofzombies(var_0, var_1);

  while(level.numberofalivecivilians > 0 || isDefined(level.waitingforcivilianspawn)) {
    if(maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() < var_0) {
      var_2 = spawnnumberofzombies(1, var_1);
    }

    waitframe();
  }
}

spawnnumberofzombies(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0; var_2++) {
    checkspawningpaused(var_0);
    var_3 = maps\mp\zombies\zombies_spawn_manager::getenemytypetospawn(var_2, var_0);
    var_3 = modifyaitype(var_3, var_0);
    var_4 = maps\mp\zombies\zombies_spawn_manager::spawnzombietype(var_3);
    level.spawninfo.numberspawned++;

    if(isDefined(level.roundspawndelayfunc[level.roundtype])) {
      var_1 = [[level.roundspawndelayfunc[level.roundtype]]](var_2, var_0);
    }

    wait(var_1);
  }

  return var_2;
}

checkspawningpaused(var_0) {
  while(maps\mp\zombies\_util::iszombiegamepaused()) {
    waitframe();
  }

  if(isDefined(level.currentmaxenemycountfunc[level.roundtype])) {
    var_1 = [[level.currentmaxenemycountfunc[level.roundtype]]](level.maxenemycount);
  } else {
    var_1 = level.maxenemycount;
  }

  while(maps\mp\agents\_agent_utility::getnumactiveagents() >= var_1) {
    wait 0.1;
  }
}

checkforspecialaiintroround() {
  var_0 = undefined;

  for(var_1 = 0; var_1 < level.spawninfo.specialspawnsinfo.size; var_1++) {
    var_2 = level.spawninfo.specialspawnsinfo[var_1];

    if(var_2["intro"]) {
      continue;
    }
    if(level.roundtype == "normal" && var_2["startingRound"] > level.wavecounter) {
      continue;
    }
    if(level.roundtype != "normal" && var_2["startingCivilianRound"] > level.wavecounter) {
      continue;
    }
    if(var_2["totalSpawned"] >= var_2["startingTotalAllowed"]) {
      continue;
    }
    if(maps\mp\agents\_agent_utility::getnumactiveagents(var_2["type"]) >= var_2["startingMaxActive"]) {
      continue;
    }
    level.spawninfo.specialspawnsinfo[var_1]["intro"] = 1;
    return var_1;
  }

  return undefined;
}

modifyaitype(var_0, var_1) {
  if(isDefined(level.getspawntypefunc[level.roundtype])) {
    return [[level.getspawntypefunc[level.roundtype]]](level.spawninfo.numberspawned, var_1);
  }

  if(level.spawninfo.packremaining > 0) {
    level.spawninfo.packremaining--;
    return level.spawninfo.packtype;
  }

  if(level.spawninfo.nextpossiblespecialaipack <= level.spawninfo.numberspawned) {
    var_3 = checkforspecialaiintroround();

    if(isDefined(var_3)) {
      setspecialspawntype(var_3);
      return level.spawninfo.specialspawnsinfo[var_3]["type"];
    }

    for(var_4 = 0; var_4 < level.spawninfo.specialspawnsinfo.size; var_4++) {
      var_5 = level.spawninfo.specialspawnsinfo[var_4];
      var_6 = var_5["type"];

      if(level.roundtype == "normal" && var_5["startingRound"] > level.wavecounter) {
        continue;
      }
      if(level.roundtype != "normal" && var_5["startingCivilianRound"] > level.wavecounter) {
        continue;
      }
      if(var_5["currentProbability"] <= 0) {
        continue;
      }
      if(var_5["currentRemainingCooldown"] > 0) {
        continue;
      }
      if(var_5["totalSpawned"] >= var_5["startingTotalAllowed"]) {
        continue;
      }
      if(var_5["nextValidSpawnTime"] >= gettime()) {
        continue;
      }
      if(maps\mp\agents\_agent_utility::getnumactiveagents(var_6) >= var_5["startingMaxActive"]) {
        continue;
      }
      if(randomint(100) > var_5["currentProbability"]) {
        continue;
      }
      setspecialspawntype(var_4);
      return var_6;
    }
  }

  return var_0;
}

setspecialspawntype(var_0) {
  var_1 = level.spawninfo.specialspawnsinfo[var_0];

  if(var_1["minPackSize"] < var_1["maxPackSize"]) {
    var_2 = randomintrange(var_1["minPackSize"], var_1["maxPackSize"]);
  } else {
    var_2 = var_1["minPackSize"];
  }

  level.spawninfo.specialspawnsinfo[var_0]["spawned"] = 1;
  level.spawninfo.packtype = var_1["type"];
  level.spawninfo.packremaining = var_2 - 1;
  level.spawninfo.specialspawnsinfo[var_0]["currentProbability"] = level.spawninfo.specialspawnsinfo[var_0]["currentProbability"] - 10;

  if(level.roundtype == "normal") {
    level.spawninfo.nextpossiblespecialaipack = level.spawninfo.numberspawned + var_2 + 10;
  } else {
    level.spawninfo.nextpossiblespecialaipack = level.spawninfo.numberspawned + var_2 + randomintrange(level.spawninfo.specialairange["min"], level.spawninfo.specialairange["max"]);
  }
}

activatespecialspawncooldown(var_0) {
  for(var_1 = 0; var_1 < level.spawninfo.specialspawnsinfo.size; var_1++) {
    if(level.spawninfo.specialspawnsinfo[var_1]["type"] == var_0) {
      level.spawninfo.specialspawnsinfo[var_1]["nextValidSpawnTime"] = gettime() + level.spawninfo.specialspawnsinfo[var_1]["packCooldown"];
      return;
    }
  }
}

calculaterespawnthreshold() {
  var_0 = maps\mp\zombies\_util::getnumplayers();
  var_1 = level.wavecounter / 3;

  if(var_0 == 1) {
    var_2 = var_1;
  } else {
    var_2 = (var_0 - 1) * var_1 * 0.75;
  }

  return int(12 + var_2);
}

calculatemaxactiveai() {
  var_0 = maps\mp\zombies\_util::getnumplayers();
  var_1 = level.wavecounter / 2;

  if(var_1 < 1) {
    var_1 = 1;
  }

  if(var_0 == 1) {
    var_2 = var_1 * 0.5;
  } else {
    var_2 = (var_0 - 1) * var_1;
  }

  return int(12 + var_2);
}

calculatemaxspecialaicount() {
  if(level.wavecounter < 4) {
    return 0;
  }

  var_0 = maps\mp\zombies\_util::getnumplayers();
  var_1 = level.wavecounter / 5;

  if(var_1 < 1) {
    var_1 = 1;
  }

  if(var_0 == 1) {
    var_2 = var_1;
  } else {
    var_2 = (var_0 - 1) * var_1 * 0.5;
  }

  return int(6 + var_2);
}

calculatecivilianspecialairange() {
  var_0 = maps\mp\zombies\_util::getnumplayers();
  var_1 = level.wavecounter / 5;

  if(var_0 == 1) {
    var_2 = var_1;
  } else {
    var_2 = (var_0 - 1) * 0.5 + var_1;
  }

  var_3 = [];
  var_3["min"] = int(max(0, 6 - var_1 * 0.75));
  var_3["max"] = int(max(0, 10 - var_1 * 0.5));
  return var_3;
}

calculatecivilianpacksize() {
  var_0 = maps\mp\zombies\_util::getnumplayers();
  var_1 = level.wavecounter / 2;

  if(var_0 == 1) {
    var_2 = var_1;
  } else {
    var_2 = (var_0 - 1) * 0.5 * var_1;
  }

  return int(12 + var_2);
}

upcomingcivilianroundnotification(var_0) {
  level endon("game_ended");
  var_1 = int(var_0 * 0.5);

  for(;;) {
    if(level.spawninfo.numberspawned - maps\mp\zombies\zombies_spawn_manager::getnumberofzombies() >= var_1) {
      level notify("upcoming_civilian_round");
      break;
    }

    wait 0.1;
  }
}