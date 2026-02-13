/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2614.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("ball_turret_gunner", _id_09AC::_id_F76D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ball_turret_gunner", "findBoxCenter", ::_id_2168);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ball_turret_gunner", "getBombingPoint", ::_id_2169);
  scripts\cp_mp\utility\script_utility::registersharedfunc("ball_turret_gunner", "assignTargetMarkers", ::_id_215E);
}

_id_2168(var_0, var_1) {
  return _id_0817::_id_5AE1(var_0, var_1);
}

_id_2169(var_0, var_1) {
  var_2 = _id_09BC::_id_F317(var_0, var_1);
  return var_2.point;
}

_id_215E(var_0) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  var_0 endon("disconnect");
  level endon("game_ended");

  for(;;) {
    var_1 = [];
    var_2 = [];

    if(isDefined(self._id_542C) && _id_079B::_id_EEE7(self._id_542C)) {
      _id_079B::_id_EEDE(self._id_542C);
    }

    if(isDefined(self._id_5FBD) && _id_079B::_id_EEE7(self._id_5FBD)) {
      _id_079B::_id_EEDE(self._id_5FBD);
    }

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
    wait 2;
  }
}