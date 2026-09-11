/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\init.gsc
***********************************************/

function init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "init")]]();
  level thread scripts\cp_mp\killstreaks\airdrop::init();
  level thread scripts\cp_mp\killstreaks\airstrike::init();
  level thread scripts\cp_mp\killstreaks\juggernaut::init();
  level thread scripts\cp_mp\killstreaks\toma_strike::init();
  level thread scripts\cp_mp\killstreaks\uav::init();
  level thread scripts\cp_mp\killstreaks\helper_drone::init();
  level thread scripts\cp_mp\killstreaks\manual_turret::init();
  level thread scripts\cp_mp\killstreaks\emp_drone_targeted::init();
  level thread scripts\cp_mp\killstreaks\sentry_gun::init();
  level thread _calloutmarkerping_handleluinotify_acknowledged::init();
  total_killed();

  if(level.gametype != "br") {
    level thread scripts\cp_mp\killstreaks\cruise_predator::init();
    level thread scripts\cp_mp\killstreaks\white_phosphorus::init();
    level thread scripts\cp_mp\killstreaks\gunship::init();
    level thread scripts\cp_mp\killstreaks\chopper_gunner::init();
    level thread scripts\cp_mp\killstreaks\chopper_support::init();
    level thread scripts\cp_mp\killstreaks\emp_drone::init();
    return;
  }
}

function total_killed() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::ref_14279("killstreak", 1);
  var_0.ref_14422["missileLocking"] = 2;
}