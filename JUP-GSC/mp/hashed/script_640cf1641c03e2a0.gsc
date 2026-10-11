/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_640cf1641c03e2a0.gsc
*************************************************/

#using script_747ad1ab3322f8bc;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\poi;
#using scripts\mp\utility\debug;
#namespace namespace_39878ad79a617fab;

function function_ca39a413ace3c168() {
  setDvar(@ "hash_cc838a8ebb92734", 0);
  level.parareinforcestruct = spawnStruct();
  function_97af096f73d8367a();
  function_7dccce8c87ea644();
  level thread function_a6193ffd30278d98();
}

function function_97af096f73d8367a() {
  while(!flag_exist("create_script_initialized")) {
    waitframe();
  }

  flag_wait("create_script_initialized");
  level.parareinforcestruct.landingspots = getStructArray("para_landingSpot", "script_noteworthy");
}

function function_7dccce8c87ea644() {
  while(!flag_exist("create_script_initialized")) {
    waitframe();
  }

  flag_wait("create_script_initialized");
  waitframe();

  if(poi_issystemactive()) {
    while(level.poi.size == 0) {
      waitframe();
    }

    waitframe();

    foreach(poiname, poi in level.poi) {
      struct = spawnStruct();
      struct.var_e574839e9e50e6a7 = [];
      struct.var_932a9b3d757d01e9 = [];
      struct.landingspots = [];

      if(istrue(level.var_4cfd75aa6ddde156)) {
        struct.var_e574839e9e50e6a7 = getStructArray("ac130_enter", "targetname");
        struct.var_932a9b3d757d01e9 = getStructArray("ac130_exit", "targetname");
        struct.landingspots = getStructArray("para_landingSpot", "script_noteworthy");
        level.poi[poiname]["paraReinforceStruct"] = struct;
        continue;
      }

      struct.var_e574839e9e50e6a7 = function_9656b61cc8a37cba(getStructArray("ac130_enter", "targetname"), poiname);
      struct.var_932a9b3d757d01e9 = function_9656b61cc8a37cba(getStructArray("ac130_exit", "targetname"), poiname);
      struct.landingspots = function_9656b61cc8a37cba(getStructArray("para_landingSpot", "script_noteworthy"), poiname);
      level.poi[poiname]["paraReinforceStruct"] = struct;
    }

    return;
  }

  level.parareinforcestruct = spawnStruct();
  level.parareinforcestruct.var_e574839e9e50e6a7 = getStructArray("ac130_enter", "targetname");
  level.parareinforcestruct.var_932a9b3d757d01e9 = getStructArray("ac130_exit", "targetname");
  level.parareinforcestruct.landingspots = getStructArray("para_landingSpot", "script_noteworthy");
}

function function_55ab9c6da96226e7(numriders, reinforceorigin, var_3b496abb2047566b, var_ec862c2c00c7ab5d, priority, category, subcategory, team, var_93390a6953905fef, poiname, spawnheading, var_94ba23284fa98c04, noc130, skipstealth, tier, var_4f200828059689db, nationality) {
  if(isDefined(level.radiation) && istrue(level.radiation.spreading)) {
    return;
  }

  if(!isDefined(numriders)) {
    numriders = 5;
  }

  if(!isDefined(poiname)) {
    poiname = poi_findpoioriginisin(reinforceorigin);
  }

  if(!isDefined(var_4f200828059689db)) {
    var_4f200828059689db = 2048;
  }

  reinforceorigin = scripts\mp\ai_behavior::function_d378cc95abab583b(reinforceorigin, poiname);
  reinforceorigin = getclosestpointonnavmesh(reinforceorigin);
  landingorigin = function_2673db74633ed911(reinforceorigin, poiname);

  if(!isDefined(landingorigin)) {
    landingorigin = reinforceorigin;
  }

  spawners = undefined;

  if(isDefined(var_ec862c2c00c7ab5d) && isDefined(var_ec862c2c00c7ab5d.requests)) {
    spawners = var_ec862c2c00c7ab5d.requests;
  }

  spawners = function_984016d3b51024a2(numriders, landingorigin, spawners, priority, category, poiname, 512, tier, team, nationality);

  if(!isDefined(spawners) || spawners.size == 0) {
    return;
  }

  spawner = spawners[0];
  dropheight = ter_op(isDefined(var_3b496abb2047566b), var_3b496abb2047566b, 7000);
  var_1e4bce6c927436e0 = spawner.parachute_land_origin + (0, 0, dropheight);

  if(!isDefined(spawnheading)) {
    spawnheading = (0, randomintrange(1, 360), 0);
  }

  var_cd36c086ac42b7c6 = var_1e4bce6c927436e0 - anglesToForward(spawnheading) * 512 * numriders / 2;
  ac130_spawnloc = undefined;

  if(!isDefined(spawnheading)) {
    ac130_spawnloc = function_9e7d8e0b07e473f0(var_1e4bce6c927436e0, poiname);
  } else {
    ac130_spawnloc = var_1e4bce6c927436e0 - anglesToForward(spawnheading) * 40000;
  }

  if(istrue(noc130)) {
    foreach(spawner in spawners) {
      spawner.origin = reinforceorigin + (0, 0, dropheight) + (randomfloatrange(-128, 128), randomfloatrange(-128, 128), 0);
    }

    return function_4f963624aaba7f77(spawners, team, reinforceorigin, priority, category, subcategory, var_94ba23284fa98c04, var_4f200828059689db, skipstealth);
  }

  ac130 = namespace_c0945f72aac1f0a::function_35669831b02dc8fa(ac130_spawnloc, var_cd36c086ac42b7c6, -2000);
  println("<dev string:x1c>");

  foreach(spawner in spawners) {
    spawner.origin = ac130.origin;
  }

  heading = vectorNormalize(var_1e4bce6c927436e0 - ac130_spawnloc);
  var_f7df9b6a197040a2 = ac130.origin + heading * 60000;
  ac130 thread namespace_c0945f72aac1f0a::function_16dfd690940ae271(var_f7df9b6a197040a2);
  return function_4f963624aaba7f77(spawners, team, reinforceorigin, priority, category, subcategory, var_94ba23284fa98c04, var_4f200828059689db, 1, ac130);
}

function private function_4f963624aaba7f77(spawners, team, reinforceorigin, priority, category, subcategory, var_94ba23284fa98c04, var_4f200828059689db, skipstealth, ac130) {
  riders = [];
  falldelay = 0;

  foreach(spawner in spawners) {
    spawner.script_demeanor = undefined;
    rider = ai_mp_requestspawnagent(spawner.aitype, spawner.origin, spawner.angles, priority, category, subcategory, undefined, team, undefined, undefined, skipstealth, undefined, 0);

    if(isDefined(rider)) {
      rider.var_b582b10663b5b2a9 = 0;
      rider.spawnpoint = spawner;
      rider.var_48713689eb4db4b4 = undefined;

      if(scripts\engine\utility::issharedfuncdefined("paraReinforce", "onChutePull")) {
        rider.var_48713689eb4db4b4 = scripts\engine\utility::getsharedfunc("paraReinforce", "onChutePull");
      }

      rider.var_55ddeb59df2dee74 = &function_fa870422edefd17d;
      rider.reinforceorigin = reinforceorigin;
      rider.ac130 = ter_op(isDefined(ac130), ac130, rider);
      rider thread namespace_c0945f72aac1f0a::create_paratrooper(falldelay, var_4f200828059689db);
      riders[riders.size] = rider;

      if(isDefined(var_94ba23284fa98c04)) {
        thread[[var_94ba23284fa98c04]](rider);
      }

      rider setscriptablepartstate("skydiveVfx", "enabled", 0);
    }

    wait randomfloatrange(0.1, 0.75);
  }

  return riders;
}

function function_6a8ad55c5a4036d1() {
  thread scripts\mp\ai_behavior::function_a5117518725da028(self, self.reinforceorigin, 768, undefined, 1024, 0);
}

function function_fa870422edefd17d() {
  self setscriptablepartstate("skydiveVfx", "default", 0);
  self playSound("mp_parachute_land_ally");
  self notify("para_landed");
  level thread scripts\mp\ai_behavior::ai_watchforbadpath(self);
}

function function_984016d3b51024a2(numriders, origin, spawners, priority, category, poiname, var_5d0b62df4c7d5d12, tier, team, nationality) {
  if(!isDefined(category)) {
    category = "reinforcements";
  }

  var_644d90de7685f75 = function_8c6dbb64c8e1603c(numriders, category, origin, poiname, 0);

  if(!var_644d90de7685f75 && !function_359f24553bdcca92(numriders, priority)) {
    assertmsg("<dev string:x65>");
    return;
  }

  if(!isDefined(spawners)) {
    spawners = [];
    newspawnpoints = [];
    offset_array = [-150, -75, 0, 75, 150];

    for(i = 0; i < 5; i++) {
      for(j = 0; j < 5; j++) {
        offset = (offset_array[i], offset_array[j], 0);
        new_spawn = spawnStruct();
        new_spawn.origin = origin + offset;
        landing_spot = getgroundposition(new_spawn.origin, 64);
        newspawnpoints[newspawnpoints.size] = new_spawn;
      }
    }

    newspawnpoints = array_randomize(newspawnpoints);
  } else {
    newspawnpoints = spawners;
  }

  if(numriders > newspawnpoints.size) {
    numriders = newspawnpoints.size;
  }

  for(i = 0; i < numriders; i++) {
    if(!isDefined(newspawnpoints[i])) {
      continue;
    }

    spawners[i] = newspawnpoints[i];
    spawners[i].angles = (0, 0, 0);
    spawners[i].allow_momentum = 1;

    if(!isDefined(spawners[i].parachute_land_origin)) {
      if(!isDefined(spawners[i].origin)) {
        spawners[i].origin = origin;
      }

      spawners[i].parachute_land_origin = spawners[i].origin;
    }

    if(isDefined(spawners[i].tier)) {
      tier = spawners[i].tier;
    }

    if(!isDefined(nationality)) {
      nationality = undefined;

      if(isDefined(level.teamnationality) && isDefined(level.teamnationality[team])) {
        nationality = level.teamnationality[team];
      }
    }

    if(!isDefined(spawners[i].aitype)) {
      aitype = undefined;

      if(isDefined(spawners[i].type)) {
        aitype = function_7f1a2e2ebe0c1693(spawners[i].type, tier, nationality);
      } else {
        aitype = function_d5bc07eabf352abb(undefined, poiname, undefined, undefined, tier, nationality);
      }

      spawners[i].aitype = aitype;
    }
  }

  return spawners;
}

function function_2673db74633ed911(origin, poiname) {
  potentiallocs = [];

  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = poi_findpoioriginisin(origin, 0, 1);
    }

    if(!isDefined(level.poi[poiname]["paraReinforceStruct"].landingspots) || level.poi[poiname]["paraReinforceStruct"].landingspots.size == 0) {
      return;
    }

    potentiallocs = level.poi[poiname]["paraReinforceStruct"].landingspots;
  } else {
    if(!isDefined(level.parareinforcestruct.landingspots) || level.parareinforcestruct.landingspots.size == 0) {
      return;
    }

    potentiallocs = level.parareinforcestruct.landingspots;
  }

  if(isDefined(origin)) {
    orderedlocs = sortbydistance(level.parareinforcestruct.landingspots, origin);
    potentiallocs = [];

    foreach(loc in orderedlocs) {
      dist = distance2dsquared(loc.origin, origin);

      if(dist > 65536 && dist < 2250000) {
        potentiallocs[potentiallocs.size] = loc;
      }
    }

    if(potentiallocs.size > 0) {
      return random(potentiallocs).origin;
    } else {
      return orderedlocs[0].origin;
    }
  }

  return random(potentiallocs).origin;
}

function function_9e7d8e0b07e473f0(origin, poiname) {
  potentiallocs = [];

  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = poi_findpoioriginisin(origin, 0, 1);
    }

    if(!isDefined(level.poi[poiname]["paraReinforceStruct"].var_e574839e9e50e6a7) || level.poi[poiname]["paraReinforceStruct"].var_e574839e9e50e6a7.size == 0) {
      return;
    }

    potentiallocs = level.poi[poiname]["paraReinforceStruct"].var_e574839e9e50e6a7;
  } else {
    if(!isDefined(level.parareinforcestruct.var_e574839e9e50e6a7) || level.parareinforcestruct.var_e574839e9e50e6a7.size == 0) {
      return;
    }

    potentiallocs = level.parareinforcestruct.var_e574839e9e50e6a7;
  }

  return random(potentiallocs).origin;
}

function function_1cd198f23cffc84f(origin, poiname) {
  potentiallocs = [];

  if(poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = poi_findpoioriginisin(origin, 0, 1);
    }

    if(!isDefined(level.poi[poiname]["paraReinforceStruct"].var_932a9b3d757d01e9) || level.poi[poiname]["paraReinforceStruct"].var_932a9b3d757d01e9.size == 0) {
      return;
    }

    potentiallocs = level.poi[poiname]["paraReinforceStruct"].var_932a9b3d757d01e9;
  } else {
    if(!isDefined(level.parareinforcestruct.var_932a9b3d757d01e9) || level.parareinforcestruct.var_932a9b3d757d01e9.size == 0) {
      return;
    }

    potentiallocs = level.parareinforcestruct.var_932a9b3d757d01e9;
  }

  return random(potentiallocs).origin;
}

function function_a6193ffd30278d98() {
  while(true) {
    if(getdvarint(@ "hash_cc838a8ebb92734", 0) == 1) {
      foreach(node in level.parareinforcestruct.landingspots) {
        thread scripts\mp\utility\debug::drawsphere(node.origin, 64, 1, (0, 1, 0));
      }
    }

    wait 1;
  }
}

function function_9dfd191f35f0c0eb() {
  while(true) {
    if(getdvarint(@ "hash_2f74ed938ab306ba", 0) == 1) {
      foreach(node in level.parareinforcestruct.landingspots) {
        thread scripts\mp\utility\debug::drawsphere(node.origin, 64, 1, (0, 1, 0));
      }
    }

    wait 1;
  }
}