/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\utility\reinforcement_util.gsc
********************************************************/

#using script_102d83a437e2b29f;
#using script_3a8f9ace195c9da9;
#using script_f603f40349f99c8;
#using scripts\common\utility;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace reinforcement_util;

function function_8bcc57ecc1d97b99(var_4fc8f8139dbb2513, var_bd977d7be720602c) {
  level.reinforcementmgr = spawnStruct();
  level.reinforcementmgr.var_93712922d49ccfe4 = [];
  level.reinforcementmgr.var_bd977d7be720602c = var_bd977d7be720602c;
  level flag_set("reinforcementMgr_initialized");
  thread[[var_4fc8f8139dbb2513]]();
  thread function_4263d0d23af617df();
}

function add_reinforcement(var_dfec89ad8ca0cdc1, var_1b4eb49dae050e20, var_f249c0bb3d7fb281, predicates, var_c1cc3c4bab7d6d0b) {
  assert(isDefined(var_dfec89ad8ca0cdc1) && isstring(var_dfec89ad8ca0cdc1));
  assert(isDefined(var_1b4eb49dae050e20) && isint(var_1b4eb49dae050e20));
  assert(isDefined(var_f249c0bb3d7fb281) && isstring(var_f249c0bb3d7fb281));
  level flag_wait("reinforcementMgr_initialized");
  targetdata = level.reinforcementmgr.var_93712922d49ccfe4[var_dfec89ad8ca0cdc1];

  if(!isDefined(targetdata)) {
    targetdata = spawnStruct();
    targetdata.var_dfec89ad8ca0cdc1 = var_dfec89ad8ca0cdc1;
    targetdata.spawners = [];
    targetdata.var_d625f475dff5d2bd = 0;
    targetdata.groupsize = getStructArray(var_dfec89ad8ca0cdc1, "targetname").size;
    level.reinforcementmgr.var_93712922d49ccfe4[var_dfec89ad8ca0cdc1] = targetdata;
  }

  assertex(!isDefined(targetdata.spawners[var_f249c0bb3d7fb281]), "add_reinforcement Error - trying to add a duplicate spawner (targetnameToSpawn)");
  assertex(var_1b4eb49dae050e20 <= targetdata.groupsize, "add_reinforcement Error - there are fewer enemies than you want to kill");
  var_4262643d07dfa727 = spawnStruct();
  var_4262643d07dfa727.var_1b4eb49dae050e20 = var_1b4eb49dae050e20;
  var_4262643d07dfa727.var_f249c0bb3d7fb281 = var_f249c0bb3d7fb281;
  var_4262643d07dfa727.predicates = [];
  var_4262643d07dfa727.var_c1cc3c4bab7d6d0b = var_c1cc3c4bab7d6d0b;

  if(isDefined(predicates)) {
    if(isarray(predicates)) {
      var_4262643d07dfa727.predicates = predicates;
    } else {
      var_4262643d07dfa727.predicates[0] = predicates;
    }
  }

  targetdata.spawners[var_f249c0bb3d7fb281] = var_4262643d07dfa727;
}

function private function_4263d0d23af617df() {
  level endon("game_ended");
  level flag_wait("reinforcementMgr_initialized");

  while(true) {
    foreach(targetdata in level.reinforcementmgr.var_93712922d49ccfe4) {
      if(!isDefined(targetdata)) {
        continue;
      }

      spawnqueue = [];
      spawncount = 0;

      foreach(spawner in targetdata.spawners) {
        if(targetdata.var_d625f475dff5d2bd < spawner.var_1b4eb49dae050e20) {
          continue;
        }

        var_25a0373bcaf45538 = 1;

        foreach(var_6788e3106fcb4652 in spawner.predicates) {
          if(![[var_6788e3106fcb4652]]()) {
            var_25a0373bcaf45538 = 0;
            break;
          }
        }

        if(var_25a0373bcaf45538) {
          spawnqueue[spawncount] = spawner;
          spawncount += 1;
        }
      }

      foreach(tospawn in spawnqueue) {
        if(tospawn.var_f249c0bb3d7fb281 != "") {
          function_6149b301ce19988b(tospawn.var_f249c0bb3d7fb281, level.reinforcementmgr.var_bd977d7be720602c);
        }

        if(isDefined(tospawn.var_c1cc3c4bab7d6d0b)) {
          thread[[tospawn.var_c1cc3c4bab7d6d0b]]();
        }
      }

      foreach(var_d82f76c79780c083 in spawnqueue) {
        targetdata.spawners[var_d82f76c79780c083.var_f249c0bb3d7fb281] = undefined;
      }
    }

    waitframe();
  }
}

function function_6e91939ff8132810(enemygroup) {
  flag_wait("reinforcementMgr_initialized");

  if(!isDefined(enemygroup)) {
    return;
  }

  targetdata = level.reinforcementmgr.var_93712922d49ccfe4[enemygroup];

  if(!isDefined(targetdata)) {
    return;
  }

  targetdata.var_d625f475dff5d2bd += 1;
}

function heli_reinforcements(heli_name, heli_health, heli_type, var_81bab6febf7f6625, var_8fe58d021853358c, var_65a79f108a26d325, var_493bc9bba3b495b) {
  if(isstring(var_493bc9bba3b495b) && var_493bc9bba3b495b != "") {
    flag_wait(var_493bc9bba3b495b);
  }

  if(!isDefined(heli_name) || !isstring(heli_name) || heli_name == "") {
    assertmsg("Reinforcements helicopter needs a name to find the vehicle spawner struct.");
    return;
  }

  veh_spawners = getStructArray(heli_name, "targetname");

  if(!isDefined(veh_spawners) || veh_spawners.size < 1) {
    assertmsg("Vehicle spawner struct " + heli_name + " does not exist.");
    return;
  }

  veh_spawner = veh_spawners[0];

  if(!isDefined(var_81bab6febf7f6625)) {
    var_81bab6febf7f6625 = 0;
  }

  veh_spawner.var_bb38e84f2964aa8a = !var_81bab6febf7f6625;

  if(istrue(var_8fe58d021853358c)) {
    veh_spawner.target = undefined;
  }

  if(isDefined(heli_type) && isstring(heli_type) && heli_type != "") {
    foreach(spawner in veh_spawners) {
      spawner.script_function = heli_type;
    }
  }

  heli = namespace_548a10c405703106::function_e48fde1878d8a034(veh_spawner);
  heli.no_evasive = 1;
  heli.nocrash = 1;

  if(isDefined(heli_health) && isnumber(heli_health)) {
    heli.health_remaining = heli_health;
  }

  if(!istrue(var_65a79f108a26d325)) {
    return heli;
  }

  foreach(rider in heli.riders) {
    rider.heli = heli;
    rider thread function_aeab3822a7542ef4();
  }

  return heli;
}

function private function_aeab3822a7542ef4() {
  if(!isDefined(self.heli)) {
    return false;
  }

  self.heli waittill("unloaded");
  self.ignoreall = 1;
  namespace_a0852b262a68d01::function_fac67371e80874db();
  self setstealthstate("idle");
  struct_goal = getStruct(self.target, "targetname");
  self setgoalpos(struct_goal.origin);
  waittill_any_return_2("reached_path_end", "stop_going_to_node");
  self.ignoreall = 0;
  return true;
}