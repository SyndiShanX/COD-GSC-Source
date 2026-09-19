/********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_demo.gsc
********************************************************/

main() {
  _id_87A7();
  _id_199A();
}

_id_87A7() {
  level._id_19D5["gametype_think"] = ::_id_199B;
  level._id_19D5["notify_enemy_bots_bomb_used"] = ::_id_67F5;
}

_id_199A() {
  _id_8792();
}

_id_8792() {
  maps\mp\bots\_bots_gametype_common::_id_1ADB();
  maps\mp\bots\_bots_util::_id_1B20();
  var_0 = maps\mp\bots\_bots_gametype_common::_id_1B1D(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level._id_1913)
    var_2 thread maps\mp\bots\_bots_gametype_common::_id_62EA();

    thread _id_1997();
    level._id_19E8 = 1;
  }
}

_id_199B() {
  self notify("bot_dd_think");
  self endon("bot_dd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self endon("owner_disconnect");

  while(!isDefined(level._id_19E8))
    waitframe();

  self _meth_8353("separation", 0);
  self _meth_8353("grenade_objectives", 1);
  self._id_28EE = undefined;
  self._id_2CA5 = 0;

  for(;;) {
    waitframe();

    if(isDefined(self._id_28EE) && !_id_190F(self._id_28EE)) {
      self._id_28EE = undefined;
      _id_1998();
    }

    if(maps\mp\_utility::inovertime())
      var_0 = level._id_1913[0]._id_6DB2 != self.team;
    else
      var_0 = self.team == game["attackers"];

    if(var_0) {
      _id_1A96("attack");

      if(!isDefined(self._id_28EE)) {
        continue;
      }
      _id_1B08();
      _id_1970();

      if(self._id_7ECA == "sweep_zone") {
        if(!maps\mp\bots\_bots_util::_id_1A2E(self._id_28EE._id_28D4)) {
          var_1["min_goal_time"] = 2;
          var_1["max_goal_time"] = 4;
          var_1["override_origin_node"] = common_scripts\utility::random(self._id_28EE._id_1B49);
          maps\mp\bots\_bots_strategy::_id_1AA6(self._id_28EE._id_28D4, level._id_7790, var_1);
        }
      } else if(self._id_7ECA == "defend_zone") {
        if(!_func_279(level._id_2D65[self._id_28EE.label]) && !maps\mp\bots\_bots_util::_id_1A2E(level._id_2D65[self._id_28EE.label].origin)) {
          var_1["score_flags"] = "strongly_avoid_center";
          maps\mp\bots\_bots_strategy::_id_1AA6(level._id_2D65[self._id_28EE.label].origin, level._id_7790, var_1);
        }
      } else if(self._id_7ECA == "investigate_someone_using_bomb")
        _id_5519();
      else if(self._id_7ECA == "atk_bomber")
        _id_7060();

      continue;
    }

    _id_1A96("defend");

    if(!isDefined(self._id_28EE)) {
      continue;
    }
    _id_1972();

    if(self._id_7ECA == "defend_zone") {
      if(!maps\mp\bots\_bots_util::_id_1A2E(self._id_28EE._id_28D4)) {
        var_1["score_flags"] = "strict_los";
        var_1["override_origin_node"] = common_scripts\utility::random(self._id_28EE._id_1B49);
        maps\mp\bots\_bots_strategy::_id_1AA6(self._id_28EE._id_28D4, level._id_7790, var_1);
      }

      continue;
    }

    if(self._id_7ECA == "investigate_someone_using_bomb") {
      _id_5519();
      continue;
    }

    if(self._id_7ECA == "defuser")
      _id_2C92();
  }
}

_id_67F5(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_3B69(self);
  var_2 = maps\mp\bots\_bots_gametype_common::_id_4065(var_0);

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_28EE) && var_1 == var_4._id_28EE)
      var_4 _id_1999("investigate_someone_using_bomb");
  }
}

_id_7060() {
  self endon("change_role");
  var_0 = maps\mp\bots\_bots_gametype_common::_id_40DF(self._id_28EE, 0);
  self _meth_8356(var_0.origin, 0, "critical");
  var_1 = maps\mp\bots\_bots_util::_id_1B21(undefined, "change_role");

  if(var_1 == "goal") {
    var_2 = maps\mp\gametypes\_gamelogic::_id_46E5();
    var_3 = var_2 - level._id_7078 * 2 * 1000;
    var_4 = gettime() + var_3;

    if(var_3 > 0)
      maps\mp\bots\_bots_util::_id_1B22(var_3);

    var_5 = var_4 > 0 && gettime() >= var_4;
    var_6 = maps\mp\bots\_bots_gametype_common::_id_1911(level._id_7078 + 2, "bomb_planted", var_5);
    self _meth_8358();

    if(var_6)
      _id_1998();
  }
}

_id_2C92() {
  self endon("change_role");
  self _meth_837B("scripted");
  var_0 = maps\mp\bots\_bots_gametype_common::_id_40DE(self._id_28EE).origin;
  self _meth_8356(var_0, 20, "critical");
  var_1 = maps\mp\bots\_bots_util::_id_1B21(undefined, "change_role");

  if(var_1 == "bad_path") {
    self._id_2CA5++;

    if(self._id_2CA5 >= 4) {
      for(;;) {
        var_2 = _func_0B9(var_0, 50, 0);
        var_3 = self._id_2CA5 - 4;

        if(var_2.size <= var_3) {
          var_4 = _func_1F2(var_0, 50, self);

          if(isDefined(var_4))
            self _meth_8356(var_4, 20, "critical");
          else
            break;
        } else
          self _meth_8356(var_2[var_3].origin, 20, "critical");

        var_1 = maps\mp\bots\_bots_util::_id_1B21(undefined, "change_role");

        if(var_1 == "bad_path") {
          self._id_2CA5++;
          continue;
        }

        break;
      }
    }
  }

  if(var_1 == "goal") {
    var_5 = (self._id_28EE._id_2CA0 - gettime()) * 1000;
    var_6 = var_5 - level._id_2CA9 * 2 * 1000;
    var_7 = gettime() + var_6;

    if(var_6 > 0)
      maps\mp\bots\_bots_util::_id_1B22(var_6);

    var_8 = var_7 > 0 && gettime() >= var_7;
    var_9 = maps\mp\bots\_bots_gametype_common::_id_1911(level._id_2CA9 + 2, "bomb_defused", var_8);

    if(!var_9 && self._id_2CA5 >= 4)
      self._id_2CA5++;

    self _meth_8358();

    if(var_9)
      _id_1998();
  }
}

_id_5519() {
  self endon("change_role");

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  self _meth_8357(common_scripts\utility::random(self._id_28EE._id_1B49), "critical");
  var_0 = maps\mp\bots\_bots_util::_id_1B21();

  if(var_0 == "goal") {
    wait 2;
    _id_1998();
  }
}

_id_4297(var_0) {
  var_1 = _id_42B2(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!_func_0C1(var_3)) {
      if(var_3._id_56C2)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(_func_0C1(var_3)) {
      if(isDefined(var_3._id_7ECA) && var_3._id_7ECA == "defuser")
        return var_3;
    }
  }

  return undefined;
}

_id_42A6(var_0) {
  var_1 = _id_42B2(var_0, self.team);

  foreach(var_3 in var_1) {
    if(!_func_0C1(var_3)) {
      if(var_3._id_5777)
        return var_3;
    }
  }

  foreach(var_3 in var_1) {
    if(_func_0C1(var_3)) {
      if(isDefined(var_3._id_7ECA) && var_3._id_7ECA == "atk_bomber")
        return var_3;
    }
  }

  return undefined;
}

_id_190F(var_0) {
  if(var_0._id_A560 == "any" || var_0._id_18F9)
    return 1;

  return 0;
}

_id_405F() {
  var_0 = [];

  foreach(var_2 in level._id_1913) {
    if(_id_190F(var_2))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_42B2(var_0, var_1) {
  var_2 = [];
  var_3 = maps\mp\bots\_bots_gametype_common::_id_41FB(var_1);

  foreach(var_5 in var_3) {
    if(_func_0C1(var_5)) {
      if(isDefined(var_5._id_28EE) && var_5._id_28EE == var_0)
        var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);

      continue;
    }

    if(distancesquared(var_5.origin, var_0._id_28D4) < level._id_7790 * level._id_7790)
      var_2 = common_scripts\utility::_id_0F6F(var_2, var_5);
  }

  return var_2;
}

_id_1A94(var_0, var_1) {
  var_2[0] = _id_42B2(var_0[0], game["defenders"]).size;
  var_2[1] = _id_42B2(var_0[1], game["defenders"]).size;

  if(var_2[0] > var_2[1] + var_1)
    return var_0[1];
  else if(var_2[0] + var_1 < var_2[1])
    return var_0[0];
}

_id_1A96(var_0) {
  var_1 = undefined;

  if(var_0 == "attack")
    var_1 = _id_1971();
  else if(var_0 == "defend")
    var_1 = _id_1973();

  if(isDefined(var_1) && (!isDefined(self._id_28EE) || self._id_28EE != var_1)) {
    self._id_28EE = var_1;
    _id_1998();
  }
}

_id_1973() {
  var_0 = _id_405F();
  var_1 = undefined;

  if(var_0.size == 1)
    var_1 = var_0[0];
  else if(var_0.size == 2) {
    var_2[0] = _id_42B2(var_0[0], game["defenders"]).size;
    var_2[1] = _id_42B2(var_0[1], game["defenders"]).size;
    var_3[0] = _id_553C(var_0[0]);
    var_3[1] = _id_553C(var_0[1]);

    if(var_3[0] && var_3[1] || !var_3[0] && !var_3[1]) {
      var_4 = 0;

      if(isDefined(self._id_28EE))
        var_4 = 1;

      var_1 = _id_1A94(var_0, var_4);

      if(!isDefined(var_1) && !isDefined(self._id_28EE))
        var_1 = common_scripts\utility::random(var_0);
    } else if(var_3[0] || var_3[1]) {
      var_5 = common_scripts\utility::_id_98E7(var_3[0], 0, 1);
      var_6 = common_scripts\utility::_id_98E7(!var_3[0], 0, 1);

      if(var_2[var_5] > var_2[var_6] + 2)
        var_1 = var_0[var_6];
      else if(var_2[var_5] <= var_2[var_6])
        var_1 = var_0[var_5];
      else if(!isDefined(self._id_28EE)) {
        if(var_2[var_5] >= var_2[var_6] + 2)
          var_1 = var_0[var_6];
        else if(var_2[var_5] < var_2[var_6] + 2)
          var_1 = var_0[var_5];
      }
    }
  }

  return var_1;
}

_id_4269(var_0) {
  var_1 = _id_405F();

  foreach(var_3 in var_1) {
    if(var_3 != var_0)
      return var_3;
  }
}

_id_1971() {
  if(isDefined(self._id_28EE)) {
    return;
  }
  if(!isDefined(level._id_2921) || !_id_190F(level._id_2921) || gettime() > level._id_66B4) {
    level._id_66B4 = gettime() + 1000 * _func_0A4(30, 45);
    level._id_2921 = common_scripts\utility::random(_id_405F());
  }

  if(!isDefined(level._id_2921)) {
    return;
  }
  var_0 = level._id_2921;
  var_1 = _id_4269(var_0);
  self._id_28EE = undefined;

  if(isDefined(var_1)) {
    if(_func_0A3(1.0) < 0.25)
      return var_1;
  }

  return var_0;
}

_id_1B08() {
  var_0 = _id_4269(self._id_28EE);

  if(isDefined(var_0)) {
    var_1 = distance(self.origin, self._id_28EE._id_28D4);
    var_2 = distance(self.origin, var_0._id_28D4);

    if(var_2 < var_1 * 0.6)
      self._id_28EE = var_0;
  }
}

_id_1970() {
  if(isDefined(self._id_7ECA)) {
    if(self._id_7ECA == "investigate_someone_using_bomb")
      return;
  }

  var_0 = undefined;

  if(_id_553C(self._id_28EE))
    var_0 = "defend_zone";
  else {
    var_1 = _id_42A6(self._id_28EE);

    if(!isDefined(var_1) || var_1 == self)
      var_0 = "atk_bomber";
    else if(_func_0C1(var_1)) {
      var_2 = distance(self.origin, self._id_28EE._id_28D4);
      var_3 = distance(var_1.origin, self._id_28EE._id_28D4);

      if(var_2 < var_3 * 0.9) {
        var_0 = "atk_bomber";
        var_1 _id_1998();
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = "sweep_zone";

  _id_1999(var_0);
}

_id_1972() {
  if(isDefined(self._id_7ECA)) {
    if(self._id_7ECA == "investigate_someone_using_bomb")
      return;
  }

  var_0 = undefined;

  if(_id_553C(self._id_28EE)) {
    var_1 = _id_4297(self._id_28EE);

    if(!isDefined(var_1) || var_1 == self)
      var_0 = "defuser";
    else if(_func_0C1(var_1)) {
      var_2 = distance(self.origin, self._id_28EE._id_28D4);
      var_3 = distance(var_1.origin, self._id_28EE._id_28D4);

      if(var_2 < var_3 * 0.9) {
        var_0 = "defuser";
        var_1 _id_1998();
      }
    }
  }

  if(!isDefined(var_0))
    var_0 = "defend_zone";

  _id_1999(var_0);
}

_id_1999(var_0) {
  if(!isDefined(self._id_7ECA) || self._id_7ECA != var_0) {
    _id_1998();
    self._id_7ECA = var_0;
  }
}

_id_1998() {
  self._id_7ECA = undefined;
  self _meth_8358();
  self _meth_837B(undefined);
  maps\mp\bots\_bots_strategy::_id_19A3();
  self notify("change_role");
  self._id_2CA5 = 0;
}

_id_1997() {
  level notify("bot_dd_ai_director_update");
  level endon("bot_dd_ai_director_update");
  level endon("game_ended");
  level._id_7790 = 725;

  for(;;) {
    foreach(var_1 in level._id_1913) {
      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_7ECA) && isDefined(var_3._id_28EE) && var_3._id_28EE == var_1) {
          if(!_id_190F(var_1)) {
            if(var_3._id_7ECA == "atk_bomber" || var_3._id_7ECA == "defuser")
              var_3 _id_1998();

            continue;
          }

          if(_id_553C(var_1)) {
            if(var_3._id_7ECA == "atk_bomber")
              var_3 _id_1998();
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_553C(var_0) {
  return common_scripts\utility::_id_562E(var_0._id_18F9);
}