/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\zombies\zombies_spawn_manager.gsc
*****************************************************/

init(var_0) {
  while(!isDefined(level.struct_class_names)) {
    wait 0.05;
  }

  if(!isDefined(level.zombies_spawners_zombie)) {
    level.zombies_spawners_zombie = [];
  }

  level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie, common_scripts\utility::getstructarray("zombie_spawner", "targetname"));
  level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie, common_scripts\utility::getstructarray("Spawner_A", "targetname"));
  level.zombie_spawning_active = 0;
  level.zombie_wave_running = 0;
  level.maxenemycount = 0;
  level.getspawntypefunc = [];
  level.candroppickupsfunc = [];
  level.roundstartfunc = [];
  level.roundendfunc = [];
  level.numenemiesthisroundfunc = [];
  level.roundspawndelayfunc = [];
  level.mutatorfunc = [];
  level.movemodefunc = [];
  level.moveratescalefunc = [];
  level.nonmoveratescalefunc = [];
  level.traverseratescalefunc = [];

  if(isDefined(level.mutatortablesetupfunc)) {
    [[level.mutatortablesetupfunc]]();
  } else {
    defaultmutatorsetup();
  }
}

defaultmutatorsetup() {
  level.special_mutators["emz"] = [::emzmutatorshouldapply, 2.0];
  level.special_mutators["fast"] = [::fastmutatorshouldapply, 1.0];
  level.special_mutators["exploder"] = [::explodermutatorshouldapply, 1.0];
}

getsolowaveoffset() {
  return 2;
}

shouldwaveend(var_0, var_1) {
  if(isDefined(level.shouldwaveendoverridefunc)) {
    return [[level.shouldwaveendoverridefunc]](var_0, var_1);
  }

  return var_0 >= var_1;
}

calculatemaxenemycount(var_0) {
  if(isDefined(level.nummaxenemiesthisroundfunc) && isDefined(level.nummaxenemiesthisroundfunc[level.roundtype])) {
    return [[level.nummaxenemiesthisroundfunc[level.roundtype]]](var_0);
  }

  return var_0;
}

spawnzombies(var_0, var_1, var_2) {
  level endon("zombie_stop_spawning");
  var_3 = undefined;
  var_4 = undefined;

  if(isDefined(var_2)) {
    var_3 = var_2["overrideSpawnType"];
    var_4 = var_2["mutatorFunc"];
  }

  var_5 = isDefined(var_2) && maps\mp\zombies\_util::is_true(var_2["limitedSpawns"]);
  var_6 = isDefined(var_2) && maps\mp\zombies\_util::is_true(var_2["forceSpawnDelay"]);

  for(var_7 = 0; !shouldwaveend(var_7, var_0); var_7++) {
    while(maps\mp\zombies\_util::iszombiegamepaused()) {
      waitframe();
    }

    while(maps\mp\agents\_agent_utility::getnumactiveagents() >= level.maxenemycount) {
      wait 0.1;
    }

    while(getnumberofzombies() >= var_0 && !var_5) {
      wait 0.1;
    }

    while(isDefined(level.zombie_pause_spawning_count) && level.zombie_pause_spawning_count > 0) {
      wait 0.1;
    }

    if(isDefined(var_3)) {
      var_8 = var_3;
    } else {
      var_8 = getenemytypetospawn(var_7, var_0);
    }

    if(isDefined(level.zombiesnextspawntype)) {
      var_8 = level.zombiesnextspawntype;
      level.zombiesnextspawntype = undefined;
    }

    var_10 = spawnzombietype(var_8, undefined, var_4);

    if(!var_6 && isDefined(level.roundspawndelayfunc[level.roundtype])) {
      var_1 = [[level.roundspawndelayfunc[level.roundtype]]](var_7, var_0);
    }

    level.totalaispawned++;
    level common_scripts\utility::waittill_notify_or_timeout("end_spawn_wait", var_1);
  }

  if(isDefined(var_2) && isDefined(var_2["notifyWhenFinished"])) {
    level notify(var_2["notifyWhenFinished"]);
  }
}

getmaxenemycount() {
  if(level.nextgen) {
    return calculatemaxenemycount(24);
  } else {
    return calculatemaxenemycount(20);
  }
}

runwave(var_0) {
  level endon("zombie_wave_interrupt");
  level.zombie_spawning_active = 1;
  level.zombie_wave_running = 1;
  level.totaldesiredai = calculatetotalai();
  level.totalaispawned = 0;
  level.maxenemycount = getmaxenemycount();
  var_1 = calculatespawndelay();

  if(isDefined(level.spawnzombiesoverridefunc)) {
    [[level.spawnzombiesoverridefunc]](level.totaldesiredai, var_1);
  } else {
    spawnzombies(level.totaldesiredai, var_1);
  }

  level.zombie_spawning_active = 0;
  wait 2.0;

  while(zombiesarealive()) {
    waitframe();
  }

  level.zombie_wave_running = 0;
  level notify("zombie_wave_ended");
}

zombiesarealive(var_0) {
  if(isDefined(level.recyclezombierequestspending) && level.recyclezombierequestspending > 0) {
    return 1;
  }

  var_1 = "all";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  var_2 = maps\mp\agents\_agent_utility::getactiveagentsoftype(var_1);

  foreach(var_4 in var_2) {
    if(!isscriptedagent(var_4)) {
      continue;
    }
    if(var_4.team == level.enemyteam) {
      return 1;
    }
  }

  return 0;
}

getnumberofzombies() {
  var_0 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
  var_1 = 0;

  foreach(var_3 in var_0) {
    if(var_3.team == level.enemyteam) {
      var_1++;
    }
  }

  return var_1;
}

getenemytypetospawn(var_0, var_1) {
  if(isDefined(level.getspawntypefunc[level.roundtype])) {
    return [[level.getspawntypefunc[level.roundtype]]](var_0, var_1);
  }

  return "zombie_generic";
}

calculatetotalai() {
  var_0 = 24;
  var_1 = 6;
  var_2 = level.wavecounter / 5;

  if(var_2 < 1) {
    var_2 = 1;
  }

  if(level.wavecounter >= 10) {
    var_2 = var_2 * (level.wavecounter * 0.15);
  }

  var_3 = maps\mp\zombies\_util::getnumplayers();

  if(var_3 == 1) {
    var_0 = var_0 + 0.5 * var_1 * var_2;
  } else {
    var_0 = var_0 + (var_3 - 1) * var_1 * var_2;
  }

  switch (level.wavecounter) {
    case 1:
      var_0 = var_0 * 0.25;
      break;
    case 2:
      var_0 = var_0 * 0.3;
      break;
    case 3:
      var_0 = var_0 * 0.7;
      break;
    case 4:
      var_0 = var_0 * 0.9;
      break;
  }

  if(isDefined(level.numenemiesthisroundfunc[level.roundtype])) {
    var_0 = [[level.numenemiesthisroundfunc[level.roundtype]]](var_0);
  }

  return int(var_0);
}

calculatespawndelay(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 2.0;
  }

  if(level.wavecounter == 1) {
    return var_0;
  }

  var_1 = var_0 * pow(0.95, level.wavecounter - 1);

  if(var_1 < 0.08) {
    var_1 = 0.08;
  }

  return var_1;
}

spawnzombietype(var_0, var_1, var_2, var_3) {
  var_4 = maps\mp\zombies\_zombies::spawnzombie(var_0, var_1, var_3);

  if(!isDefined(var_4)) {
    return;
  }
  if(isDefined(var_2)) {
    var_5 = var_2;
  } else if(isDefined(level.mutatorfunc[var_0])) {
    var_5 = level.mutatorfunc[var_0];
  } else {
    var_5 = ::applyzombiemutator;
  }

  [[var_5]](var_4);
  var_6 = var_0;

  if(isDefined(var_4.activemutators)) {
    foreach(var_9, var_8 in var_4.activemutators) {
      var_6 = var_6 + ("_" + var_9);
    }
  }

  if(var_4.agent_type == var_6 && isDefined(level.agentclasses[var_6])) {
    var_4 thread maps\mp\zombies\_zombies_audio::do_zombies_playvocals("spawn", var_4.agent_type);
  }

  if(isscriptedagent(var_4)) {
    var_4 scragentsetzombietype(var_6);
  }

  return var_4;
}

exomutatorshouldapply(var_0) {
  if(level.currentgen) {
    if(cg_calculatemutatoractivecount() >= 10) {
      return 0;
    }
  }

  if(!isscriptedagent(self)) {
    return 0;
  }

  if(isDefined(level.mutators_disabled[self.agent_type])) {
    if(isDefined(level.mutators_disabled[self.agent_type]["exo"]) && level.mutators_disabled[self.agent_type]["exo"]) {
      return 0;
    }
  }

  var_1 = 0;

  if(level.players.size < 2) {
    var_1 = 2;
  }

  var_2 = 3 + var_1;

  if(var_0 >= var_2) {
    var_3 = var_2;
    var_4 = 0.1;
    var_5 = 18 + var_1;
    var_6 = 1.0;
    var_7 = var_4;

    if(var_0 >= var_5) {
      var_7 = var_6;
    } else {
      var_8 = (var_0 - var_3) / (var_5 - var_3);
      var_7 = var_4 + var_8 * (var_6 - var_4);
    }

    if(randomfloat(1.0) < var_7) {
      return 1;
    }
  }

  return 0;
}

cg_calculatemutatoractivecount() {
  var_0 = 0;

  if(isDefined(level.activemutators["exo"])) {
    var_0 = level.activemutators["exo"];
  }

  return var_0;
}

emzmutatorshouldapply(var_0) {
  var_1 = 0;

  if(level.players.size < 2) {
    var_1 = 2;
  }

  var_2 = 4 + var_1;
  return var_0 >= var_2;
}

fastmutatorshouldapply(var_0) {
  var_1 = 0;

  if(level.players.size < 2) {
    var_1 = 2;
  }

  var_2 = 5 + var_1;
  var_3 = 20 + var_1;
  return var_0 >= var_2 && var_0 < var_3;
}

explodermutatorshouldapply(var_0) {
  if(level.roundtype == "zombie_dog") {
    return level.specialroundcounter < 6;
  }

  var_1 = 0;

  if(level.players.size < 2) {
    var_1 = 2;
  }

  var_2 = 6 + var_1;
  return var_0 >= var_2;
}

specialmutatorshouldapplydoground(var_0) {
  if(level.specialroundcounter < 3) {
    return 0;
  }

  var_1 = 1.0;

  if(level.specialroundcounter < 5) {
    var_1 = 0.5;
  }

  if(randomfloat(1.0) < var_1) {
    return 1;
  }

  return 0;
}

specialmutatorshouldapply(var_0) {
  if(!isscriptedagent(self)) {
    return 0;
  }

  if(isDefined(level.shouldspecialmutatorapplyfunc)) {
    var_1 = self[[level.shouldspecialmutatorapplyfunc]](var_0);

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  if(level.roundtype == "zombie_dog") {
    return specialmutatorshouldapplydoground(var_0);
  }

  if(level.currentgen) {
    if(cg_calculatemutatoractivecount() >= 10) {
      return 0;
    }
  }

  var_2 = 0;

  if(isDefined(level.specialmutatorstartingroundoverridefunc)) {
    var_3 = [[level.specialmutatorstartingroundoverridefunc]]();
  } else {
    if(level.players.size < 2) {
      var_2 = 2;
    }

    var_3 = 4;
  }

  var_4 = var_3 + var_2;
  var_5 = 0.05;
  var_6 = 20 + var_2;
  var_7 = 0.25;
  var_8 = (var_7 - var_5) / (var_6 - var_4);
  var_9 = 0.5;

  if(var_0 >= var_4) {
    var_10 = min(var_9, var_5 + var_8 * float(var_0 - var_4));

    if(randomfloat(1.0) < var_10) {
      return 1;
    }
  }

  return 0;
}

applyzombiemutator(var_0) {
  if(!isscriptedagent(var_0)) {
    return;
  }
  var_1 = var_0 specialmutatorshouldapply(level.wavecounter);
  var_2 = [];
  var_3 = var_0 exomutatorshouldapply(level.wavecounter) || var_1;

  if(var_3) {
    var_0 thread maps\mp\zombies\_mutators::mutator_apply("exo");
  }

  if(var_1) {
    var_7 = [];
    var_8 = 0.0;

    foreach(var_12, var_5 in level.special_mutators) {
      var_10 = var_5[0];
      var_11 = var_5[1];

      if(isDefined(level.mutators_disabled[var_0.agent_type])) {
        if(isDefined(level.mutators_disabled[var_0.agent_type][var_12]) && level.mutators_disabled[var_0.agent_type][var_12]) {
          continue;
        }
      }

      if(var_0[[var_10]](level.wavecounter)) {
        var_7[var_7.size] = var_12;
        var_8 = var_8 + var_11;
      }
    }

    var_13 = randomfloat(var_8);
    var_14 = 0.0;

    foreach(var_12 in var_7) {
      var_11 = level.special_mutators[var_12][1];

      if(var_13 > var_14 && var_13 <= var_14 + var_11) {
        var_0 thread maps\mp\zombies\_mutators::mutator_apply(var_12);
        break;
      }

      var_14 = var_14 + var_11;
    }
  }
}