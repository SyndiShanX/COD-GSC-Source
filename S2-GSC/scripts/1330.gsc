/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1330.gsc
**************************************/

init() {
  level._id_6232 = 6;
  level._id_622E = 675.0;
  level._id_622F = 185.0;
  level._id_6230 = 0.95;
  level._id_6231 = 2.0;
  level._id_6233 = 0.42;
  level._id_6234 = 1.65;
  level._id_622C = 2.1;
  level._id_6225 = 4.3;
  level._id_6226 = 1.0;
  level._id_6227 = 0.85;
  level._id_6228 = 0.25;
  self._id_622D = [];
  self._id_4B78 = 0;
}

_id_3662() {
  self._id_4B78 = 1;
  thread _id_5FC7();
  thread _id_5FC9();
}

_id_622A(var_0, var_1) {
  var_2 = "airstrike_missile_mp";
  var_3 = "scorestreak_minimap_mortar_strike_damage";
  var_4 = "scorestreak_minimap_mortar_strike_kill";
  var_5 = 1;
  var_6 = 100;
  var_7 = 0;
  var_8 = 1;
  var_9 = _getweaponexplosionradius(var_2);
  var_10 = var_9 * 2;
  self._id_29E1 = _func_190("script_model", var_1);
  self._id_29E1 _meth_8351(var_0, var_3, var_10, var_10, var_8, var_7);
  self._id_29E1 _meth_8352(var_6, var_5);
  var_11 = 100;
  var_12 = 0;
  var_13 = _func_1FF(var_2, var_12, var_11);
  var_14 = var_13 * 2;
  self._id_5A88 = _func_190("script_model", var_1);
  self._id_5A88 _meth_8351(var_0, var_4, var_14, var_14, var_8, var_7);
  self._id_5A88 _meth_8352(var_6, var_5);
}

_id_6229() {
  self waittill("death");
  var_0 = 80;
  var_1 = 0;
  self._id_29E1 _meth_8352(var_0, var_1);
  self._id_5A88 _meth_8352(var_0, var_1);
  wait(var_0 / 1000);
  self._id_29E1 delete();
  self._id_5A88 delete();
}

_id_5FC7() {
  self endon("MisinformationDisabled");

  for(;;) {
    var_0 = _id_464F();

    if(_getpathdist(self.origin, var_0) > 0) {
      var_0 = var_0 - (0, 0, 500);
      _id_622A(self, var_0);
      wait(_randomfloat(level._id_6226) + level._id_6225);
      _id_6229();
      wait(_randomfloat(level._id_6228) + level._id_6227);
      continue;
    }

    waitframe();
  }
}

_id_5FC8() {
  self endon("MisinformationDisabled");

  for(;;) {
    var_0 = _id_464F();

    if(_getpathdist(self.origin, var_0) > 0) {
      var_1 = randomint(10);

      if(var_1 >= 0 &var_1 < 6)
        var_2 = "tabun_grenade_mp";
      else if(var_1 >= 6 &var_1 < 9) {
        var_2 = "smoke_grenade_mp";

        if(isDefined(self.team) && self.team == "axis")
          var_2 = "smoke_grenade_axis_mp";
      } else
        var_2 = "killstreak_carepackage_grenade_mp";

      _magicgrenademanual(var_2, var_0, (0, 0, 0), 0.05, self);
      wait(level._id_622C);
      continue;
    }

    waitframe();
  }
}

_id_5FC9() {
  self endon("MisinformationDisabled");

  for(;;) {
    var_0 = _id_464F();

    if(_getpathdist(self.origin, var_0) > 0) {
      thread _id_2817(var_0);
      wait(level._id_6233 + _randomfloat(level._id_6234));
      continue;
    }

    waitframe();
  }
}

_id_2817(var_0) {
  self endon("MisinformationDisabled");
  var_1 = spawnStruct();

  if(isDefined(self._id_622D)) {
    self._id_622D = common_scripts\utility::_id_0FA0(self._id_622D);

    if(self._id_622D.size >= level._id_6232) {
      maps\mp\_utility::_objective_delete(self._id_622D[0]._id_3770);
      maps\mp\_utility::_objective_delete(self._id_622D[0]._id_3EE2);
      self._id_622D[0] = undefined;
    }

    self._id_622D = common_scripts\utility::_id_0FA0(self._id_622D);
  } else
    self._id_622D = [];

  self._id_622D[self._id_622D.size] = var_1;
  var_1._id_3EE2 = _id_04D1::_id_45A9();
  _objective_add(var_1._id_3EE2, "invisible", (0, 0, 0));
  _objective_position(var_1._id_3EE2, var_0);
  _objective_icon(var_1._id_3EE2, "cb_compassping_minion_friend_mp");

  if(!level.teambased)
    _objective_playerenemyteam(var_1._id_3EE2, self getentitynumber());
  else
    _objective_team(var_1._id_3EE2, self.team);

  var_1._id_3770 = _id_04D1::_id_45A9();
  _objective_add(var_1._id_3770, "invisible", (0, 0, 0));
  _objective_position(var_1._id_3770, var_0);
  _objective_icon(var_1._id_3770, "cb_compassping_enemy_objective");

  if(!level.teambased)
    _objective_playerteam(var_1._id_3770, self getentitynumber());
  else
    _objective_team(var_1._id_3770, level._id_6C63[self.team]);

  if(self._id_4B78)
    thread _id_63CF(var_1);
  else {
    self._id_622D = common_scripts\utility::_id_0F98(var_1, self._id_622D);
    maps\mp\_utility::_objective_delete(var_1._id_3770);
    maps\mp\_utility::_objective_delete(var_1._id_3EE2);
    var_1 = undefined;
  }
}

_id_63CF(var_0) {
  self endon("MisinformationDisabled");

  if(!isDefined(var_0) || !isDefined(var_0._id_3770) || !isDefined(var_0._id_3EE2)) {
    return;
  }
  _objective_state(var_0._id_3770, "active");
  _objective_state(var_0._id_3EE2, "active");
  wait(level._id_6230 + _randomfloat(level._id_6231));

  if(!isDefined(var_0) || !isDefined(var_0._id_3770) || !isDefined(var_0._id_3EE2)) {
    return;
  }
  self._id_622D = common_scripts\utility::_id_0F98(var_0, self._id_622D);
  maps\mp\_utility::_objective_delete(var_0._id_3770);
  maps\mp\_utility::_objective_delete(var_0._id_3EE2);
  var_0 = undefined;
}

_id_2F9E() {
  self notify("MisinformationDisabled");

  if(isDefined(self._id_622B))
    self._id_622B delete();

  if(isDefined(self._id_622D)) {
    self._id_622D = common_scripts\utility::_id_0FA0(self._id_622D);

    for(var_0 = self._id_622D.size - 1; var_0 >= 0; var_0--) {
      maps\mp\_utility::_objective_delete(self._id_622D[var_0]._id_3770);
      maps\mp\_utility::_objective_delete(self._id_622D[var_0]._id_3EE2);
      self._id_622D[var_0] = undefined;
    }

    self._id_622D = [];
  }

  self._id_4B78 = 0;
}

_id_464F() {
  var_0 = randomint(2) * 2 - 1;
  var_1 = randomint(2) * 2 - 1;
  var_2 = (var_0 * _randomfloatrange(level._id_622F, level._id_622E), var_1 * _randomfloatrange(level._id_622F, level._id_622E), 0.0);
  var_2 = self.origin + var_2;
  var_2 = _getgroundposition(var_2, 3);
  return var_2;
}