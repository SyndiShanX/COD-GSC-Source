/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\conf.gsc
*********************************************/

func_00F9() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::func_00D5();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.var_3FDC, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 10);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 65);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 1);
    maps\mp\_utility::func_7C04(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 0);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  level.var_6BAF = ::func_6BAF;
  level.var_6B5C = ::func_6B5C;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "kc_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["kill_denied"] = "kc_killdenied";
  game["dialog"]["kill_lost"] = "kc_killlost";
  game["dialog"]["defense_obj"] = "kc_start";
  game["dialog"]["offense_obj"] = "kc_start";
  level.var_257E["vanish"] = loadfx("vfx/unique/dogtag_vanish");
}

func_5300() {
  maps\mp\_utility::func_8653();
  setdynamicdvar("scr_conf_roundswitch", 0);
  maps\mp\_utility::func_7BF8("conf", 0, 0, 9);
  setdynamicdvar("scr_conf_roundlimit", 1);
  maps\mp\_utility::func_7BF7("conf", 1);
  setdynamicdvar("scr_conf_winlimit", 1);
  maps\mp\_utility::func_7C04("conf", 1);
  setdynamicdvar("scr_conf_halftime", 0);
  maps\mp\_utility::func_7BE5("conf", 0);
}

func_6BAF() {
  setclientnamemode("auto_change");
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  maps\mp\_utility::func_86DC("allies", &"OBJECTIVES_CONF");
  maps\mp\_utility::func_86DC("axis", &"OBJECTIVES_CONF");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_CONF");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_CONF");
  } else {
    maps\mp\_utility::func_86DB("allies", &"OBJECTIVES_CONF_SCORE");
    maps\mp\_utility::func_86DB("axis", &"OBJECTIVES_CONF_SCORE");
  }

  maps\mp\_utility::func_86D8("allies", &"OBJECTIVES_CONF_HINT");
  maps\mp\_utility::func_86D8("axis", &"OBJECTIVES_CONF_HINT");
  lib_050D::func_10E4();
  level.var_31F9 = [];
  var_02[0] = level.var_3FDC;
  var_02[1] = "blocker_conf";
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
}

func_6B5C(param_00, param_01, param_02) {
  level thread func_903E(param_00, param_01);
  if(game["state"] == "postgame" && game["teamScores"][param_01.var_01A7] > game["teamScores"][level.var_6C63[param_01.var_01A7]]) {
    param_01.var_3B4B = 1;
  }
}

func_903E(param_00, param_01) {
  var_02 = param_00.var_012C["team"];
  if(isDefined(level.var_31F9[param_00.var_48CA])) {
    playFX(level.var_257E["vanish"], level.var_31F9[param_00.var_48CA].var_28D4);
    level.var_31F9[param_00.var_48CA] notify("reset");
  } else {
    var_03 = [];
    if(isDefined(param_00.var_01A7) && param_00.var_01A7 == "allies") {
      var_03[0] = spawn("script_model", (0, 0, 0));
      var_03[0] setModel("prop_usa_kc_dogtags");
      var_03[1] = spawn("script_model", (0, 0, 0));
      var_03[1] setModel("prop_usa_kc_dogtags");
    } else if(isDefined(param_00.var_01A7) && param_00.var_01A7 == "axis") {
      var_03[0] = spawn("script_model", (0, 0, 0));
      var_03[0] setModel("prop_ger_kc_dogtags");
      var_03[1] = spawn("script_model", (0, 0, 0));
      var_03[1] setModel("prop_ger_kc_dogtags");
    }

    var_04 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.var_31F9[param_00.var_48CA] = maps\mp\gametypes\_gameobjects::func_2837("any", var_04, var_03, (0, 0, 16));
    maps\mp\_utility::func_068B(level.var_31F9[param_00.var_48CA].var_698A);
    maps\mp\_utility::func_068B(level.var_31F9[param_00.var_48CA].var_698B);
    maps\mp\_utility::func_068B(level.var_31F9[param_00.var_48CA].var_698C);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["allies"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["axis"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["broadcaster"]);
    level.var_31F9[param_00.var_48CA] maps\mp\gametypes\_gameobjects::func_8A5A(0);
    level.var_31F9[param_00.var_48CA].var_6BBF = ::func_6BBF;
    level.var_31F9[param_00.var_48CA].var_A490 = param_00;
    level.var_31F9[param_00.var_48CA].var_A496 = var_02;
    level.var_31F9[param_00.var_48CA].var_6989 = maps\mp\gametypes\_gameobjects::func_45A9();
    objective_add(level.var_31F9[param_00.var_48CA].var_6989, "invisible", (0, 0, 0));
    level.var_31F9[param_00.var_48CA].var_6988 = maps\mp\gametypes\_gameobjects::func_45A9();
    objective_add(level.var_31F9[param_00.var_48CA].var_6988, "invisible", (0, 0, 0));
    level thread func_2404(param_00);
    param_00 thread func_95BD(level.var_31F9[param_00.var_48CA]);
  }

  if(isDefined(param_01.var_6E6B) && param_01.var_6E6B && isDefined(param_01.paratrooperinsertgroundposition)) {
    var_05 = param_01.paratrooperinsertgroundposition + (0, 0, 14);
  } else {
    var_05 = var_02.var_0116 + (0, 0, 14);
  }

  level.var_31F9[param_01.var_48CA].var_28D4 = var_05;
  level.var_31F9[param_01.var_48CA].var_9D65.var_0116 = var_05;
  level.var_31F9[param_01.var_48CA].var_A582[0].var_0116 = var_05;
  level.var_31F9[param_01.var_48CA].var_A582[1].var_0116 = var_05;
  level.var_31F9[param_01.var_48CA] maps\mp\gametypes\_gameobjects::func_5307();
  level.var_31F9[param_01.var_48CA] maps\mp\gametypes\_gameobjects::func_0C30("any");
  level.var_31F9[param_01.var_48CA].var_A582[0] thread func_8C21(level.var_31F9[param_01.var_48CA], maps\mp\_utility::func_45DE(var_03));
  level.var_31F9[param_01.var_48CA].var_A582[1] thread func_8C21(level.var_31F9[param_01.var_48CA], var_03);
  level.var_31F9[param_01.var_48CA].var_A582[0] func_84DF("friendly", 1);
  level.var_31F9[param_01.var_48CA].var_A582[1] func_84DF("enemy", 1);
  level.var_31F9[param_01.var_48CA].var_1180 = var_02;
  function_01D1(level.var_31F9[param_01.var_48CA].var_6989, "waypoint_dogtags");
  objective_position(level.var_31F9[param_01.var_48CA].var_6989, var_05);
  objective_state(level.var_31F9[param_01.var_48CA].var_6989, "active");
  objective_playerenemyteam(level.var_31F9[param_01.var_48CA].var_6989, param_01 getentitynumber());
  function_01D1(level.var_31F9[param_01.var_48CA].var_6988, "waypoint_dogtags_friendlys");
  objective_position(level.var_31F9[param_01.var_48CA].var_6988, var_05);
  objective_state(level.var_31F9[param_01.var_48CA].var_6988, "active");
  objective_playerteam(level.var_31F9[param_01.var_48CA].var_6988, param_01 getentitynumber());
  playsoundatpos(var_05, "mp_killconfirm_tags_drop");
  level.var_31F9[param_01.var_48CA].var_A582[0] scriptmodelplayanim("mp_dogtag_spin");
  level.var_31F9[param_01.var_48CA].var_A582[1] scriptmodelplayanim("mp_dogtag_spin");
}

func_8C21(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("reset");
  self method_805C();
  foreach(var_03 in level.var_744A) {
    if(var_03.var_01A7 == param_01) {
      self showtoclient(var_03);
    }

    if(var_03.var_01A7 == "spectator" && param_01 == "allies") {
      self showtoclient(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self method_805C();
    foreach(var_03 in level.var_744A) {
      if(var_03.var_01A7 == param_01) {
        self showtoclient(var_03);
      }

      if(var_03.var_01A7 == "spectator" && param_01 == "allies") {
        self showtoclient(var_03);
      }

      if(param_00.var_A496 == var_03.var_01A7 && var_03 == param_00.var_1180) {
        objective_state(param_00.var_6989, "invisible");
      }
    }
  }
}

func_6BBF(param_00) {
  if(isDefined(param_00.var_0117)) {
    param_00 = param_00.var_0117;
  }

  var_01 = param_00.var_012C["team"];
  if(var_01 == self.var_A496) {
    var_02 = lib_0380::func_6842("mp_kc_tag_denied", undefined, param_00.var_0116);
    if(isPlayer(param_00)) {
      param_00 maps\mp\_utility::func_5C43("kill_denied");
    }

    if(isDefined(self.var_1180) && isPlayer(self.var_1180)) {
      self.var_1180 maps\mp\_utility::func_5C43("kc_killlost");
    }

    var_03 = self.var_A490 == param_00;
    param_00 maps\mp\_events::func_5A38(var_03);
  } else {
    var_04 = lib_0380::func_6842("mp_kc_tag_collected", undefined, param_00.var_0116);
    if(isPlayer(self.var_1180) && self.var_1180 != param_00) {
      level thread maps\mp\gametypes\_rank::func_1457("team_confirmed", self.var_1180);
    }

    param_00 maps\mp\_events::func_5A35();
    if(isPlayer(param_00)) {
      param_00 maps\mp\_utility::func_5C43("kill_confirmed");
    }

    param_00 maps\mp\gametypes\_gamescore::func_47BD(var_01, 1, 1);
  }

  level thread maps\mp\_events::func_63E9(param_00);
  func_7D6F();
}

func_7D6F() {
  self.var_1180 = undefined;
  self notify("reset");
  self.var_A582[0] method_805C();
  self.var_A582[1] method_805C();
  self.var_28D4 = (0, 0, 1000);
  self.var_9D65.var_0116 = (0, 0, 1000);
  self.var_A582[0].var_0116 = (0, 0, 1000);
  self.var_A582[1].var_0116 = (0, 0, 1000);
  maps\mp\gametypes\_gameobjects::func_0C30("none");
  objective_state(self.var_6989, "invisible");
  objective_state(self.var_6988, "invisible");
}

func_95BD(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    param_00.var_A496 = self.var_012C["team"];
    param_00 func_7D6F();
  }
}

func_2404(param_00) {
  level endon("game_ended");
  var_01 = param_00.var_48CA;
  param_00 waittill("disconnect");
  if(isDefined(level.var_31F9[var_01])) {
    level.var_31F9[var_01] maps\mp\gametypes\_gameobjects::func_0C30("none");
    playFX(level.var_257E["vanish"], level.var_31F9[var_01].var_28D4);
    level.var_31F9[var_01] notify("reset");
    wait 0.05;
    if(isDefined(level.var_31F9[var_01])) {
      objective_delete(level.var_31F9[var_01].var_6989);
      objective_delete(level.var_31F9[var_01].var_6988);
      level.var_31F9[var_01].var_9D65 delete();
      for(var_02 = 0; var_02 < level.var_31F9[var_01].var_A582.size; var_02++) {
        level.var_31F9[var_01].var_A582[var_02] delete();
      }

      level.var_31F9[var_01] notify("deleted");
      level.var_31F9[var_01] = undefined;
    }
  }
}

func_84DF(param_00, param_01) {
  var_02 = undefined;
  param_00 = tolower(param_00);
  var_03["friendly"] = 1;
  var_03["enemy"] = 2;
  var_03["objective"] = 5;
  var_03["neutral"] = 0;
  var_02 = var_03[param_00];
  self hudoutlineenable(var_02, param_01);
}