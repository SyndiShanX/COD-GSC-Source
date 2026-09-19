/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_sd.gsc
******************************************************/

main() {
  _id_87A7();
  _id_1ABF();
}

_id_87A7() {
  level._id_19D5["crate_can_use"] = ::_id_2734;
  level._id_19D5["gametype_think"] = ::_id_1AC0;
  level._id_19D5["should_start_cautious_approach"] = ::_id_8B7D;
  level._id_19D5["know_enemies_on_start"] = undefined;
  level._id_19D5["notify_enemy_bots_bomb_used"] = ::_id_67F5;
}

_id_1ABF() {
  _id_8799();
}

_id_2734(var_0) {
  if(_func_1EF(self) && !isDefined(var_0._id_1B7B))
    return 0;

  if(!maps\mp\_utility::_id_5800(self))
    return 1;

  if(!isDefined(self._id_7ECA))
    return 0;

  switch (self._id_7ECA) {
    case "investigate_someone_using_bomb":
    case "bomb_defuser":
    case "atk_bomber":
      return 0;
  }

  return 1;
}

_id_8799() {
  level._id_1B3B = 1;
  level._id_52D4 = 3000;
  maps\mp\bots\_bots_gametype_common::_id_1ADB();
  maps\mp\bots\_bots_util::_id_1B20();
  level._id_1ABE = [];
  level._id_1ABE["axis"] = [];
  level._id_1ABE["allies"] = [];
  level._id_199D["atk_bomber"] = ::_id_10F8;
  level._id_199D["clear_target_zone"] = ::_id_23CF;
  level._id_199D["defend_planted_bomb"] = ::_id_2C3B;
  level._id_199D["defuser"] = ::_id_18B6;
  level._id_199D["investigate_someone_using_bomb"] = ::_id_551A;
  level._id_199D["camp_bomb"] = ::_id_1ECB;
  level._id_199D["defender"] = ::_id_2C7C;
  level._id_199D["backstabber"] = ::_id_14ED;
  level._id_199D["random_killer"] = ::_id_7A3B;
  var_0 = maps\mp\bots\_bots_gametype_common::_id_1B1D(["_a", "_b"]);

  if(var_0) {
    foreach(var_2 in level._id_1913)
    var_2 thread maps\mp\bots\_bots_gametype_common::_id_62EA();

    thread _id_1ABD();
    level._id_19E8 = 1;
  }
}

_id_1AC0() {
  self notify("bot_sd_think");
  self endon("bot_sd_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self._id_4B44 = undefined;

  while(!isDefined(level._id_19E8))
    waitframe();

  self _meth_8353("separation", 0);
  self _meth_8353("grenade_objectives", 1);
  self _meth_8353("use_obj_path_style", 1);
  var_0 = game["attackers"];
  var_1 = 1;

  if(isDefined(level._id_832F) && isDefined(level._id_832F._id_2006) && level._id_832F._id_2006 == self && isDefined(self._id_7ECA) && self._id_7ECA == "atk_bomber")
    var_1 = 0;

  if(var_1) {
    self._id_7ECA = undefined;

    if(isDefined(level._id_10F6) && level._id_10F6 == self)
      level._id_10F6 = undefined;
  }

  self._id_9526 = undefined;
  self._id_4B44 = 0;
  self._id_10F7 = 0;
  self._id_8311 = undefined;
  self._id_2C7B = undefined;
  self._id_2CA5 = 0;

  if(!isDefined(level._id_52CA) && !level._id_6510) {
    level._id_52CA = level._id_832F._id_28D4;
    level._id_52CB = _func_0BA(level._id_832F._id_28D4);
  }

  if(self.team == var_0 && !isDefined(level._id_1F1B)) {
    var_2 = 0;

    if(!level._id_6510) {
      var_3 = maps\mp\bots\_bots_gametype_common::_id_41FB(var_0);

      foreach(var_5 in var_3) {
        if(!_func_0C1(var_5))
          var_2 = 1;
      }
    }

    if(var_2) {
      var_7 = 6000;
      level._id_1F1B = gettime() + var_7;
      _func_01E("bomb", var_7 / 1000, level._id_832F._id_28D4, 75, 300, var_0);
    }
  }

  for(;;) {
    wait(_func_0A4(1, 3) * 0.05);

    if(self.health <= 0) {
      continue;
    }
    self._id_4B44 = 1;

    if(!isDefined(self._id_7ECA))
      _id_52E9();

    if(isDefined(self._id_9526)) {
      continue;
    }
    if(self.team == var_0) {
      if(!level._id_6510 && isDefined(level._id_1F1B) && gettime() < level._id_1F1B && !isDefined(level._id_832F._id_2006)) {
        if(!maps\mp\bots\_bots_util::_id_1A2E(level._id_832F._id_28D4)) {
          var_8 = _func_0BA(level._id_832F._id_28D4);

          if(isDefined(var_8)) {
            var_9["nearest_node_to_center"] = var_8;
            maps\mp\bots\_bots_strategy::_id_1AA6(level._id_832F._id_28D4, 900, var_9);
          } else
            level._id_1F1B = gettime();
        }
      } else
        self[[level._id_199D[self._id_7ECA]]]();

      continue;
    }

    if(level._id_18F9 && isDefined(level._id_8330)) {
      if(distancesquared(self.origin, level._id_8330.origin) > _func_0DA(level._id_7790 * 2)) {
        if(!isDefined(self._id_2C7B)) {
          self._id_2C7B = 1;
          self _meth_837B("scripted");
        }
      } else if(isDefined(self._id_2C7B) && !isDefined(self._id_8311)) {
        self._id_2C7B = undefined;
        self _meth_837B(undefined);
      }
    }

    if(level._id_18F9 && isDefined(level._id_18B5) && isDefined(level._id_8330) && self._id_7ECA != "defuser") {
      if(!maps\mp\bots\_bots_util::_id_1A2E(level._id_8330.origin)) {
        self _meth_8358();
        maps\mp\bots\_bots_strategy::_id_1AA6(level._id_8330.origin, level._id_7790);
      }

      continue;
    }

    self[[level._id_199D[self._id_7ECA]]]();
  }
}

_id_18D9(var_0) {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  self _meth_8353("disable_movement", 1);
  self _meth_8354("stand");
  wait(var_0);
  self _meth_8353("disable_movement", 0);
  self _meth_8354("none");
}

_id_10F8() {
  self endon("new_role");

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  if(isDefined(level._id_832F) && isDefined(level._id_832F._id_2006) && isalive(level._id_832F._id_2006) && level._id_832F._id_2006 != self)
    wait 0.7;

  if(!self._id_568D && !level._id_6510) {
    if(isDefined(level._id_832F)) {
      if(!isDefined(self._id_5B18))
        self._id_5B18 = level._id_832F._id_28D4;

      if(distancesquared(self._id_5B18, level._id_832F._id_28D4) > 4) {
        self _meth_8358();
        self._id_5B18 = level._id_832F._id_28D4;
      }
    }

    if(self._id_10F7 >= 2) {
      var_1 = _func_0B9(level._id_832F._id_28D4, 512, 0);
      var_2 = undefined;

      foreach(var_4 in var_1) {
        if(!var_4 _meth_8389()) {
          var_2 = var_4;
          break;
        }
      }

      if(isDefined(var_2)) {
        self _meth_8356(var_2.origin, 20, "critical");
        maps\mp\bots\_bots_util::_id_1B21();

        if(isDefined(level._id_832F) && !isDefined(level._id_832F._id_2006))
          level._id_832F _id_04D1::_id_86F9(self);
      } else {}

      return;
    }

    if(!self _meth_8367()) {
      var_6 = 15;
      var_7 = 32;
      var_8 = maps\mp\bots\_bots_util::_id_1AA8("BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3F03, level._id_832F._id_28D4, var_6 + var_7, self);

      if(isDefined(var_8)) {
        var_9 = self _meth_8356(level._id_832F._id_28D4, 0, "critical");

        if(var_9) {
          childthread _id_18E0();
          return;
        }
      } else {
        var_1 = _func_0B9(level._id_832F._id_28D4, 512, 0);

        if(var_1.size > 0) {
          self _meth_8356(var_1[0].origin, 0, "critical");
          maps\mp\bots\_bots_util::_id_1B21();
        }

        if(isDefined(level._id_832F) && !isDefined(level._id_832F._id_2006)) {
          var_8 = maps\mp\bots\_bots_util::_id_1AA8("BotGetClosestNavigablePoint", maps\mp\bots\_bots_util::_id_3F03, level._id_832F._id_28D4, var_6 + var_7, self);

          if(!isDefined(var_8))
            level._id_832F _id_04D1::_id_86F9(self);
        }
      }
    }
  } else {
    if(isDefined(self._id_3237) && gettime() < self._id_3237) {
      return;
    }
    if(!isDefined(level._id_18D1))
      level._id_18D1 = level._id_1913[randomint(level._id_1913.size)];

    var_10 = level._id_18D1;
    self._id_1912 = var_10;

    if(!isDefined(level._id_52CC) || gettime() - level._id_52CC < level._id_52D4) {
      level._id_52CC = gettime() + level._id_52D4;
      thread _id_18D9(level._id_52D4 / 1000);
      wait(level._id_52D4 / 1000);
    }

    self _meth_8358();

    if(level._id_115F == "rush") {
      self _meth_837B("scripted");
      var_11 = maps\mp\bots\_bots_gametype_common::_id_40DF(var_10, 1);
      self _meth_8356(var_11.origin, 0, "critical");
    }

    var_12 = maps\mp\bots\_bots_util::_id_1B21();

    if(var_12 == "goal") {
      var_13 = _id_4308() - gettime();
      var_14 = var_13 - level._id_7078 * 2 * 1000;
      var_15 = gettime() + var_14;

      if(var_14 > 0)
        maps\mp\bots\_bots_util::_id_1B22(var_14);

      var_16 = gettime() >= var_15;
      var_17 = maps\mp\bots\_bots_gametype_common::_id_1911(level._id_7078 + 2, "bomb_planted", var_16);
      self _meth_8358();

      if(var_17) {
        maps\mp\bots\_bots_strategy::_id_19BC();
        _id_1AD7("defend_planted_bomb");
      } else if(var_14 > 5000)
        self._id_3237 = gettime() + 5000;
    }
  }
}

_id_4308() {
  if(level._id_18F9)
    return level._id_2CA0;
  else
    return gettime() + maps\mp\gametypes\_gamelogic::_id_46E5();
}

_id_18E0() {
  self notify("bomber_monitor_no_path");
  self endon("death");
  self endon("disconnect");
  self endon("goal");
  self endon("bomber_monitor_no_path");
  level._id_832F endon("pickup_object");

  for(;;) {
    self waittill("no_path");
    self._id_10F7++;
  }
}

_id_23CF() {
  self endon("new_role");

  if(isDefined(level._id_10F6)) {
    if(level._id_115F == "rush") {
      if(!isDefined(self._id_84E9)) {
        if(!level._id_6510) {
          var_0["nearest_node_to_center"] = level._id_52CB;
          maps\mp\bots\_bots_strategy::_id_1AA6(level._id_52CA, 900, var_0);
          wait(_func_0A5(0.0, 4.0));
          maps\mp\bots\_bots_strategy::_id_19A3();
        }

        self._id_84E9 = 1;
      }

      if(self _meth_837D("strategyLevel") > 0)
        _id_84A4();

      if(_func_0C1(level._id_10F6) && isDefined(level._id_10F6._id_1912))
        var_1 = level._id_10F6._id_1912;
      else if(isDefined(level._id_18D1))
        var_1 = level._id_18D1;
      else
        var_1 = maps\mp\bots\_bots_gametype_common::_id_3B69(level._id_10F6);

      if(!maps\mp\bots\_bots_util::_id_1A2E(var_1._id_28D4)) {
        var_0["min_goal_time"] = 2;
        var_0["max_goal_time"] = 4;
        var_0["override_origin_node"] = common_scripts\utility::random(var_1._id_1B49);
        maps\mp\bots\_bots_strategy::_id_1AA6(var_1._id_28D4, level._id_7790, var_0);
      }
    }
  }
}

_id_2C3B() {
  self endon("new_role");

  if(level._id_18F9 && isDefined(level._id_8330)) {
    if(level._id_115F == "rush")
      _id_2F3A();

    if(!maps\mp\bots\_bots_util::_id_1A2E(level._id_8330.origin)) {
      var_0["score_flags"] = "strongly_avoid_center";
      maps\mp\bots\_bots_strategy::_id_1AA6(level._id_8330.origin, level._id_7790, var_0);
    }
  }
}

_id_18B6() {
  self endon("new_role");

  if(level._id_18D3 || !isDefined(level._id_8330)) {
    return;
  }
  var_0 = _id_3B82();

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = common_scripts\utility::_id_40B0(level._id_8330.origin, var_0._id_1B49);
  var_2 = (level._id_8330.origin[0], level._id_8330.origin[1], var_1[0].origin[2]);

  if(self._id_2CA5 <= 1)
    var_3 = _id_2056(var_2, undefined);
  else {
    self _meth_8358();
    var_3 = self _meth_8356(var_2, 20, "critical");
  }

  if(!var_3) {
    return;
  }
  var_4 = maps\mp\bots\_bots_util::_id_1B21();

  if(var_4 == "bad_path") {
    self._id_2CA5++;

    if(self._id_2CA5 >= 4) {
      for(;;) {
        var_5 = _func_0B9(var_2, 50, 0);
        var_6 = self._id_2CA5 - 4;

        if(var_5.size <= var_6) {
          var_7 = _func_1F2(var_2, 50, self);

          if(isDefined(var_7))
            self _meth_8356(var_7, 20, "critical");
          else
            break;
        } else
          self _meth_8356(var_5[var_6].origin, 20, "critical");

        var_4 = maps\mp\bots\_bots_util::_id_1B21();

        if(var_4 == "bad_path") {
          self._id_2CA5++;
          continue;
        }

        break;
      }
    }
  }

  if(var_4 == "goal") {
    var_8 = _id_4308() - gettime();
    var_9 = var_8 - level._id_2CA9 * 2 * 1000;
    var_10 = gettime() + var_9;

    if(var_9 > 0)
      maps\mp\bots\_bots_util::_id_1B22(var_9);

    var_11 = gettime() >= var_10;
    var_12 = level._id_8330.origin[2] - self.origin[2];
    var_13 = maps\mp\bots\_bots_gametype_common::_id_1911(level._id_2CA9 + 2, "bomb_defused", var_11, var_12 > 40);

    if(!var_13 && self._id_2CA5 >= 4)
      self._id_2CA5++;

    self _meth_8358();
    maps\mp\bots\_bots_strategy::_id_19BC();
  }
}

_id_551A() {
  self endon("new_role");

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  var_0 = maps\mp\bots\_bots_gametype_common::_id_3B69(self);
  self _meth_8357(common_scripts\utility::random(var_0._id_1B49), "critical");
  var_1 = maps\mp\bots\_bots_util::_id_1B21();

  if(var_1 == "goal") {
    wait 2;
    _id_1AD7(self._id_76C6);
  }
}

_id_1ECB() {
  self endon("new_role");

  if(isDefined(level._id_832F._id_2006)) {
    if(self._id_76C6 == "defender")
      self._id_2C75 = maps\mp\bots\_bots_gametype_common::_id_3B69(self);

    _id_1AD7(self._id_76C6);
  } else if(!maps\mp\bots\_bots_util::_id_1A2E(level._id_832F._id_28D4)) {
    var_0["nearest_node_to_center"] = level._id_832F._id_6639;
    maps\mp\bots\_bots_strategy::_id_1AA6(level._id_832F._id_28D4, level._id_7790, var_0);
  }
}

_id_2C7C() {
  self endon("new_role");

  if(!maps\mp\bots\_bots_util::_id_1A2E(self._id_2C75._id_28D4)) {
    var_0["score_flags"] = "strict_los";
    var_0["override_origin_node"] = common_scripts\utility::random(self._id_2C75._id_1B49);
    maps\mp\bots\_bots_strategy::_id_1AA6(self._id_2C75._id_28D4, level._id_7790, var_0);
  }
}

_id_14ED() {
  self endon("new_role");

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  if(!isDefined(self._id_14EC))
    self._id_14EC = "1_move_to_midpoint";

  if(self._id_14EC == "1_move_to_midpoint") {
    var_0 = level._id_1913[0]._id_28D4;
    var_1 = level._id_1913[1]._id_28D4;
    var_2 = ((var_0[0] + var_1[0]) * 0.5, (var_0[1] + var_1[1]) * 0.5, (var_0[2] + var_1[2]) * 0.5);
    var_3 = _func_0B9(var_2, 512, 0);

    if(var_3.size == 0) {
      _id_1AD7("random_killer");
      return;
    }

    var_4 = undefined;
    var_5 = int(var_3.size * (var_3.size + 1) * 0.5);
    var_6 = randomint(var_5);

    for(var_7 = 0; var_7 < var_3.size; var_7++) {
      var_8 = var_3.size - var_7;

      if(var_6 < var_8) {
        var_4 = var_3[var_7];
        break;
      }

      var_6 = var_6 - var_8;
    }

    self _meth_837B("scripted");
    var_9 = self _meth_8357(var_4, "guard");

    if(var_9) {
      var_10 = maps\mp\bots\_bots_util::_id_1B21();

      if(var_10 == "goal") {
        wait(_func_0A5(1.0, 4.0));
        self._id_14EC = "2_move_to_enemy_spawn";
      }
    }
  }

  if(self._id_14EC == "2_move_to_enemy_spawn") {
    var_11 = _id_050D::_id_46A0("allies");
    var_12 = common_scripts\utility::random(var_11);
    self _meth_837B("scripted");
    var_9 = self _meth_8356(var_12.origin, 250, "guard");

    if(var_9) {
      var_10 = maps\mp\bots\_bots_util::_id_1B21();

      if(var_10 == "goal")
        self._id_14EC = "3_move_to_bombzone";
    }
  }

  if(self._id_14EC == "3_move_to_bombzone") {
    if(!isDefined(self._id_1910))
      self._id_1910 = randomint(level._id_1913.size);

    self _meth_837B(undefined);
    var_9 = self _meth_8356(common_scripts\utility::random(level._id_1913[self._id_1910]._id_1B49).origin, 160, "objective");

    if(var_9) {
      var_10 = maps\mp\bots\_bots_util::_id_1B21();

      if(var_10 == "goal") {
        self _meth_8358();
        self._id_14EC = "2_move_to_enemy_spawn";
        self._id_1910 = 1 - self._id_1910;
      }
    }
  }
}

_id_7A3B() {
  self endon("new_role");

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  self[[self._id_6F7F]]();
}

_id_84A4() {
  if(!isDefined(self._id_0CB2)) {
    self _meth_8353("force_sprint", 1);
    self._id_0CB2 = 1;
  }
}

_id_2F3A() {
  if(isDefined(self._id_0CB2)) {
    self _meth_8353("force_sprint", 0);
    self._id_0CB2 = undefined;
  }
}

_id_8578() {
  if(!isDefined(self._id_8311)) {
    self _meth_837B("scripted");
    self._id_8311 = 1;
  }
}

_id_2056(var_0, var_1) {
  var_2 = level._id_1FB1;
  var_3["entrance_points_index"] = var_1;
  maps\mp\bots\_bots_strategy::_id_196A(var_0, var_2, var_3);
  waitframe();

  while(distancesquared(self.origin, var_0) > var_2 * var_2 && maps\mp\bots\_bots_util::_id_1A2D()) {
    if(_id_4308() - gettime() < 20000) {
      _id_8578();
      _id_84A4();
      break;
    }

    waitframe();
  }

  if(maps\mp\bots\_bots_util::_id_1A2D())
    maps\mp\bots\_bots_strategy::_id_19A3();

  return self _meth_8356(var_0, 20, "critical");
}

_id_67F5(var_0) {
  var_1 = maps\mp\bots\_bots_gametype_common::_id_4065(var_0);

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_7ECA))
      var_3 _id_1AD7("investigate_someone_using_bomb");
  }
}

_id_8B7D(var_0) {
  var_1 = 2000;
  var_2 = var_1 * var_1;

  if(var_0) {
    if(_id_4308() - gettime() < 15000)
      return 0;

    var_3 = 0;
    var_4 = common_scripts\utility::_id_416F(self.team);

    foreach(var_6 in level.players) {
      if(!isDefined(var_6.team)) {
        continue;
      }
      if(isalive(var_6) && var_6.team == var_4)
        var_3 = 1;
    }

    return var_3;
  } else
    return distancesquared(self.origin, self._id_19A7) <= var_2 && self _meth_8377();
}

_id_42B6(var_0) {
  var_1 = [];
  var_2 = maps\mp\bots\_bots_gametype_common::_id_41FB(game["defenders"]);

  foreach(var_4 in var_2) {
    if(_func_0C1(var_4) && isDefined(var_4._id_7ECA) && var_4._id_7ECA == "defender") {
      if(isDefined(var_4._id_2C75) && var_4._id_2C75 == var_0)
        var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);

      continue;
    }

    if(distancesquared(var_4.origin, var_0._id_28D4) < level._id_7790 * level._id_7790)
      var_1 = common_scripts\utility::_id_0F6F(var_1, var_4);
  }

  return var_1;
}

_id_3B82() {
  if(isDefined(level._id_99C0)) {
    foreach(var_1 in level._id_1913) {
      if(distancesquared(level._id_99C0.origin, var_1._id_28D4) < 90000)
        return var_1;
    }
  }

  return undefined;
}

_id_4343(var_0) {
  var_0 = "_" + _func_117(var_0);

  for(var_1 = 0; var_1 < level._id_1913.size; var_1++) {
    if(level._id_1913[var_1].label == var_0)
      return level._id_1913[var_1];
  }
}

_id_18E7() {
  self endon("stopped_being_bomb_carrier");
  self endon("new_role");
  common_scripts\utility::_id_A70A("death", "disconnect");
  level._id_10F6 = undefined;
  level._id_5B15 = gettime();

  if(isDefined(self))
    self._id_7ECA = undefined;

  var_0 = maps\mp\bots\_bots_gametype_common::_id_41FB(game["attackers"], 1);
  _id_3DE4(var_0, undefined);
}

_id_18E6() {
  self endon("death");
  self endon("disconnect");
  self endon("stopped_being_bomb_carrier");
  level._id_832F endon("pickup_object");
  level._id_832F waittill("reset");

  if(maps\mp\_utility::_id_566A(self))
    self _meth_8358();

  _id_1AD7("atk_bomber");
}

_id_8532() {
  level._id_10F6 = self;
  _id_1AD7("atk_bomber");
  thread _id_18E7();

  if(!level._id_6510)
    thread _id_18E6();

  if(_func_0C1(self)) {
    maps\mp\bots\_bots_strategy::_id_19B0();

    if(level._id_115F == "rush" && self _meth_837D("strategyLevel") > 0)
      _id_84A4();
  }
}

_id_52E9() {
  if(self.team == game["attackers"]) {
    if(level._id_18F9)
      _id_1AD7("defend_planted_bomb");
    else if(!isDefined(level._id_10F6))
      _id_8532();
    else if(level._id_115F == "rush")
      _id_1AD7("clear_target_zone");
  } else {
    var_0 = _id_42B3("backstabber");
    var_1 = _id_42B3("defender");
    var_2 = level._id_1A92[self._id_6F7D];
    var_3 = self _meth_837D("strategyLevel");

    if(var_2 == "active") {
      if(!isDefined(self._id_7ECA) && level._id_0C10 && var_3 > 0) {
        if(var_0.size == 0)
          _id_1AD7("backstabber");
        else {
          var_4 = 1;

          foreach(var_6 in var_0) {
            var_7 = level._id_1A92[var_6._id_6F7D];

            if(var_7 == "active") {
              var_4 = 0;
              break;
            }
          }

          if(var_4) {
            _id_1AD7("backstabber");
            var_0[0] _id_1AD7(undefined);
          }
        }
      }

      if(!isDefined(self._id_7ECA)) {
        if(var_1.size < 4)
          _id_1AD7("defender");
      }

      if(!isDefined(self._id_7ECA)) {
        var_9 = randomint(4);

        if(var_9 == 3 && level._id_0C18 && var_3 > 0)
          _id_1AD7("random_killer");
        else if(var_9 == 2 && level._id_0C10 && var_3 > 0)
          _id_1AD7("backstabber");
        else
          _id_1AD7("defender");
      }
    } else if(var_2 == "stationary") {
      if(!isDefined(self._id_7ECA)) {
        if(var_1.size < 4)
          _id_1AD7("defender");
        else {
          foreach(var_11 in var_1) {
            var_12 = level._id_1A92[var_11._id_6F7D];

            if(var_12 == "active") {
              _id_1AD7("defender");
              var_11 _id_1AD7(undefined);
              break;
            }
          }
        }
      }

      if(!isDefined(self._id_7ECA) && level._id_0C10 && var_3 > 0) {
        if(var_0.size == 0)
          _id_1AD7("backstabber");
      }

      if(!isDefined(self._id_7ECA))
        _id_1AD7("defender");
    }

    if(self._id_7ECA == "defender") {
      var_14 = level._id_1913;

      if(_id_4B38(self.team))
        var_14 = _id_427A(self.team);

      if(var_14.size == 1)
        self._id_2C75 = var_14[0];
      else {
        var_15 = _id_42B6(var_14[0]);
        var_16 = _id_42B6(var_14[1]);

        if(var_15.size < var_16.size)
          self._id_2C75 = var_14[0];
        else if(var_16.size < var_15.size)
          self._id_2C75 = var_14[1];
        else
          self._id_2C75 = common_scripts\utility::random(var_14);
      }
    }
  }
}

_id_1AD7(var_0) {
  if(_func_0C1(self)) {
    maps\mp\bots\_bots_strategy::_id_19A3();
    self _meth_837B(undefined);
  }

  self._id_76C6 = self._id_7ECA;
  self._id_7ECA = var_0;
  self notify("new_role");
}

_id_1AD8(var_0, var_1) {
  self endon("death");
  self endon("disconnect");
  self endon("new_role");
  wait(var_1);
  _id_1AD7(var_0);
}

_id_3DE4(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    if(isDefined(var_2)) {
      var_4 thread _id_1AD8(var_1, _func_0A5(0.0, var_2));
      continue;
    }

    var_4 thread _id_1AD7(var_1);
  }
}

_id_427A(var_0) {
  return level._id_1ABE[var_0];
}

_id_4B38(var_0) {
  var_1 = _id_427A(var_0);
  return var_1.size > 0;
}

_id_42B3(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_6E97) {
    if(isalive(var_3) && maps\mp\_utility::_id_5800(var_3) && isDefined(var_3._id_7ECA) && var_3._id_7ECA == var_0)
      var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_1ABD() {
  level notify("bot_sd_ai_director_update");
  level endon("bot_sd_ai_director_update");
  level endon("game_ended");
  level._id_0C10 = randomint(3) <= 1;
  level._id_0C18 = randomint(3) <= 1;
  level._id_115F = "rush";
  level._id_7790 = 725;
  level._id_1FB1 = 140;

  for(;;) {
    if(isDefined(level._id_832F) && isDefined(level._id_832F._id_2006) && !_func_0C1(level._id_832F._id_2006))
      level._id_18D1 = maps\mp\bots\_bots_gametype_common::_id_3B69(level._id_832F._id_2006);

    var_0 = 0;

    if(!level._id_18F9) {
      var_1 = maps\mp\bots\_bots_gametype_common::_id_41FB(game["attackers"]);

      foreach(var_3 in var_1) {
        if(var_3._id_568D) {
          level._id_1F1B = gettime();

          if(!isDefined(level._id_10F6) || var_3 != level._id_10F6) {
            if(isDefined(level._id_10F6) && isalive(level._id_10F6)) {
              level._id_10F6 _id_1AD7(undefined);
              level._id_10F6 notify("stopped_being_bomb_carrier");
            }

            var_0 = 1;
            var_3 _id_8532();
          }
        }
      }

      if(!level._id_6510 && !isDefined(level._id_832F._id_2006)) {
        var_5 = _func_0BA(level._id_832F._id_28D4);

        if(isDefined(var_5)) {
          level._id_832F._id_6639 = var_5;
          var_6 = 0;
          var_7 = maps\mp\bots\_bots_gametype_common::_id_41FB(game["defenders"], 1);

          foreach(var_9 in var_7) {
            var_10 = var_9 _meth_838A();
            var_11 = var_9 _meth_837D("strategyLevel");

            if(var_11 > 0 && var_9._id_7ECA != "camp_bomb" && isDefined(var_10) && _func_1F4(var_5, var_10, 1)) {
              var_12 = var_9 _meth_8375();

              if(common_scripts\utility::within_fov(var_9.origin, var_9 getplayerangles(), level._id_832F._id_28D4, var_12)) {
                if(var_11 >= 2 || distancesquared(var_9.origin, level._id_832F._id_28D4) < _func_0DA(700)) {
                  var_6 = 1;
                  break;
                }
              }
            }
          }

          if(var_6) {
            foreach(var_9 in var_7) {
              if(var_9._id_7ECA != "camp_bomb" && var_9 _meth_837D("strategyLevel") > 0)
                var_9 _id_1AD7("camp_bomb");
            }
          }
        }
      }

      var_16 = level._id_1913;

      if(_id_4B38(game["defenders"]))
        var_16 = _id_427A(game["defenders"]);

      for(var_17 = 0; var_17 < var_16.size; var_17++) {
        for(var_18 = 0; var_18 < var_16.size; var_18++) {
          var_19 = _id_42B6(var_16[var_17]);
          var_20 = _id_42B6(var_16[var_18]);

          if(var_19.size > var_20.size + 1) {
            var_21 = [];

            foreach(var_3 in var_19) {
              if(_func_0C1(var_3))
                var_21 = common_scripts\utility::_id_0F6F(var_21, var_3);
            }

            if(var_21.size > 0) {
              var_24 = common_scripts\utility::random(var_21);
              var_24 maps\mp\bots\_bots_strategy::_id_19A3();
              var_24._id_2C75 = var_16[var_18];
            }
          }
        }
      }
    } else {
      if(isDefined(level._id_10F6))
        level._id_10F6 = undefined;

      if(!isDefined(level._id_18B5) || !isalive(level._id_18B5)) {
        var_25 = [];
        var_26 = _id_42B3("defender");
        var_27 = _id_42B3("backstabber");
        var_28 = _id_42B3("random_killer");

        if(var_26.size > 0)
          var_25 = var_26;
        else if(var_27.size > 0)
          var_25 = var_27;
        else if(var_28.size > 0)
          var_25 = var_28;

        if(var_25.size > 0 && isDefined(level._id_8330)) {
          var_29 = common_scripts\utility::_id_40B0(level._id_8330.origin, var_25);
          level._id_18B5 = var_29[0];
          level._id_18B5 _id_1AD7("defuser");
          level._id_18B5 maps\mp\bots\_bots_strategy::_id_19B0();
          level._id_18B5 thread _id_2CA6();
        }
      }

      if(!isDefined(level._id_8327)) {
        level._id_8327 = 1;
        var_30 = maps\mp\bots\_bots_gametype_common::_id_41FB(game["attackers"]);

        foreach(var_3 in var_30) {
          if(isDefined(var_3._id_7ECA)) {
            if(var_3._id_7ECA == "atk_bomber") {
              var_3 thread _id_1AD7(undefined);
              continue;
            }

            if(var_3._id_7ECA != "defend_planted_bomb")
              var_3 thread _id_1AD8("defend_planted_bomb", _func_0A5(0.0, 3.0));
          }
        }
      }
    }

    wait 0.5;
  }
}

_id_2CA6() {
  common_scripts\utility::_id_A70A("death", "disconnect");
  level._id_18B5 = undefined;
}