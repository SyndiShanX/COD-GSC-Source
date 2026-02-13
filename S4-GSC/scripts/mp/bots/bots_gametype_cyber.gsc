/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_cyber.gsc
***************************************************/

main() {
  _id_D795();
  _id_D76C();
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::_id_2757;
  level._id_279D["know_enemies_on_start"] = undefined;
  level._id_279D["emp_picked_up_cancel"] = ::_id_26EE;
  level._id_279D["tactical_revive_override"] = ::_id_26F0;
}

_id_D76C() {
  scripts\mp\bots\bots_gametype_common::_id_28D0();
  scripts\mp\bots\bots_util::_id_291B();
  var_0 = scripts\mp\bots\bots_gametype_common::_id_2917(["_allies", "_axis"]);

  if(var_0) {
    foreach(var_2 in level._id_A8E8) {
      var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0BF();
    }

    level._id_BDBF = 600;
    level._id_27B0 = 1;
  }
}

_id_2757() {
  self notify("bot_sab_think");
  self endon("bot_sab_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  _id_7F08();
  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  self _meth_8054("use_obj_path_style", 1);
  self._id_A488 = gettime();

  if(!isDefined(level._id_A46C)) {
    level._id_A46C = gettime() + 100;
  }

  for(;;) {
    wait 0.05;

    if(gettime() >= level._id_A46C) {
      _id_FB6F();
      level._id_A46C = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_EF52)) {
      if(!isDefined(level._id_25F9)) {
        if(_id_09F9::_id_27ED("seek_cyber_emp", undefined) == 0) {
          var_0 = ::_id_4299;
          var_1 = spawnStruct();
          var_1._id_A860 = level._id_429C.trigger;
          var_1._id_CD72 = 16;
          var_1._id_DA6E = level._id_279D["emp_picked_up_cancel"];
          var_1._id_0E86 = var_0;
          var_2 = _func_02AB(level._id_429C._id_4140, self);
          _id_09F9::_id_2862("seek_cyber_emp", var_2, 99, var_1);
        }
      } else if(self._id_8783) {
        var_3 = level._id_A8E8[scripts\engine\utility::_id_647F(self.team)];
        var_4 = scripts\mp\bots\bots_gametype_common::_id_639E(var_3, 1);
        self _meth_8058(var_4.origin, 0, "critical", var_4.angles[1]);
        var_5 = scripts\mp\bots\bots_util::_id_291C();

        if(var_5 == "goal") {
          self _meth_804E("use", level._id_B1DA + 2);
          level scripts\engine\utility::_id_108A7(level._id_B1DA + 2, "bomb_planted");
        }
      } else if(level._id_25F9.team == self.team) {
        if(!scripts\mp\bots\bots_util::_id_2805()) {
          _id_09F9::_id_27E3(level._id_25F9, 400);
        }
      } else if(gettime() > self._id_A488 || _func_0202(self.origin + (0, 0, 77), level._id_25F9.origin + (0, 0, 77), 0, self)) {
        self _meth_8058(level._id_25F9.origin, 16, "hunt");
        self._id_A488 = gettime() + randomintrange(4500, 5500);
      }

      continue;
    }

    var_3 = level._id_A8E8[scripts\engine\utility::_id_647F(level._id_EF52)];

    if(self.team == level._id_EF52) {
      if(!_id_859F()) {
        _id_09F9::_id_2899(var_3._id_4140, 600);
      }
    } else if(isDefined(level._id_25FD) && level._id_25FD == self) {
      var_6 = scripts\mp\bots\bots_gametype_common::_id_639D(var_3).origin;
      self _meth_8058(var_6, 20, "critical");
      var_7 = scripts\mp\bots\bots_util::_id_291C(undefined, "no_longer_bomb_defuser");

      if(var_7 == "goal") {
        self _meth_804E("use", level._id_4644 + 2);
        _id_1093D(level._id_4644 + 2);
      }
    } else if(!scripts\mp\bots\bots_util::_id_2805()) {
      var_8["entrance_points_index"] = "zone" + var_3.label;
      _id_09F9::_id_2729(var_3._id_4140, 200, var_8);
    }
  }
}

_id_26EE(var_0) {
  if(isDefined(level._id_429C._id_32D5)) {
    return 1;
  }

  return 0;
}

_id_4299(var_0) {
  self _meth_804E("use", 0.5);
  var_1 = self _meth_803A();

  if(var_1 == "default" || var_1 == "camper") {
    wait 0.5;
  }
}

_id_1093D(var_0) {
  var_1 = gettime();
  var_2 = var_1 + var_0 * 1000;
  wait 0.05;

  while(self usebuttonpressed() && gettime() < var_2 && level._id_2663) {
    wait 0.05;
  }
}

_id_859F() {
  return scripts\mp\bots\bots_util::_id_280B();
}

_id_7F08() {
  if(isDefined(level._id_2945) && level._id_2945) {
    return;
  }
  level._id_2945 = 1;
}

_id_FB6F() {
  if(!level._id_2663) {
    if(isDefined(level._id_EF52)) {
      level._id_EF52 = undefined;
      level._id_25F9 = undefined;
    }

    var_0 = level._id_25F9;
    level._id_25F9 = undefined;

    foreach(var_2 in level._id_AE7C) {
      if(isalive(var_2) && var_2._id_8783) {
        level._id_25F9 = var_2;
      }
    }

    var_4 = 0;

    if(!isDefined(var_0) && isDefined(level._id_25F9)) {
      var_4 = 1;

      if(isai(level._id_25F9)) {
        level._id_25F9 thread _id_2649();
      }
    } else if(isDefined(var_0) && !isDefined(level._id_25F9))
      var_4 = 1;

    if(var_4) {
      foreach(var_2 in level._id_AE7C) {
        if(scripts\mp\utility\entity::_id_8744(var_2)) {
          var_2 _id_09F9::_id_2766();
        }
      }

      return;
    }
  } else {
    if(isDefined(level._id_2661) && !isDefined(level._id_EF52)) {
      level._id_EF52 = level._id_2661.team;
      level._id_8F6E = gettime();
    }

    if(!isDefined(level._id_25FD) || !isalive(level._id_25FD) || gettime() > level._id_8F6E + 1000) {
      var_7 = [];

      foreach(var_2 in level._id_AE7C) {
        if(isalive(var_2) && scripts\mp\utility\entity::_id_8744(var_2) && var_2.team != level._id_EF52) {
          var_7[var_7.size] = var_2;
        }
      }

      if(var_7.size > 0) {
        var_10 = level._id_A8E8[scripts\engine\utility::_id_647F(level._id_EF52)];
        var_11 = scripts\engine\utility::_id_6369(var_10._id_4140, var_7);

        if(!isDefined(level._id_25FD) || level._id_25FD != var_11[0]) {
          var_12 = level._id_25FD;
          level._id_25FD = var_11[0];
          level._id_25FD _id_09F9::_id_2766();

          if(isDefined(var_12)) {
            var_12 notify("no_longer_bomb_defuser");
          }
        }
      }
    }
  }
}

_id_2649() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!level._id_2663 && self._id_8783) {
    var_0 = [];

    foreach(var_2 in level._id_AE7C) {
      if(isalive(var_2) && scripts\mp\utility\entity::_id_8744(var_2) && var_2.team == self.team && var_2 scripts\mp\bots\bots_util::_id_2805()) {
        var_0[var_0.size] = var_2;
      }
    }

    var_4 = 0;

    foreach(var_6 in var_0) {
      var_7 = distancesquared(self.origin, var_6.origin);
      var_8 = var_6._id_276D * var_6._id_276D;
      var_9 = var_6._id_276D * 2 * (var_6._id_276D * 2);

      if(var_7 > var_8 && var_7 < var_9) {
        var_4++;
      }
    }

    self setmovespeedscale(1.0 - 0.15 * var_4);
    wait 1;
  }
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !_id_09F4::_id_2809(var_0.cratetype)) {
    return 0;
  }

  if(self._id_8783) {
    return 0;
  }

  if(!scripts\mp\bots\bots_util::_id_2805() && !scripts\mp\bots\bots_util::_id_280B() && !scripts\mp\bots\bots_util::_id_2800()) {
    return 1;
  }

  return 0;
}

_id_26F0() {
  if(level._id_2663) {
    return 0;
  }

  if(isDefined(level._id_429C._id_32D5) && self == level._id_429C._id_32D5) {
    return 0;
  }

  if(istrue(self._id_878C)) {
    return 0;
  }

  var_0 = scripts\mp\utility\teams::_id_6DCA(self.team, "aliveCount");
  var_1 = scripts\mp\utility\teams::_id_6DCA(self.team, "teamCount");
  var_2 = var_1 - var_0;

  if(var_2 == 0) {
    return 0;
  }

  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(istrue(self._id_878C)) {
      var_3++;
    }
  }

  var_8 = int(clamp(var_1 - 2, 1, 3));

  if(var_3 < var_8 + 1) {
    var_4 = 1;
  }

  if(var_4) {
    if(var_1 == 2) {
      var_9 = 1;
    } else {
      var_9 = var_0 / var_1 <= 0.7;
    }

    if(var_9) {
      return 1;
    }
  }

  return 0;
}