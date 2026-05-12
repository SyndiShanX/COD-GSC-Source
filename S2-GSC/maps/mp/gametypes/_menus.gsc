/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\gametypes\_menus.gsc
*********************************************/

func_00D5() {
  if(!isDefined(game["gamestarted"])) {
    game["menu_team"] = "team_marinesopfor";
    if(level.var_6520) {
      game["menu_team"] = "team_mt_options";
    }

    game["menu_class"] = "class";
    game["menu_class_allies"] = "class_marines";
    game["menu_class_axis"] = "class_opfor";
    game["menu_changeclass_allies"] = "changeclass_marines";
    game["menu_changeclass_axis"] = "changeclass_opfor";
    if(level.var_6520) {
      for(var_00 = 0; var_00 < level.var_985B.size; var_00++) {
        var_01 = "menu_class_" + level.var_985B[var_00];
        var_02 = "menu_changeclass_" + level.var_985B[var_00];
        game[var_01] = game["menu_class_allies"];
        game[var_02] = "changeclass_marines";
      }
    }

    game["menu_changeclass"] = "changeclass";
    if(level.var_258F) {
      game["menu_controls"] = "ingame_controls";
      if(level.var_910F) {
        if(level.var_6520) {
          for(var_00 = 0; var_00 < level.var_985B.size; var_00++) {
            var_01 = "menu_class_" + level.var_985B[var_00];
            var_02 = "menu_changeclass_" + level.var_985B[var_00];
            game[var_01] = game[var_01] + "_splitscreen";
            game[var_02] = game[var_02] + "_splitscreen";
          }
        }

        game["menu_team"] = game["menu_team"] + "_splitscreen";
        game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
        game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
        game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
        game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
        game["menu_controls"] = game["menu_controls"] + "_splitscreen";
        game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
        game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
      }
    }

    precachestring(&"MP_HOST_ENDED_GAME");
    precachestring(&"MP_HOST_ENDGAME_RESPONSE");
  }

  if(!function_0367()) {
    level thread func_6B6C();
  }
}

func_6B6C() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_A921();
  }
}

func_445C(param_00) {
  if(param_00 <= 100) {
    if(maps\mp\_utility::func_761E()) {
      param_00 = "practice" + param_00;
    } else {
      param_00 = "custom" + param_00;
    }
  } else if(param_00 <= 200) {
    param_00 = param_00 - 101;
    param_00 = "class" + param_00;
  } else if(param_00 <= 206) {
    param_00 = param_00 - 200;
    param_00 = "axis_recipe" + param_00;
  } else {
    param_00 = param_00 - 206;
    param_00 = "allies_recipe" + param_00;
  }

  return param_00;
}

func_A921() {
  self endon("disconnect");
  level endon("game_ended");
  for(;;) {
    self waittill("luinotifyserver", var_00, var_01);
    if(var_00 == "class_select") {
      func_4AAF(var_01);
    }

    if(var_00 == "end_game") {
      func_4AD2();
    }

    if(var_00 == "team_select") {
      func_4AFB(var_01);
    }
  }
}

func_4AAF(param_00) {
  if(maps\mp\_utility::func_56B3() && self method_8436() && !maps\mp\_utility::func_551F()) {
    self setclientomnvar("ui_options_menu", 0);
    return;
  }

  if(!function_026D(self) && !isai(self)) {
    if("" + param_00 != "callback") {
      self setclientomnvar("ui_loadout_selected", param_00);
    }
  }

  if(isDefined(self.var_A6EF) && self.var_A6EF) {
    return;
  }

  if(!maps\mp\_utility::func_0C1E()) {
    return;
  }

  self setclientomnvar("ui_options_menu", 0);
  if("" + param_00 != "callback") {
    if(isbot(self) || function_026D(self)) {
      self.var_012C["class"] = param_00;
      self.var_2319 = param_00;
      maps\mp\gametypes\_class::func_23DC();
      return;
    }

    var_01 = param_00 + 1;
    var_01 = func_445C(var_01);
    if(!isDefined(self.var_012C["class"]) || var_01 == self.var_012C["class"]) {
      return;
    }

    self.var_012C["class"] = var_01;
    self.var_2319 = var_01;
    maps\mp\gametypes\_class::func_23DC();
    thread func_6112();
    return;
  }

  func_6111("callback");
}

func_4AD2() {
  level thread maps\mp\gametypes\_gamelogic::func_3E1A();
}

func_4AFB(param_00) {
  if(!getdvarint("3193") && level.var_3FDC != "infect") {
    if(maps\mp\_utility::func_602B() && !getdvarint("850") && !getdvarint("5357")) {
      return;
    }
  }

  if(common_scripts\utility::func_562E(level.blockteamchange) && common_scripts\utility::func_562E(self.var_4B96)) {
    return;
  }

  if(param_00 != 3) {
    thread func_8C08();
  }

  if(param_00 == 3) {
    self setclientomnvar("ui_options_menu", 0);
    self setclientomnvar("ui_spectator_selected", 1);
    self setclientomnvar("ui_loadout_selected", -1);
    self.var_90E3 = 1;
    if(maps\mp\_utility::func_56B3()) {
      self method_8506(1);
      thread maps\mp\gametypes\_spectating::func_872F();
    }
  } else {
    self setclientomnvar("ui_spectator_selected", -1);
    self.var_90E3 = 0;
    if(maps\mp\_utility::func_56B3()) {
      self method_8506(0);
    }
  }

  self setclientomnvar("ui_team_selected", param_00);
  if(param_00 == 0) {
    param_00 = "axis";
  } else if(param_00 == 1) {
    param_00 = "allies";
  } else if(param_00 == 2) {
    param_00 = "random";
  } else {
    param_00 = "spectator";
  }

  if(isDefined(self.var_012C["team"]) && param_00 == self.var_012C["team"]) {
    self notify("selected_same_team");
    return;
  }

  self setclientomnvar("ui_loadout_selected", -1);
  self setclientomnvar("ui_session_state", "team_select");
  if(param_00 == "axis") {
    thread func_873A("axis");
    return;
  }

  if(param_00 == "allies") {
    thread func_873A("allies");
    return;
  }

  if(param_00 == "random") {
    self thread[[level.var_1385]]();
    return;
  }

  if(param_00 == "spectator") {
    thread func_8730();
    return;
  }
}

func_8C08() {
  self endon("disconnect");
  level endon("game_ended");
  common_scripts\utility::func_A70A("joined_team", "selected_same_team");
  if(maps\mp\_utility::func_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::func_8753(2);
    return;
  }

  if(maps\mp\_utility::isprophuntgametype() || maps\mp\_utility::isdogfightgametype()) {
    thread maps\mp\gametypes\_playerlogic::func_8753(-1);
  }
}

func_1385() {
  if(maps\mp\_utility::func_56B9()) {
    thread func_873A("allies");
    self.var_0179 = "allies";
    return;
  }

  if(!isDefined(self.var_01A7)) {
    if(self method_8436() && !maps\mp\_utility::func_551F()) {
      thread func_8730();
    } else if(function_0154() == "hub") {
      var_00 = function_02EE();
      if(var_00 == "axis") {
        thread func_873A("axis");
      } else {
        thread func_873A("allies");
      }
    } else if(level.var_984F["axis"] < level.var_984F["allies"]) {
      thread func_873A("axis");
    } else if(level.var_984F["allies"] < level.var_984F["axis"]) {
      thread func_873A("allies");
    } else if(getteamscore("allies") > getteamscore("axis")) {
      thread func_873A("axis");
    } else {
      thread func_873A("allies");
    }

    return;
  }

  if(self method_8436() && !maps\mp\_utility::func_551F()) {
    thread func_8730();
    return;
  }

  if(level.var_984F["axis"] < level.var_984F["allies"] && self.var_01A7 != "axis") {
    thread func_873A("axis");
    return;
  }

  if(level.var_984F["allies"] < level.var_984F["axis"] && self.var_01A7 != "allies") {
    thread func_873A("allies");
    return;
  }

  if(level.var_984F["allies"] == level.var_984F["axis"]) {
    if(getteamscore("allies") > getteamscore("axis") && self.var_01A7 != "axis") {
      thread func_873A("axis");
      return;
    }

    if(self.var_01A7 != "allies") {
      thread func_873A("allies");
      return;
    }

    self setclientomnvar("ui_session_state", self.var_0178);
    return;
  }
}

func_873A(param_00) {
  self endon("disconnect");
  if(!isai(self) && level.var_984D && !maps\mp\gametypes\_teams::func_452D(param_00)) {
    self setclientomnvar("ui_session_state", self.var_0178);
    return;
  }

  if(level.var_5139 && !self.var_4B62) {
    self.var_4B96 = 0;
  }

  if(self.var_0178 == "playing") {
    self.var_9566 = 1;
    self.var_596B = param_00;
    self.var_5C62 = self.var_012C["team"];
  }

  func_09FC(param_00);
  if(self.var_0178 == "playing") {
    self suicide();
  }

  self.did_cancel_class_select = 0;
  func_A69A();
  func_36E3();
  if(self.var_0178 == "spectator") {
    if(maps\mp\_utility::func_579B() && common_scripts\utility::func_562E(self.var_3A61)) {
      self.var_3A61 = undefined;
      return;
    }

    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !maps\mp\_utility::func_5727()) {
      if(isDefined(self.var_A6F1) && self.var_A6F1) {
        return;
      }

      maps\mp\gametypes\_playerlogic::func_9035();
    }

    thread maps\mp\gametypes\_spectating::func_872F();
  }
}

func_8730() {
  if(isDefined(self.var_012C["team"]) && self.var_012C["team"] == "spectator") {
    return;
  }

  if(isalive(self)) {
    self.var_9566 = 1;
    self.var_596B = "spectator";
    self.var_5C62 = self.var_012C["team"];
    self suicide();
  }

  self notify("becameSpectator");
  func_09FC("spectator");
  self.var_012C["class"] = undefined;
  self.var_2319 = undefined;
  thread maps\mp\gametypes\_playerlogic::func_90A5();
}

watch_for_cancel_class_select() {
  self notify("stop_watch_for_cancel_class_select");
  self endon("stop_watch_for_cancel_class_select");
  for(;;) {
    self waittillmatch("class_select_cancel", "luinotifyserver");
    if(self.var_0178 == "spectator") {
      maps\mp\_utility::func_A165("spectator");
      level notify("class_select_cancel_spectator", self);
    }
  }
}

func_A69A() {
  self endon("disconnect");
  level endon("game_ended");
  childthread watch_for_cancel_class_select();
  self.var_A6EF = 1;
  if(maps\mp\_utility::func_0C1E()) {
    for(;;) {
      self waittill("luinotifyserver", var_00, var_01);
      if(var_00 == "class_select") {
        break;
      }
    }

    if("" + var_01 != "callback") {
      if(isbot(self) || function_026D(self)) {
        self.var_012C["class"] = var_01;
        self.var_2319 = var_01;
        maps\mp\gametypes\_class::func_23DC();
      } else {
        var_01 = var_01 + 1;
        self.var_012C["class"] = func_445C(var_01);
        self.var_2319 = func_445C(var_01);
        maps\mp\gametypes\_class::func_23DC();
      }

      self notify("notWaitingToSelectClass");
      self.var_A6EF = 0;
      return;
    }

    self notify("notWaitingToSelectClass");
    self.var_A6EF = 0;
    func_6111("callback");
    return;
  }

  if(!isai(self) && maps\mp\_utility::func_8BFD()) {
    thread maps\mp\gametypes\_playerlogic::func_8753(3);
    for(;;) {
      self waittill("luinotifyserver", var_00, var_01);
      if(var_00 == "class_select") {
        break;
      }
    }
  }

  self notify("notWaitingToSelectClass");
  self.var_A6EF = 0;
  func_1DE9();
}

func_170E(param_00) {
  var_01 = self.var_012C["team"];
  if(maps\mp\_utility::func_0C1E()) {
    thread maps\mp\gametypes\_playerlogic::func_8753(2);
    if(!self method_8436() || maps\mp\_utility::func_551F()) {
      func_A69A();
    }

    func_36E3();
    if(self.var_0178 == "spectator") {
      if(game["state"] == "postgame") {
        return;
      }

      if(game["state"] == "playing" && !maps\mp\_utility::func_5727()) {
        if(isDefined(self.var_A6F1) && self.var_A6F1) {
          return;
        }

        thread maps\mp\gametypes\_playerlogic::func_9035();
      }

      thread maps\mp\gametypes\_spectating::func_872F();
    }

    self.var_2589 = gettime();
    return;
  }

  thread func_1DE9();
  if(maps\mp\_utility::isprophuntgametype() && self.var_0178 == "spectator") {
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !maps\mp\_utility::func_5727()) {
      if(isDefined(self.var_A6F1) && self.var_A6F1) {
        return;
      }

      thread maps\mp\gametypes\_playerlogic::func_9035();
    }

    thread maps\mp\gametypes\_spectating::func_872F();
  }
}

func_1DE9() {
  maps\mp\gametypes\_class::func_23DC();
  self.var_83A7 = 1;
  self.var_2319 = "class0";
  if(isDefined(level.var_1DEA)) {
    self[[level.var_1DEA]]();
  }
}

func_171C() {
  thread maps\mp\gametypes\_playerlogic::func_8753(1);
}

func_8C09() {
  var_00 = self.var_012C["team"];
  self openpopupmenu(game["menu_class_" + var_00]);
}

func_6116() {
  if(isDefined(self.var_012C["team"]) && self.var_012C["team"] == "spectator") {
    return;
  }

  if(isalive(self)) {
    self.var_9566 = 1;
    self.var_596B = "spectator";
    self.var_5C62 = self.var_012C["team"];
    self suicide();
  }

  func_09FC("spectator");
  self.var_012C["class"] = undefined;
  self.var_2319 = undefined;
  maps\mp\gametypes\_class::func_23DC();
  thread maps\mp\gametypes\_playerlogic::func_90A5();
}

func_A919() {
  if(!self.var_4B62) {
    self endon("death");
    self endon("disconnect");
    self endon("streamClassWeaponsComplete");
    level endon("game_ended");
    self waittill("hasDoneCombat");
    self notify("endStreamClassWeapons");
    self iclientprintlnbold(game["strings"]["change_class_cancel"]);
    wait(2);
    self iclientprintlnbold(game["strings"]["change_class"]);
  }
}

func_6112() {
  var_00 = maps\mp\_utility::func_56B1();
  var_01 = (level.var_5139 && !var_00) || (var_00 && maps\mp\_utility::func_46E3() < 5000) || common_scripts\utility::func_562E(self.var_0C1F);
  if(self.var_4B62) {
    var_01 = 0;
  }

  if(var_01) {
    thread maps\mp\gametypes\_playerlogic::func_9455(1);
    if(self.var_2327) {
      self endon("death");
      self endon("disconnect");
      level endon("game_ended");
      self endon("endStreamClassWeapons");
      thread func_A919();
      self iclientprintlnbold(game["strings"]["change_class_wait"]);
      self waittill("streamClassWeaponsComplete");
      self iclientprintlnbold("");
      self method_8533(0);
    }

    maps\mp\gametypes\_class::func_864F(self.var_012C["class"]);
    self.var_95AE = undefined;
    self.var_95AF = undefined;
    maps\mp\gametypes\_class::func_4790(self.var_012C["team"], self.var_012C["class"]);
    if(!isDefined(self.var_9085)) {
      self notify("faux_spawn");
      maps\mp\gametypes\_class::func_0F35();
      if(common_scripts\utility::func_562E(self.var_5DF6)) {
        maps\mp\killstreaks\_killstreaks::func_A129(1);
        return;
      }

      return;
    }

    return;
  }

  maps\mp\gametypes\_playerlogic::func_9455();
  if(!maps\mp\_utility::func_5727()) {
    self iclientprintlnbold(game["strings"]["change_class"]);
  }
}

func_6111(param_00) {
  var_01 = self.var_012C["team"];
  var_02 = maps\mp\gametypes\_class::func_445C(param_00);
  var_03 = maps\mp\gametypes\_class::func_4729(param_00);
  if(var_02 == "restricted") {
    func_170E();
    return;
  }

  if(isDefined(self.var_012C["class"]) && self.var_012C["class"] == var_02 && isDefined(self.var_012C["primary"]) && self.var_012C["primary"] == var_03) {
    return;
  }

  if(maps\mp\_utility::isprophuntgametype() && game["roundsPlayed"] > 0) {
    return;
  }

  if(self.var_0178 == "playing") {
    if(isDefined(self.var_012C["lastClass"]) && isDefined(self.var_012C["class"])) {
      self.var_012C["lastClass"] = self.var_012C["class"];
      self.var_5B84 = self.var_012C["lastClass"];
    }

    self.var_012C["class"] = var_02;
    self.var_2319 = var_02;
    maps\mp\gametypes\_class::func_23DC();
    self.var_012C["primary"] = var_03;
    if(game["state"] == "postgame") {
      return;
    }

    thread func_6112();
  } else {
    if(isDefined(self.var_012C["lastClass"]) && isDefined(self.var_012C["class"])) {
      self.var_012C["lastClass"] = self.var_012C["class"];
      self.var_5B84 = self.var_012C["lastClass"];
    }

    self.var_012C["class"] = var_02;
    self.var_2319 = var_02;
    maps\mp\gametypes\_class::func_23DC();
    self.var_012C["primary"] = var_03;
    if(game["state"] == "postgame") {
      return;
    }

    if(game["state"] == "playing" && !maps\mp\_utility::func_5727()) {
      thread maps\mp\gametypes\_playerlogic::func_9035();
    }
  }

  thread maps\mp\gametypes\_spectating::func_872F();
}

func_09FC(param_00, param_01, param_02) {
  if(isDefined(self.var_01A7)) {
    maps\mp\gametypes\_playerlogic::func_7CE1();
    if(isDefined(param_02) && param_02) {
      maps\mp\gametypes\_playerlogic::func_2B77(self.var_01A7);
    }

    maps\mp\gametypes\_killcam_nemesis::func_4AFB(self.var_01A7, param_00);
  }

  self.var_012C["team"] = param_00;
  self.var_01A7 = param_00;
  if(!getdvarint("4036", 0) && getdvarint("3193") || !maps\mp\_utility::func_602B() || isbot(self) || function_026D(self) || !maps\mp\_utility::func_0C2D() || getdvarint("850") || getdvarint("5357")) {
    if(level.var_984D) {
      self.var_0179 = param_00;
    } else if(param_00 == "spectator") {
      self.var_0179 = "spectator";
    } else {
      self.var_0179 = "none";
    }
  }

  if(function_025F() && !function_0367() && level.var_984D && !isbot(self) || function_026D(self) && self.var_0179 == "none") {
    var_03 = getmatchdata("match_common", "matchID");
    self dlogevent("telemetry_error_event", ["error", ["category_id", 14, "message", "no team assigned", "code", 0, "stack_trace", "", "match_id", var_03]]);
  }

  if(game["state"] != "postgame") {
    maps\mp\gametypes\_playerlogic::func_09FD();
    if(isDefined(param_02) && param_02) {
      maps\mp\gametypes\_playerlogic::func_50F8(self.var_01A7, "_menus addToTeam()");
    }
  }

  if(!maps\mp\_utility::func_579B()) {
    maps\mp\_utility::func_A143();
  }

  if(isDefined(param_01) && param_01) {
    waittillframeend;
  }

  maps\mp\_utility::func_A132();
  if(param_00 == "spectator") {
    self notify("joined_spectators");
    level notify("joined_team", self);
    return;
  }

  self notify("joined_team");
  level notify("joined_team", self);
}

func_36E3() {
  self.var_A6F0 = 0;
  self notify("end_respawn");
}