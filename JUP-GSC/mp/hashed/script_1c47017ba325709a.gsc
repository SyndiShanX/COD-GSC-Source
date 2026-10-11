/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_1c47017ba325709a.gsc
*************************************************/

#using script_1c47017ba325709a;
#using script_24e4405cf93f20ed;
#using script_41ba451876d0900c;
#using script_4bac13d511590220;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\poi;
#namespace namespace_3715b32331beba31;

function function_7f4d3080c6e8748b() {
  level.var_ce783fc59ea392d1 = 1;

  setDvar(@ "hash_34414e279fdbc0a1", 0);

  level.var_fa8b075e623245a7 = getdvarint(@ "hash_2ff2c53d8d6e7c01", 30) * 1000;
  level.var_e575d73e8d29994 = getdvarint(@ "hash_79b9e1dd01ae9cb7", 0);
  level.var_fcb29aee3f6eab0d = getdvarint(@ "hash_9d611e4d54454129", 30);
  level.var_25de264ee4d0e7aa = getdvarint(@ "hash_e4be7be05ab1911", 4000);

  level.var_40e5e944fbbf704e = 1;

  function_8e34d09c5e2fc0f2();

  level thread function_9b7d54ce89689d91();
  level thread function_389a8c0032be2508();

  level.var_e435e1e848664132["veh9_techo_rebel_armor"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["veh9_overland_2016"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["veh9_sedan_hatchback_1985"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["veh9_mil_cargo_truck"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["veh9_jltv"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["veh9_jltv_mg"] = &function_95e274db21433c2b;
  level.var_e435e1e848664132["techo_reinforce"] = &function_95e274db21433c2b;
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_techo_rebel_armor", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_overland_2016", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_sedan_hatchback_1985", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_mil_cargo_truck", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_jltv", "GROUND_REINFORCE", 6);
  scripts\cp_mp\vehicles\vehicle_tracking::function_5c8408cb68649308("veh9_jltv_mg", "GROUND_REINFORCE", 6);
}

function function_8e34d09c5e2fc0f2() {
  while(!flag_exist("create_script_initialized")) {
    waitframe();
  }

  flag_wait("create_script_initialized");
  waitframe();
  level.var_b01c03d751886f28 = 0;

  if(getdvarint(@ "hash_4a77ef221a7d22a", 0) == 1) {
    return;
  }

  if(scripts\mp\poi::poi_issystemactive()) {
    while(level.poi.size == 0) {
      waitframe();
    }

    waitframe();
    var_46f73294fb8b410c = getStructArray("ground_reinforce_node", "targetname");

    foreach(poiname, poi in level.poi) {
      level.poi[poiname]["groundReinforceStruct"] = spawnStruct();
      level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f = [];
      level.poi[poiname]["groundReinforceStruct"].unloadnodes = [];

      if(istrue(level.var_4cfd75aa6ddde156)) {
        spawnnodes = var_46f73294fb8b410c;
      } else {
        spawnnodes = scripts\mp\poi::function_9656b61cc8a37cba(var_46f73294fb8b410c, poiname);
      }

      foreach(index, node in spawnnodes) {
        if(isDefined(node.spawnnodeid)) {
          continue;
        }

        var_3de9d35a8cbb1ea6 = function_6747838fa0463ab2(node, spawnnodes);

        if(isDefined(var_3de9d35a8cbb1ea6) && isDefined(var_3de9d35a8cbb1ea6.packageid)) {
          level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f[var_3de9d35a8cbb1ea6.packageid] = var_3de9d35a8cbb1ea6;
        }
      }

      foreach(package in level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f) {
        foreach(node in package.pathnodes) {
          if(!array_contains(package.spawnnodes, node)) {
            level.poi[poiname]["groundReinforceStruct"].unloadnodes[level.poi[poiname]["groundReinforceStruct"].unloadnodes.size] = node;
          }
        }

        if(!istrue(level.var_40e5e944fbbf704e)) {
          package.pathnodes = undefined;
        }
      }
    }

    return;
  }

  level.groundreinforcestruct = spawnStruct();
  level.groundreinforcestruct.var_e45aa5237f84ce6f = [];
  level.groundreinforcestruct.unloadnodes = [];
  spawnnodes = getStructArray("ground_reinforce_node", "targetname");

  foreach(node in spawnnodes) {
    var_3de9d35a8cbb1ea6 = function_6747838fa0463ab2(node, spawnnodes);

    if(isDefined(var_3de9d35a8cbb1ea6) && isDefined(var_3de9d35a8cbb1ea6.packageid)) {
      level.groundreinforcestruct.var_e45aa5237f84ce6f[var_3de9d35a8cbb1ea6.packageid] = var_3de9d35a8cbb1ea6;
    }
  }

  foreach(package in level.groundreinforcestruct.var_e45aa5237f84ce6f) {
    foreach(node in package.pathnodes) {
      if(!array_contains(package.spawnnodes, node)) {
        level.groundreinforcestruct.unloadnodes[level.groundreinforcestruct.unloadnodes.size] = node;
      }
    }

    if(!istrue(level.var_40e5e944fbbf704e)) {
      package.pathnodes = undefined;
    }
  }
}

function function_6747838fa0463ab2(node, spawnnodes) {
  if(!isDefined(node.target)) {
    return;
  }

  package = spawnStruct();
  package.packageid = level.var_b01c03d751886f28;
  level.var_b01c03d751886f28++;
  package.pathnodes = [];
  var_4a3b8372442841e5 = [];
  var_8bae1659c6ed57f9 = 0;
  allnodes = [node];
  var_428b0c825645a14b = 0;
  var_46f73294fb8b410c = [];

  while(var_428b0c825645a14b < allnodes.size) {
    thisnode = allnodes[var_428b0c825645a14b];
    var_428b0c825645a14b++;

    if(array_contains(spawnnodes, thisnode)) {
      if(!array_contains(var_46f73294fb8b410c, thisnode)) {
        var_46f73294fb8b410c[var_46f73294fb8b410c.size] = thisnode;
        thisnode = function_a8c8d8521c0de967(thisnode, var_8bae1659c6ed57f9);
        var_4a3b8372442841e5[var_4a3b8372442841e5.size] = thisnode.spawnnodeid;
        thisnode.var_4a3b8372442841e5 = [thisnode.spawnnodeid];
        var_8bae1659c6ed57f9++;
      }
    } else if(isDefined(thisnode.targetname)) {
      newnodes = getStructArray(thisnode.targetname, "target");

      foreach(newnode in newnodes) {
        if(!array_contains(allnodes, newnode)) {
          allnodes[allnodes.size] = newnode;
          newnode.var_4a3b8372442841e5 = [];
          newnode.packageid = package.packageid;
          newnode.prev = undefined;
        }
      }
    }

    if(isDefined(thisnode.target)) {
      newnodes = getStructArray(thisnode.target, "targetname");

      foreach(newnode in newnodes) {
        if(!array_contains(allnodes, newnode)) {
          allnodes[allnodes.size] = newnode;
          newnode.var_4a3b8372442841e5 = [];
          newnode.packageid = package.packageid;
          newnode.prev = thisnode;
          continue;
        }

        if(!isDefined(newnode.prev)) {
          newnode.prev = thisnode;
          continue;
        }

        if(isarray(newnode.prev)) {
          if(!array_contains(newnode.prev, thisnode)) {
            newnode.prev[newnode.prev.size] = thisnode;
          }

          continue;
        }

        if(newnode.prev != thisnode) {
          newnode.prev = [newnode.prev, thisnode];
        }
      }
    }
  }

  foreach(spawnnode in var_46f73294fb8b410c) {
    function_64f41b179b2030cc(spawnnode);
  }

  package.pathnodes = array_combine_unique(package.pathnodes, allnodes);

  foreach(spawnnode in var_46f73294fb8b410c) {
    package.spawnnodes[spawnnode.spawnnodeid] = spawnnode;
  }

  package.var_4a3b8372442841e5 = var_4a3b8372442841e5;
  return package;
}

function function_64f41b179b2030cc(spawnnode) {
  allnodes = getStructArray(spawnnode.target, "targetname");
  var_428b0c825645a14b = 0;

  while(var_428b0c825645a14b < allnodes.size) {
    node = allnodes[var_428b0c825645a14b];
    var_428b0c825645a14b++;
    node.var_4a3b8372442841e5[node.var_4a3b8372442841e5.size] = spawnnode.spawnnodeid;

    if(isDefined(node.target)) {
      childnodes = getStructArray(node.target, "targetname");

      if(isDefined(childnodes)) {
        foreach(childnode in childnodes) {
          if(array_contains(allnodes, childnode)) {
            assertmsg("<dev string:x1c>" + spawnnode.poi);
            continue;
          }

          allnodes[allnodes.size] = childnode;
        }
      }
    }
  }
}

function function_a8c8d8521c0de967(node, nodeid) {
  node.lastusedtime = 0;
  node.spawnnodeid = nodeid;
  return node;
}

function function_1172336a24a3fac0(reinforcevehicletype, reinforceorigin, poiname, var_93390a6953905fef, var_7c99d4ed1e5a3a8) {
  spawners = undefined;
  var_37a86a6d390bf8ec = [];

  if(scripts\mp\poi::poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = scripts\mp\poi::poi_findpoioriginisin(reinforceorigin);
    }

    var_a829cd2e1f4ec42a = sortbydistance(level.poi[poiname]["groundReinforceStruct"].unloadnodes, reinforceorigin);
  } else {
    var_a829cd2e1f4ec42a = sortbydistance(level.groundreinforcestruct.unloadnodes, reinforceorigin);
  }

  numpackages = var_7c99d4ed1e5a3a8;

  if(istrue(var_93390a6953905fef)) {
    numpackages = 1;
  }

  var_30f3cbc949cf145c = [];

  for(i = 0; i < numpackages; i++) {
    if(isDefined(var_a829cd2e1f4ec42a[i])) {
      var_30f3cbc949cf145c[var_30f3cbc949cf145c.size] = var_a829cd2e1f4ec42a[i];
    }
  }

  if(istrue(level.forceclosest) || istrue(level.var_e575d73e8d29994)) {
    return [var_30f3cbc949cf145c[0]];
  }

  return var_30f3cbc949cf145c;
}

function function_3f36fce913f23b19(var_e710a9290407911b, poiname) {
  if(scripts\mp\poi::poi_issystemactive()) {
    foreach(unloadnode in var_e710a9290407911b) {
      package = level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f[unloadnode.packageid];
      var_fd5ea9cb37c309d3 = [];

      foreach(spawnid in unloadnode.var_4a3b8372442841e5) {
        var_fd5ea9cb37c309d3[var_fd5ea9cb37c309d3.size] = package.spawnnodes[spawnid];
      }

      var_d81c039f781faf29 = [];

      if(function_a794fcf9545f2062()) {
        foreach(spawnloc in var_fd5ea9cb37c309d3) {
          players = getentitiesinradiusfrompartitiongrid(spawnloc.origin, level.var_25de264ee4d0e7aa, createentitytypemask(["etype_player"]), [], undefined);

          if(isDefined(players) && players.size > 0) {
            continue;
          }

          var_d81c039f781faf29[var_d81c039f781faf29.size] = spawnloc;
        }
      }

      if(var_d81c039f781faf29.size > 0) {
        return [random(var_d81c039f781faf29), unloadnode];
      }
    }

    return [undefined, undefined];
  }

  foreach(unloadnode in var_e710a9290407911b) {
    package = level.groundreinforcestruct.var_e45aa5237f84ce6f[unloadnode.packageid];
    var_fd5ea9cb37c309d3 = [];

    foreach(spawnid in unloadnode.var_4a3b8372442841e5) {
      var_fd5ea9cb37c309d3[var_fd5ea9cb37c309d3.size] = package.spawnnodes[spawnid];
    }

    if(var_fd5ea9cb37c309d3.size > 0) {
      return [random(var_fd5ea9cb37c309d3), unloadnode];
    }
  }

  return [undefined, undefined];
}

function function_c277806325266d3c(unloadnode, spawnnode, poiname) {
  if(scripts\mp\poi::poi_issystemactive()) {
    if(!isDefined(poiname)) {
      poiname = scripts\mp\poi::poi_findpoioriginisin(unloadnode.origin);
    }

    package = level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f[unloadnode.packageid];
  } else {
    package = level.groundreinforcestruct.var_e45aa5237f84ce6f[unloadnode.packageid];
  }

  nodepath = [unloadnode];
  currentnode = unloadnode;

  while(isDefined(currentnode.prev)) {
    if(isarray(currentnode.prev)) {
      potentialnodes = [];

      foreach(node in currentnode.prev) {
        if(array_contains(node.var_4a3b8372442841e5, spawnnode.spawnnodeid)) {
          potentialnodes[potentialnodes.size] = node;
        }
      }

      currentnode = random(potentialnodes);
    } else {
      currentnode = currentnode.prev;
    }

    nodepath[nodepath.size] = currentnode;
  }

  nodepath = array_reverse(nodepath);
  origins = [];

  foreach(node in nodepath) {
    origins[origins.size] = node.origin;
  }

  return origins;
}

function function_96a6b09d8ce2a773(node, spawnnodeid, package) {
  potentialnodes = getStructArray(node.targetname, "target");

  foreach(potentialnode in potentialnodes) {
    if(isDefined(potentialnode.spawnnodeid) && potentialnode.spawnnodeid == spawnnodeid) {
      return potentialnode;
    }

    if(isDefined(potentialnode.var_4a3b8372442841e5) && array_contains(potentialnode.var_4a3b8372442841e5, spawnnodeid)) {
      potentialnodes[potentialnodes.size] = potentialnode;
    }
  }

  return random(potentialnodes);
}

function function_2301ba68ec48226e(var_3de9d35a8cbb1ea6) {
  if(!isDefined(var_3de9d35a8cbb1ea6.lastusedtime)) {
    return true;
  }

  if(var_3de9d35a8cbb1ea6.lastusedtime + level.var_fa8b075e623245a7 < gettime()) {
    var_3de9d35a8cbb1ea6.lastusedtime = undefined;
    return true;
  }

  return false;
}

function function_a5b0665e0a814be6(numagents, var_ec862c2c00c7ab5d, reinforceorigin, priority, category, subcategory, groupname, team, var_93390a6953905fef, poiname, nationality, reinforcevehicletype) {
  if(isDefined(level.radiation) && istrue(level.radiation.spreading)) {
    return [undefined, undefined];
  }

  reinforcevehicletype = function_5e7837d4d6b6dd45(reinforcevehicletype);

  if(!scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_canspawnVehicle(reinforcevehicletype, undefined, undefined, "GROUND_REINFORCE")) {
    return [undefined, undefined];
  }

  if(!isDefined(poiname)) {
    poiname = scripts\mp\poi::poi_findpoioriginisin(reinforceorigin);
  }

  if(scripts\mp\poi::poi_issystemactive()) {
    if(!isDefined(level.poi[poiname]) || !isDefined(level.poi[poiname]["groundReinforceStruct"]) || level.poi[poiname]["groundReinforceStruct"].var_e45aa5237f84ce6f.size == 0) {
      return [undefined, undefined];
    }
  } else if(!isDefined(level.groundreinforcestruct) || level.groundreinforcestruct.var_e45aa5237f84ce6f.size == 0) {
    return [undefined, undefined];
  }

  vehicle = undefined;
  reinforceorigin = scripts\mp\ai_behavior::function_d378cc95abab583b(reinforceorigin, poiname);
  reinforceorigin = getclosestpointonnavmesh(reinforceorigin);
  unloadnodes = function_1172336a24a3fac0(reinforcevehicletype, reinforceorigin, poiname, var_93390a6953905fef, 5);
  [vehspawner, unloadnode] = function_3f36fce913f23b19(unloadnodes, poiname);

  if(!isDefined(vehspawner)) {
    return [undefined, undefined];
  }

  vehspawner.origin = getclosestpointonnavmesh(vehspawner.origin) + (0, 0, 128);
  vehspawner.unloadnode = unloadnode;
  vehspawner.lastusedtime = gettime();
  tier = function_aa34a142b7664dd1(namespace_6a3f8c14894f44be::function_5cc0c507e92f7b47(poiname));

  if(!isDefined(var_ec862c2c00c7ab5d)) {
    var_ec862c2c00c7ab5d = function_236a093e8a0ec040(reinforcevehicletype, tier);
  }

  if(!isDefined(vehspawner.poi)) {
    vehspawner.poi = poiname;
  }

  logstring("Ground reinforcement spawn: " + numagents + " AI at " + reinforceorigin);
  spawners = function_f260b1cef943f1ab(reinforcevehicletype, numagents, var_ec862c2c00c7ab5d, vehspawner.origin, vehspawner.poi, priority, category, nationality);
  riders = function_4ad6c25d6754f697(spawners, numagents, reinforceorigin, priority, category, subcategory, team, groupname, reinforcevehicletype);

  if(!isDefined(riders) || riders.size == 0) {
    return [undefined, undefined];
  }

  vehspawner.nopath = 1;
  vehspawner.dontgetonpath = 1;
  spawndata = spawnStruct();
  spawndata.origin = vehspawner.origin;
  spawndata.angles = vehspawner.angles;
  spawndata.spawntype = "GROUND_REINFORCE";
  spawndata.showheadicon = 1;
  spawndata.initai = 1;
  skinoverride = function_55dace275f65d5b6(reinforcevehicletype);

  if(isDefined(skinoverride)) {
    spawndata.skinoverride = skinoverride;
  }

  faildata = spawnStruct();
  vehicle = scripts\cp_mp\vehicles\vehicle::vehicle_spawn(reinforcevehicletype, spawndata, faildata);
  vehicle.vehicle_spawner = vehspawner;
  vehicle.reinforceorigin = reinforceorigin;
  vehicle.var_eb504fc7e1cfeb4c = getdvarint(@ "hash_9e4fff9024bd3a06", 1);
  spawninvehicle = !isDefined(vehspawner.var_3f0312e6382c878f) || istrue(vehspawner.var_3f0312e6382c878f);
  vehicle scripts\cp_mp\vehicles\vehicle::function_f92faaaf5c5077c6(riders, spawninvehicle);

  if(isDefined(level.var_6e5ff6cae14c4081)) {
    level.var_6e5ff6cae14c4081[level.var_6e5ff6cae14c4081.size] = vehicle;
  }

  if(isDefined(level.var_e435e1e848664132[reinforcevehicletype])) {
    vehicle thread[[level.var_e435e1e848664132[reinforcevehicletype]]]();
  }

  if(false) {
    vehicle thread function_6f177a0ad8466261();
  }

  if(istrue(vehicle.var_20d6bfff3d46371d)) {
    foreach(rider in riders) {
      scripts\mp\ai_mp_controller::function_c9b9fe3f7f739586(rider);
    }
  }

  return [vehicle, riders];
}

function function_f260b1cef943f1ab(vehicle_type, numriders, var_ec862c2c00c7ab5d, origin, poiname, priority, category, nationality) {
  standardorigin = ter_op(isDefined(level.var_f0872e42daf6d4d5), level.var_f0872e42daf6d4d5, origin);
  var_ca38685e5bf373f4 = (0, 0, 0);
  maxriders = scripts\cp_mp\vehicles\vehicle::function_95022424d8b0dc1c(vehicle_type);

  if(numriders > maxriders) {
    numriders = maxriders;
  }

  if(!isDefined(category)) {
    category = "reinforcements";
  }

  var_644d90de7685f75 = function_8c6dbb64c8e1603c(numriders, category, origin, poiname, 0);

  if(!var_644d90de7685f75 && !scripts\mp\ai_mp_controller::function_359f24553bdcca92(numriders, priority)) {
    msg = "<dev string:x43>" + numriders + "<dev string:x6f>";
    println(msg);

    return undefined;
  }

  riders = [];
  spawnnode = spawnStruct();
  spawnnode.poi = poiname;
  spawnnode.origin = origin;

  for(i = 0; i < numriders; i++) {
    riders[i] = spawnStruct();
    riders[i].origin = standardorigin;
    riders[i].angles = var_ca38685e5bf373f4;
    riders[i].poi = poiname;
    type = undefined;

    if(isDefined(var_ec862c2c00c7ab5d.requests[i].type)) {
      type = var_ec862c2c00c7ab5d.requests[i].type;
    }

    tier = undefined;

    if(isDefined(var_ec862c2c00c7ab5d.requests[i].tier)) {
      tier = var_ec862c2c00c7ab5d.requests[i].tier;
    }

    overridenationality = undefined;

    if(isDefined(var_ec862c2c00c7ab5d.requests[i].nationality)) {
      overridenationality = var_ec862c2c00c7ab5d.requests[i].nationality;
    }

    riders[i].aitype = function_d5bc07eabf352abb(spawnnode, poiname, undefined, type, tier, default_to(overridenationality, nationality));
  }

  return riders;
}

function function_4ad6c25d6754f697(spawners, numagents, reinforceorigin, priority, category, subcategory, team, groupname, vehicle_type, fillorder) {
  if(!isDefined(spawners)) {
    return undefined;
  }

  if(!isDefined(groupname)) {
    groupname = scripts\mp\ai_mp_controller::function_78759441c259f58a(reinforceorigin, numagents);
  }

  if(!isDefined(fillorder)) {
    fillorder = vehicle_type;
  }

  fillorder = function_ceb3c1ef8f369684(fillorder);
  var_a19b73001eb4102 = [];
  riders = [];

  foreach(index, spawner in spawners) {
    rider = scripts\mp\ai_mp_controller::ai_mp_requestspawnagent(spawner.aitype, spawner.origin, spawner.angles, priority, category, subcategory, groupname, team, undefined, spawner.poi, undefined, undefined, 0);

    if(isDefined(rider)) {
      rider.group = spawner;
      rider.group.group_name = spawner.targetname;
      rider.spawnpoint = spawner;
      rider.spawner = spawner;
      rider.vehiclerunexit = 1;

      if(isDefined(fillorder)) {
        if(isDefined(fillorder[index])) {
          rider.script_startingposition = fillorder[index];
        } else if(!array_contains(fillorder, index)) {
          rider.script_startingposition = index;
        } else {
          for(i = 0; i < numagents; i++) {
            if(!array_contains(fillorder, i) && !array_contains(var_a19b73001eb4102, i)) {
              rider.script_startingposition = i;
              break;
            }
          }
        }
      } else {
        rider.script_startingposition = index;
      }

      var_a19b73001eb4102[var_a19b73001eb4102.size] = rider.script_startingposition;

      if(isDefined(level.var_7a9f066f79bed633)) {
        rider thread[[level.var_7a9f066f79bed633]]();
      }

      riders[riders.size] = rider;
      rider thread namespace_9246f10206f50768::function_cba4ff426a2f58ab(rider.script_startingposition);
    }
  }

  return riders;
}

function function_95e274db21433c2b() {
  vehiclepathorigins = [];
  vehiclepathorigins = function_c277806325266d3c(self.vehicle_spawner.unloadnode, self.vehicle_spawner, self.vehicle_spawner.poi);

  if(scripts\mp\ai_mp_controller::function_e57289d4e2128a53(vehiclepathorigins)) {
    self.var_20d6bfff3d46371d = 1;
  }

  self.vehiclepathorigins = vehiclepathorigins;
  thread function_710348ca3287d2e9();
  veh_speed = scripts\engine\utility::mph_to_ips(level.var_fcb29aee3f6eab0d);

  if(issubstr(self.classname_mp, "cargo")) {
    namespace_9246f10206f50768::function_1da2c31423c2676a();
    self setconfigvalue("p2p", "brakeAtGoal", 1);
    self setconfigvalue("p2p", "goalThreshold", level.var_fcb29aee3f6eab0d * 4);
    self setconfigvalue("p2p", "steeringMultiplier", 2.5);
    self setconfigvalue("p2p", "stuckTime", 1);
    self setconfigvalue("p2p", "manualSpeed", veh_speed);
  } else {
    namespace_9246f10206f50768::function_1da2c31423c2676a();
    self setconfigvalue("p2p", "brakeAtGoal", 1);
    self setconfigvalue("p2p", "goalThreshold", level.var_fcb29aee3f6eab0d * 4);
    self setconfigvalue("p2p", "steeringMultiplier", 2.5);
    self setconfigvalue("p2p", "stuckTime", 1);
    self setconfigvalue("p2p", "manualSpeed", veh_speed);
  }

  self.var_9acfc0bd86b2e2c1 = &namespace_9246f10206f50768::fn_damagefeedback;
  self.fn_death = &namespace_9246f10206f50768::function_6a0b2a08499a9842;
  scripts\common\vehicle::vehicle_lights_on("headlights", "script_vehicle_iw9_truck_techo_rebel_armor");
  self endon("death");
  self endon("stop_chasing");
  self endon("startedUnload");

  if(!isDefined(level.var_24a25c6be881be0c)) {
    level.var_24a25c6be881be0c = [];
  }

  if(issharedfuncdefined("veh9_techo_rebel_armor", "damageIgnoresArmor")) {
    self.var_7a646ff827387ac0 = getsharedfunc("veh9_techo_rebel_armor", "damageIgnoresArmor");
  }

  for(result = undefined; !istrue(self.unloading); result = namespace_9246f10206f50768::function_8f40a2c8678f8304(self.origin, currenttargetorigin, level.var_fcb29aee3f6eab0d)) {
    currenttargetorigin = self.vehiclepathorigins[0];
    waitframe();

    if(!isDefined(currenttargetorigin)) {
      thread unloadvehicle("combat");
      return;
    }

    if(isDefined(result) && result != "path_blocked") {
      self.vehiclepathorigins = array_slice(self.vehiclepathorigins, 1);
    }

    if(self.vehiclepathorigins.size == 1) {
      self setconfigvalue("p2p", "goalThreshold", level.var_fcb29aee3f6eab0d * 4);
    }

    namespace_9246f10206f50768::function_28991b23dba743d8(currenttargetorigin);
  }
}

function private unloadvehicle(exittype) {
  self endon("death");
  self notify("startedUnload");

  if(istrue(self.unloading)) {
    return;
  }

  self.unloading = 1;
  riders = self.riders;
  namespace_cbe993018617a21d::function_7d8f81a94dc08a15(1, exittype);
  scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_setteam(self, "neutral");
  scripts\cp_mp\vehicles\vehicle_occupancy::function_887b4e2cbe3ab92c();
  rushpath = self.vehiclepathorigins;
  rushpath[rushpath.size] = self.reinforceorigin;

  foreach(rider in riders) {
    rider thread scripts\mp\ai_behavior::function_65f6a39e1083fb6b(rider, rushpath, 64, 128, undefined, 1, riders);
  }

  if(getdvarint(@ "hash_88693526977782e2", 1) != 1) {
    return;
  }

  self endon("stop_watching_abandoned");
  wait 180;
  level thread function_9f45b9478c4e937b(self);
}

function function_9f45b9478c4e937b(vehicle) {
  vehicle scripts\cp_mp\vehicles\vehicle_spawn::function_357783d7c1d96273();
  husk = vehicle scripts\cp_mp\vehicles\vehicle::function_12f5a0e2344c10c5();

  if(!isDefined(husk)) {
    return;
  }

  wait 60;

  if(isDefined(husk)) {
    husk scripts\cp_mp\vehicles\vehicle_spawn::function_357783d7c1d96273();
  }
}

function function_710348ca3287d2e9() {
  self endon("death");
  self endon("startedUnload");
  stoppedframes = 0;

  while(true) {
    waitframe();

    if(scripts\common\vehicle_code::vehicle_is_stopped()) {
      stoppedframes++;
    } else {
      stoppedframes = 0;
    }

    if(namespace_cbe993018617a21d::function_eee51130cc8dce38()) {
      thread unloadvehicle("combat");
      return;
    }

    if(stoppedframes > 10) {
      thread unloadvehicle();
      return;
    }
  }
}

function function_5e7837d4d6b6dd45(type) {
  switch (type) {
    case #"hash_139f3265d782181a":
      return "veh9_techo_rebel_armor";
    case #"hash_b0c26101fc869b42":
      return "veh9_overland_2016";
    case #"hash_6caacd2dac633568":
      return "veh9_sedan_hatchback_1985";
    case #"hash_5b5f747772f36407":
      return "veh9_mil_cargo_truck";
    case #"hash_d63ab45faf622239":
      return "veh9_jltv";
    case #"hash_4fd5c53c1a7ee8be":
      return "veh9_jltv_mg";
    default:
      return "veh9_techo_rebel_armor";
  }
}

function function_236a093e8a0ec040(vehicle_type, tier) {
  if(!isDefined(tier)) {
    tier = 1;
  }

  var_246027a1b24dd32f = [];

  switch (vehicle_type) {
    case #"hash_cb367b51338c9d6":
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = "lmg";
      break;
    case #"hash_228830c793bd36cb":
    case #"hash_5211f142350a63e1":
    case #"hash_d212f4961f28eb58":
    case #"hash_d63b8f48fb92540d":
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("convoy_attack_turret", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      break;
    case #"hash_f9260a8d132b789":
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("patrol_primary", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      var_246027a1b24dd32f[var_246027a1b24dd32f.size] = function_ed108ff3eb578327("vehicle_patrol_rare", tier);
      break;
    default:
      return undefined;
  }

  agentrequests = [];

  foreach(reinforcementtype in var_246027a1b24dd32f) {
    agentrequests[agentrequests.size] = function_de59d7cb310c1aff(reinforcementtype, tier);
  }

  var_ec862c2c00c7ab5d = function_b9d78fce07834c95(agentrequests);
  return var_ec862c2c00c7ab5d;
}

function function_ceb3c1ef8f369684(vehicle_type) {
  switch (vehicle_type) {
    case #"hash_cb367b51338c9d6":
      return [0, 5, 6];
    case #"hash_d63b8f48fb92540d":
      return [0, 4, 1, 2, 3];
    case #"hash_b11f7e24c0be7a29":
      return [0, 1, 3, 4, 5, 6, 7];
    default:
      return undefined;
  }
}

function function_55dace275f65d5b6(vehicletype) {
  if(!isDefined(level.reinforcementoptions.var_48d4812167fbb628[vehicletype])) {
    return;
  }

  return random(level.reinforcementoptions.var_48d4812167fbb628[vehicletype]);
}

function function_6f177a0ad8466261() {
  self endon("<dev string:x97>");

  while(true) {
    thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, self.origin + (0, 0, 10000), 1, (1, 0, 0));
    wait 1;
  }
}

function function_9b7d54ce89689d91() {
  while(true) {
    while(getdvarint(@ "hash_59530b43705e341f", 0) == 0) {
      waitframe();
    }

    [vehicle, agents] = namespace_43bf74a2ee9234c0::function_a5b0665e0a814be6(getdvarint(@ "hash_59530b43705e341f", 0), ["<dev string:xa0>", "<dev string:xa6>", "<dev string:xad>", "<dev string:xb8>"], level.players[0].origin, "<dev string:xbf>", "<dev string:xc7>", "<dev string:xd9>", undefined, undefined, 1, scripts\mp\poi::poi_findpoioriginisin(level.players[0].origin));
    setDvar(@ "hash_59530b43705e341f", 0);
  }
}

function function_389a8c0032be2508() {
  while(true) {
    if(getdvarint(@ "hash_34414e279fdbc0a1", 0) == 1) {
      if(poi_issystemactive()) {
        foreach(poiname, poi in level.poi) {
          foreach(package in level.poi[poiname]["<dev string:xe2>"].var_e45aa5237f84ce6f) {
            level thread function_956e403f85aab2f7(package);

            foreach(spawnnode in package.spawnnodes) {
              print3d(spawnnode.origin + (0, 0, 128), "<dev string:xfb>" + spawnnode.spawnnodeid, (1, 1, 1), 1, 3, 20);
            }

            foreach(pathnode in package.pathnodes) {
              if(array_contains(package.spawnnodes, pathnode)) {
                continue;
              }

              newstring = "<dev string:x106>";

              foreach(spawnid in pathnode.var_4a3b8372442841e5) {
                newstring = newstring + spawnid + "<dev string:x10a>";
              }

              print3d(pathnode.origin + (0, 0, 128), newstring, (1, 1, 1), 1, 5, 20);
            }
          }
        }
      } else {
        foreach(package in level.groundreinforcestruct.var_e45aa5237f84ce6f) {}
      }
    }

    waitframe();
  }
}

function function_956e403f85aab2f7(package) {
  foreach(node in package.spawnnodes) {
    sphere(node.origin, 128, (0, 1, 0));
  }

  foreach(node in package.pathnodes) {
    if(array_contains(package.spawnnodes, node)) {
      continue;
    }

    if(isDefined(node.prev)) {
      if(isarray(node.prev)) {
        sphere(node.origin, 128, (1, 0, 1));

        foreach(prevnode in node.prev) {
          line(node.origin, prevnode.origin, (0, 1, 0));
        }
      } else {
        line(node.origin, node.prev.origin, (0, 1, 0));
      }
    }

    if(!array_contains(package.spawnnodes, node)) {
      sphere(node.origin, 64, (1, 1, 0));
    }
  }
}

# /