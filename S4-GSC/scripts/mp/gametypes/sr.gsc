/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sr.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = "sd";
  var_0[1] = "bombzone";
  var_0[2] = "blocker";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 3, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 150);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2CE(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2CF(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::_id_C250(scripts\mp\utility\game::getgametype(), 1);
  }

  _id_FC7D();
  level._id_9086 = getdvarint("#x3fe087e8887191b5c", 0);
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_A543 = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_AAA3 = ::_id_AAA3;
  level._id_AB47 = ::_id_AB47;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB3F = ::_id_AB3F;
  level._id_60D0 = scripts\mp\utility\game::_id_899A;
  level._id_AB42 = ::_id_AA7B;
  level._id_C650 = scripts\mp\gametypes\obj_bombzone::_id_C650;
  level._id_15BE = 0;
  level._id_267E = 0;
  level._id_A586 = 1;
  level._id_19B0 = 0;
  level._id_29EA = 0;
  game["dialog"]["gametype"] = "gametype_snr";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
  game["dialog"]["kill_confirmed"] = "kill_confirmed";
  game["dialog"]["lastalive_revive"] = "lastalive_revive";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_bomb_interacting", 0);
  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  level thread _id_907D();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3c04fd1f560ede06e", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("#x311a1c7680401f7f3", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("#x343528e709efd2096", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("#x3144c06279e054c06", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("#x33557e78daab45479", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("#x33f3c621864c344e5", 0);
  scripts\mp\utility\game::_id_C25D("sr", 0);
  setdynamicdvar("#x372c9ba6d59f2d38b", 0);
}

_id_AB7F() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

_id_ABAD() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::_id_D61C(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::_id_D61C(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  _id_8294();
  level._id_4CE2 = ::_id_4CE2;
  _id_D6E0();
  thread _id_267A();
}

_id_8294() {
  _id_0817::_id_D461("SearchAndRescue", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_sd_spawn_attacker");
  _id_0817::_id_113A("mp_sd_spawn_defender");
  _id_0817::_id_1136("attacker", "mp_tdm_spawn");
  _id_0817::_id_1136("attacker", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("defender", "mp_tdm_spawn");
  _id_0817::_id_1136("defender", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B8("normal", "mp_tdm_spawn");
  _id_0817::_id_C2B8("fallback", "mp_tdm_spawn_secondary");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = "defender";

  if(self.pers["team"] == game["attackers"]) {
    var_0 = "attacker";
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_sd_spawn_" + var_0);
    var_2 = _id_0817::_id_6D4D(var_1);
  } else
    var_2 = _id_0817::_id_6D4A(self, self.pers["team"], "normal", "fallback");

  return var_2;
}

_id_ABA4() {
  self._id_8986 = 0;
  self._id_87F7 = 0;
  self._id_8783 = 0;

  if(level._id_A2F7 && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);

    foreach(var_1 in level._id_A8E8) {
      var_1.trigger disableplayeruse(self);
    }
  }

  level notify("spawned_player");

  if(scripts\mp\utility\teams::_id_8878(self.sessionteam)) {
    level notify("sr_player_joined", self);
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["plants"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["plants"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["rescues"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["rescues"]);
    }
  }
}

_id_907D() {
  level endon("game_ended");

  for(;;) {
    waitframe();
    level thread _id_9079();
  }
}

_id_9079() {
  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_0[var_2] = [];
    var_3[var_2] = 0;
  }

  foreach(var_2 in level._id_EF89) {
    var_6 = scripts\mp\utility\teams::_id_6DCA(var_2, "players");
    var_3 = 0;
    var_0 = [];

    foreach(var_8 in var_6) {
      if(scripts\mp\utility\player::isreallyalive(var_8)) {
        var_3++;

        if(istrue(var_8.inlaststand)) {
          var_0[var_0.size] = var_8;
        }
      }
    }

    if(var_0.size > 0 && var_3 <= var_0.size) {
      level._id_9086 = 0;

      foreach(var_8 in var_0) {
        var_8 suicide();
      }
    }
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread _id_34DE();
}

_id_34DE() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
    level._id_E3E2[game["attackers"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
    level._id_E3E2[game["defenders"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
}

_id_CF9E(var_0, var_1) {
  _func_01EA("ui_objective_state", 0);
  setomnvar("ui_bomb_interacting", 0);
  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
}

_id_AAA3(var_0) {
  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_2663) {
      _id_CF9E(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
    } else {
      _id_CF9E(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level._id_2663) {
      return;
    }
    level thread _id_CF9E(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread _id_CF9E(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

_id_AB47(var_0) {
  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  var_1 = scripts\mp\utility\game::_id_6AF7(var_0);
  var_1 thread _id_6FAE();
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  } else if(var_0._id_87F7) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  }

  scripts\mp\gametypes\obj_bombzone::_id_2685(var_1, var_0);
}

_id_6FAE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_id_10968(3);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastenemyalive", self, var_0);

  foreach(var_2 in level.players) {
    if(var_2.pers["team"] == self.pers["team"]) {
      if(isDefined(var_2._id_ED4A) && var_2._id_ED4A) {
        level._id_A586 = 0;
      }
    }
  }

  level notify("last_alive", self);
}

_id_ABC0() {
  _id_CF9E(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_2668)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1._id_2668);
      break;
    }
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 5, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 5, 0, 20);
  level._id_2682 = scripts\mp\utility\dvars::_id_509A("bombtimer", 45, 1, 300);
  level._id_A2F7 = scripts\mp\utility\dvars::_id_509C("multibomb", 0, 0, 1);
  level._id_DD44 = scripts\mp\utility\dvars::_id_509C("silentPlant", 0, 0, 1);
}

_id_C47C(var_0) {
  var_1 = [];
  var_2 = getEntArray("script_brushmodel", "classname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4._id_CD69) && var_4._id_CD69 == "bombzone") {
      foreach(var_6 in var_0) {
        if(distance(var_4.origin, var_6.origin) < 100 && issubstr(tolower(var_6._id_CD99), "c")) {
          var_6._id_C2ED = var_4;
          var_1[var_1.size] = var_6;
          break;
        }
      }
    }
  }

  foreach(var_10 in var_1) {
    var_10._id_C2ED delete();
    var_11 = getEntArray(var_10.target, "targetname");

    foreach(var_13 in var_11) {
      var_13 delete();
    }

    var_10 delete();
  }

  return scripts\engine\utility::_id_1BD1(var_0);
}

_id_267A() {
  scripts\mp\gametypes\obj_bombzone::_id_2694("sd_bomb");
  var_0 = getEntArray("bombzone", "targetname");
  var_0 = _id_C47C(var_0);
  level._id_A8E8 = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_2, 1);
    var_3._id_AA79 = ::_id_AA79;
    var_3._id_AAC2 = ::_id_AAC2;
    var_3._id_ABCB = ::_id_ABD2;
    level._id_A8E8[var_3._id_A8E1] = var_3;
  }
}

_id_AA79(var_0) {
  scripts\mp\gametypes\obj_bombzone::_id_268A(var_0);

  if(!_id_07D6::_id_886F(var_0.pers["team"])) {
    if(level._id_A2F7) {
      if(self._id_A8E1 == "_a") {
        level._id_A8E8["_b"] _id_07D6::_id_15DF("none");
        level._id_A8E8["_b"] _id_07D6::_id_D8E0("friendly");
      } else {
        level._id_A8E8["_a"] _id_07D6::_id_15DF("none");
        level._id_A8E8["_a"] _id_07D6::_id_D8E0("friendly");
      }
    }
  }
}

_id_AAC2(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::_id_268F(var_0, var_1, var_2);

  if(!_id_07D6::_id_886F(var_1.pers["team"])) {
    if(level._id_A2F7 && !var_2) {
      if(self._id_A8E1 == "_a") {
        level._id_A8E8["_b"] _id_07D6::_id_15DF("enemy");
        level._id_A8E8["_b"] _id_07D6::_id_D8E0("any");
      } else {
        level._id_A8E8["_a"] _id_07D6::_id_15DF("enemy");
        level._id_A8E8["_a"] _id_07D6::_id_D8E0("any");
      }
    }
  }
}

_id_ABD2(var_0) {
  if(!_id_07D6::_id_886F(var_0.pers["team"])) {
    foreach(var_2 in level._id_A8E8) {
      if(var_2 == self) {
        continue;
      }
      var_2 _id_07D6::_id_4AD1();
    }
  }

  scripts\mp\gametypes\obj_bombzone::_id_2691(var_0);
}

_id_AA7B(var_0, var_1, var_2, var_3, var_4) {
  if(var_3 == game["attackers"]) {
    setgameendtime(0);
    wait 3;
    _id_CF9E(game["attackers"], game["end_reason"]["target_destroyed"]);
  } else {
    wait 1.5;
    setgameendtime(0);
    _id_CF9E(game["defenders"], game["end_reason"]["bomb_defused"]);
  }
}

_id_D6E0() {
  if(_func_0127() && scripts\mp\utility\game::_id_6B32("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level._id_CF9F[game["attackers"]] = ::scripts\mp\utility\game::_id_6B33(game["attackers"], 5);
  }
}

_id_4CE2(var_0) {
  var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["rescues"]);
}