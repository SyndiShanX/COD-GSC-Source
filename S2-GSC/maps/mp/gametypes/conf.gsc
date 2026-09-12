/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\conf.gsc
*********************************************/

main() {
  if(getDvar("1673") == "mp_background") {
    return;
  }

  maps\mp\gametypes\_globallogic::init();
  lib_01DD::func_8A0C();
  maps\mp\gametypes\_globallogic::func_8A0C();
  if(isusingmatchrulesdata()) {
    level.var_5300 = ::func_5300;
    [[level.var_5300]]();
    level thread maps\mp\_utility::func_7C13();
  } else {
    maps\mp\_utility::func_7BF8(level.gametype, 0, 0, 9);
    maps\mp\_utility::func_7BFA(level.gametype, 10);
    maps\mp\_utility::func_7BF9(level.gametype, 65);
    maps\mp\_utility::func_7BF7(level.gametype, 1);
    maps\mp\_utility::func_7C04(level.gametype, 1);
    maps\mp\_utility::func_7BF1(level.gametype, 0);
    maps\mp\_utility::func_7BE5(level.gametype, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  maps\mp\_utility::func_873B(1);
  level.var_6BAF = ::func_6BAF;
  level.onnormaldeath = ::onnormaldeath;
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
  if(level.splitscreen) {
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
  var_02[0] = level.gametype;
  var_02[1] = "blocker_conf";
  maps\mp\gametypes\_gameobjects::main(var_02);
}

onnormaldeath(param_00, param_01, param_02) {
  level thread func_903E(param_00, param_01);
  if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.var_6C63[param_01.team]]) {
    param_01.finalkill = 1;
  }
}

func_903E(param_00, param_01) {
  var_02 = param_00.pers["team"];
  if(isDefined(level.var_31F9[param_00.guid])) {
    playFX(level.var_257E["vanish"], level.var_31F9[param_00.guid].var_28D4);
    level.var_31F9[param_00.guid] notify("reset");
  } else {
    var_03 = [];
    if(isDefined(param_00.team) && param_00.team == "allies") {
      var_03[0] = spawn("script_model", (0, 0, 0));
      var_03[0] setModel("prop_usa_kc_dogtags");
      var_03[1] = spawn("script_model", (0, 0, 0));
      var_03[1] setModel("prop_usa_kc_dogtags");
    } else if(isDefined(param_00.team) && param_00.team == "axis") {
      var_03[0] = spawn("script_model", (0, 0, 0));
      var_03[0] setModel("prop_ger_kc_dogtags");
      var_03[1] = spawn("script_model", (0, 0, 0));
      var_03[1] setModel("prop_ger_kc_dogtags");
    }

    var_04 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.var_31F9[param_00.guid] = maps\mp\gametypes\_gameobjects::func_2837("any", var_04, var_03, (0, 0, 16));
    maps\mp\_utility::func_68B(level.var_31F9[param_00.guid].var_698A);
    maps\mp\_utility::func_68B(level.var_31F9[param_00.guid].var_698B);
    maps\mp\_utility::func_68B(level.var_31F9[param_00.guid].var_698C);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.guid].var_6996["allies"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.guid].var_6996["axis"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.guid].var_6996["broadcaster"]);
    level.var_31F9[param_00.guid] maps\mp\gametypes\_gameobjects::func_8A5A(0);
    level.var_31F9[param_00.guid].var_6BBF = ::func_6BBF;
    level.var_31F9[param_00.guid].victim = param_00;
    level.var_31F9[param_00.guid].var_A496 = var_02;
    level.var_31F9[param_00.guid].var_6989 = maps\mp\gametypes\_gameobjects::func_45A9();
    objective_add(level.var_31F9[param_00.guid].var_6989, "invisible", (0, 0, 0));
    level.var_31F9[param_00.guid].var_6988 = maps\mp\gametypes\_gameobjects::func_45A9();
    objective_add(level.var_31F9[param_00.guid].var_6988, "invisible", (0, 0, 0));
    level thread func_2404(param_00);
    param_00 thread func_95BD(level.var_31F9[param_00.guid]);
  }

  if(isDefined(param_00.var_6E6B) && param_00.var_6E6B && isDefined(param_00.paratrooperinsertgroundposition)) {
    var_05 = param_00.paratrooperinsertgroundposition + (0, 0, 14);
  } else {
    var_05 = param_01.origin + (0, 0, 14);
  }

  level.var_31F9[param_00.guid].var_28D4 = var_05;
  level.var_31F9[param_00.guid].var_9D65.origin = var_05;
  level.var_31F9[param_00.guid].var_A582[0].origin = var_05;
  level.var_31F9[param_00.guid].var_A582[1].origin = var_05;
  level.var_31F9[param_00.guid] maps\mp\gametypes\_gameobjects::func_5307();
  level.var_31F9[param_00.guid] maps\mp\gametypes\_gameobjects::func_C30("any");
  level.var_31F9[param_00.guid].var_A582[0] thread func_8C21(level.var_31F9[param_00.guid], maps\mp\_utility::func_45DE(var_02));
  level.var_31F9[param_00.guid].var_A582[1] thread func_8C21(level.var_31F9[param_00.guid], var_02);
  level.var_31F9[param_00.guid].var_A582[0] func_84DF("friendly", 1);
  level.var_31F9[param_00.guid].var_A582[1] func_84DF("enemy", 1);
  level.var_31F9[param_00.guid].attacker = param_01;
  function_01D1(level.var_31F9[param_00.guid].var_6989, "waypoint_dogtags");
  objective_position(level.var_31F9[param_00.guid].var_6989, var_05);
  objective_state(level.var_31F9[param_00.guid].var_6989, "active");
  objective_playerenemyteam(level.var_31F9[param_00.guid].var_6989, param_00 getentitynumber());
  function_01D1(level.var_31F9[param_00.guid].var_6988, "waypoint_dogtags_friendlys");
  objective_position(level.var_31F9[param_00.guid].var_6988, var_05);
  objective_state(level.var_31F9[param_00.guid].var_6988, "active");
  objective_playerteam(level.var_31F9[param_00.guid].var_6988, param_00 getentitynumber());
  playsoundatpos(var_05, "mp_killconfirm_tags_drop");
  level.var_31F9[param_00.guid].var_A582[0] scriptmodelplayanim("mp_dogtag_spin");
  level.var_31F9[param_00.guid].var_A582[1] scriptmodelplayanim("mp_dogtag_spin");
}

func_8C21(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("reset");
  self hide();
  foreach(var_03 in level.players) {
    if(var_03.team == param_01) {
      self showtoclient(var_03);
    }

    if(var_03.team == "spectator" && param_01 == "allies") {
      self showtoclient(var_03);
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();
    foreach(var_03 in level.players) {
      if(var_03.team == param_01) {
        self showtoclient(var_03);
      }

      if(var_03.team == "spectator" && param_01 == "allies") {
        self showtoclient(var_03);
      }

      if(param_00.var_A496 == var_03.team && var_03 == param_00.attacker) {
        objective_state(param_00.var_6989, "invisible");
      }
    }
  }
}

func_6BBF(param_00) {
  if(isDefined(param_00.owner)) {
    param_00 = param_00.owner;
  }

  var_01 = param_00.pers["team"];
  if(var_01 == self.var_A496) {
    var_02 = lib_0380::func_6842("mp_kc_tag_denied", undefined, param_00.origin);
    if(isPlayer(param_00)) {
      param_00 maps\mp\_utility::func_5C43("kill_denied");
    }

    if(isDefined(self.attacker) && isPlayer(self.attacker)) {
      self.attacker maps\mp\_utility::func_5C43("kc_killlost");
    }

    var_03 = self.victim == param_00;
    param_00 maps\mp\_events::func_5A38(var_03);
  } else {
    var_04 = lib_0380::func_6842("mp_kc_tag_collected", undefined, param_00.origin);
    if(isPlayer(self.attacker) && self.attacker != param_00) {
      level thread maps\mp\gametypes\_rank::func_1457("team_confirmed", self.attacker);
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
  self.attacker = undefined;
  self notify("reset");
  self.var_A582[0] hide();
  self.var_A582[1] hide();
  self.var_28D4 = (0, 0, 1000);
  self.var_9D65.origin = (0, 0, 1000);
  self.var_A582[0].origin = (0, 0, 1000);
  self.var_A582[1].origin = (0, 0, 1000);
  maps\mp\gametypes\_gameobjects::func_C30("none");
  objective_state(self.var_6989, "invisible");
  objective_state(self.var_6988, "invisible");
}

func_95BD(param_00) {
  level endon("game_ended");
  self endon("disconnect");
  for(;;) {
    self waittill("joined_team");
    param_00.var_A496 = self.pers["team"];
    param_00 func_7D6F();
  }
}

func_2404(param_00) {
  level endon("game_ended");
  var_01 = param_00.guid;
  param_00 waittill("disconnect");
  if(isDefined(level.var_31F9[var_01])) {
    level.var_31F9[var_01] maps\mp\gametypes\_gameobjects::func_C30("none");
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