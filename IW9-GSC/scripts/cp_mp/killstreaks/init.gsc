/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\init.gsc
***********************************************/

init() {
  if(getdvarint("r_reflectionprobegenerate", 0) == 1) {
    return;
  }
  if(getdvarint("dvar_742CAA13B3C2E685", 0) == 1) {
    return;
  }
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "init")]]();
  _id_DC7912CA19ED8FFF();
  _id_E6D056D3A1DDFCCC();
  level.heli_structs_entrances = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_entrance");
  level.heli_structs_goals = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_goal");
  level.heli_structs_paths = scripts\cp_mp\utility\game_utility::getlocalestructarray("ks_heli_path");
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
  level thread _id_0B6E69AC53E6EE66::init();
  level thread _id_10AD6174C8938599::init();
  level thread _id_249F45D992AF1114::init();
  level thread scripts\cp_mp\killstreaks\sentry_gun::init();
  level thread _id_509A782DD5B89CF1::init();

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level thread _id_1EDDEC53ABF6E24C::init();
    level thread scripts\cp_mp\killstreaks\cruise_predator::init();
    level thread scripts\cp_mp\killstreaks\white_phosphorus::init();
    level thread scripts\cp_mp\killstreaks\gunship::init();
    level thread scripts\cp_mp\killstreaks\chopper_gunner::init();
    level thread scripts\cp_mp\killstreaks\chopper_support::init();
    level thread _id_6D68CFDF0836123C::init();
  }

  while(!scripts\cp_mp\utility\script_utility::issharedfuncdefined("aggregator", "registerOnPlayerSpawnCallback"))
    waitframe();
}

_id_DC7912CA19ED8FFF() {
  _id_E2818AD39A3341B4 = scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_clearleveldataforvehicle("killstreak", 1);
  _id_E2818AD39A3341B4.warningbits["missileLocking"] = 2;
  _id_E2818AD39A3341B4.warningbits["burningDown"] = 1;
}

_id_E6D056D3A1DDFCCC() {
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_thermal");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_thermal_fog");
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_flash", 0.1);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_static", 0.1);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_slamzoom", 0.1);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_color_light_damage", 0.1, 0.1, 0.3);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_color_heavy_damage", 0.1, 0.2, 0.5);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_thermal_light_damage", 0.1, 0.1, 0.3);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_thermal_heavy_damage", 0.1, 0.2, 0.5);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_ads_shutter", 0.25, 0.1, 0.25);
  scripts\cp_mp\utility\killstreak_utility::_id_C0B0A582FF9E4D57("killstreak_weapon_change_shutter", 0.025, 0.08, 0.15);
}