/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2629.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("glide_bomb", _id_09B3::_id_F782);
  scripts\cp_mp\utility\script_utility::registersharedfunc("glide_bomb", "registerVO", ::_id_7021);
  scripts\cp_mp\utility\script_utility::registersharedfunc("glide_bomb", "eventRecord", ::_id_701B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("glide_bomb", "assignTargetMarkers", ::_id_7016);
}

_id_7021() {
  game["dialog"]["cruise_separation_1"] = "flavor_predator20";
  game["dialog"]["cruise_separation_2"] = "flavor_predator30";
  game["dialog"]["cruise_control_1"] = "flavor_predator40";
  game["dialog"]["cruise_control_2"] = "flavor_predator50";
  game["dialog"]["cruise_control_3"] = "flavor_predator60";
  game["dialog"]["cruise_kill"] = "mp_glob_kill_bchr_tghc";
  game["dialog"]["cruise_miss"] = "mp_glob_kill_bchr_tgmc";
}

_id_701B(var_0) {
  if(isDefined(var_0)) {
    _id_07CE::_id_BB7B(var_0);
  }
}

_id_7016(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = level.players;
  var_4 = spawnStruct();

  foreach(var_6 in var_3) {
    if(level.teambased && var_6.team == var_0.team || var_6 == var_0) {
      var_2[var_2.size] = var_6;
      continue;
    }

    if(var_6 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    var_1[var_1.size] = var_6;
  }

  var_4._id_542C = var_1;
  var_4._id_5FBD = var_2;
  return var_4;
}