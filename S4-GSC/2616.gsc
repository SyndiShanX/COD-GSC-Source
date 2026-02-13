/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2616.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("chopper_gunner", _id_09AD::_id_F770);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", ::_id_3655);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "findTargetStruct", ::_id_3650);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", ::_id_364E);
}

_id_3655(var_0, var_1) {
  _id_0AAF::_id_D42B(var_0, var_1);
}

_id_3650(var_0, var_1) {
  return _id_09AE::_id_36BF(var_0, var_1);
}

_id_364E() {
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  foreach(var_4 in var_2) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_1[var_1.size] = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    var_0[var_0.size] = var_4;
  }

  self._id_542C = _id_079B::_id_EEDF("thermalvisionenemydefault", self.owner, var_0, self.owner, 0, 1, 1);
  self._id_5FBD = _id_079B::_id_EEDF("thermalvisionfriendlydefault", self.owner, var_1, self.owner, 1, 1);
}