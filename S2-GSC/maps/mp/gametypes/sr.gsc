/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\sr.gsc
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
    maps\mp\_utility::func_7BF8(level.var_3FDC, 3, 0, 9);
    maps\mp\_utility::func_7BFA(level.var_3FDC, 2.5);
    maps\mp\_utility::func_7BF9(level.var_3FDC, 1);
    maps\mp\_utility::func_7BF7(level.var_3FDC, 0);
    maps\mp\_utility::func_7C04(level.var_3FDC, 4);
    maps\mp\_utility::func_7BF1(level.var_3FDC, 1);
    maps\mp\_utility::func_7BE5(level.var_3FDC, 0);
    level.var_6031 = 0;
    level.var_6035 = 0;
  }

  level.var_10EB = 1;
  level.var_6933 = 1;
  maps\mp\_utility::func_873B(1);
  level.var_6702 = 1;
  level.var_6B86 = ::maps\mp\gametypes\common_sd_sr::func_6B86;
  level.var_6BAF = ::func_6BAF;
  level.var_6BA7 = ::func_6BA7;
  level.var_6B7B = ::func_6B7B;
  level.var_6AE2 = ::maps\mp\gametypes\common_sd_sr::func_6AE2;
  level.var_6B5E = ::maps\mp\gametypes\common_sd_sr::func_6B5E;
  level.var_6BB6 = ::maps\mp\gametypes\common_sd_sr::func_6BB6;
  level.var_6B5C = ::maps\mp\gametypes\common_sd_sr::func_6B5C;
  level.var_3FC7 = ::maps\mp\gametypes\common_sd_sr::func_5782;
  level.var_0C25 = 0;
  if(level.var_6031 || level.var_6035) {
    level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
  }

  game["dialog"]["gametype"] = "sr_intro";
  if(getdvarint("2043")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  game["dialog"]["kill_confirmed"] = "kc_killconfirmed";
  game["dialog"]["revived"] = "sr_rev";
  setomnvar("ui_bomb_a_timer_endtime", 0);
  setomnvar("ui_bomb_b_timer_endtime", 0);
  level.var_257E["vanish"] = loadfx("vfx/test/test_fx");
}

func_5300() {
  maps\mp\_utility::func_8653();
  var_00 = getmatchrulesdata("srData", "roundLength");
  setdynamicdvar("scr_sr_timelimit", var_00);
  maps\mp\_utility::func_7BFA("sr", var_00);
  var_01 = getmatchrulesdata("srData", "roundSwitch");
  setdynamicdvar("scr_sr_roundswitch", var_01);
  maps\mp\_utility::func_7BF8("sr", var_01, 0, 9);
  var_02 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("scr_sr_winlimit", var_02);
  maps\mp\_utility::func_7C04("sr", var_02);
  setdynamicdvar("scr_sr_bombtimer", getmatchrulesdata("srData", "bombTimer"));
  setdynamicdvar("scr_sr_planttime", getmatchrulesdata("srData", "plantTime"));
  setdynamicdvar("scr_sr_defusetime", getmatchrulesdata("srData", "defuseTime"));
  setdynamicdvar("scr_sr_multibomb", getmatchrulesdata("srData", "multiBomb"));
  setdynamicdvar("scr_sr_silentplant", getmatchrulesdata("srData", "silentPlant"));
  setdynamicdvar("scr_sr_roundlimit", 0);
  maps\mp\_utility::func_7BF7("sr", 0);
  setdynamicdvar("scr_sr_scorelimit", 1);
  maps\mp\_utility::func_7BF9("sr", 1);
  setdynamicdvar("scr_sr_halftime", 0);
  maps\mp\_utility::func_7BE5("sr", 0);
}

func_6BAF() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_00 = game["attackers"];
    var_01 = game["defenders"];
    game["attackers"] = var_01;
    game["defenders"] = var_00;
  }

  setclientnamemode("manual_change");
  level.var_0611["bomb_explosion"] = loadfx("vfx/explosion/mp_gametype_bomb");
  level.var_0611["search_dstry_bomb_arming_light"] = loadfx("vfx/unique/search_dstry_bomb_arming_light");
  maps\mp\_utility::func_86DC(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
  maps\mp\_utility::func_86DC(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  if(level.var_910F) {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_SD_ATTACKER");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_SD_DEFENDER");
  } else {
    maps\mp\_utility::func_86DB(game["attackers"], &"OBJECTIVES_SD_ATTACKER_SCORE");
    maps\mp\_utility::func_86DB(game["defenders"], &"OBJECTIVES_SD_DEFENDER_SCORE");
  }

  maps\mp\_utility::func_86D8(game["attackers"], &"OBJECTIVES_SD_ATTACKER_HINT");
  maps\mp\_utility::func_86D8(game["defenders"], &"OBJECTIVES_SD_DEFENDER_HINT");
  lib_050D::func_10E4();
  var_02[0] = "sd";
  var_02[1] = "bombzone";
  var_02[2] = "blocker";
  maps\mp\gametypes\_gameobjects::func_00F9(var_02);
  maps\mp\gametypes\common_sd_sr::func_A121();
  level.var_31F9 = [];
  maps\mp\gametypes\common_sd_sr::func_872D();
  thread maps\mp\gametypes\common_sd_sr::func_18FD();
}

func_6BA7() {
  var_00 = isDefined(self.var_57A7) && self.var_57A7;
  self.var_5777 = 0;
  self.var_56C2 = 0;
  if(!var_00) {
    self.var_568D = 0;
    self.var_0112 = 0;
  }

  if(isPlayer(self) && !var_00) {
    if(level.var_6510 && self.var_012C["team"] == game["attackers"]) {
      self setclientomnvar("ui_carrying_bomb", 1);
      thread maps\mp\gametypes\_hud_message::func_9102("bomb_pickedup");
    } else {
      self setclientomnvar("ui_carrying_bomb", 0);
    }
  }

  self.var_57A7 = undefined;
  level notify("spawned_player");
  if(self.var_0179 == "axis" || self.var_0179 == "allies") {
    level notify("sr_player_joined", self);
    maps\mp\_utility::func_867B(0);
    if(isDefined(self.var_012C["plants"])) {
      maps\mp\_utility::func_867B(self.var_012C["plants"]);
    }

    maps\mp\_utility::func_867C(0);
    if(isDefined(self.var_012C["defuses"])) {
      maps\mp\_utility::func_867C(self.var_012C["defuses"]);
    }

    self.var_0021 = 0;
    if(isDefined(self.var_012C["denied"])) {
      self.var_0021 = self.var_012C["denied"];
    }
  }
}

func_8BAA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isDefined(self.var_9566)) {
    return 0;
  }

  if(isDefined(self.var_A878)) {
    return 0;
  }

  if(isDefined(param_01) && param_01 == self) {
    return 0;
  }

  if(level.var_984D && isDefined(param_01) && isDefined(param_01.var_01A7) && param_01.var_01A7 == self.var_01A7) {
    return 0;
  }

  if(isDefined(param_01) && !isDefined(param_01.var_01A7) && param_01.var_003A == "trigger_hurt" || param_01.var_003A == "worldspawn") {
    return 0;
  }

  return 1;
}

func_6B7B(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09) {
  if(isPlayer(self)) {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  if(!maps\mp\_utility::func_3FA0("prematch_done")) {
    maps\mp\gametypes\_playerlogic::func_60B2();
  } else {
    var_0A = func_8BAA(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
    if(var_0A) {
      var_0A = var_0A && !maps\mp\_utility::func_57A0(self);
    }

    if(var_0A) {
      var_0A = var_0A && !maps\mp\gametypes\_playerlogic::func_60B2();
    }

    if(var_0A) {
      level thread func_903E(self, param_01);
    }
  }

  thread maps\mp\gametypes\common_sd_sr::func_21AB();
  maps\mp\gametypes\common_sd_sr::func_254C(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09);
}

func_903E(param_00, param_01) {
  if(function_01EF(param_00)) {
    return;
  }

  if(function_01EF(param_01)) {
    param_01 = param_01.var_0117;
  }

  var_02 = param_00.var_0116 + (0, 0, 14);
  if(isDefined(level.var_31F9[param_00.var_48CA])) {
    playFX(level.var_257E["vanish"], level.var_31F9[param_00.var_48CA].var_28D4);
    level.var_31F9[param_00.var_48CA] notify("reset");
  } else {
    var_03[0] = spawn("script_model", (0, 0, 0));
    var_03[0] setclientowner(param_00);
    var_03[0] setModel("prop_dogtags_future_enemy_animated");
    var_03[1] = spawn("script_model", (0, 0, 0));
    var_03[1] setclientowner(param_00);
    var_03[1] setModel("prop_dogtags_future_friend_animated");
    var_04 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    level.var_31F9[param_00.var_48CA] = maps\mp\gametypes\_gameobjects::func_2837("any", var_04, var_03, (0, 0, 16));
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["allies"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["axis"]);
    maps\mp\gametypes\_objpoints::func_2D3E(level.var_31F9[param_00.var_48CA].var_6996["broadcaster"]);
    level.var_31F9[param_00.var_48CA] maps\mp\gametypes\_gameobjects::func_8A5A(0);
    level.var_31F9[param_00.var_48CA].var_6BBF = ::func_6BBF;
    level.var_31F9[param_00.var_48CA].var_A490 = param_00;
    level.var_31F9[param_00.var_48CA].var_A496 = param_00.var_01A7;
    level thread func_2404(param_00);
    param_00 thread func_95BD(level.var_31F9[param_00.var_48CA]);
  }

  level.var_31F9[param_00.var_48CA].var_28D4 = var_02;
  level.var_31F9[param_00.var_48CA].var_9D65.var_0116 = var_02;
  level.var_31F9[param_00.var_48CA].var_A582[0].var_0116 = var_02;
  level.var_31F9[param_00.var_48CA].var_A582[1].var_0116 = var_02;
  level.var_31F9[param_00.var_48CA] maps\mp\gametypes\_gameobjects::func_5307();
  level.var_31F9[param_00.var_48CA] maps\mp\gametypes\_gameobjects::func_0C30("any");
  level.var_31F9[param_00.var_48CA].var_A582[0] thread func_8C21(level.var_31F9[param_00.var_48CA], maps\mp\_utility::func_45DE(param_00.var_01A7));
  level.var_31F9[param_00.var_48CA].var_A582[1] thread func_8C21(level.var_31F9[param_00.var_48CA], param_00.var_01A7);
  level.var_31F9[param_00.var_48CA].var_1180 = param_01;
  if(param_00.var_01A7 == "axis") {
    function_01D1(level.var_31F9[param_00.var_48CA].var_698B, "waypoint_dogtags_friendlys");
    objective_team(level.var_31F9[param_00.var_48CA].var_698B, "axis");
    function_01D1(level.var_31F9[param_00.var_48CA].var_698A, "waypoint_dogtags");
    objective_team(level.var_31F9[param_00.var_48CA].var_698A, "allies");
  } else {
    function_01D1(level.var_31F9[param_00.var_48CA].var_698A, "waypoint_dogtags_friendlys");
    objective_team(level.var_31F9[param_00.var_48CA].var_698A, "allies");
    function_01D1(level.var_31F9[param_00.var_48CA].var_698B, "waypoint_dogtags");
    objective_team(level.var_31F9[param_00.var_48CA].var_698B, "axis");
  }

  objective_position(level.var_31F9[param_00.var_48CA].var_698A, var_02);
  objective_position(level.var_31F9[param_00.var_48CA].var_698B, var_02);
  objective_state(level.var_31F9[param_00.var_48CA].var_698A, "active");
  objective_state(level.var_31F9[param_00.var_48CA].var_698B, "active");
  playsoundatpos(var_02, "mp_killconfirm_tags_drop");
  level notify("sr_player_killed", param_00);
  param_00.var_95B4 = 1;
  param_00.var_0112 = 3;
  level.var_31F9[param_00.var_48CA].var_A582[0] scriptmodelplayanim("mp_dogtag_spin");
  level.var_31F9[param_00.var_48CA].var_A582[1] scriptmodelplayanim("mp_dogtag_spin");
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
    }
  }
}

func_913F() {
  maps\mp\gametypes\_playerlogic::func_50F8(self.var_01A7);
  self.var_0CA4 = 1;
  thread func_A6E1();
}

func_A6E1() {
  self endon("started_spawnPlayer");
  for(;;) {
    wait 0.05;
    if(isDefined(self) && self.var_0178 == "spectator" || !maps\mp\_utility::func_57A0(self)) {
      self.var_012C["lives"] = 1;
      maps\mp\gametypes\_playerlogic::func_9035();
      continue;
    }
  }
}

func_6BBF(param_00) {
  if(isDefined(param_00.var_0117)) {
    param_00 = param_00.var_0117;
  }

  if(param_00.var_012C["team"] == self.var_A496) {
    self.var_9D65 method_8617("mp_snd_ally_revive");
    param_00 thread maps\mp\_events::func_7E63(self.var_A490);
    if(isDefined(self.var_A490)) {
      level notify("sr_player_respawned", self.var_A490);
      self.var_A490 maps\mp\_utility::func_5C43("revived");
    }

    if(isDefined(self.var_A490)) {
      if(!level.var_3F9D) {
        self.var_A490 thread func_913F();
      }
    }

    param_00 maps\mp\gametypes\_missions::func_7750("ch_rescuer");
    if(!isDefined(param_00.var_7D26)) {
      param_00.var_7D26 = [];
    }

    param_00.var_7D26[self.var_A490.var_48CA] = 1;
    if(param_00.var_7D26.size == 4) {
      param_00 maps\mp\gametypes\_missions::func_7750("ch_helpme");
    }
  } else {
    self.var_9D65 method_8617("mp_killconfirm_tags_pickup");
    param_00 thread maps\mp\_events::func_35D3();
    if(isDefined(self.var_A490)) {
      if(!level.var_3F9D) {
        self.var_A490 maps\mp\_utility::func_86C3("spawn_info", game["strings"]["spawn_next_round"]);
        self.var_A490 thread maps\mp\gametypes\_playerlogic::func_7CFA(3);
      }

      self.var_A490.var_95B4 = undefined;
    }

    param_00 maps\mp\_utility::func_5C43("kill_confirmed");
    param_00 maps\mp\gametypes\_missions::func_7750("ch_hideandseek");
  }

  self.var_A490.var_0112 = 0;
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
  objective_state(self.var_698A, "invisible");
  objective_state(self.var_698B, "invisible");
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
      objective_delete(level.var_31F9[var_01].var_698A);
      objective_delete(level.var_31F9[var_01].var_698A);
      level.var_31F9[var_01].var_9D65 delete();
      for(var_02 = 0; var_02 < level.var_31F9[var_01].var_A582.size; var_02++) {
        level.var_31F9[var_01].var_A582[var_02] delete();
      }

      level.var_31F9[var_01] notify("deleted");
      level.var_31F9[var_01] = undefined;
    }
  }
}