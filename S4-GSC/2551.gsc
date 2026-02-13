/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2551.gsc
*************************************************/

_id_D7FB() {
  level._id_2882 = [];
  level._id_2883 = [];
  level._id_2882["active"][0] = "run_and_gun";
  level._id_2882["active"][1] = "cqb";
  level._id_2882["stationary"][0] = "camper";
  level._id_2884 = [];

  foreach(var_5, var_1 in level._id_2882) {
    foreach(var_3 in var_1) {
      level._id_2884[var_3] = var_5;
      level._id_2883[level._id_2883.size] = var_3;
    }
  }

  level._id_2885 = [];
  level._id_2885["active"] = 4;
  level._id_2885["stationary"] = 1;
  level._id_2880 = [];
  level._id_2880["run_and_gun"] = ::_id_804E;
  level._id_2880["camper"] = ::_id_804D;
  level._id_2881["run_and_gun"] = ::_id_FBA9;
  level._id_2881["camper"] = ::_id_FBA8;
}

_id_2701() {
  self._id_B023 = self _meth_803A();
  self.pers["personality"] = self._id_B023;
  self._id_B024 = level._id_2880[self._id_B023];

  if(!isDefined(self._id_B024)) {
    self._id_B024 = level._id_2880["run_and_gun"];
  }

  self[[self._id_B024]]();
  self._id_B025 = level._id_2881[self._id_B023];

  if(!isDefined(self._id_B025)) {
    self._id_B025 = level._id_2881["run_and_gun"];
  }
}

_id_2705() {
  if(isDefined(self._id_B026) && self._id_B026) {
    return;
  }
  if(isDefined(self.pers["personality"])) {
    self _meth_8056(self.pers["personality"]);
    return;
  }

  var_0 = self.team;

  if(!isDefined(var_0) && !isDefined(self._id_28F7)) {
    var_0 = self.pers["team"];
  }

  var_1 = getarraykeys(level._id_2885);
  var_2 = [];
  var_3 = [];

  foreach(var_9, var_5 in level._id_2882) {
    var_3[var_9] = 0;

    foreach(var_7 in var_5) {
      var_2[var_7] = 0;
    }
  }

  foreach(var_11 in level._id_AE7C) {
    if(var_11 == self) {
      continue;
    }
    if(!scripts\mp\utility\entity::_id_8A94(var_11) || !isDefined(var_11._id_74DA)) {
      continue;
    }
    if(isDefined(var_11.team) && var_11.team == var_0 || !level.teambased) {
      var_7 = var_11 _meth_803A();
      var_9 = level._id_2884[var_7];
      var_2[var_7] = var_2[var_7] + 1;
      var_3[var_9] = var_3[var_9] + 1;
    }
  }

  var_13 = [];

  foreach(var_15 in var_1) {
    var_13[var_15] = int(var_3[var_15] / level._id_2885[var_15]);
  }

  var_17 = undefined;

  for(var_18 = 0; var_18 < var_1.size && !isDefined(var_17); var_18++) {
    var_19 = var_1[var_18];
    var_20 = 1;

    for(var_21 = 0; var_21 < var_1.size; var_21++) {
      var_22 = var_1[var_21];

      if(var_19 != var_22) {
        if(var_13[var_19] >= var_13[var_22]) {
          var_20 = 0;
        }
      }
    }

    if(var_20) {
      var_17 = var_19;
    }
  }

  if(!isDefined(var_17)) {
    var_23 = [];

    foreach(var_15 in var_1) {
      var_23[var_15] = level._id_2885[var_15] - var_3[var_15] % level._id_2885[var_15];
    }

    var_26 = 0;

    foreach(var_15 in var_1) {
      var_26 = var_26 + var_23[var_15];
    }

    var_29 = randomfloat(var_26);

    foreach(var_15 in var_1) {
      if(var_29 < var_23[var_15]) {
        var_17 = var_15;
        break;
      }

      var_29 = var_29 - var_23[var_15];
    }
  }

  var_32 = undefined;
  var_33 = undefined;
  var_34 = 9999;
  var_35 = undefined;
  var_36 = -9999;
  var_37 = scripts\engine\utility::array_randomize(level._id_2882[var_17]);

  foreach(var_7 in var_37) {
    if(var_2[var_7] < var_34) {
      var_33 = var_7;
      var_34 = var_2[var_7];
    }

    if(var_2[var_7] > var_36) {
      var_35 = var_7;
      var_36 = var_2[var_7];
    }
  }

  if(var_36 - var_34 >= 2) {
    var_32 = var_33;
  } else {
    var_32 = scripts\engine\utility::random(level._id_2882[var_17]);
  }

  if(self _meth_803A() != var_32) {
    self _meth_8056(var_32);
  }

  self._id_74DA = 1;
}

_id_804D() {
  _id_38BF();
}

_id_804E() {
  _id_38BF();
}

_id_FBA8() {
  if(scripts\engine\utility::is_equal(level.gametype, "base")) {
    return;
  }
  if(_id_DACD() && !scripts\mp\bots\bots_util::_id_2805() && !scripts\mp\bots\bots_util::_id_280F()) {
    var_0 = self _meth_803E();
    var_1 = 0;

    if(!isDefined(self._id_30AD)) {
      self._id_30AD = 0;
    }

    var_2 = var_0 == "hunt";
    var_3 = gettime() > self._id_30AD + 10000;

    if((!var_2 || var_3) && !scripts\mp\bots\bots_util::_id_2877()) {
      if(!self _meth_8042()) {
        _id_289F();
      }

      if(isDefined(level._id_AD3C)) {
        var_1 = [[level._id_AD3C]]();
      }

      if(!var_1) {
        var_1 = _id_5AB8();

        if(!var_1) {
          self._id_30AD = gettime();
        }
      }
    }

    if(isDefined(var_1) && var_1) {
      self._id_169C = scripts\mp\bots\bots_util::_id_289B("bot_find_ambush_entrances", ::_id_278C, self._id_A54D, 1);
      var_4 = _id_09F9::_id_27B6("trap_directional", "trap", "c4");

      if(isDefined(var_4)) {
        var_5 = gettime();
        _id_09F9::_id_28C1(var_4, self._id_169C, self._id_A54D, self._id_16CA);
        var_5 = gettime() - var_5;

        if(var_5 > 0 && isDefined(self._id_1697) && isDefined(self._id_A54D)) {
          self._id_1697 = self._id_1697 + var_5;
          self._id_A54D._id_26FE = self._id_1697 + 10000;
        }
      }

      if(!_id_09F9::_id_27ED() && !scripts\mp\bots\bots_util::_id_2805() && isDefined(self._id_A54D)) {
        var_6 = self _meth_8059(self._id_A54D, "camp", self._id_16CA);

        if(var_6) {
          thread _id_3901("bad_path", "node_relinquished", "out_of_ammo");
          thread _id_10A7C();
          thread _id_26F1("clear_camper_data", "goal");
          thread _id_2920("clear_camper_data", "bot_add_ambush_time_delayed", self._id_169C, self._id_16CA);
          childthread _id_290A("clear_camper_data", "goal");
          return;
        }

        _id_38BF();
        return;
        return;
      }
    } else {
      if(var_0 == "camp") {
        self _meth_802B();
      }

      _id_FBA9();
    }
  }
}

_id_FBA9() {
  var_0 = undefined;
  var_1 = self _meth_8042();

  if(var_1) {
    var_0 = self _meth_803B();
  }

  if(gettime() - self._id_904F > 5000) {
    _id_290A();
  }

  if(!_id_09F9::_id_27ED() && !scripts\mp\bots\bots_util::_id_280F()) {
    var_2 = undefined;
    var_3 = undefined;

    if(var_1) {
      var_2 = distancesquared(self.origin, var_0);
      var_3 = self _meth_803D();
      var_4 = var_3 * 2;

      if(isDefined(self._id_2856) && var_2 < var_4 * var_4) {
        var_5 = _func_0027("investigated");
        _func_001F(0, gettime() - self._id_2857, 1, self._id_2856, var_4, "kill", var_5, self);
        _func_001F(0, gettime() - self._id_2857, 1, self._id_2856, var_4, "death", var_5, self);
        self._id_2856 = undefined;
        self._id_2857 = undefined;
      }
    }

    if(!var_1 || var_2 < var_3 * var_3) {
      var_6 = _id_289F();
      var_7 = undefined;
      var_8 = undefined;

      if(var_6) {
        var_7 = self _meth_803B();
        var_8 = self _meth_803E();
      }

      var_9 = 25;

      if(istrue(self._id_5283)) {
        var_9 = 50;
      }

      if(var_6 && randomfloat(100) < var_9) {
        var_10 = _id_09F9::_id_27B6("trap_directional", "trap");

        if(isDefined(var_10)) {
          var_11 = self _meth_803B();

          if(isDefined(var_11)) {
            var_12 = _func_0080(var_11);

            if(isDefined(var_12) && _func_00A6(var_12).size > 0) {
              var_13 = _id_278C(var_12, 0);
              var_14 = _id_09F9::_id_28C1(var_10, var_13, var_12);

              if(!isDefined(var_14) || var_14) {
                self _meth_802B();
                var_6 = _id_289F();

                if(var_6) {
                  var_7 = self _meth_803B();
                  var_8 = self _meth_803E();
                }
              }
            }
          }
        }
      }

      if(var_6 && self _meth_8042()) {
        var_15 = self _meth_803B();
        var_16 = self _meth_803E();
        var_17 = scripts\mp\bots\bots_util::_id_2916(var_7, var_15);
        var_18 = var_8 == var_16;

        if(var_17 && var_18) {
          thread _id_3901("enemy", "bad_path", "goal", "node_relinquished", "search_end");
        }
      }
    }
  }
}

_id_290A(var_0, var_1) {}

_id_3901(var_0, var_1, var_2, var_3, var_4) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death_or_disconnect");
  self endon("start_tactical_goal");
  var_5 = self _meth_803B();
  var_6 = 1;

  while(var_6) {
    var_7 = scripts\engine\utility::_id_1089B(var_0, var_1, var_2, var_3, var_4, "script_goal_changed");
    var_6 = 0;
    var_8 = 1;

    if(var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed") {
      if(!self _meth_8042()) {
        var_8 = 0;
      } else {
        var_9 = self _meth_803B();
        var_8 = scripts\mp\bots\bots_util::_id_2916(var_5, var_9);
      }
    }

    if(var_7 == "enemy" && isDefined(self._id_0192)) {
      var_8 = 0;
      var_6 = 1;
    }

    if(var_8) {
      self _meth_802B();
    }
  }
}

_id_10A7C() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death_or_disconnect");

  while(!scripts\mp\bots\bots_util::_id_2877()) {
    wait 0.5;
  }

  self notify("out_of_ammo");
}

_id_26F1(var_0, var_1) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death_or_disconnect");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var_2 = gettime();

  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  if(isDefined(self._id_1697) && isDefined(self._id_A54D)) {
    self._id_1697 = self._id_1697 + (gettime() - var_2);
    self._id_A54D._id_26FE = self._id_1697 + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

_id_2920(var_0, var_1, var_2, var_3) {
  self notify("bot_watch_entrances_delayed");

  if(var_2.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death_or_disconnect");
    self endon(var_0);
    self endon("node_relinquished");
    self endon("bad_path");

    if(isDefined(var_1)) {
      self waittill(var_1);
    }

    self endon("path_enemy");
    childthread scripts\mp\bots\bots_util::_id_2925(var_2, var_3, 0, self._id_1697);
    childthread _id_285E();
  }
}

_id_285E() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("death_or_disconnect");

  while(!isDefined(self._id_10A77)) {
    wait 0.05;
  }

  while(isDefined(self._id_10A77)) {
    foreach(var_1 in self._id_10A77) {
      var_1._id_10A75[self._id_5501] = var_1._id_10A74[self._id_5501];
    }

    _id_09F9::_id_BD26(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

_id_278C(var_0, var_1) {
  self endon("disconnect");
  var_2 = [];
  var_3 = _func_0066(var_0.origin);

  if(isDefined(var_3) && var_3.size > 0) {
    wait 0.05;
    var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";

    if(var_4 && var_1) {
      var_3 = self _meth_804B(var_3, "node_exposure_vis", var_0.origin, "crouch");
    }

    foreach(var_6 in var_3) {
      if(distancesquared(self.origin, var_6.origin) < 90000) {
        continue;
      }
      if(var_4 && var_1) {
        wait 0.05;

        if(!scripts\mp\bots\bots_util::_id_5520(var_6.origin, var_0.origin, "crouch")) {
          continue;
        }
      }

      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_278A(var_0) {
  var_1 = [];
  var_2 = gettime();
  var_3 = var_0.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0[var_4];

    if(!isDefined(var_5._id_26FE) || var_2 > var_5._id_26FE) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

_id_278B(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = var_2 * var_2;

  if(level.teambased) {
    foreach(var_7 in level._id_AE7C) {
      if(!var_7 scripts\cp_mp\utility\player_utility::_isalive()) {
        continue;
      }
      if(!isDefined(var_7.team)) {
        continue;
      }
      if(var_7.team == var_1.team && var_7 != var_1 && isDefined(var_7._id_A54D)) {
        var_4[var_4.size] = var_7._id_A54D.origin;
      }
    }
  }

  var_9 = var_4.size;
  var_10 = var_0.size;

  for(var_11 = 0; var_11 < var_10; var_11++) {
    var_12 = 0;
    var_13 = var_0[var_11];

    for(var_14 = 0; !var_12 && var_14 < var_9; var_14++) {
      var_15 = distancesquared(var_4[var_14], var_13.origin);
      var_12 = var_15 < var_5;
    }

    if(!var_12) {
      var_3[var_3.size] = var_13;
    }
  }

  return var_3;
}

_id_38BF() {
  self notify("clear_camper_data");

  if(isDefined(self._id_A54D) && isDefined(self._id_A54D._id_26FE)) {
    self._id_A54D._id_26FE = undefined;
  }

  self._id_A54D = undefined;
  self._id_B9B2 = undefined;
  self._id_16CA = undefined;
  self._id_169C = undefined;
  self._id_1696 = randomintrange(20000, 30000);
  self._id_1697 = -1;
}

_id_DACD() {
  if(_id_09F9::_id_27ED()) {
    return 0;
  }

  if(gettime() > self._id_1697) {
    return 1;
  }

  if(!self _meth_8042()) {
    return 1;
  }

  return 0;
}

_id_5AB8() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return scripts\mp\bots\bots_util::_id_289B("find_camp_node_worker", ::_id_5AB9);
}

_id_5AB9() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_38BF();

  if(level._id_110E1 <= 0) {
    return 0;
  }

  var_0 = _func_00F5(self.origin);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self getplayerangles();

  if(isDefined(var_0)) {
    var_4 = _func_002B(var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);

    if(!isDefined(var_4)) {
      var_4 = _func_002B(var_0, self.team, -1, "enemy_predict", ">", 0);
    }

    if(isDefined(var_4)) {
      var_5 = _func_00F6(var_4);
      var_6 = _func_00A6(var_5);

      if(var_6.size == 0) {
        var_4 = undefined;
      }
    }

    if(!isDefined(var_4)) {
      var_7 = -1;
      var_8 = -1;

      for(var_9 = 0; var_9 < level._id_110E1; var_9++) {
        var_5 = _func_00F6(var_9);
        var_6 = _func_00A6(var_5);

        if(var_6.size > 0) {
          var_10 = scripts\engine\utility::random(_func_00F7(var_9));
          var_11 = isDefined(var_10._id_0481) && var_10._id_0481 == "no_bot_random_path";

          if(!var_11) {
            var_12 = distance2dsquared(_func_00F9(var_9), self.origin);

            if(var_12 > var_7) {
              var_7 = var_12;
              var_8 = var_9;
            }
          }
        }
      }

      var_4 = var_8;
    }

    var_13 = _func_00FA(var_0, var_4);

    if(!isDefined(var_13) || var_13.size == 0) {
      return 0;
    }

    for(var_14 = 0; var_14 <= int(var_13.size / 2); var_14++) {
      var_1 = var_13[var_14];
      var_2 = var_13[int(min(var_14 + 1, var_13.size - 1))];

      if(_func_0029(var_2, self.team, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(var_1) && isDefined(var_2) && var_1 != var_2) {
      var_3 = _func_00F9(var_2) - _func_00F9(var_1);
      var_3 = vectortoangles(var_3);
    }
  }

  var_15 = undefined;

  if(isDefined(var_1)) {
    var_16 = 1;
    var_17 = 1;
    var_18 = 0;

    while(var_16) {
      var_19 = _func_00F8(var_1, 800 * var_17, 1);

      if(var_19.size > 1024) {
        var_19 = _func_00F7(var_1, 0);
      }

      wait 0.05;
      var_20 = randomint(100);

      if(var_20 < 66 && var_20 >= 33) {
        var_3 = (var_3[0], var_3[1] + 45, 0);
      } else if(var_20 < 33) {
        var_3 = (var_3[0], var_3[1] - 45, 0);
      }

      if(var_19.size > 0) {
        while(var_19.size > 1024) {
          var_19[var_19.size - 1] = undefined;
        }

        var_21 = int(clamp(var_19.size * 0.15, 1, 10));

        if(var_18) {
          var_19 = self _meth_804A(var_19, var_21, var_21, "node_camp", anglesToForward(var_3), "lenient");
        } else {
          var_19 = self _meth_804A(var_19, var_21, var_21, "node_camp", anglesToForward(var_3));
        }

        var_19 = _id_278A(var_19);

        if(!isDefined(self._id_30BD) || !self._id_30BD) {
          var_22 = 800;
          var_19 = _id_278B(var_19, self, var_22);
        }

        if(var_19.size > 0) {
          var_15 = scripts\engine\utility::_id_BFF2(var_19);
        }
      }

      if(isDefined(var_15)) {
        var_16 = 0;
      } else if(isDefined(self._id_30AF)) {
        if(var_17 == 1 && !var_18) {
          var_17 = 3;
        } else if(var_17 == 3 && !var_18) {
          var_18 = 1;
        } else if(var_17 == 3 && var_18) {
          var_16 = 0;
        }
      } else
        var_16 = 0;

      if(var_16) {
        wait 0.05;
      }
    }
  }

  if(!isDefined(var_15) || !self _meth_8048(var_15)) {
    return 0;
  }

  self._id_A54D = var_15;
  self._id_1697 = gettime() + self._id_1696;
  self._id_A54D._id_26FE = self._id_1697;
  self._id_16CA = var_3[1];
  return 1;
}

_id_5AB1(var_0, var_1) {
  _id_38BF();

  if(isDefined(var_0)) {
    self._id_B9B2 = var_0;
  } else {
    var_2 = undefined;
    var_3 = _func_00B4(self.origin, 5000, 0, 2000);

    if(var_3.size > 0) {
      var_2 = self _meth_8049(var_3, var_3.size * 0.25, "node_traffic");
    }

    if(isDefined(var_2)) {
      self._id_B9B2 = var_2.origin;
    } else {
      return 0;
    }
  }

  var_4 = 2000;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = _func_00B4(self._id_B9B2, var_4, 0, 1000);
  var_6 = undefined;

  if(var_5.size > 0) {
    var_7 = int(max(1, int(var_5.size * 0.15)));
    var_5 = self _meth_804A(var_5, var_7, var_7, "node_ambush", self._id_B9B2);
  }

  var_5 = _id_278A(var_5);

  if(var_5.size > 0) {
    var_6 = scripts\engine\utility::_id_BFF2(var_5);
  }

  if(!isDefined(var_6) || !self _meth_8048(var_6)) {
    return 0;
  }

  self._id_A54D = var_6;
  self._id_1697 = gettime() + self._id_1696;
  self._id_A54D._id_26FE = self._id_1697;
  var_8 = vectornormalize(self._id_B9B2 - self._id_A54D.origin);
  var_9 = vectortoangles(var_8);
  self._id_16CA = var_9[1];
  return 1;
}

_id_289F() {
  if(scripts\mp\bots\bots_util::_id_280F()) {
    return 0;
  }

  return self[[level._id_28A1]]();
}

_id_28A0() {
  var_0 = 0;
  var_1 = self _meth_8030("chanceToSeekOutKiller") * 100;

  if(self._id_B023 == "camper") {
    var_1 = 0;
  }

  var_2 = undefined;

  if(randomint(100) < var_1) {
    var_2 = scripts\mp\bots\bots_util::_id_28A4();
  }

  if(!isDefined(var_2)) {
    var_2 = self _meth_802C();
  }

  if(isDefined(var_2)) {
    var_0 = self _meth_8058(var_2, 128, "hunt");
  }

  return var_0;
}

_id_28CE() {
  if(_id_09F6::_id_28CF()) {
    return "callback";
  } else {
    return "class0";
  }
}