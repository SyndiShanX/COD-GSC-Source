/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\bots\_bots_personality.gsc
**********************************************/

func_897D() {
  level.var_1A90 = [];
  level.var_1A91 = [];
  level.var_1A90["active"][0] = "default";
  level.var_1A90["active"][1] = "run_and_gun";
  level.var_1A90["active"][2] = "cqb";
  level.var_1A90["stationary"][0] = "camper";
  level.var_1A92 = [];
  foreach(var_05, var_01 in level.var_1A90) {
    foreach(var_03 in var_01) {
      level.var_1A92[var_03] = var_05;
      level.var_1A91[level.var_1A91.size] = var_03;
    }
  }

  level.var_1A93 = [];
  level.var_1A93["active"] = 4;
  level.var_1A93["stationary"] = 1;
  level.var_1A8E = [];
  level.var_1A8E["default"] = ::func_523C;
  level.var_1A8E["camper"] = ::func_523B;
  level.var_1A8F["default"] = ::func_A0C0;
  level.var_1A8F["camper"] = ::func_A0BF;
}

func_1939() {
  self.var_6F7D = self method_8368();
  self.var_012C["personality"] = self.var_6F7D;
  self.var_6F7E = level.var_1A8E[self.var_6F7D];
  if(!isDefined(self.var_6F7E)) {
    self.var_6F7E = level.var_1A8E["default"];
  }

  self[[self.var_6F7E]]();
  self.var_6F7F = level.var_1A8F[self.var_6F7D];
  if(!isDefined(self.var_6F7F)) {
    self.var_6F7F = level.var_1A8F["default"];
  }
}

func_193F() {
  if(isDefined(self.var_6F80) && self.var_6F80) {
    return;
  }

  if(isDefined(self.var_012C["personality"])) {
    self botsetpersonality(self.var_012C["personality"]);
    return;
  }

  var_00 = self.var_01A7;
  if(!isDefined(var_00) && !isDefined(self.var_1AFA)) {
    var_00 = self.var_012C["team"];
  }

  var_01 = getarraykeys(level.var_1A93);
  var_02 = [];
  var_03 = [];
  foreach(var_09, var_05 in level.var_1A90) {
    var_03[var_09] = 0;
    foreach(var_07 in var_05) {
      var_02[var_07] = 0;
    }
  }

  foreach(var_0B in level.var_6E97) {
    if(var_0B == self) {
      continue;
    }

    if(!maps\mp\_utility::func_5800(var_0B) || !isDefined(var_0B.var_4B22)) {
      continue;
    }

    if((isDefined(var_0B.var_01A7) && var_0B.var_01A7 == var_00) || !level.var_984D) {
      var_07 = var_0B method_8368();
      var_09 = level.var_1A92[var_07];
      var_02[var_07] = var_02[var_07] + 1;
      var_03[var_09] = var_03[var_09] + 1;
    }
  }

  var_0D = [];
  foreach(var_0F in var_01) {
    var_0D[var_0F] = int(var_03[var_0F] / level.var_1A93[var_0F]);
  }

  var_11 = undefined;
  for(var_12 = 0; var_12 < var_01.size && !isDefined(var_11); var_12++) {
    var_13 = var_01[var_12];
    var_14 = 1;
    for(var_15 = 0; var_15 < var_01.size; var_15++) {
      var_16 = var_01[var_15];
      if(var_13 != var_16) {
        if(var_0D[var_13] >= var_0D[var_16]) {
          var_14 = 0;
        }
      }
    }

    if(var_14) {
      var_11 = var_13;
    }
  }

  if(!isDefined(var_11)) {
    var_17 = [];
    foreach(var_0F in var_01) {
      var_17[var_0F] = level.var_1A93[var_0F] - var_03[var_0F] % level.var_1A93[var_0F];
    }

    var_1A = 0;
    foreach(var_0F in var_01) {
      var_1A = var_1A + var_17[var_0F];
    }

    var_1D = randomfloat(var_1A);
    foreach(var_0F in var_01) {
      if(var_1D < var_17[var_0F]) {
        var_11 = var_0F;
        break;
      }

      var_1D = var_1D - var_17[var_0F];
    }
  }

  var_20 = undefined;
  var_21 = undefined;
  var_22 = 9999;
  var_23 = undefined;
  var_24 = -9999;
  var_25 = common_scripts\utility::func_0F92(level.var_1A90[var_11]);
  foreach(var_07 in var_25) {
    if(var_02[var_07] < var_22) {
      var_21 = var_07;
      var_22 = var_02[var_07];
    }

    if(var_02[var_07] > var_24) {
      var_23 = var_07;
      var_24 = var_02[var_07];
    }
  }

  if(var_24 - var_22 >= 2) {
    var_20 = var_21;
  } else {
    var_20 = common_scripts\utility::func_7A33(level.var_1A90[var_11]);
  }

  if(self method_8368() != var_20) {
    self botsetpersonality(var_20);
  }

  self.var_4B22 = 1;
}

func_523B() {
  func_23AB();
}

func_523C() {
  func_23AB();
}

func_A0BF() {
  if(func_8B73() && !maps\mp\bots\_bots_util::func_1A2D() && !maps\mp\bots\_bots_util::func_1A36()) {
    var_00 = self method_835F();
    var_01 = 0;
    if(!isDefined(self.var_1F00)) {
      self.var_1F00 = 0;
    }

    var_02 = var_00 == "hunt";
    var_03 = gettime() > self.var_1F00 + 10000;
    if((!var_02 || var_03) && !maps\mp\bots\_bots_util::func_1A8B()) {
      if(!self method_8367()) {
        func_1AAE();
      }

      if(isDefined(level.var_6CBF)) {
        var_01 = [[level.var_6CBF]]();
      }

      if(!var_01) {
        var_01 = func_3B67();
        if(!var_01) {
          self.var_1F00 = gettime();
        }
      }
    }

    if(isDefined(var_01) && var_01) {
      self.var_0D41 = maps\mp\bots\_bots_util::func_1AA8("bot_find_ambush_entrances", ::func_19C8, self.var_6708, 1);
      var_04 = maps\mp\bots\_bots_strategy::func_19ED("trap_directional", "trap", "c4");
      if(isDefined(var_04)) {
        var_05 = gettime();
        maps\mp\bots\_bots_strategy::func_1AD0(var_04, self.var_0D41, self.var_6708, self.var_0D94);
        var_05 = gettime() - var_05;
        if(var_05 > 0 && isDefined(self.var_0D39) && isDefined(self.var_6708)) {
          self.var_0D39 = self.var_0D39 + var_05;
          self.var_6708.var_1938 = self.var_0D39 + 10000;
        }
      }

      if(!maps\mp\bots\_bots_strategy::func_1A14() && !maps\mp\bots\_bots_util::func_1A2D() && isDefined(self.var_6708)) {
        self botsetscriptgoalnode(self.var_6708, "camp", self.var_0D94);
        thread func_23CA("bad_path", "node_relinquished", "out_of_ammo");
        thread func_A8CF();
        thread func_192D("clear_camper_data", "goal");
        thread func_1B27("clear_camper_data", "bot_add_ambush_time_delayed", self.var_0D41, self.var_0D94);
        childthread func_1B0A("clear_camper_data", "goal");
        return;
      }

      return;
    }

    if(var_00 == "camp") {
      self method_8358();
    }

    func_A0C0();
  }
}

func_A0C0() {
  var_00 = undefined;
  var_01 = self method_8367();
  if(var_01) {
    var_00 = self method_835C();
  }

  if(gettime() - self.var_5BE2 > 5000) {
    func_1B0A();
  }

  if(!maps\mp\bots\_bots_strategy::func_1A14() && !maps\mp\bots\_bots_util::func_1A36()) {
    var_02 = undefined;
    var_03 = undefined;
    if(var_01) {
      var_02 = distancesquared(self.var_0116, var_00);
      var_03 = self method_835D();
      var_04 = var_03 * 2;
      if(isDefined(self.var_1A7B) && var_02 < var_04 * var_04) {
        var_05 = botmemoryflags("investigated");
        botflagmemoryevents(0, gettime() - self.var_1A7C, 1, self.var_1A7B, var_04, "kill", var_05, self);
        botflagmemoryevents(0, gettime() - self.var_1A7C, 1, self.var_1A7B, var_04, "death", var_05, self);
        self.var_1A7B = undefined;
        self.var_1A7C = undefined;
      }
    }

    if(!var_01 || var_02 < var_03 * var_03) {
      var_06 = func_1AAE();
      var_07 = 25;
      if(common_scripts\utility::func_562E(self.var_366C)) {
        var_07 = 50;
      }

      if(var_06 && randomfloat(100) < var_07) {
        var_08 = maps\mp\bots\_bots_strategy::func_19ED("trap_directional", "trap");
        if(isDefined(var_08)) {
          var_09 = self method_835C();
          if(isDefined(var_09)) {
            var_0A = function_00BA(var_09);
            if(isDefined(var_0A)) {
              var_0B = func_19C8(var_0A, 0);
              var_0C = maps\mp\bots\_bots_strategy::func_1AD0(var_08, var_0B, var_0A);
              if(!isDefined(var_0C) || var_0C) {
                self method_8358();
                var_06 = func_1AAE();
              }
            }
          }
        }
      }

      if(var_06) {
        thread func_23CA("enemy", "bad_path", "goal", "node_relinquished", "search_end");
        return;
      }
    }
  }
}

func_1B0A(param_00, param_01) {
  self notify("bot_try_trap_follower");
  self endon("bot_try_trap_follower");
  self endon("death");
  self endon("disconnect");
  if(isDefined(param_00)) {
    self endon(param_00);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  if(isDefined(param_01)) {
    self waittill(param_01);
  }

  var_02 = maps\mp\bots\_bots_strategy::func_19ED("trap_follower");
  if(isDefined(var_02) && self isonground()) {
    var_03 = maps\mp\bots\_bots_util::func_19FA(300, 600, 0.7, 1);
    if(var_03.size > 0) {
      self botpressbutton(var_02["item_action"]);
      common_scripts\utility::func_A71A(5, "grenade_fire", "missile_fire");
    }
  }
}

func_23CA(param_00, param_01, param_02, param_03, param_04) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death");
  self endon("disconnect");
  self endon("start_tactical_goal");
  var_05 = self method_835C();
  var_06 = 1;
  while(var_06) {
    var_07 = common_scripts\utility::func_A715(param_00, param_01, param_02, param_03, param_04, "script_goal_changed");
    var_06 = 0;
    var_08 = 1;
    if(var_07 == "node_relinquished" || var_07 == "goal" || var_07 == "script_goal_changed") {
      if(!self method_8367()) {
        var_08 = 0;
      } else {
        var_09 = self method_835C();
        var_08 = maps\mp\bots\_bots_util::func_1B1C(var_05, var_09);
      }
    }

    if(var_07 == "enemy" && isDefined(self.var_0088)) {
      var_08 = 0;
      var_06 = 1;
    }

    if(var_08) {
      self method_8358();
    }
  }
}

func_A8CF() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death");
  self endon("disconnect");
  while(!maps\mp\bots\_bots_util::func_1A8B()) {
    wait(0.5);
  }

  self notify("out_of_ammo");
}

func_192D(param_00, param_01) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death");
  self endon("disconnect");
  if(isDefined(param_00)) {
    self endon(param_00);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var_02 = gettime();
  if(isDefined(param_01)) {
    self waittill(param_01);
  }

  if(isDefined(self.var_0D39) && isDefined(self.var_6708)) {
    self.var_0D39 = self.var_0D39 + gettime() - var_02;
    self.var_6708.var_1938 = self.var_0D39 + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

func_1B27(param_00, param_01, param_02, param_03) {
  self notify("bot_watch_entrances_delayed");
  if(param_02.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death");
    self endon("disconnect");
    self endon(param_00);
    self endon("node_relinquished");
    self endon("bad_path");
    if(isDefined(param_01)) {
      self waittill(param_01);
    }

    self endon("path_enemy");
    childthread maps\mp\bots\_bots_util::func_1B2A(param_02, param_03, 0, self.var_0D39);
    childthread func_1A84();
  }
}

func_1A84() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");
  while(!isDefined(self.var_A8C9)) {
    wait 0.05;
  }

  while(isDefined(self.var_A8C9)) {
    foreach(var_01 in self.var_A8C9) {
      var_01.var_A8C7[self.var_37CD] = var_01.var_A8C6[self.var_37CD];
    }

    maps\mp\bots\_bots_strategy::func_7733(0.5);
    wait(randomfloatrange(0.5, 0.75));
  }
}

func_19C8(param_00, param_01) {
  self endon("disconnect");
  var_02 = [];
  var_03 = findentrances(param_00.var_0116);
  if(isDefined(var_03) && var_03.size > 0) {
    wait 0.05;
    var_04 = param_00.var_01B9 != "Cover Stand" && param_00.var_01B9 != "Conceal Stand";
    if(var_04 && param_01) {
      var_03 = self method_8382(var_03, "node_exposure_vis", param_00.var_0116, "crouch");
    }

    foreach(var_06 in var_03) {
      if(distancesquared(self.var_0116, var_06.var_0116) < 90000) {
        continue;
      }

      if(var_04 && param_01) {
        wait 0.05;
        if(!maps\mp\bots\_bots_util::func_37DF(var_06.var_0116, param_00.var_0116, "crouch")) {
          continue;
        }
      }

      var_02[var_02.size] = var_06;
    }
  }

  return var_02;
}

func_19C4(param_00) {
  var_01 = [];
  var_02 = gettime();
  var_03 = param_00.size;
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = param_00[var_04];
    if(!isDefined(var_05.var_1938) || var_02 > var_05.var_1938) {
      var_01[var_01.size] = var_05;
    }
  }

  return var_01;
}

func_19C5(param_00, param_01, param_02) {
  var_03 = [];
  var_04 = [];
  var_05 = param_02 * param_02;
  if(level.var_984D) {
    foreach(var_07 in level.var_6E97) {
      if(!maps\mp\_utility::func_57A0(var_07)) {
        continue;
      }

      if(!isDefined(var_07.var_01A7)) {
        continue;
      }

      if(var_07.var_01A7 == param_01.var_01A7 && var_07 != param_01 && isDefined(var_07.var_6708)) {
        var_04[var_04.size] = var_07.var_6708.var_0116;
      }
    }
  }

  var_09 = var_04.size;
  var_0A = param_00.size;
  for(var_0B = 0; var_0B < var_0A; var_0B++) {
    var_0C = 0;
    var_0D = param_00[var_0B];
    for(var_0E = 0; !var_0C && var_0E < var_09; var_0E++) {
      var_0F = distancesquared(var_04[var_0E], var_0D.var_0116);
      var_0C = var_0F < var_05;
    }

    if(!var_0C) {
      var_03[var_03.size] = var_0D;
    }
  }

  return var_03;
}

func_23AB() {
  self notify("clear_camper_data");
  if(isDefined(self.var_6708) && isDefined(self.var_6708.var_1938)) {
    self.var_6708.var_1938 = undefined;
  }

  self.var_6708 = undefined;
  self.var_753C = undefined;
  self.var_0D94 = undefined;
  self.var_0D41 = undefined;
  self.var_0D38 = randomintrange(20000, 30000);
  self.var_0D39 = -1;
}

func_8B73() {
  if(maps\mp\bots\_bots_strategy::func_1A14()) {
    return 0;
  }

  if(gettime() > self.var_0D39) {
    return 1;
  }

  if(!self method_8367()) {
    return 1;
  }

  return 0;
}

func_3B67() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return maps\mp\bots\_bots_util::func_1AA8("find_camp_node_worker", ::func_3B68);
}

func_3B68() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  func_23AB();
  if(level.var_AC9C <= 0) {
    return 0;
  }

  var_00 = getzonenearest(self.var_0116);
  var_01 = undefined;
  var_02 = undefined;
  var_03 = self getangles();
  if(isDefined(var_00)) {
    var_04 = botzonenearestcount(var_00, self.var_01A7, -1, "enemy_predict", ">", 0, "ally", "<", 1);
    if(!isDefined(var_04)) {
      var_04 = botzonenearestcount(var_00, self.var_01A7, -1, "enemy_predict", ">", 0);
    }

    if(isDefined(var_04)) {
      var_05 = getzonenodeforindex(var_04);
      var_06 = function_0204(var_05);
      if(var_06.size == 0) {
        var_04 = undefined;
      }
    }

    if(!isDefined(var_04)) {
      var_07 = -1;
      var_08 = -1;
      for(var_09 = 0; var_09 < level.var_AC9C; var_09++) {
        var_05 = getzonenodeforindex(var_09);
        var_06 = function_0204(var_05);
        if(var_06.size > 0) {
          var_0A = common_scripts\utility::func_7A33(getzonenodes(var_09));
          var_0B = isDefined(var_0A.var_01A5) && var_0A.var_01A5 == "no_bot_random_path";
          if(!var_0B) {
            var_0C = distance2dsquared(getzoneorigin(var_09), self.var_0116);
            if(var_0C > var_07) {
              var_07 = var_0C;
              var_08 = var_09;
            }
          }
        }
      }

      var_04 = var_08;
    }

    var_0D = getzonepath(var_00, var_04);
    if(!isDefined(var_0D) || var_0D.size == 0) {
      return 0;
    }

    for(var_0E = 0; var_0E <= int(var_0D.size / 2); var_0E++) {
      var_01 = var_0D[var_0E];
      var_02 = var_0D[int(min(var_0E + 1, var_0D.size - 1))];
      if(botzonegetcount(var_02, self.var_01A7, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(var_01) && isDefined(var_02) && var_01 != var_02) {
      var_03 = getzoneorigin(var_02) - getzoneorigin(var_01);
      var_03 = vectortoangles(var_03);
    }
  }

  var_0F = undefined;
  if(isDefined(var_01)) {
    var_10 = 1;
    var_11 = 1;
    var_12 = 0;
    while(var_10) {
      var_13 = getzonenodesbydist(var_01, 800 * var_11, 1);
      if(var_13.size > 1024) {
        var_13 = getzonenodes(var_01, 0);
      }

      wait 0.05;
      var_14 = randomint(100);
      if(var_14 < 66 && var_14 >= 33) {
        var_03 = (var_03[0], var_03[1] + 45, 0);
      } else if(var_14 < 33) {
        var_03 = (var_03[0], var_03[1] - 45, 0);
      }

      if(var_13.size > 0) {
        while(var_13.size > 1024) {
          var_13[var_13.size - 1] = undefined;
        }

        var_15 = int(clamp(var_13.size * 0.15, 1, 10));
        if(var_12) {
          var_13 = self botnodepickmultiple(var_13, var_15, var_15, "node_camp", anglesToForward(var_03), "lenient");
        } else {
          var_13 = self botnodepickmultiple(var_13, var_15, var_15, "node_camp", anglesToForward(var_03));
        }

        var_13 = func_19C4(var_13);
        if(!isDefined(self.var_1F10) || !self.var_1F10) {
          var_16 = 800;
          var_13 = func_19C5(var_13, self, var_16);
        }

        if(var_13.size > 0) {
          var_0F = common_scripts\utility::func_7A46(var_13);
        }
      }

      if(isDefined(var_10)) {
        var_11 = 0;
        continue;
      }

      if(isDefined(self.var_1F01)) {
        if(var_12 == 1 && !var_13) {
          var_12 = 3;
        } else if(var_12 == 3 && !var_13) {
          var_13 = 1;
        } else if(var_12 == 3 && var_13) {
          var_11 = 0;
        }

        continue;
      }

      var_11 = 0;
      if(var_11) {
        wait 0.05;
      }
    }
  }

  if(!isDefined(var_14) || !self botnodeavailable(var_14)) {
    return 0;
  }

  self.var_6708 = var_14;
  self.var_0D39 = gettime() + self.var_0D38;
  self.var_6708.var_1938 = self.var_0D39;
  self.var_0D94 = var_13[1];
  return 1;
}

func_3B64(param_00, param_01) {
  func_23AB();
  if(isDefined(param_00)) {
    self.var_753C = param_00;
  } else {
    var_02 = undefined;
    var_03 = getnodesinradius(self.var_0116, 5000, 0, 2000);
    if(var_03.size > 0) {
      var_02 = self method_8366(var_03, var_03.size * 0.25, "node_traffic");
    }

    if(isDefined(var_02)) {
      self.var_753C = var_02.var_0116;
    } else {
      return 0;
    }
  }

  var_04 = 2000;
  if(isDefined(var_03)) {
    var_04 = var_03;
  }

  var_05 = getnodesinradius(self.var_753C, var_04, 0, 1000);
  var_06 = undefined;
  if(var_05.size > 0) {
    var_07 = int(max(1, int(var_05.size * 0.15)));
    var_05 = self botnodepickmultiple(var_05, var_07, var_07, "node_ambush", self.var_753C);
  }

  var_05 = func_19C4(var_05);
  if(var_05.size > 0) {
    var_06 = common_scripts\utility::func_7A46(var_05);
  }

  if(!isDefined(var_06) || !self botnodeavailable(var_06)) {
    return 0;
  }

  self.var_6708 = var_06;
  self.var_0D39 = gettime() + self.var_0D38;
  self.var_6708.var_1938 = self.var_0D39;
  var_08 = vectornormalize(self.var_753C - self.var_6708.var_0116);
  var_09 = vectortoangles(var_08);
  self.var_0D94 = var_09[1];
  return 1;
}

func_1AAE() {
  if(maps\mp\bots\_bots_util::func_1A36()) {
    return 0;
  }

  var_00 = level.var_1AB0[self.var_01A7];
  return self[[var_00]]();
}

func_1AAF() {
  var_00 = 0;
  var_01 = 50;
  if(self.var_6F7D == "camper") {
    var_01 = 0;
  }

  var_02 = undefined;
  if(randomint(100) < var_01) {
    var_02 = maps\mp\bots\_bots_util::func_1AB2();
  }

  if(!isDefined(var_02)) {
    var_03 = self method_8363();
    if(isDefined(var_03)) {
      var_02 = var_03.var_0116;
    }
  }

  if(isDefined(var_02)) {
    var_00 = self botsetscriptgoal(var_02, 128, "hunt");
  }

  return var_00;
}

func_1ADD() {
  if(maps\mp\_utility::func_761E()) {
    return "practice" + randomintrange(1, 6);
  }

  if(maps\mp\bots\_bots_loadout::func_1ADE()) {
    return "callback";
  }

  return "class0";
}