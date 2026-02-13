/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\sd.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
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
  }

  _id_FC7D();
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
  level._id_AB37 = ::_id_AB37;
  level._id_15BE = 0;
  level._id_267E = 0;
  level._id_19B0 = 0;
  level._id_29EA = 0;
  game["dialog"]["gametype"] = "mp_glob_sede_bchr_in09";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_sede_bchr_in10";
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  if(!isDefined(game["roundsPlayed"])) {
    var_1 = "mp_glob_gene_bchr_z253";
    var_2 = "mp_glob_gene_bchr_z252";
  } else {
    var_1 = "mp_glob_gene_bchr_z253";
    var_2 = "mp_glob_gene_bchr_z252";
  }

  game["dialog"]["offense_obj"] = var_1;
  game["dialog"]["defense_obj"] = var_2;
  game["dialog"]["bomb_achieve"] = "mp_glob_sede_bchr_z117";
  game["dialog"]["bomb_pickup"] = "mp_glob_sede_bchr_z117";
  game["dialog"]["bomb_pickup_first"] = "mp_glob_sede_bchr_z117";
  game["dialog"]["bomb_enemy_pickup"] = "mp_glob_sede_bchr_z114";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "mp_glob_sede_bchr_z113";
  game["dialog"]["bomb_defusing"] = "mp_glob_sede_bchr_z111";
  game["dialog"]["bomb_defused"] = "mp_glob_sede_bchr_z112";
  game["dialog"]["bomb_planting"] = "mp_glob_sede_bchr_z115";
  game["dialog"]["bomb_planted"] = "mp_glob_sede_bchr_z116";
  game["dialog"]["enemy_bomb_a"] = ["mp_glob_sede_bchr_enemysplantedthebomb", "mp_glob_sede_bchr_othersidesgotabombon"];
  game["dialog"]["enemy_bomb_b"] = ["mp_glob_sede_bchr_enemysplantedthebomb_01", "mp_glob_sede_bchr_enemybombplantedatb", "mp_glob_sede_bchr_bsgotanenemybombonit", "mp_glob_sede_bchr_othersidesgotabombon_01"];
  game["dialog"]["enemy_bomb_defused"] = ["mp_glob_sede_bchr_enemysdefusedourbomb", "mp_glob_sede_bchr_ourbombsbeendiffused", "mp_glob_sede_bchr_enemytookapartourbom", "mp_glob_sede_bchr_ourbombsbeentakenout"];
  game["dialog"]["enemy_bomb_planted"] = ["mp_glob_sede_bchr_enemysplantedabomb", "mp_glob_sede_bchr_enemysgotabombplante", "mp_glob_sede_bchr_bombplantedbytheenem", "mp_glob_sede_bchr_enemybombisinplay"];
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  setomnvar("ui_bomb_timer_endtime_a", 0);
  setomnvar("ui_bomb_timer_endtime_b", 0);
  setomnvar("ui_bomb_planted_a", 0);
  setomnvar("ui_bomb_planted_b", 0);
  setomnvar("ui_bomb_interacting", 0);
  level._id_A5E0 = 1;
  level._id_6288 = 0;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3f6537d6ed093b6fc", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("#x3491b89d713d4e625", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("#x3241e808ebab6b790", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("#x342232bfbcca13ec8", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("#x31b13c3c9f9a0670b", getmatchrulesdata("bombData", "silentPlant"));
  setdynamicdvar("#x356dc778d4c50c901", getmatchrulesdata("bombData", "resetProgress"));
  setdynamicdvar("#x3f250a01f3895a583", 0);
  scripts\mp\utility\game::_id_C25D("sd", 0);
  setdynamicdvar("#x33ba2965c5923bfbd", 0);
}

_id_10974() {
  if(scripts\mp\utility\game::_id_8A95() || scripts\mp\utility\game::_id_8902()) {
    game["dialog"]["gametype"] = "gametype_sandrescue";
  }

  _id_07D1::_id_60C2("prematch_done");
  level._id_AD53 = 1;
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

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    level._effect["bomb_explosion"] = loadfx("vfx/s4/gamemode/vfx_search_bombsite_destroy_xmas.vfx");
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    level._effect["bomb_explosion"] = loadfx("vfx/s4/gamemode/vfx_search_bombsite_destroy_valentine.vfx");
  } else {
    level._effect["bomb_explosion"] = loadfx("vfx/s4/gamemode/vfx_search_bombsite_destroy.vfx");
  }

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
  thread _id_10974();
  _id_D6E0();
  thread _id_267A();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_1136(game["attackers"], "mp_sd_spawn_attacker");
  _id_0817::_id_1136(game["defenders"], "mp_sd_spawn_defender");

  if(level.mapname == "mp_m_speedball" || level.mapname == "mp_m_overunder" || level.mapname == "mp_m_overwinter") {
    var_0 = _id_0817::_id_6D4E("mp_sd_spawn_defender");
    var_1 = _id_0817::_id_6D4E("mp_sd_spawn_attacker");
  } else if(level.mapname == "mp_petrograd") {
    var_0 = _id_0817::_id_6D4E("mp_sd_spawn_attacker");
    var_1 = _id_0817::_id_6D4E("mp_sd_spawn_defender", 1);
  } else {
    var_0 = _id_0817::_id_6D4E("mp_sd_spawn_attacker");
    var_1 = _id_0817::_id_6D4E("mp_sd_spawn_defender");
  }

  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  _id_0817::_id_D461("StartSpawn", "Crit_Default");
  var_0 = self.pers["team"];

  if(var_0 == game["attackers"]) {
    var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
  } else {
    var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
  }

  return var_1;
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", -1);

  if(scripts\mp\utility\entity::_id_8877(self)) {
    self._id_8986 = 0;
    self._id_87F7 = 0;
    self._id_8783 = 0;
    self._id_9075 = 0;
  }

  if(level._id_A2F7 && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);

    foreach(var_1 in level._id_A8E8) {
      var_1.trigger disableplayeruse(self);
    }
  }

  scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::_id_D550(self.pers["plants"]);
  }

  scripts\mp\utility\stats::_id_D551(0);

  if(isDefined(self.pers["defuses"])) {
    scripts\mp\utility\stats::_id_D551(self.pers["defuses"]);
  }

  level notify("spawned_player");
  checkresetallowspectating();
  thread _id_FCC2();
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);

  if(!isDefined(level._id_6288)) {
    level._id_6288 = 0;
  }

  level._id_6288 = level._id_6288 + 1;

  if(level._id_6288 == 1) {
    _id_07BF::_id_7D94(9, 1);
    var_1 _id_07BF::_id_7D94(6, 1);
  }

  thread _id_34DE();
}

checkresetallowspectating() {
  var_0 = 0;
  var_1 = level._id_E3E2[game["attackers"]];
  var_2 = level._id_E3E2[game["defenders"]];

  if(isDefined(var_1._id_15B5) && var_1._id_15B5 == 1) {
    if(scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
      level._id_E3E2[game["attackers"]]._id_15B5 = 0;
      var_0 = 1;
    }
  }

  if(isDefined(var_2._id_15B5) && var_2._id_15B5 == 1) {
    if(scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
      level._id_E3E2[game["defenders"]]._id_15B5 = 0;
      var_0 = 1;
    }
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
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
  thread _id_07F8::sd_round_end_music(var_0);
}

_id_841C() {
  foreach(var_1 in level.players) {
    if(istrue(var_1._id_8986) && isDefined(var_1._id_9020)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1._id_9020);
      break;
    }
  }
}

_id_AAA3(var_0) {
  _id_841C();

  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_2663) {
      _id_CF9E(game["attackers"], game["end_reason"]["enemies_eliminated"]);
    } else {
      _id_CF9E(game["defenders"], game["end_reason"]["enemies_eliminated"]);
    }
  } else if(var_0 == game["attackers"]) {
    if(level._id_2663) {
      return;
    }
    level thread _id_CF9E(game["defenders"], game["end_reason"]["enemies_eliminated"]);
  } else if(var_0 == game["defenders"])
    level thread _id_CF9E(game["attackers"], game["end_reason"]["enemies_eliminated"]);
}

_id_AB47(var_0) {
  if(level._id_265C > 0 || level._id_2635) {
    return;
  }
  var_1 = scripts\mp\utility\game::_id_6AF7(var_0);
  var_1._id_9075 = 1;
  var_1 thread _id_6FAE();
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;
  var_8 = 0;

  if(isDefined(var_1._id_9075) && var_1._id_9075) {
    var_1 thread _id_0A9F::_id_7003("last_man_kill");
  }

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
    var_1 thread _id_07B1::_id_6FB9("mode_sd_plant_save");
    var_8 = 1;
  } else if(var_0._id_87F7) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
    var_1 thread _id_07B1::_id_6FB9("mode_sd_defuse_save");
    var_8 = 1;
  }

  if(isDefined(level._id_CFA2._id_32D5)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_0.pers["team"]) {
      if(var_1.pers["team"] == level._id_CFA2._id_32D5.team && var_1 != level._id_CFA2._id_32D5) {
        var_9 = distancesquared(level._id_CFA2._id_32D5.origin, var_1.origin);

        if(var_9 < 105625) {
          var_1 thread scripts\mp\rank::_id_CC00("defend");
          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
          var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
          var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
          var_8 = 1;
        }
      }
    }
  }

  if(!var_8) {
    scripts\mp\gametypes\obj_bombzone::_id_2685(var_1, var_0);
  }
}

_id_6FAE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\game::_id_D5FA(3, self.team, self getentitynumber());
  scripts\mp\utility\player::_id_10968(3);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

_id_ABC0() {
  _id_CF9E(game["defenders"], game["end_reason"]["time_limit_reached"]);

  if(!isDefined(level.alreadyhittimelimit)) {
    _id_07BF::_id_FC32();
    level.alreadyhittimelimit = 1;
  }

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_2668)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1._id_2668);
      break;
    }
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_2682 = scripts\mp\utility\dvars::_id_509A("bombtimer", 45, 1, 300);
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 5, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 5, 0, 20);
  level._id_A2F7 = scripts\mp\utility\dvars::_id_509C("multibomb", 0, 0, 1);
  level._id_DD44 = scripts\mp\utility\dvars::_id_509C("silentPlant", 0, 0, 1);
  level._id_C63B = scripts\mp\utility\dvars::_id_509C("resetProgress", 0, 0, 1);
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

  if(scripts\mp\utility\game::isholidayenabled(2)) {
    foreach(var_2 in var_0) {
      var_3 = getEntArray(var_2.target, "targetname");
      var_3[0] setModel("gen_bomb_site_holiday");
    }
  } else if(scripts\mp\utility\game::isholidayenabled(3)) {
    foreach(var_2 in var_0) {
      var_3 = getEntArray(var_2.target, "targetname");
      var_3[0] setModel("gen_bomb_site_vday");
    }
  }

  level._id_A8E8 = [];

  foreach(var_8 in var_0) {
    var_2 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_8, 1, 1);
    var_2._id_AA79 = ::_id_AA79;
    var_2._id_AAC2 = ::_id_AAC2;
    var_2._id_ABCB = ::_id_ABD2;
    level._id_A8E8[var_2._id_A8E1] = var_2;
  }

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  level._id_CFA2 _id_07D6::_id_C579(1, 1, 2);
  level._id_CFA2 _id_07D6::_id_D61B("waypoint_bomb");
  level._id_CFA2 _id_07D6::_id_D8E0("friendly");
  _func_046E(level._id_CFA2._id_A908, 1);
  level._id_CFA3 = level._id_CFA2._id_10430[0];
  _func_0401(level._id_CFA2._id_A908, 1);
  _id_07F9::_id_A8B1(level._id_CFA2._id_A908, 0);
  _id_07F9::_id_A8B2(level._id_CFA2._id_A908, 0);

  if(!_id_07D1::_id_60BE("prematch_done")) {
    wait 0.5;
  }

  foreach(var_2 in level._id_A8E8) {
    var_11 = scripts\mp\gametypes\obj_bombzone::_id_6CED(var_2._id_A8E1);
    var_2 _id_07D6::_id_C579(1, 1, var_11);
    var_2 _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    var_2 _id_07D6::_id_D8E0("any");
    _func_046E(var_2._id_A908, 1);
    _func_046F(var_2._id_A908, 1);
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

  if(isDefined(var_1) && !_id_07D6::_id_886F(var_1.pers["team"])) {
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

_id_D6E0() {
  if(_func_0127() && scripts\mp\utility\game::_id_6B32("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level._id_CF9F[game["attackers"]] = ::scripts\mp\utility\game::_id_6B33(game["attackers"], 5);
  }
}

_id_AA7B(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level._id_A737)) {
    return;
  }
  if(var_3 == game["attackers"]) {
    setgameendtime(0);
    wait 3;
    _id_CF9E(game["attackers"], game["end_reason"]["target_destroyed"]);
  } else {
    setgameendtime(0);
    wait 1.5;
    _id_CF9E(game["defenders"], game["end_reason"]["bomb_defused"]);
  }

  _id_07BF::_id_FC32();
}

_id_FCC2() {
  if(level._id_2663) {
    if(game["attackers"] == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 22);
    } else {
      self setclientomnvar("ui_match_status_hint_text", 23);
    }
  } else if(isDefined(level._id_CFA2)) {
    if(isDefined(level._id_CFA2._id_32D5)) {
      if(level._id_CFA2._id_32D5.team == self.team) {
        if(level._id_CFA2._id_32D5 == self) {
          self setclientomnvar("ui_match_status_hint_text", 21);
        } else {
          self setclientomnvar("ui_match_status_hint_text", 25);
        }
      } else
        self setclientomnvar("ui_match_status_hint_text", 26);
    } else if(game["attackers"] == self.team)
      self setclientomnvar("ui_match_status_hint_text", 24);
    else {
      self setclientomnvar("ui_match_status_hint_text", 26);
    }
  } else
    self setclientomnvar("ui_match_status_hint_text", -1);
}

_id_AB37() {
  level._id_6288 = 0;
  _id_07BF::_id_CB40();
}