/***************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_to_dd.gsc
***************************************************/

main() {
  _id_D795();
  _id_D76D();
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::_id_2771;
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(isDefined(var_0.cratetype) && !_id_09F4::_id_2809(var_0.cratetype)) {
    return 0;
  }

  return _id_868E();
}

_id_8B42(var_0, var_1) {
  if(var_0 == 0) {
    var_0 = "_a";
  } else {
    var_0 = "_b";
  }

  var_2 = spawnStruct();
  var_2.origin = var_1;
  var_2.angles = (0, randomint(360), 0);
  level._id_A8E8[var_0]._id_2952[level._id_A8E8[var_0]._id_2952.size] = var_2;
}

_id_2798() {
  if(level.mapname == "mp_metropolis") {
    if(scripts\mp\utility\game::_id_82D1() && level._id_A8E8["_a"]._id_2952.size == 0) {
      var_0 = (-505, -361, 68);
      _id_8B42(0, var_0);
      var_0 = (-582, -311, 68);
      _id_8B42(0, var_0);
      var_0 = (-583, -387, 68);
      _id_8B42(0, var_0);
      var_0 = (-583, -387, 68);
      _id_8B42(0, var_0);
      var_0 = (-497, -326, 68);
      _id_8B42(0, var_0);
    }
  }
}

_id_D76D() {
  scripts\mp\bots\bots_util::_id_291B();
  var_0 = scripts\mp\bots\bots_gametype_common::_id_2917(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level._id_A8E8) {
      var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0BF();
    }

    level._id_27B0 = 1;
  }
}

_id_6BFE() {
  return level._id_A8E8["_a"];
}

_id_8770() {
  if(!scripts\mp\utility\game::_id_82D1()) {
    if(self.team == game["attackers"]) {
      return 1;
    }

    return 0;
  }

  var_0 = _id_6BFE();

  if(var_0._id_ADAE == "neutral") {
    return 1;
  }

  if(var_0._id_ADAE == self.team) {
    return 0;
  }

  return 1;
}

_id_87F5() {
  if(!scripts\mp\utility\game::_id_82D1()) {
    if(self.team == game["defenders"]) {
      return 1;
    }

    return 0;
  }

  var_0 = _id_6BFE();

  if(var_0._id_ADAE == "neutral") {
    return 0;
  }

  if(var_0._id_ADAE == self.team) {
    return 1;
  }

  return 0;
}

_id_2771() {
  self notify("bot_dem_think");
  self endon("bot_dem_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  _id_7F09();
  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  self _meth_8054("use_obj_path_style", 1);
  self._id_85A0 = 0;
  self._id_8664 = 0;
  self._id_4154 = undefined;

  if(!isDefined(level._id_A46C)) {
    level._id_A46C = gettime() - 100;
  }

  for(;;) {
    wait 0.05;

    if(gettime() >= level._id_A46C) {
      _id_FB70();
      level._id_A46C = gettime() + 100;
    }

    if(self.health <= 0) {
      continue;
    }
    if(scripts\mp\utility\game::_id_82D1() && !isDefined(self._id_4154)) {
      self._id_4154 = _id_6BFE();
    }

    if(_id_8770()) {
      if(self._id_8664) {
        _id_B19B();
      } else {
        if(!isDefined(self._id_4154)) {
          self._id_4154 = _id_5AB6("attackers");
        }

        if(isDefined(self._id_4154)) {
          if(_id_8568(self._id_4154) && !_id_868E()) {
            _id_09F9::_id_2899(self._id_4154._id_2951.origin, 600);
          } else if(!_id_8568(self._id_4154) && !_id_856B()) {
            var_0["entrance_points_index"] = "zone" + self._id_4154.label;
            _id_09F9::_id_2729(self._id_4154._id_2951.origin, 350, var_0);
          }
        }
      }

      continue;
    }

    if(self._id_85A0) {
      if(!isDefined(level._id_436B[self._id_4154.label])) {
        self._id_85A0 = 0;
      }
    }

    if(self._id_85A0) {
      _id_4639();
      continue;
    }

    if(!isDefined(self._id_4154)) {
      self._id_4154 = _id_5AB6("defenders");
    }

    if(isDefined(self._id_4154)) {
      if(_id_8568(self._id_4154) && !_id_856B()) {
        var_0["entrance_points_index"] = "zone" + self._id_4154.label;
        _id_09F9::_id_2729(self._id_4154._id_2951.origin, 350, var_0);
        continue;
      }

      if(!_id_8568(self._id_4154) && !_id_868E()) {
        _id_09F9::_id_2899(self._id_4154._id_2951.origin, 600);
      }
    }
  }
}

_id_B19B() {
  _id_70F2(1);
}

_id_4639() {
  _id_70F2(0);
}

_id_70F2(var_0) {
  _id_09F9::_id_2766();

  if(var_0) {
    self _meth_8058(self._id_4154._id_2951.origin, 20, "critical", self._id_4154._id_2951.angles[1]);
  } else {
    var_1 = level._id_436B[self._id_4154.label].origin;
    self _meth_8058(var_1, 20, "critical");
  }

  var_2 = scripts\mp\bots\bots_util::_id_291C(undefined, "dem_bomb_exploded", "no_longer_bomb_defuser");

  if(var_2 == "goal") {
    self _meth_804E("use", level._id_4644 + 2);
    _id_1093C(level._id_4644 + 2, var_0);

    if(var_0) {
      self._id_8664 = 0;
    } else {
      self._id_85A0 = 0;
    }
  }
}

_id_1093C(var_0, var_1) {
  var_2 = gettime();
  var_3 = var_2 + var_0 * 1000;
  wait 0.05;

  while(self usebuttonpressed() && gettime() < var_3 && isDefined(self._id_4154) && var_1 != _id_8568(self._id_4154)) {
    wait 0.05;
  }
}

_id_868E() {
  return scripts\mp\bots\bots_util::_id_280B();
}

_id_856B() {
  return scripts\mp\bots\bots_util::_id_2801();
}

_id_63A3(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in level._id_AE7C) {
    if(var_1 == "attackers" && !var_4 _id_8770()) {
      continue;
    }
    if(var_1 == "defenders" && !var_4 _id_87F5()) {
      continue;
    }
    if(isalive(var_4) && scripts\mp\utility\entity::_id_8A94(var_4) && isDefined(var_4._id_4154) && var_4._id_4154 == var_0) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_63A0(var_0) {
  var_1 = _id_63A3(var_0, "defenders");

  foreach(var_3 in var_1) {
    if(var_3._id_85A0) {
      return var_3;
    }
  }

  return undefined;
}

_id_63A1(var_0) {
  var_1 = _id_63A3(var_0, "attackers");

  foreach(var_3 in var_1) {
    if(var_3._id_8664) {
      return var_3;
    }
  }

  return undefined;
}

_id_5AB6(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    if(!istrue(var_3._id_265C)) {
      var_4 = 0;

      if(var_0 == "defenders") {
        var_4 = var_3._id_2940 > _id_63A3(var_3, "defenders").size;
      } else if(var_0 == "attackers") {
        var_4 = var_3._id_293F > _id_63A3(var_3, "attackers").size;
      }

      if(var_4) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  var_6 = undefined;

  if(var_1.size > 0) {
    var_7 = 999999999;

    foreach(var_3 in var_1) {
      var_9 = distancesquared(var_3._id_2951.origin, self.origin);

      if(var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  }

  return var_6;
}

_id_FB70() {
  var_0 = [];

  foreach(var_2 in level._id_A8E8) {
    if(!istrue(var_2._id_265C)) {
      var_0[var_0.size] = var_2;
    }
  }

  if(level._id_BC08 == 2 && var_0.size == 1) {
    foreach(var_5 in level._id_AE7C) {
      if(scripts\mp\utility\entity::_id_8A94(var_5) && isDefined(var_5._id_4154) && var_5._id_4154 != var_0[0]) {
        var_5._id_4154 = undefined;
        var_5 _id_09F9::_id_2766();
        var_5 notify("dem_bomb_exploded");
        var_5._id_85A0 = 0;
        var_5._id_8664 = 0;
      }
    }

    level._id_BC08 = 1;
  }

  _id_FB57(var_0);
  _id_FB58(var_0);
}

_id_FB57(var_0) {
  if(gettime() > level._id_A485) {
    level._id_41AE = 1 - level._id_41AE;
    level._id_A485 = gettime() + 90000;
  }

  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8744(var_3) && isalive(var_3) && var_3 _id_8770()) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    if(var_1 >= 2) {
      var_0[1 - level._id_41AE]._id_293F = 1;
    } else {
      var_0[1 - level._id_41AE]._id_293F = 0;
    }

    var_0[level._id_41AE]._id_293F = var_1 - var_0[1 - level._id_41AE]._id_293F;
  } else if(var_0.size == 1)
    var_0[0]._id_293F = var_1;

  foreach(var_6 in var_0) {
    var_7 = _id_63A3(var_6, "attackers");

    if(var_7.size > var_6._id_293F) {
      var_7 = scripts\engine\utility::array_randomize(var_7);

      foreach(var_9 in var_7) {
        if(!var_9._id_8664) {
          var_9._id_4154 = undefined;
          var_9 _id_09F9::_id_2766();
          break;
        }
      }
    }
  }

  foreach(var_6 in var_0) {
    if(!_id_8568(var_6) && !isDefined(_id_63A1(var_6))) {
      var_7 = _id_63A3(var_6, "attackers");

      if(var_7.size > 0) {
        var_13 = scripts\engine\utility::_id_6369(var_6._id_2951.origin, var_7);
        var_13[0]._id_8664 = 1;
        var_13[0] _id_09F9::_id_2766();
      }
    }
  }
}

_id_FB58(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_AE7C) {
    if(scripts\mp\utility\entity::_id_8744(var_3) && isalive(var_3) && var_3 _id_87F5()) {
      var_1++;
    }
  }

  if(var_0.size == 2) {
    var_0[0]._id_2940 = int(var_1 / 2);
    var_0[1]._id_2940 = int(var_1 / 2);
    var_0[level._id_A168]._id_2940 = var_0[level._id_A168]._id_2940 + var_1 % 2;

    for(var_5 = 0; var_5 < var_0.size; var_5++) {
      if(_id_8568(var_0[var_5])) {
        var_0[var_5]._id_2940++;
        var_0[1 - var_5]._id_2940--;
      }
    }
  } else if(var_0.size == 1)
    var_0[0]._id_2940 = var_1;

  foreach(var_7 in var_0) {
    var_8 = _id_63A3(var_7, "defenders");

    if(var_8.size > var_7._id_2940) {
      var_8 = scripts\engine\utility::array_randomize(var_8);

      foreach(var_10 in var_8) {
        if(!var_10._id_85A0) {
          var_10._id_4154 = undefined;
          var_10 _id_09F9::_id_2766();
          break;
        }
      }
    }
  }

  foreach(var_7 in var_0) {
    if(_id_8568(var_7)) {
      var_14 = _id_63A0(var_7);

      if(!isDefined(var_14) || gettime() > level._id_A489) {
        var_8 = _id_63A3(var_7, "defenders");

        if(var_8.size > 0) {
          var_15 = scripts\engine\utility::_id_6369(var_7._id_2951.origin, var_8);

          if(!isDefined(var_14) || var_15[0] != var_14) {
            var_15[0]._id_85A0 = 1;
            var_15[0] _id_09F9::_id_2766();

            if(isDefined(var_14)) {
              var_14._id_85A0 = 0;
              var_14 notify("no_longer_bomb_defuser");
            }
          }
        }

        level._id_A489 = gettime() + 2500;
      }
    }
  }
}

_id_8568(var_0) {
  return isDefined(var_0._id_2663) && var_0._id_2663 == 1;
}

_id_7F09() {
  if(isDefined(level._id_2945) && level._id_2945) {
    return;
  }
  level._id_2945 = 1;
  level._id_A168 = randomint(2);
  level._id_BC08 = 2;
  level._id_41AE = randomint(2);
  level._id_A485 = gettime() + 90000;
  level._id_A489 = 0;
}