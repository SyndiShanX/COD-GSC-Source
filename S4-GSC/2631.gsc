/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2631.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("gunship", _id_09B4::_id_F784);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "findBoxCenter", ::_id_72D6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "getBombingPoint", ::_id_72D7);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "assignTargetMarkers", ::_id_72CA);
}

_id_72D6(var_0, var_1) {
  return _id_0817::_id_5AE1(var_0, var_1);
}

_id_72D7(var_0, var_1) {
  var_2 = _id_09BC::_id_F317(var_0, var_1);
  return var_2.point;
}

_id_72CA(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_2[var_2.size] = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  self._id_542C = _id_079B::_id_EEDF("thermalvisionenemydefault", self.owner, var_1, self.owner, 0, 1, 1);
  self._id_5FBD = _id_079B::_id_EEDF("thermalvisionfriendlydefault", self.owner, var_2, self.owner, 1, 1);
}