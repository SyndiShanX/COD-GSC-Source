/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grind.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "dom";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 85);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level._id_4CEB = [];
  scripts\mp\gametypes\obj_grindzone::init();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_9FE9 = ::_id_ABB3;
  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  game["dialog"]["gametype"] = "gametype_grind";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_grind";
  game["dialog"]["offense_obj"] = "boost_grind";
  game["dialog"]["defense_obj"] = "boost_grind";
  game["dialog"]["grind_enable_a"] = "grind_enable_a";
  game["dialog"]["grind_enable_b"] = "grind_enable_b";
  game["dialog"]["grind_disable_a"] = "grind_disable_a";
  game["dialog"]["grind_disable_b"] = "grind_disable_b";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x349db6a80627c6659", getmatchrulesdata("grindData", "bankTime"));
  setdynamicdvar("#x387cae659e8cd5b62", getmatchrulesdata("grindData", "bankRate"));
  setdynamicdvar("#x3cddc4907104bb9c3", getmatchrulesdata("grindData", "bankCaptureTime"));
  setdynamicdvar("#x38a7ca84735af38fc", getmatchrulesdata("grindData", "bankDisable"));
  setdynamicdvar("#x3de08a3ed3b9370a5", getmatchrulesdata("grindData", "bankDisableTags"));
  setdynamicdvar("#x36a2059ece6aafafd", getmatchrulesdata("grindData", "bankDisableTime"));
  setdynamicdvar("#x329dc29855423d0cd", getmatchrulesdata("grindData", "megaBankLimit"));
  setdynamicdvar("#x3a51c2660aebca1c7", getmatchrulesdata("grindData", "megaBankBonusKS"));
  setdynamicdvar("#x39157723e23d9acf7", getmatchrulesdata("grindData", "megaBankBonus"));
  setdynamicdvar("#x3f55fcdcda155b37a", 0);
  scripts\mp\utility\game::_id_C25D("grind", 0);
  setdynamicdvar("#x33e55ee05b4fe1a2a", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/WAR_HINT");
  _id_8294();
  _id_405B();
  level._id_4CE2 = ::_id_4CE2;
  _id_D8C5();
  thread _id_4073();
  level thread _id_C52E();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_21DC = scripts\mp\utility\dvars::_id_509A("bankTime", 2, 0, 10);
  level._id_21D9 = scripts\mp\utility\dvars::_id_509C("bankRate", 1, 1, 10);
  level._id_21CD = scripts\mp\utility\dvars::_id_509C("bankCaptureTime", 0, 0, 10);
  level._id_21CE = scripts\mp\utility\dvars::_id_509C("bankDisable", 1, 0, 1);
  level._id_21CF = scripts\mp\utility\dvars::_id_509C("bankDisableTags", 0, 0, 50);
  level._id_21D0 = scripts\mp\utility\dvars::_id_509C("bankDisableTime", 0, 0, 120);
  level._id_9D38 = scripts\mp\utility\dvars::_id_509C("megaBankLimit", 5, 5, 15);
  level._id_9D37 = scripts\mp\utility\dvars::_id_509C("megaBankBonusKS", 1, 0, 10);
  level._id_9D36 = scripts\mp\utility\dvars::_id_509C("megaBankBonus", 150, 0, 750);
  var_0 = scripts\mp\utility\dvars::getwatcheddvar("scorelimit");

  if(level._id_21CF == 0 && var_0 > 0) {
    level._id_21CF = int(var_0);
  }
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 34);

  if(isDefined(self._id_ED74)) {
    self setclientomnvar("ui_grind_tags", self._id_ED74);
  }
}

_id_ABB3(var_0) {
  self setclientomnvar("ui_grind_tags", 0);
  level thread _id_5067(var_0);
}

_id_405B() {
  level._id_4CE8 = [];

  for(var_0 = 0; var_0 < 50; var_0++) {
    var_1 = spawn("script_model", (0, 0, 0));
    var_1 setModel("military_dogtags_iw8");
    var_1 _meth_82CB("mp_dogtag_spin");
    var_1 setscriptablepartstate("visibility", "hide", 0);
    var_1 setasgametypeobjective();
    var_2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_2._id_0481 = "trigger_dogtag";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "useObject";
    var_3._id_4140 = var_2.origin;
    var_3._id_5513 = var_2 getentitynumber();
    var_3._id_90B8 = 0;
    var_3._id_10430 = var_1;
    var_3._id_A97E = (0, 0, 16);
    var_3.trigger = var_2;
    var_3.trigger _meth_80DB();
    var_3._id_F637 = "proximity";
    var_3 _id_07D6::_id_15DF("none");
    level._id_4CE8[level._id_4CE8.size] = var_3;
  }
}

_id_6DB1() {
  var_0 = level._id_4CE8[0];
  var_1 = gettime();

  foreach(var_3 in level._id_4CE8) {
    if(!isDefined(var_3._id_90B8)) {
      continue;
    }
    if(var_3._id_83B6 == "none") {
      var_0 = var_3;
      break;
    }

    if(var_3._id_90B8 < var_1) {
      var_1 = var_3._id_90B8;
      var_0 = var_3;
    }
  }

  var_0 notify("reset");
  var_0 _id_07D6::_id_81EA();
  var_0._id_90B8 = gettime();
  return var_0;
}

_id_E38B(var_0) {
  var_1 = var_0.origin;
  var_2 = var_0.team;
  var_3 = var_1 + (0, 0, 14);
  var_4 = 35;
  var_5 = var_0 getstance();

  if(var_5 == "prone") {
    var_4 = 14;
  }

  if(var_5 == "crouch") {
    var_4 = 25;
  }

  var_6 = var_1 + (0, 0, var_4);
  var_7 = (0, randomfloat(360), 0);
  var_8 = anglesToForward(var_7);
  var_9 = randomfloatrange(30, 150);
  var_10 = 0.5;
  var_11 = var_3 + var_9 * var_8;
  var_12 = _func_019A(var_3, var_11);
  var_13 = _id_6DB1();
  var_13._id_4140 = var_6;
  var_13.trigger.origin = var_6;
  var_13._id_10430.origin = var_6;
  var_13.team = var_0.team;
  var_13._id_10430.team = var_13.team;
  var_13._id_83B6 = "any";
  var_13.trigger show();
  var_13.trigger linkto(var_13._id_10430, "tag_origin");
  playsoundatpos(var_3, "mp_grind_token_drop");
  var_13 thread _id_ED6C(var_2, var_6, var_12, var_10);
  return var_13;
}

_id_ED6C(var_0, var_1, var_2, var_3) {
  _id_07D6::_id_15DF("any");
  self._id_10430 thread _id_DCF7(self, scripts\mp\utility\game::_id_6BE2(var_0)[0]);
  self._id_10430 setasgametypeobjective();
  var_4 = getdvarint("#x33c01342f08fa6256");
  var_5 = distance(var_1, var_2);
  var_6 = var_2 - var_1;
  var_7 = 0.5 * var_4 * _func_0219(var_3) * -1;
  var_8 = (var_6[0] / var_3, var_6[1] / var_3, (var_6[2] - var_7) / var_3);
  self._id_10430 movegravity(var_8, var_3);
}

_id_DCF7(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self setscriptablepartstate("visibility", "show", 0);
}

_id_A148(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\player::_id_8ACE() || isDefined(var_1._id_E307)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    var_0._id_10430 setscriptablepartstate("visibility", "hide", 0);
    var_0.trigger hide();
    var_0._id_4140 = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0._id_10430.origin = (0, 0, 1000);
    var_0 _id_07D6::_id_15DF("none");
    var_1 _id_B7A5(var_1._id_ED74 + 1);
    var_1 thread _id_0A9F::_id_7003("tag_collected");
    var_1 playSound("mp_grind_token_pickup");

    if(isDefined(level._id_EB99) && level._id_EB99) {
      if(isDefined(var_1._id_3E59) && var_1._id_3E59) {
        var_1 _id_07C1::_id_D4EE("kill");
      } else {
        var_1 _id_07C1::_id_AA91(undefined, var_1);
      }
    }

    break;
  }
}

onplayerconnect(var_0) {
  var_0._id_8A17 = 0;
  var_0 thread _id_A11C();
}

_id_B7A5(var_0) {
  self._id_ED74 = var_0;
  self._id_01F1 = var_0;

  if(var_0 > 999) {
    var_0 = 999;
  }

  self setclientomnvar("ui_grind_tags", var_0);
}

_id_A11C() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    _id_B7A5(0);
  }
}

_id_7902(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

_id_4073() {
  var_0 = getEntArray("grind_location", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_grindzone::_id_D896(var_2, 1, 1);
    var_3 thread _id_CA7E();
    level._id_A8E8[var_3._id_A8E1] = var_3;
  }

  if(level.mapname == "mp_deadzone") {
    var_5 = spawnStruct();
    var_5.origin = (1416, 1368, 300);
    var_5.angles = (0, 0, 0);
    var_5._id_CD99 = "b";
    var_3 = scripts\mp\gametypes\obj_grindzone::_id_D896(var_5, 1, 1);
    var_3 thread _id_CA7E();
    level._id_A8E8[var_3._id_A8E1] = var_3;
  }

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level._id_A8E8) {
    var_7 = scripts\mp\gametypes\obj_grindzone::_id_6CED(var_3._id_A8E1);
    var_3 _id_07D6::_id_C579(1, 1, var_7);
    var_3 _id_07D6::_id_D8E0("any");
    var_3 scripts\mp\gametypes\obj_grindzone::_id_D614();
    var_3 scripts\mp\gametypes\obj_grindzone::_id_D607();
  }
}

_id_88D9(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1._id_ADAE == var_0.team) {
    return 1;
  }

  return 0;
}

_id_CA7E() {
  level endon("game_ended");
  self endon("stop_trigger" + self._id_A8E1);

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(self._id_4A88) {
      continue;
    }
    if(self._id_E57B) {
      continue;
    }
    if(isagent(var_0)) {
      continue;
    }
    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0._id_8A17) {
      continue;
    }
    var_0._id_8A17 = 1;
    level thread _id_BD7C(var_0, self);
  }
}

_id_C52E() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_ED74)) {
      continue;
    }
    var_1._id_ED74 = 0;
  }
}

_id_BD7C(var_0, var_1) {
  while(var_0._id_ED74 && _id_88D9(var_0, var_1) && !var_1._id_E57B && !var_1._id_4A88) {
    if(var_0._id_ED74 >= level._id_9D38) {
      var_0 playsoundtoplayer("mp_grind_token_banked_large", var_0);
      _id_CBF4(var_0, level._id_9D38, var_1);
      var_2 = scripts\mp\rank::getscoreinfovalue("tag_score");
      var_2 = var_2 * level._id_9D38;

      if(!var_0 scripts\mp\utility\perk::_hasperk("specialty_killstreak_to_scorestreak")) {
        var_0 scripts\mp\killstreaks\killstreaks::_id_6FF5("capture", level._id_9D37);
      }

      var_0 thread _id_0A9F::_id_7003("mega_bank", undefined, var_2 + level._id_9D36);
      var_0 scripts\mp\utility\stats::_id_7DAE("tagsMegaBanked", 1);
    } else {
      var_0 playsoundtoplayer("mp_grind_token_banked", var_0);
      var_3 = level._id_21D9;

      if(var_3 > var_0._id_ED74) {
        var_3 = var_0._id_ED74;
      }

      _id_CBF4(var_0, var_3, var_1);

      for(var_4 = 0; var_4 < var_3; var_4++) {
        var_0 thread _id_0A9F::_id_7003("tag_score");
      }
    }

    if(isDefined(level._id_EB99) && level._id_EB99 && isDefined(var_0._id_3E59) && var_0._id_3E59) {
      var_0 _id_07C1::_id_D4EE("kill");
    }

    wait(level._id_21DC);
  }

  var_1 scripts\mp\gametypes\obj_grindzone::_id_D608();
  var_0._id_8A17 = 0;
}

_id_CBF4(var_0, var_1, var_2) {
  var_0 _id_B7A5(var_0._id_ED74 - var_1);
  scripts\mp\gamescore::_id_7001(var_0.team, var_1, 0);
  var_0 scripts\mp\utility\stats::_id_7DAE("confirmed", var_1);
  var_0 scripts\mp\persistence::_id_E770("round", "confirmed", var_0.pers["confirmed"]);
  var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["confirmed"]);

  if(level._id_21CE) {
    var_2._id_ED75 = var_2._id_ED75 + var_1;

    if(var_2._id_ED75 >= level._id_21CF) {
      var_2 _id_07D6::_id_15DF("none");
      var_2 thread _id_1086F();
      var_2._id_4A88 = 1;
      var_2._id_03A9 setscriptablepartstate("flag", "off");
      var_2._id_03A9 setscriptablepartstate("pulse", "off");

      if(isDefined(var_2._id_A8E1)) {
        foreach(var_4 in level._id_EF89) {
          _id_0A8D::_id_E775("grind_disable_" + var_2._id_A8E1, var_4);
        }
      }

      if(level._id_21D0 == 0) {
        return;
      }
      var_2 thread _id_10867();
      return;
    }
  }
}

_id_1086F() {
  foreach(var_1 in level.players) {
    _id_07F9::_id_A8CF(self._id_A908, var_1);
  }

  waitframe();
  _id_07D6::_id_D8E0("none");
}

_id_10867() {
  level endon("game_ended");
  wait(level._id_21D0);
  self._id_4A88 = 0;
  self._id_03A9 setscriptablepartstate("flag", "idle");
  _id_07D6::_id_15DF("any");
  _id_07D6::_id_D8E0("any");

  if(isDefined(self._id_A8E1)) {
    foreach(var_1 in level._id_EF89) {
      _id_0A8D::_id_E775("grind_enable_" + self._id_A8E1, var_1);
    }
  }
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
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

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  level thread _id_5067(var_0, var_1);
}

_id_5067(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(var_0._id_ED74 > 49) {
    var_2 = 49;
  } else if(var_0._id_ED74 > 0) {
    var_2 = var_0._id_ED74;
  } else {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _id_E38B(var_0);
    var_4.team = var_0.team;
    var_4._id_103C2 = var_0;
    var_4.attacker = var_1;
    level notify("new_tag_spawned", var_4);
    level thread _id_A148(var_4);
  }

  var_5 = var_0._id_ED74 - var_2;
  var_5 = int(max(0, var_5));
  var_0 _id_B7A5(var_5);
}

_id_4CE2(var_0) {
  if(isPlayer(var_0)) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["denied"]);
  }
}

_id_D8C5() {
  scripts\mp\gamelogic::_id_D8E5("waypoint_bank_a", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_a", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_bank_b", 0, "neutral", "MP_INGAME_ONLY/OBJ_BANK_CAPS", "icon_waypoint_dom_b", 0);
  scripts\mp\gamelogic::_id_D8E5("waypoint_scoring_foe_a", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_scoring_foe_b", 2, "enemy", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_scoring_friend_a", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_scoring_friend_b", 2, "friendly", "MP_INGAME_ONLY/OBJ_SCORING_CAPS", "icon_waypoint_dom_b", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_contested_a", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_a", 1);
  scripts\mp\gamelogic::_id_D8E5("waypoint_contested_b", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dom_b", 1);
}

_id_C50D() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3806a10bc0145262", "") != "") {
      var_0 = getDvar("#x3806a10bc0145262", "");

      foreach(var_2 in level._id_A8E8) {
        if(isDefined(var_2._id_A8E1) && var_2._id_A8E1 == var_0) {
          var_2 notify("stop_trigger" + var_2._id_A8E1);
          var_2 _id_07D6::_id_15DF("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2._id_1041A = "none";
          var_2 _id_07D6::_id_D61B(undefined, undefined);
          var_3 = [];

          foreach(var_5 in level._id_A8E8) {
            if(var_5._id_A8E1 != var_0) {
              var_3[var_5._id_A8E1] = var_5;
            }
          }

          level._id_A8E8 = var_3;
          break;
        }
      }

      setdynamicdvar("#x3806a10bc0145262", "");
    }

    wait 1;
  }
}

_id_B17A() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3dfcdef2d7e684127", "") != "") {
      var_0 = getDvar("#x3dfcdef2d7e684127", "");
      var_1 = undefined;
      var_2 = getEntArray("grind_location", "targetname");

      foreach(var_4 in var_2) {
        if("_" + var_4._id_CD99 == var_0) {
          var_1 = var_4;
        }
      }

      var_1.origin = level.players[0].origin;
      var_1._id_ADAE = "neutral";
      var_6 = var_1.origin + (0, 0, 32);
      var_7 = var_1.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, undefined, scripts\engine\trace::_id_3EF6(1));
      var_1.origin = var_8["position"];
      var_1._id_FB2F = vectortoangles(var_8["normal"]);
      var_1._id_01D7 = anglesToForward(var_1._id_FB2F);
      var_1._id_0376 = anglestoright(var_1._id_FB2F);
      var_9[0] = spawn("script_model", var_1.origin);
      var_9[0].angles = var_1.angles;
      var_10 = spawn("trigger_radius", var_1.origin, 0, 90, 128);
      var_10._id_CD99 = var_1._id_CD99;
      var_1 = var_10;
      var_11 = _id_07D6::_id_406E("neutral", var_1, var_9, (0, 0, 100));

      if(isDefined(var_1._id_A8E1)) {
        var_11._id_A8E1 = var_1._id_A8E1;
      } else {
        var_11._id_A8E1 = var_11 _id_07D6::_id_6AF1();
      }

      if(isDefined(var_1._id_7C73)) {
        var_11._id_7C73 = var_1._id_7C73;
      } else {
        var_11._id_7C73 = var_11 _id_07D6::_id_6AF1();
      }

      var_11 thread _id_CA7E();
      var_11 _id_07D6::_id_15DF("enemy");
      var_11 _id_07D6::_id_D8D2(level._id_21CD);
      var_11 _id_07D6::_id_D61B("waypoint_defend", "waypoint_bank");
      var_11 _id_07D6::_id_D8E0("any");
      var_11 _id_07D6::_id_316A(1);
      var_11._id_ABCB = scripts\mp\gametypes\obj_grindzone::_id_110D8;
      var_11._id_AA79 = scripts\mp\gametypes\obj_grindzone::_id_110D9;
      var_11._id_ABC8 = scripts\mp\gametypes\obj_grindzone::_id_110D6;
      var_11._id_AA8D = scripts\mp\gametypes\obj_grindzone::_id_110D2;
      var_11._id_ABC7 = scripts\mp\gametypes\obj_grindzone::_id_110D5;
      var_11._id_37F3 = level._id_21CD * 1000;
      var_6 = var_11._id_10430[0].origin + (0, 0, 32);
      var_7 = var_11._id_10430[0].origin + (0, 0, -32);
      var_12 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
      var_13 = [];
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, var_13, var_12);
      var_11._id_22B7 = var_8["position"];
      var_14 = vectortoangles(var_8["normal"]);
      var_14 = -1 * var_14;
      var_11._id_22B6 = anglesToForward(var_14);
      var_11 scripts\mp\gametypes\obj_grindzone::_id_D607();
      level._id_A8E8[var_11._id_A8E1] = var_11;
      setdynamicdvar("#x3dfcdef2d7e684127", "");
    }

    wait 1;
  }
}