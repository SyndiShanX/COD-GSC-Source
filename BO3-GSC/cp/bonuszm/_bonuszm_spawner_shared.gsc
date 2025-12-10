/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm_spawner_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\colors_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\serverfaceanim_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#namespace namespace_2396e2d7;

function function_fc1970dd() {
  level.bonuszm_zombie_spawners = [];
  level.bonuszm_zombie_spawners["female"] = [];
  level.var_3fae1bc = 0;
  if(isDefined(level.var_a9e78bf7["aitypeFemale"])) {
    array::add(level.bonuszm_zombie_spawners["female"], "actor_" + level.var_a9e78bf7["aitypeFemale"]);
    if(isDefined(level.var_a9e78bf7["femaleSpawnChance"])) {
      level.var_3fae1bc = int(level.var_a9e78bf7["femaleSpawnChance"]);
    }
  }
  level.bonuszm_zombie_spawners["male"] = [];
  if(isDefined(level.var_a9e78bf7["aitypeMale1"])) {
    array::add(level.bonuszm_zombie_spawners["male"], "actor_" + level.var_a9e78bf7["aitypeMale1"]);
  }
  if(isDefined(level.var_a9e78bf7["aitypeMale2"])) {
    if(isDefined(level.var_a9e78bf7["maleSpawnChance2"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance2"]) {
      array::add(level.bonuszm_zombie_spawners["male"], "actor_" + level.var_a9e78bf7["aitypeMale2"]);
    }
  }
  if(isDefined(level.var_a9e78bf7["aitypeMale3"])) {
    if(isDefined(level.var_a9e78bf7["maleSpawnChance3"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance3"]) {
      array::add(level.bonuszm_zombie_spawners["male"], "actor_" + level.var_a9e78bf7["aitypeMale3"]);
    }
  }
  if(isDefined(level.var_a9e78bf7["aitypeMale4"])) {
    if(isDefined(level.var_a9e78bf7["maleSpawnChance4"]) && randomint(100) < level.var_a9e78bf7["maleSpawnChance4"]) {
      array::add(level.bonuszm_zombie_spawners["male"], "actor_" + level.var_a9e78bf7["aitypeMale4"]);
    }
  }
}

function function_9bb9e127() {
  if(!isDefined(level.bonuszm_zombie_spawners)) {
    return undefined;
  }
  if(!level.bonuszm_zombie_spawners.size) {
    return undefined;
  }
  spawneraitype = undefined;
  var_bc003134 = randomint(100) < level.var_3fae1bc;
  if(var_bc003134 && level.bonuszm_zombie_spawners["female"].size) {
    spawneraitype = array::random(level.bonuszm_zombie_spawners["female"]);
  } else {
    spawneraitype = array::random(level.bonuszm_zombie_spawners["male"]);
  }
  assert(isDefined(spawneraitype));
  return spawneraitype;
}

function function_b6c845e8() {
  if(level.var_a9e78bf7["zombifyenabled"]) {
    level.overrideglobalspawnfunc = &bonuzm_spawn;
  } else {
    level.overrideglobalspawnfunc = undefined;
  }
}

function private function_cf0834db(spawner) {
  if(spawner.archetype == "direwolf" || spawner.archetype == "civilian" || issubstr(spawner.classname, "hero") || issubstr(spawner.classname, "boss") || (isDefined(spawner.targetname) && issubstr(spawner.targetname, "hakim")) || (isDefined(spawner.targetname) && issubstr(spawner.targetname, "chase_bomber")) || spawner.targetname === "comm_relay_igc_robot" || spawner.targetname === "robot_wrestles_maretti" || spawner.targetname === "cin_lot_09_02_pursuit_vign_wallsmash_robot" || spawner.targetname === "cin_gen_hendricksmoment_riphead_robot" || spawner.targetname === "standdown_robot01" || spawner.targetname === "standdown_robot02" || spawner.targetname === "standdown_robot03" || spawner.targetname === "rainman" || spawner.targetname === "balcony_bash_robot") {
    return false;
  }
  if(isDefined(spawner.script_vehicleride)) {
    return false;
  }
  return true;
}

function private function_aa71a1e8(spawner) {
  if(!isDefined(spawner.targetname)) {
    return true;
  }
  if(spawner.targetname == "foundry_hackable_vehicle" || spawner.targetname == "hijack_diaz_wasp_spawnpoint") {
    return false;
  }
  return true;
}

function function_559632b9() {
  var_6cc76a5d = 0;
  var_fcbd82a5 = 0;
  if(!(isDefined(level.var_64b9a8b0) && level.var_64b9a8b0)) {
    zombies = getactorteamarray("axis");
    foreach(zombie in zombies) {
      if(zombie.archetype == "zombie") {
        if(zombie ai::get_behavior_attribute("suicidal_behavior")) {
          var_fcbd82a5++;
          continue;
        }
        if(zombie ai::get_behavior_attribute("spark_behavior")) {
          var_6cc76a5d++;
        }
      }
    }
  }
  if(randomint(100) < level.var_a9e78bf7["deimosinfectedzombiechance"] && var_6cc76a5d < 2) {
    return "deimos_zombie";
  }
  if(randomint(100) < level.var_a9e78bf7["sparkzombieupgradedchance"] && var_6cc76a5d < 1) {
    return "sparky_upgraded";
  }
  if(randomint(100) < level.var_a9e78bf7["sparkzombiechance"] && var_6cc76a5d < 1) {
    return "sparky";
  }
  if(randomint(100) < level.var_a9e78bf7["suicidalzombieupgradedchance"] && var_6cc76a5d < 2) {
    return "on_fire_upgraded";
  }
  if(randomint(100) < level.var_a9e78bf7["suicidalzombiechance"] && var_6cc76a5d < 2) {
    return "on_fire";
  }
  return "";
}

function bonuzm_spawn(b_force = 0, str_targetname, v_origin, v_angles, bignorespawninglimit) {
  e_spawned = undefined;
  force_spawn = 0;
  makeroom = 0;
  infinitespawn = 0;
  deleteonzerocount = 0;
  if(getdvarstring("") != "") {
    return;
  }
  if(!spawner::check_player_requirements()) {
    return;
  }
  while(true) {
    if(!(isDefined(bignorespawninglimit) && bignorespawninglimit)) {
      spawner::global_spawn_throttle(1);
    }
    if(isDefined(self.lastspawntime) && self.lastspawntime >= gettime()) {
      wait(0.05);
      continue;
    }
    break;
  }
  if(isactorspawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 2) == 2) {
      makeroom = 1;
    }
  } else if(isvehiclespawner(self)) {
    if(isDefined(self.spawnflags) && (self.spawnflags & 8) == 8) {
      makeroom = 1;
    }
  }
  if(b_force || (isDefined(self.spawnflags) && (self.spawnflags & 16) == 16) || isDefined(self.script_forcespawn)) {
    force_spawn = 1;
  }
  if(isDefined(self.spawnflags) && (self.spawnflags & 64) == 64) {
    infinitespawn = 1;
  }
  if(!isDefined(e_spawned)) {
    if(isactorspawner(self)) {
      assert(isDefined(self.archetype));
      var_8b333c37 = function_cf0834db(self);
      if(self.team == "axis" && var_8b333c37) {
        var_2985e88a = self.archetype;
        var_1a2d16a4 = function_559632b9();
        if(self.archetype == "warlord" || var_1a2d16a4 == "on_fire_upgraded" || var_1a2d16a4 == "sparky_upgraded") {
          e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn, "actor_spawner_bo3_zombie_bonuszm_warlord");
          if(self.archetype == "warlord") {
            e_spawned.var_6ad7f3f8 = 1;
            e_spawned.var_d4d290e = 1;
          }
        } else {
          zombify = 1;
          spawneraitype = function_9bb9e127();
          if(isDefined(spawneraitype)) {
            e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn, spawneraitype, zombify);
          } else {
            e_spawned = self spawnfromspawner(str_targetname, 1, makeroom, infinitespawn);
          }
          if(isDefined(e_spawned) && isDefined(var_2985e88a)) {
            e_spawned.var_2985e88a = var_2985e88a;
            if(var_1a2d16a4 == "deimos_zombie") {
              e_spawned.var_b7a92141 = 1;
            }
          }
        }
        if(isDefined(e_spawned)) {
          e_spawned.target = self.target;
          e_spawned.var_30e91c0d = var_1a2d16a4;
        }
      } else {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
      }
    } else {
      var_261da234 = function_aa71a1e8(self);
      spawneraitype = undefined;
      if(var_261da234 && isDefined(self.archetype)) {
        if(self.archetype == "wasp") {
          spawneraitype = "spawner_zombietron_parasite_purple_cpzm";
        } else if(self.archetype == "raps") {
          spawneraitype = "spawner_zombietron_veh_meatball_small";
        }
      }
      if(isDefined(spawneraitype)) {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn, spawneraitype);
      } else {
        e_spawned = self spawnfromspawner(str_targetname, force_spawn, makeroom, infinitespawn);
      }
    }
  }
  if(isDefined(e_spawned)) {
    e_spawned.var_11f7b644 = gettime();
    level.global_spawn_count++;
    if(isDefined(level.run_custom_function_on_ai)) {
      e_spawned thread[[level.run_custom_function_on_ai]](self, str_targetname, force_spawn);
    }
    if(isDefined(v_origin) || isDefined(v_angles)) {
      e_spawned spawner::teleport_spawned(v_origin, v_angles);
    }
    self.lastspawntime = gettime();
  }
  if(deleteonzerocount || (isDefined(self.script_delete_on_zero) && self.script_delete_on_zero) && isDefined(self.count) && self.count <= 0) {
    self delete();
  }
  if(issentient(e_spawned)) {
    if(!spawner::spawn_failed(e_spawned)) {
      return e_spawned;
    }
  } else {
    return e_spawned;
  }
}