/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_ctf.gsc
*************************************************/

main() {
  _id_D795();
  _id_D76B();
}

_id_D795() {
  level._id_279D["crate_can_use"] = ::_id_3E6F;
  level._id_279D["gametype_think"] = ::_id_2754;
  level._id_279D["get_watch_node_chance"] = ::_id_274F;
}

_id_D76B() {
  level._id_27A3 = ::_id_4117;
  level._id_27A6 = ::_id_4118;
  level._id_279E = ::_id_633E;
  level._id_279F = ::_id_633F;
  level._id_27A1 = ::_id_274B;
  level._id_27AB = ::_id_2751;
  scripts\mp\bots\bots_util::_id_291B();

  while(!isDefined(level._id_EF72)) {
    wait 0.05;
  }

  level._id_EF72["allies"]._id_A8E1 = "allies";
  level._id_EF72["axis"]._id_A8E1 = "axis";
  scripts\mp\bots\bots_gametype_common::_id_2711(level._id_EF72, "flag_");
  var_0 = _func_00F5(level._id_EF72["allies"]._id_4140);

  if(isDefined(var_0)) {
    _func_002C(var_0, "allies");
  }

  var_0 = _func_00F5(level._id_EF72["axis"]._id_4140);

  if(isDefined(var_0)) {
    _func_002C(var_0, "axis");
  }

  level._id_323A["allies"]._id_A3F8 = level._id_EF72["allies"].trigger._id_A3F8;
  level._id_323A["axis"]._id_A3F8 = level._id_EF72["axis"].trigger._id_A3F8;
  thread _id_274A();
  level._id_27B0 = 1;
}

_id_3E6F(var_0) {
  if(isagent(self) && !isDefined(var_0._id_2991)) {
    return 0;
  }

  if(_id_2752()) {
    return 0;
  }

  return _id_274D(self.team);
}

_id_2754() {
  self notify("bot_ctf_think");
  self endon("bot_ctf_think");
  self endon("death_or_disconnect");
  level endon("game_ended");

  while(!isDefined(level._id_27B0)) {
    wait 0.05;
  }

  self._id_A46B = 0;
  self _meth_8054("separation", 0);
  self _meth_8054("use_obj_path_style", 1);
  var_0 = 0;
  var_1 = 0;

  for(;;) {
    wait 0.05;

    if(self.health <= 0) {
      continue;
    }
    if(!isDefined(self._id_C8C5)) {
      scripts\mp\bots\bots_gametype_common::_id_27AF();
    }

    var_2 = scripts\mp\utility\game::_id_6BE2(self.team)[0];

    if(_id_274D(self.team)) {
      if(isDefined(level._id_2829) && isDefined(level._id_2829[var_2])) {
        level._id_2829[var_2] = undefined;
      }
    }

    var_3 = 0;

    if(self._id_C8C5 == "attacker") {
      if(_id_2752()) {
        var_3 = 1;
      } else if(!_id_274C()) {
        var_3 = distancesquared(self.origin, level._id_EF72[var_2]._id_4140) < _func_0219(_id_64A9());
      }
    } else if(!_id_274D(self.team))
      var_3 = !_id_2750();

    self _meth_8054("force_sprint", var_3);
    var_1 = 0;

    if(_id_2752()) {
      if(_id_274D(self.team)) {
        _id_38C6();
        var_1 = 1;

        if(!var_0) {
          var_0 = 1;
          self _meth_8055("scripted");
        }

        self _meth_8058(level._id_323A[self.team]._id_4140, 16, "critical");
      } else if(scripts\mp\bots\bots_gametype_common::_id_27A9(self.team) == 1)
        _id_2753();
      else if(gettime() > self._id_A46B) {
        _id_38C6();
        var_4 = _func_00B4(level._id_323A[self.team]._id_4140, 900, 0, 300);
        var_5 = self _meth_8049(var_4, var_4.size * 0.15, "node_hide_anywhere");

        if(!isDefined(var_5)) {
          var_5 = level._id_323A[self.team]._id_A3F8;
        }

        var_6 = self _meth_8059(var_5, "critical");

        if(var_6) {
          self._id_A46B = gettime() + 15000;
        }
      }
    } else if(self._id_C8C5 == "attacker") {
      if(_id_274C()) {
        if(!scripts\mp\bots\bots_util::_id_2800()) {
          _id_38C6();
          self _meth_802B();
          var_7 = level._id_EF72[var_2]._id_32D5;
          _id_09F9::_id_27E3(var_7, 500);
        }
      } else {
        _id_38C6();

        if(self _meth_803E() == "critical") {
          self _meth_802B();
        }

        self _meth_8058(level._id_EF72[var_2]._id_4140, 16, "objective", undefined, 300);
      }
    } else if(!_id_274D(self.team))
      _id_2753();
    else if(!_id_868D()) {
      self _meth_802B();
      var_8["score_flags"] = "strict_los";
      var_8["entrance_points_index"] = "flag_" + level._id_EF72[self.team]._id_A8E1;
      var_8["nearest_node_to_center"] = level._id_EF72[self.team].trigger._id_A3F8;
      _id_09F9::_id_2899(level._id_EF72[self.team]._id_4140, _id_64A9(), var_8);
    }

    if(var_0 && !var_1) {
      var_0 = 0;
      self _meth_8055(undefined);
    }
  }
}

_id_2753() {
  var_0 = undefined;
  var_1 = level._id_EF72[self.team];
  var_2 = var_1._id_32D5;

  if(!isDefined(var_2)) {
    var_0 = var_1._id_4140;
  } else if(self _meth_8028(var_2)) {
    var_0 = var_2.origin;

    if(self _meth_8030("strategyLevel") > 0 && !_id_274D(self.team)) {
      if(!isDefined(level._id_2829)) {
        level._id_2829 = [];
      }

      if(!isDefined(level._id_2829[var_2.team])) {
        level._id_2829[var_2.team] = [];
      }

      level._id_2829[var_2.team]["origin"] = var_0;
      level._id_2829[var_2.team]["time"] = gettime();
    }
  } else if(isDefined(var_1._id_4139)) {
    if(isDefined(var_1._id_3B0A["friendly"])) {
      if(var_1._id_A90C) {
        var_0 = var_1._id_4139;
      } else {
        var_0 = var_2.origin;
      }
    }
  } else
    var_0 = var_1._id_4140;

  if(isDefined(var_0)) {
    _id_38C6();
    self _meth_8058(var_0, 16, "critical");
  } else {
    var_3 = undefined;
    var_4 = undefined;

    if(self _meth_8030("strategyLevel") > 0) {
      if(isDefined(level._id_2829) && isDefined(level._id_2829[var_2.team])) {
        var_4 = gettime() - level._id_2829[var_2.team]["time"];

        if(var_4 < 10000) {
          var_3 = level._id_2829[var_2.team]["origin"];
        }
      }
    }

    if(isDefined(var_3)) {
      if(var_4 < 5000) {
        _id_38C6();
        self _meth_8058(var_3, 16, "critical");
      } else if(!scripts\mp\bots\bots_util::_id_280A()) {
        _id_09F9::_id_2766();
        _id_09F9::_id_287A(var_3, 400);
      }
    } else {
      _id_38C6();
      var_5 = self _meth_803E();

      if(var_5 == "objective" || var_5 == "critical") {
        self _meth_802B();
      }

      _id_09F7::_id_FBA9();
    }
  }
}

_id_38C6() {
  if(scripts\mp\bots\bots_util::_id_2805()) {
    _id_09F9::_id_2766();
  }
}

_id_868D() {
  return scripts\mp\bots\bots_util::_id_280B();
}

_id_64A9() {
  if(isalive(self) && !isDefined(level._id_BDBF)) {
    var_0 = self _meth_8041();
    var_1 = (var_0[0] + var_0[1]) / 2;
    level._id_BDBF = min(800, var_1 / 5.5);
  }

  if(!isDefined(level._id_BDBF)) {
    return 900;
  }

  return level._id_BDBF;
}

_id_4117(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::_id_27A9(var_0);

  if(var_1 == 1) {
    return 1;
  }

  if(_id_274D(var_0)) {
    var_2 = var_1 * 0.67;
  } else {
    var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

    if(_id_274D(var_3)) {
      var_2 = var_1 * 0.5;
    } else {
      var_2 = var_1 * 0.4;
    }
  }

  var_4 = int(scripts\common\utility::_id_C94D(var_2));
  var_5 = game["teamScores"][var_0];
  var_6 = game["teamScores"][scripts\engine\utility::_id_647F(var_0)];

  if(var_5 + 1 < var_6) {
    var_4 = int(min(var_4 + 1, var_1));
  }

  return var_4;
}

_id_4118(var_0) {
  var_1 = scripts\mp\bots\bots_gametype_common::_id_27A9(var_0);
  return var_1 - _id_4117(var_0);
}

_id_633E(var_0) {
  return scripts\mp\bots\bots_gametype_common::_id_27A7(var_0, level._id_323A[var_0]._id_4140, _id_64A9());
}

_id_633F(var_0) {
  return scripts\mp\bots\bots_gametype_common::_id_27A8(var_0, level._id_323A[var_0]._id_4140, _id_64A9());
}

_id_274A() {
  level notify("bot_ctf_ai_director_update");
  level endon("bot_ctf_ai_director_update");
  level endon("game_ended");
  thread scripts\mp\bots\bots_gametype_common::_id_27A2();
}

_id_274F(var_0) {
  if(var_0 == self._id_A550) {
    return 1.0;
  }

  if(!_id_868D()) {
    return 1.0;
  }

  var_1 = var_0 scripts\mp\bots\bots_util::_id_A55D("flag_allies", "flag_axis");

  if(var_1) {
    return 1.0;
  }

  return 0.2;
}

_id_274D(var_0) {
  return level._id_EF72[var_0] _id_07D6::_id_88A9();
}

_id_274E(var_0) {
  return isDefined(level._id_EF72[var_0]._id_32D5);
}

_id_2750() {
  return _id_274E(self.team);
}

_id_274C() {
  var_0 = scripts\mp\utility\game::_id_6BE2(self.team)[0];
  return _id_274E(var_0);
}

_id_2752() {
  return isDefined(self._id_32E6);
}

_id_274B() {
  if(_id_2752()) {
    return 0;
  }

  return 1;
}

_id_2751() {
  if(_id_2752()) {
    return 1;
  }

  return 0;
}