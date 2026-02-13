/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hvt.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  game["dialog"]["gametype"] = "gametype_tdm";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x37cb9400dc02387e6", getmatchrulesdata("hvtData", "hvtMaxTargets"));
  setdynamicdvar("#x310f3b8fdf3d0337d", getmatchrulesdata("hvtData", "hvtCaptureValue"));
  setdynamicdvar("#x3d6ccba87107eb70a", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("#x33f7f987edc36b03a", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/WAR_HINT");
  }

  _id_0AA3::_id_C28D(::onplayerspawned);
  _id_0A8E::_id_C285(::_id_AB63);
  _id_8294();
  scripts\mp\gametypes\bradley_spawner::_id_82A8();
  level._id_0F46 = [];
  thread _id_10B85();
}

_id_C619() {
  if(scripts\engine\utility::array_contains(level._id_0F46, self)) {
    level._id_0F46 = scripts\engine\utility::array_remove(level._id_0F46, self);
  }
}

_id_47BE() {
  _id_C795();
  level._id_0F46 = scripts\engine\utility::array_remove(level._id_0F46, self);
  self setclientomnvar("ui_hvt_status", 0);
  thread _id_DCFC("hvt_rank_demoted");
  scripts\mp\rank::_id_CC00("hvt_demoted");
}

_id_E02D(var_0, var_1) {
  if(var_0._id_ED74 == var_1._id_ED74) {
    var_2 = scripts\engine\utility::array_contains(level._id_0F46, var_0);
    return var_2;
  } else
    return var_0._id_ED74 > var_1._id_ED74;
}

_id_ED76() {
  self setclientomnvar("ui_hvt_value", self._id_ED74);
  var_0 = 0;
  var_1 = 0;

  foreach(var_3 in level.players) {
    if(var_3.team == "allies") {
      var_0 = var_0 + var_3._id_ED74;
      continue;
    }

    if(var_3.team == "axis") {
      var_1 = var_1 + var_3._id_ED74;
    }
  }

  scripts\mp\gamescore::_id_0CF2("allies", var_0);
  scripts\mp\gamescore::_id_0CF2("axis", var_1);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_7C19 = scripts\mp\utility\dvars::_id_509C("hvtCaptureValue", 5, 0, 50);
  level._id_7C25 = scripts\mp\utility\dvars::_id_509C("hvtMaxTargets", 3, 1, 10);

  if(_func_0302() < 21) {
    level._id_7C25 = 1;
  }
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(isDefined(level._id_96CC)) {
    _id_0817::_id_D461("BigTDM", "Crit_Frontline");
  } else {
    _id_0817::_id_D461("Default", "Crit_Frontline");
  }

  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_2;
}

_id_DCFC(var_0, var_1) {
  self endon("disconnect");

  if(self.team == "spectator") {
    return;
  }
  thread scripts\mp\hud_message::showsplash(var_0, var_1);
}

_id_88B0() {
  if(!isDefined(level._id_0F46)) {
    return 0;
  }

  return scripts\engine\utility::array_contains(level._id_0F46, self);
}

_id_2477() {
  if(!isDefined(self._id_A90A)) {
    _id_10BD();
  }

  thread _id_DCFC("hvt_rank_up_1", 1);
  scripts\mp\rank::_id_CC00("hvt_status");
  self setclientomnvar("ui_hvt_status", 1);
  scripts\mp\utility\outline::_id_0C2E("outlinefill_nodepth_orange", 0);
  level._id_0F46[level._id_0F46.size] = self;
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(_id_88B0()) {
    var_1 scripts\mp\rank::_id_CC00("hvt_kill");
  }

  var_10 = self getentitynumber();

  if(isDefined(level._id_ACCD[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE8, self);
    scripts\mp\utility\outline::outlinedisable(self._id_ACE7, self);
    self._id_ACE8 = undefined;
    self._id_ACE7 = undefined;
    level._id_ACCD[var_10] = undefined;
  }

  if(self.team == "allies" || self.team == "axis") {
    scripts\mp\gamescore::_id_7001(self.team, self._id_ED74 * -1);
  }
}

_id_C795() {
  if(isDefined(self._id_A90A)) {
    _id_07F9::_id_C799(self._id_A90A);
    _id_07F9::_id_C799(self._id_A909);
    self._id_A90A = undefined;
    self._id_A909 = undefined;
    scripts\mp\utility\outline::_id_0C2D();
  }
}

_id_ABC0() {
  var_0 = scripts\mp\gamescore::_id_6AA0();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

onplayerspawned() {
  self._id_ED74 = 0;

  foreach(var_1 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(var_1 != self && isDefined(var_1._id_A90A)) {
      _func_0185(var_1._id_A90A, self);
    }
  }

  if(_id_88B0()) {
    _id_47BE();
  }
}

_id_AB63(var_0) {
  var_0 _id_C619();
  var_0 _id_C795();
}

_id_10B85() {
  level endon("game_ended");
  level._id_ACCD = [];

  for(;;) {
    var_0 = scripts\engine\utility::_id_1BD6(level.players, ::_id_E02D);
    var_1 = int(min(var_0.size, level._id_7C25));
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(!var_4 _id_88B0() && var_4.team != "spectator" && var_4._id_ED74 >= 10) {
        var_4 _id_2477();
        var_4._id_8CA9 = 1;
      }

      var_2++;

      if(var_2 == level._id_7C25) {
        break;
      }
    }

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_4 = var_0[var_3];

      if(var_4 _id_88B0()) {
        if(isDefined(var_4._id_8CA9)) {
          var_4._id_8CA9 = undefined;
          var_1--;
          continue;
        }

        if(var_1 > 0) {
          var_1--;
          continue;
        }

        var_4 _id_47BE();
      }
    }

    foreach(var_6 in level.players) {
      var_7 = var_6 getentitynumber();
      var_8 = var_6.pers["team"];

      if(var_8 == "allies") {
        var_9 = "axis";
      } else {
        var_9 = "allies";
      }

      if(isalive(var_6) && istrue(var_6 _id_88B0())) {
        if(!isDefined(level._id_ACCD[var_7])) {
          level._id_ACCD[var_7] = var_6;
          var_6._id_ACE8 = scripts\mp\utility\outline::_id_ACD2(var_6, var_8, "outline_nodepth_green", "level_script");
          var_6._id_ACE7 = scripts\mp\utility\outline::_id_ACD2(var_6, var_9, "outline_nodepth_red", "level_script");
        }

        continue;
      }

      if(isDefined(level._id_ACCD[var_7])) {
        scripts\mp\utility\outline::outlinedisable(var_6._id_ACE8, var_6);
        scripts\mp\utility\outline::outlinedisable(var_6._id_ACE7, var_6);
        var_6._id_ACE8 = undefined;
        var_6._id_ACE7 = undefined;
        level._id_ACCD[var_7] = undefined;
      }
    }

    waitframe();
  }
}

_id_10BD() {
  self._id_4140 = self.origin;
  self._id_A97E = (0, 0, 24);
  self._id_A90A = _id_07F9::_id_C57D(1);
  var_0 = self._id_A90A;
  _func_0161(var_0, 90);
  _func_015D(var_0, "hud_icon_frontline_shield_hvt");
  _func_0172(var_0, 1);
  _func_018B(var_0);

  foreach(var_2 in scripts\mp\utility\teams::_id_6DCA(self.team, "players")) {
    if(var_2 != self) {
      _func_0185(var_0, var_2);
    }
  }

  _func_018C(var_0);
  _func_017A(var_0, 0);
  _func_0163(var_0, self getEye() + self._id_A97E);
  _func_016B(var_0, "current");
  _func_0182(var_0, self.team);
  self._id_A909 = _id_07F9::_id_C57D(1);
  var_0 = self._id_A909;
  _func_0161(var_0, 90);
  _func_015D(var_0, "v_ui_icon_hud_deathmarker_deathmarker01");
  _func_0172(var_0, 1);
  _id_07F9::_id_A8CA(var_0, scripts\mp\utility\game::_id_6BE2(self.team)[0]);
  _func_0182(var_0, self.team);
  _func_017A(var_0, 0);
  _func_0163(var_0, self getEye() + self._id_A97E);
  _func_016B(var_0, "current");
  thread _id_FD53();
}

_id_FD53() {
  level endon("game_ended");
  self endon("disconnect");
  self notify("endUpdateHVTObjPos");
  self endon("endUpdateHVTObjPos");

  if(!isDefined(level._id_A912)) {
    level._id_A912 = 3.0;
  }

  for(;;) {
    if(!isDefined(self._id_A90A)) {
      return;
    }
    if(self.health > 0) {
      var_0 = self getEye() + self._id_A97E;
      _id_07F9::_id_FB97(self._id_A90A, var_0);
      _id_07F9::_id_FB97(self._id_A909, var_0);
      _func_018F(self._id_A90A);
      _func_018F(self._id_A909);
    } else
      _id_C795();

    waitframe();
  }
}

_id_C7F5() {}