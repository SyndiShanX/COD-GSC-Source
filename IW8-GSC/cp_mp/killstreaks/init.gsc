/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\killstreaks\init.gsc
***********************************************/

init() {
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_85CE0B9770B02C73A1760F06D2", "_encstr_88C5055208731B")]]();
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

  if(level.gametype != "_encstr_B607038AAB") {
    level thread scripts\cp_mp\killstreaks\cruise_predator::init();
    level thread scripts\cp_mp\killstreaks\white_phosphorus::init();
    level thread scripts\cp_mp\killstreaks\gunship::init();
    level thread scripts\cp_mp\killstreaks\chopper_gunner::init();
    level thread scripts\cp_mp\killstreaks\chopper_support::init();
    level thread scripts\cp_mp\killstreaks\emp_drone::init();
  }
}

total_killed() {
  var_0 = scripts\cp_mp\utility\vehicle_omnvar_utility::_id_14279("_encstr_85CE0B9770B02C73A1760F06D2", 1);
  var_0._id_14422["_encstr_A3FA0FA331A28318788F91DA3F678A5067"] = 2;
}