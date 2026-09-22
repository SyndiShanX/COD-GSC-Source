/******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_personality.gsc
******************************************************/

_id_897D() {
  level._id_1A90 = [];
  level._id_1A91 = [];
  level._id_1A90["active"][0] = "default";
  level._id_1A90["active"][1] = "run_and_gun";
  level._id_1A90["active"][2] = "cqb";
  level._id_1A90["stationary"][0] = "camper";
  level._id_1A92 = [];

  foreach(var_5, var_1 in level._id_1A90) {
    foreach(var_3 in var_1) {
      level._id_1A92[var_3] = var_5;
      level._id_1A91[level._id_1A91.size] = var_3;
    }
  }

  level._id_1A93 = [];
  level._id_1A93["active"] = 4;
  level._id_1A93["stationary"] = 1;
  level._id_1A8E = [];
  level._id_1A8E["default"] = ::_id_523C;
  level._id_1A8E["camper"] = ::_id_523B;
  level._id_1A8F["default"] = ::_id_A0C0;
  level._id_1A8F["camper"] = ::_id_A0BF;
}

_id_1939() {
  self._id_6F7D = self botgetpersonality();
  self.pers["personality"] = self._id_6F7D;
  self._id_6F7E = level._id_1A8E[self._id_6F7D];

  if(!isDefined(self._id_6F7E)) {
    self._id_6F7E = level._id_1A8E["default"];
  }

  self[[self._id_6F7E]]();
  self._id_6F7F = level._id_1A8F[self._id_6F7D];

  if(!isDefined(self._id_6F7F)) {
    self._id_6F7F = level._id_1A8F["default"];
  }
}

_id_193F() {
  if(isDefined(self._id_6F80) && self._id_6F80) {
    return;
  }
  if(isDefined(self.pers["personality"])) {
    self botsetpersonality(self.pers["personality"]);
    return;
  }

  var_0 = self.team;

  if(!isDefined(var_0) && !isDefined(self._id_1AFA)) {
    var_0 = self.pers["team"];
  }

  var_1 = getarraykeys(level._id_1A93);
  var_2 = [];
  var_3 = [];

  foreach(var_9, var_5 in level._id_1A90) {
    var_3[var_9] = 0;

    foreach(var_7 in var_5) {
      var_2[var_7] = 0;
    }
  }

  foreach(var_11 in level._id_6E97) {
    if(var_11 == self) {
      continue;
    }
    if(!maps\mp\_utility::_id_5800(var_11) || !isDefined(var_11._id_4B22)) {
      continue;
    }
    if(isDefined(var_11.team) && var_11.team == var_0 || !level.teambased) {
      var_7 = var_11 botgetpersonality();
      var_9 = level._id_1A92[var_7];
      var_2[var_7] = var_2[var_7] + 1;
      var_3[var_9] = var_3[var_9] + 1;
    }
  }

  var_13 = [];

  foreach(var_15 in var_1) {
    var_13[var_15] = int(var_3[var_15] / level._id_1A93[var_15]);
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
      var_23[var_15] = level._id_1A93[var_15] - var_3[var_15] % level._id_1A93[var_15];
    }

    var_26 = 0;

    foreach(var_15 in var_1) {
      var_26 = var_26 + var_23[var_15];
    }

    var_29 = _randomfloat(var_26);

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
  var_37 = common_scripts\utility::array_randomize(level._id_1A90[var_17]);

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
    var_32 = common_scripts\utility::random(level._id_1A90[var_17]);
  }

  if(self botgetpersonality() != var_32) {
    self botsetpersonality(var_32);
  }

  self._id_4B22 = 1;
}

_id_523B() {
  _id_23AB();
}

_id_523C() {
  _id_23AB();
}

_id_A0BF() {
  if(_id_8B73() && !maps\mp\bots\_bots_util::_id_1A2D() && !maps\mp\bots\_bots_util::_id_1A36()) {
    var_0 = self botgetscriptgoaltype();
    var_1 = 0;

    if(!isDefined(self._id_1F00)) {
      self._id_1F00 = 0;
    }

    var_2 = var_0 == "hunt";
    var_3 = gettime() > self._id_1F00 + 10000;

    if((!var_2 || var_3) && !maps\mp\bots\_bots_util::_id_1A8B()) {
      if(!self bothasscriptgoal()) {
        _id_1AAE();
      }

      if(isDefined(level._id_6CBF)) {
        var_1 = [[level._id_6CBF]]();
      }

      if(!var_1) {
        var_1 = _id_3B67();

        if(!var_1) {
          self._id_1F00 = gettime();
        }
      }
    }

    if(isDefined(var_1) && var_1) {
      self._id_0D41 = maps\mp\bots\_bots_util::_id_1AA8("bot_find_ambush_entrances", ::_id_19C8, self._id_6708, 1);
      var_4 = maps\mp\bots\_bots_strategy::_id_19ED("trap_directional", "trap", "c4");

      if(isDefined(var_4)) {
        var_5 = gettime();
        maps\mp\bots\_bots_strategy::_id_1AD0(var_4, self._id_0D41, self._id_6708, self._id_0D94);
        var_5 = gettime() - var_5;

        if(var_5 > 0 && isDefined(self._id_0D39) && isDefined(self._id_6708)) {
          self._id_0D39 = self._id_0D39 + var_5;
          self._id_6708._id_1938 = self._id_0D39 + 10000;
        }
      }

      if(!maps\mp\bots\_bots_strategy::_id_1A14() && !maps\mp\bots\_bots_util::_id_1A2D() && isDefined(self._id_6708)) {
        self botsetscriptgoalnode(self._id_6708, "camp", self._id_0D94);
        thread _id_23CA("bad_path", "node_relinquished", "out_of_ammo");
        thread _id_A8CF();
        thread _id_192D("clear_camper_data", "goal");
        thread _id_1B27("clear_camper_data", "bot_add_ambush_time_delayed", self._id_0D41, self._id_0D94);
        childthread _id_1B0A("clear_camper_data", "goal");
        return;
      }
    } else {
      if(var_0 == "camp") {
        self botclearscriptgoal();
      }

      _id_A0C0();
    }
  }
}

_id_A0C0() {
  var_0 = undefined;
  var_1 = self bothasscriptgoal();

  if(var_1) {
    var_0 = self botgetscriptgoal();
  }

  if(gettime() - self._id_5BE2 > 5000) {
    _id_1B0A();
  }

  if(!maps\mp\bots\_bots_strategy::_id_1A14() && !maps\mp\bots\_bots_util::_id_1A36()) {
    var_2 = undefined;
    var_3 = undefined;

    if(var_1) {
      var_2 = distancesquared(self.origin, var_0);
      var_3 = self botgetscriptgoalRadius();
      var_4 = var_3 * 2;

      if(isDefined(self._id_1A7B) && var_2 < var_4 * var_4) {
        var_5 = _botmemoryflags("investigated");
        _botflagmemoryevents(0, gettime() - self._id_1A7C, 1, self._id_1A7B, var_4, "kill", var_5, self);
        _botflagmemoryevents(0, gettime() - self._id_1A7C, 1, self._id_1A7B, var_4, "death", var_5, self);
        self._id_1A7B = undefined;
        self._id_1A7C = undefined;
      }
    }

    if(!var_1 || var_2 < var_3 * var_3) {
      var_6 = _id_1AAE();
      var_7 = 25;

      if(common_scripts\utility::_id_562E(self._id_366C)) {
        var_7 = 50;
      }

      if(var_6 && _randomfloat(100) < var_7) {
        var_8 = maps\mp\bots\_bots_strategy::_id_19ED("trap_directional", "trap");

        if(isDefined(var_8)) {
          var_9 = self botgetscriptgoal();

          if(isDefined(var_9)) {
            var_10 = _getclosestnodeinsight(var_9);

            if(isDefined(var_10)) {
              var_11 = _id_19C8(var_10, 0);
              var_12 = maps\mp\bots\_bots_strategy::_id_1AD0(var_8, var_11, var_10);

              if(!isDefined(var_12) || var_12) {
                self botclearscriptgoal();
                var_6 = _id_1AAE();
              }
            }
          }
        }
      }

      if(var_6) {
        thread _id_23CA("enemy", "bad_path", "goal", "node_relinquished", "search_end");
      }
    }
  }
}

_id_1B0A(var_0, var_1) {
  self notify("bot_try_trap_follower");
  self endon("bot_try_trap_follower");
  self endon("death");
  self endon("disconnect");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  self endon("node_relinquished");
  self endon("bad_path");

  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  var_2 = maps\mp\bots\_bots_strategy::_id_19ED("trap_follower");

  if(isDefined(var_2) && self isonground()) {
    var_3 = maps\mp\bots\_bots_util::_id_19FA(300, 600, 0.7, 1);

    if(var_3.size > 0) {
      self botpressbutton(var_2["item_action"]);
      common_scripts\utility::_id_A71A(5, "grenade_fire", "missile_fire");
    }
  }
}

_id_23CA(var_0, var_1, var_2, var_3, var_4) {
  self notify("clear_script_goal_on");
  self endon("clear_script_goal_on");
  self endon("death");
  self endon("disconnect");
  self endon("start_tactical_goal");
  var_5 = self botgetscriptgoal();
  var_6 = 1;

  while(var_6) {
    var_7 = common_scripts\utility::waittill_any_return(var_0, var_1, var_2, var_3, var_4, "script_goal_changed");
    var_6 = 0;
    var_8 = 1;

    if(var_7 == "node_relinquished" || var_7 == "goal" || var_7 == "script_goal_changed") {
      if(!self bothasscriptgoal()) {
        var_8 = 0;
      } else {
        var_9 = self botgetscriptgoal();
        var_8 = maps\mp\bots\_bots_util::_id_1B1C(var_5, var_9);
      }
    }

    if(var_7 == "enemy" && isDefined(self._id_0088)) {
      var_8 = 0;
      var_6 = 1;
    }

    if(var_8) {
      self botclearscriptgoal();
    }
  }
}

_id_A8CF() {
  self notify("watch_out_of_ammo");
  self endon("watch_out_of_ammo");
  self endon("death");
  self endon("disconnect");

  while(!maps\mp\bots\_bots_util::_id_1A8B()) {
    wait 0.5;
  }

  self notify("out_of_ammo");
}

_id_192D(var_0, var_1) {
  self notify("bot_add_ambush_time_delayed");
  self endon("bot_add_ambush_time_delayed");
  self endon("death");
  self endon("disconnect");

  if(isDefined(var_0)) {
    self endon(var_0);
  }

  self endon("node_relinquished");
  self endon("bad_path");
  var_2 = gettime();

  if(isDefined(var_1)) {
    self waittill(var_1);
  }

  if(isDefined(self._id_0D39) && isDefined(self._id_6708)) {
    self._id_0D39 = self._id_0D39 + (gettime() - var_2);
    self._id_6708._id_1938 = self._id_0D39 + 10000;
  }

  self notify("bot_add_ambush_time_delayed");
}

_id_1B27(var_0, var_1, var_2, var_3) {
  self notify("bot_watch_entrances_delayed");

  if(var_2.size > 0) {
    self endon("bot_watch_entrances_delayed");
    self endon("death");
    self endon("disconnect");
    self endon(var_0);
    self endon("node_relinquished");
    self endon("bad_path");

    if(isDefined(var_1)) {
      self waittill(var_1);
    }

    self endon("path_enemy");
    childthread maps\mp\bots\_bots_util::_id_1B2A(var_2, var_3, 0, self._id_0D39);
    childthread _id_1A84();
  }
}

_id_1A84() {
  self notify("bot_monitor_watch_entrances_camp");
  self endon("bot_monitor_watch_entrances_camp");
  self notify("bot_monitor_watch_entrances");
  self endon("bot_monitor_watch_entrances");
  self endon("bot_watch_nodes_stop");
  self endon("disconnect");
  self endon("death");

  while(!isDefined(self._id_A8C9)) {
    waitframe();
  }

  while(isDefined(self._id_A8C9)) {
    foreach(var_1 in self._id_A8C9) {
      var_1._id_A8C7[self.entity_number] = var_1._id_A8C6[self.entity_number];
    }

    maps\mp\bots\_bots_strategy::_id_7733(0.5);
    wait(_randomfloatrange(0.5, 0.75));
  }
}

_id_19C8(var_0, var_1) {
  self endon("disconnect");
  var_2 = [];
  var_3 = _findentrances(var_0.origin);

  if(isDefined(var_3) && var_3.size > 0) {
    waitframe();
    var_4 = var_0.type != "Cover Stand" && var_0.type != "Conceal Stand";

    if(var_4 && var_1) {
      var_3 = self botnodescoremultiple(var_3, "node_exposure_vis", var_0.origin, "crouch");
    }

    foreach(var_6 in var_3) {
      if(distancesquared(self.origin, var_6.origin) < 90000) {
        continue;
      }
      if(var_4 && var_1) {
        waitframe();

        if(!maps\mp\bots\_bots_util::_id_37DF(var_6.origin, var_0.origin, "crouch")) {
          continue;
        }
      }

      var_2[var_2.size] = var_6;
    }
  }

  return var_2;
}

_id_19C4(var_0) {
  var_1 = [];
  var_2 = gettime();
  var_3 = var_0.size;

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0[var_4];

    if(!isDefined(var_5._id_1938) || var_2 > var_5._id_1938) {
      var_1[var_1.size] = var_5;
    }
  }

  return var_1;
}

_id_19C5(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = [];
  var_5 = var_2 * var_2;

  if(level.teambased) {
    foreach(var_7 in level._id_6E97) {
      if(!maps\mp\_utility::isreallyalive(var_7)) {
        continue;
      }
      if(!isDefined(var_7.team)) {
        continue;
      }
      if(var_7.team == var_1.team && var_7 != var_1 && isDefined(var_7._id_6708)) {
        var_4[var_4.size] = var_7._id_6708.origin;
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

_id_23AB() {
  self notify("clear_camper_data");

  if(isDefined(self._id_6708) && isDefined(self._id_6708._id_1938)) {
    self._id_6708._id_1938 = undefined;
  }

  self._id_6708 = undefined;
  self._id_753C = undefined;
  self._id_0D94 = undefined;
  self._id_0D41 = undefined;
  self._id_0D38 = _randomintrange(20000, 30000);
  self._id_0D39 = -1;
}

_id_8B73() {
  if(maps\mp\bots\_bots_strategy::_id_1A14()) {
    return 0;
  }

  if(gettime() > self._id_0D39) {
    return 1;
  }

  if(!self bothasscriptgoal()) {
    return 1;
  }

  return 0;
}

_id_3B67() {
  self notify("find_camp_node");
  self endon("find_camp_node");
  return maps\mp\bots\_bots_util::_id_1AA8("find_camp_node_worker", ::_id_3B68);
}

_id_3B68() {
  self notify("find_camp_node_worker");
  self endon("find_camp_node_worker");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  _id_23AB();

  if(level._id_AC9C <= 0) {
    return 0;
  }

  var_0 = _getzonenearest(self.origin);
  var_1 = undefined;
  var_2 = undefined;
  var_3 = self getplayerangles();

  if(isDefined(var_0)) {
    var_4 = _botzonenearestcount(var_0, self.team, -1, "enemy_predict", ">", 0, "ally", "<", 1);

    if(!isDefined(var_4)) {
      var_4 = _botzonenearestcount(var_0, self.team, -1, "enemy_predict", ">", 0);
    }

    if(isDefined(var_4)) {
      var_5 = _getzonenodeforindex(var_4);
      var_6 = _getlinkednodes(var_5);

      if(var_6.size == 0) {
        var_4 = undefined;
      }
    }

    if(!isDefined(var_4)) {
      var_7 = -1;
      var_8 = -1;

      for(var_9 = 0; var_9 < level._id_AC9C; var_9++) {
        var_5 = _getzonenodeforindex(var_9);
        var_6 = _getlinkednodes(var_5);

        if(var_6.size > 0) {
          var_10 = common_scripts\utility::random(_getzonenodes(var_9));
          var_11 = isDefined(var_10.targetname) && var_10.targetname == "no_bot_random_path";

          if(!var_11) {
            var_12 = _distance2dsquared(_getzoneorigin(var_9), self.origin);

            if(var_12 > var_7) {
              var_7 = var_12;
              var_8 = var_9;
            }
          }
        }
      }

      var_4 = var_8;
    }

    var_13 = _getzonepath(var_0, var_4);

    if(!isDefined(var_13) || var_13.size == 0) {
      return 0;
    }

    for(var_14 = 0; var_14 <= int(var_13.size / 2); var_14++) {
      var_1 = var_13[var_14];
      var_2 = var_13[int(_min(var_14 + 1, var_13.size - 1))];

      if(_botzonegetcount(var_2, self.team, "enemy_predict") != 0) {
        break;
      }
    }

    if(isDefined(var_1) && isDefined(var_2) && var_1 != var_2) {
      var_3 = _getzoneorigin(var_2) - _getzoneorigin(var_1);
      var_3 = vectortoangles(var_3);
    }
  }

  var_15 = undefined;

  if(isDefined(var_1)) {
    var_16 = 1;
    var_17 = 1;
    var_18 = 0;

    while(var_16) {
      var_19 = _getzonenodesbydist(var_1, 800 * var_17, 1);

      if(var_19.size > 1024) {
        var_19 = _getzonenodes(var_1, 0);
      }

      waitframe();
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
          var_19 = self botnodepickmultiple(var_19, var_21, var_21, "node_camp", anglesToForward(var_3), "lenient");
        } else {
          var_19 = self botnodepickmultiple(var_19, var_21, var_21, "node_camp", anglesToForward(var_3));
        }

        var_19 = _id_19C4(var_19);

        if(!isDefined(self._id_1F10) || !self._id_1F10) {
          var_22 = 800;
          var_19 = _id_19C5(var_19, self, var_22);
        }

        if(var_19.size > 0) {
          var_15 = common_scripts\utility::_id_7A46(var_19);
        }
      }

      if(isDefined(var_15)) {
        var_16 = 0;
      } else if(isDefined(self._id_1F01)) {
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
        waitframe();
      }
    }
  }

  if(!isDefined(var_15) || !self botnodeavailable(var_15)) {
    return 0;
  }

  self._id_6708 = var_15;
  self._id_0D39 = gettime() + self._id_0D38;
  self._id_6708._id_1938 = self._id_0D39;
  self._id_0D94 = var_3[1];
  return 1;
}

_id_3B64(var_0, var_1) {
  _id_23AB();

  if(isDefined(var_0)) {
    self._id_753C = var_0;
  } else {
    var_2 = undefined;
    var_3 = _getnodesinradius(self.origin, 5000, 0, 2000);

    if(var_3.size > 0) {
      var_2 = self botnodepick(var_3, var_3.size * 0.25, "node_traffic");
    }

    if(isDefined(var_2)) {
      self._id_753C = var_2.origin;
    } else {
      return 0;
    }
  }

  var_4 = 2000;

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = _getnodesinradius(self._id_753C, var_4, 0, 1000);
  var_6 = undefined;

  if(var_5.size > 0) {
    var_7 = int(max(1, int(var_5.size * 0.15)));
    var_5 = self botnodepickmultiple(var_5, var_7, var_7, "node_ambush", self._id_753C);
  }

  var_5 = _id_19C4(var_5);

  if(var_5.size > 0) {
    var_6 = common_scripts\utility::_id_7A46(var_5);
  }

  if(!isDefined(var_6) || !self botnodeavailable(var_6)) {
    return 0;
  }

  self._id_6708 = var_6;
  self._id_0D39 = gettime() + self._id_0D38;
  self._id_6708._id_1938 = self._id_0D39;
  var_8 = vectorNormalize(self._id_753C - self._id_6708.origin);
  var_9 = vectortoangles(var_8);
  self._id_0D94 = var_9[1];
  return 1;
}

_id_1AAE() {
  if(maps\mp\bots\_bots_util::_id_1A36()) {
    return 0;
  }

  var_0 = level._id_1AB0[self.team];
  return self[[var_0]]();
}

_id_1AAF() {
  var_0 = 0;
  var_1 = 50;

  if(self._id_6F7D == "camper") {
    var_1 = 0;
  }

  var_2 = undefined;

  if(randomint(100) < var_1) {
    var_2 = maps\mp\bots\_bots_util::_id_1AB2();
  }

  if(!isDefined(var_2)) {
    var_3 = self botfindnoderandom();

    if(isDefined(var_3)) {
      var_2 = var_3.origin;
    }
  }

  if(isDefined(var_2)) {
    var_0 = self botsetscriptgoal(var_2, 128, "hunt");
  }

  return var_0;
}

_id_1ADD() {
  if(maps\mp\_utility::_id_761E()) {
    return "practice" + _randomintrange(1, 6);
  }

  if(maps\mp\bots\_bots_loadout::_id_1ADE()) {
    return "callback";
  } else {
    return "class0";
  }
}