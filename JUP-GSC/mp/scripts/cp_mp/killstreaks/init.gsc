/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\killstreaks\init.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\killstreaks\airdrop;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\assault_drone;
#using scripts\cp_mp\killstreaks\auto_drone;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\chopper_support;
#using scripts\cp_mp\killstreaks\cluster_spike;
#using scripts\cp_mp\killstreaks\cruise_predator;
#using scripts\cp_mp\killstreaks\emp_drone;
#using scripts\cp_mp\killstreaks\emp_drone_targeted;
#using scripts\cp_mp\killstreaks\gunship;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\killstreaks\hover_jet;
#using scripts\cp_mp\killstreaks\juggernaut;
#using scripts\cp_mp\killstreaks\manual_turret;
#using scripts\cp_mp\killstreaks\nuke;
#using scripts\cp_mp\killstreaks\recon_drone;
#using scripts\cp_mp\killstreaks\sentry_gun;
#using scripts\cp_mp\killstreaks\toma_strike;
#using scripts\cp_mp\killstreaks\uav;
#using scripts\cp_mp\killstreaks\uav_bigmap;
#using scripts\cp_mp\killstreaks\white_phosphorus;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#namespace init;

function init() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) == 1) {
    return;
  }

  if(getdvarint(@ "hash_742caa13b3c2e685", 0) == 1) {
    return;
  }

  scripts\engine\utility::issharedfuncdefined("<dev string:x1c>", "<dev string:x2a>", 1);

  [[scripts\engine\utility::getsharedfunc("killstreak", "init")]]();
  function_dc7912ca19ed8fff();
  scripts\killstreaks\killstreak_shared::function_aa5200593ca327d2();
  level thread function_12bbd0259ce8831f();
  level thread scripts\cp_mp\killstreaks\airdrop::init();
  level thread scripts\cp_mp\killstreaks\airstrike::init();
  level thread scripts\cp_mp\killstreaks\juggernaut::init();
  level thread scripts\cp_mp\killstreaks\toma_strike::init();
  level thread scripts\cp_mp\killstreaks\uav::init();
  level thread scripts\cp_mp\killstreaks\helper_drone::init();
  level thread scripts\cp_mp\killstreaks\manual_turret::init();
  level thread scripts\cp_mp\killstreaks\emp_drone_targeted::init();
  level thread scripts\cp_mp\killstreaks\nuke::init();
  level thread scripts\cp_mp\killstreaks\emp_drone::init();
  level thread scripts\cp_mp\killstreaks\auto_drone::init();
  level thread scripts\cp_mp\killstreaks\cluster_spike::init();
  level thread scripts\cp_mp\killstreaks\assault_drone::init();
  level thread scripts\cp_mp\killstreaks\sentry_gun::init();
  level thread scripts\cp_mp\killstreaks\uav_bigmap::init();

  if(!scripts\cp_mp\utility\game_utility::isbrstylegametype()) {
    level thread scripts\cp_mp\killstreaks\hover_jet::init();
    level thread scripts\cp_mp\killstreaks\cruise_predator::init();
    level thread scripts\cp_mp\killstreaks\white_phosphorus::init();
    level thread scripts\cp_mp\killstreaks\gunship::init();
    level thread scripts\cp_mp\killstreaks\chopper_gunner::init();
    level thread scripts\cp_mp\killstreaks\chopper_support::init();
    level thread scripts\cp_mp\killstreaks\recon_drone::init();
  }

  while(!issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback")) {
    waitframe();
  }
}

function function_dc7912ca19ed8fff() {
  leveldataforvehicle = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearleveldataforvehicle("killstreak", 1);
  leveldataforvehicle.warningbits["missileLocking"] = 2;
  leveldataforvehicle.warningbits["burningDown"] = 1;
}

function function_12bbd0259ce8831f() {
  if(isDefined(level.scripted_spawner_func)) {
    flag_wait("strike_init_done");
  }

  level.heli_structs_entrances = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_entrance");
  level.heli_structs_goals = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_goal");
  level.heli_structs_paths = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_path");
}