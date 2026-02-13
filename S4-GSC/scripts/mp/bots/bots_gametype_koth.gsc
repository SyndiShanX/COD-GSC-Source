/**************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_koth.gsc
**************************************************/

main() {
  _id_D795();
  _id_D777();
}

_id_D795() {
  level._id_279D["gametype_think"] = ::_id_282A;
  level._id_279D["should_start_cautious_approach"] = ::_id_DADE;
}

_id_D777() {
  scripts\mp\bots\bots_util::_id_291B();
  var_0 = 0;

  foreach(var_2 in level._id_A8E8) {
    var_2 thread scripts\mp\bots\bots_gametype_common::_id_A0F0();
    var_3 = 0;

    if(istrue(var_2.trigger._id_F5E0)) {
      var_2.trigger scripts\engine\utility::_id_F5E2();
      var_3 = 1;
    }

    var_2._id_A578 = scripts\mp\bots\bots_gametype_common::_id_27D8(var_2.trigger);

    if(var_3) {
      var_2.trigger scripts\engine\utility::_id_F5E0();
    }
  }

  level._id_28CB = 1;

  if(!var_0) {
    level._id_27F2 = 1;
    var_5 = level._id_110CF;

    if(!isDefined(var_5)) {
      var_5 = scripts\engine\utility::random(level._id_A8E8);
    }

    scripts\mp\bots\bots_gametype_common::_id_2714([var_5]);
    level._id_27B3[var_5.trigger getentitynumber()] = 1;
    level._id_27B0 = 1;
    thread _id_2713(var_5);
  }
}

_id_2713(var_0) {
  for(var_1 = scripts\engine\utility::array_remove(level._id_A8E8, var_0); var_1.size > 0; var_1 = scripts\engine\utility::array_remove(var_1, var_2)) {
    var_2 = undefined;
    var_3 = level._id_110CF;

    if(isDefined(var_3) && scripts\engine\utility::array_contains(var_1, var_3)) {
      var_2 = var_3;
    } else {
      var_2 = scripts\engine\utility::random(var_1);
    }

    scripts\mp\bots\bots_gametype_common::_id_2714([var_2]);
    level._id_27B3[var_2.trigger getentitynumber()] = 1;
  }
}

_id_282A() {
  self notify("bot_koth_think");
  self endon("bot_koth_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self _meth_8054("separation", 0);
  self _meth_8054("grenade_objectives", 1);
  var_0 = undefined;
  var_1 = level._id_110CF;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(level._id_110CF) || !isDefined(level._id_27B3[level._id_110CF.trigger getentitynumber()])) {
      if(scripts\mp\bots\bots_util::_id_2805()) {
        _id_09F9::_id_2766();
      }

      self._id_41AD = undefined;
      self[[self._id_B025]]();
      continue;
    }

    if(var_1 != level._id_110CF) {
      var_0 = undefined;
      var_1 = level._id_110CF;
    }

    if(!istrue(level._id_110CF.trigger._id_F5E0) && isDefined(level._id_110E4) && !isDefined(var_0) && !level._id_110E8 && level._id_27F2) {
      var_2 = level._id_110E4 - gettime();

      if(var_2 > 0 && var_2 < 10000) {
        var_3 = level._id_110CF _id_07D6::_id_6C02() == self.team;

        if(!var_3) {
          var_4 = level._id_110CF._id_110D0._id_0359 * 6;

          if(var_2 < 5000) {
            var_4 = level._id_110CF._id_110D0._id_0359 * 3;
          }

          var_5 = distance(level._id_110CF._id_110D0._id_3385, self.origin);

          if(var_5 > var_4) {
            var_0 = _id_28D3();
          }
        } else {
          var_6 = scripts\mp\bots\bots_util::_id_27C9(self.team);
          var_7 = _func_0037(var_6 / 2);

          if(var_2 < 5000) {
            var_7 = _func_0037(var_6 / 3);
          }

          var_8 = _id_27CB(level._id_110CF);

          if(var_8 + 1 > var_7) {
            var_0 = _id_28D3();
          }
        }
      }
    }

    var_9 = level._id_110CF;

    if(istrue(var_0)) {
      var_10 = (level._id_BC6E + 1) % level._id_A8E8.size;

      if(var_10 == 0) {
        var_10 = 1;
      }

      var_9 = level._id_A8E8[scripts\engine\utility::_id_EA52(var_10)];
    }

    if(!_id_2804(var_9)) {
      _id_2728(var_9);
    }
  }
}

_id_28D3() {
  if(level._id_110E8) {
    return 0;
  } else {
    var_0 = self _meth_8030("strategyLevel");
    var_1 = 0;

    if(var_0 == 1) {
      var_1 = 0.1;
    } else if(var_0 == 2) {
      var_1 = 0.5;
    } else if(var_0 == 3) {
      var_1 = 0.8;
    }

    return randomfloat(1.0) < var_1;
  }
}

_id_27CB(var_0) {
  return _id_27D3(var_0).size;
}

_id_27D3(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_AE7C) {
    if(var_3 != self && scripts\mp\utility\entity::_id_8A94(var_3) && _func_03D9(self, var_3)) {
      if(var_3 istouching(level._id_110CF.trigger)) {
        if(!isai(var_3) || var_3 _id_2804(var_0)) {
          var_1[var_1.size] = var_3;
        }
      }
    }
  }

  return var_1;
}

_id_2804(var_0) {
  if(!scripts\mp\bots\bots_util::_id_2801()) {
    return 0;
  }

  return self._id_41AD == var_0;
}

_id_2728(var_0) {
  self._id_41AD = var_0;
  var_1["entrance_points_index"] = var_0._id_551A;
  var_1["override_origin_node"] = var_0._id_338B;
  _id_09F9::_id_272A(var_0.trigger.origin, var_0._id_A578, var_0.trigger, var_1);
}

_id_DADE(var_0) {
  if(var_0) {
    var_1 = level._id_110CF _id_07D6::_id_6C02();

    if(var_1 == "neutral" || var_1 == self.team) {
      return 0;
    }
  }

  return _id_09F9::_id_DADB(var_0);
}