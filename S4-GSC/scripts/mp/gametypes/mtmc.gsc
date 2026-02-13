/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\mtmc.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = "mtmc";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_4A82 = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB42 = ::_id_AAEF;
  level._id_AAA3 = ::_id_AAA3;
  level._id_8FA1 = gettime();
  level._id_60CD = ::_id_1D1A;
  level._id_60CE = ::_id_103AB;
  level._id_150E = [];
  level._id_1FE3 = [];
  game["dialog"]["gametype"] = "gametype_domination";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
  game["dialog"]["securing_a"] = "securing_a";
  game["dialog"]["securing_b"] = "securing_b";
  game["dialog"]["securing_c"] = "securing_c";
  game["dialog"]["secured_a"] = "secure_a";
  game["dialog"]["secured_b"] = "secure_b";
  game["dialog"]["secured_c"] = "secure_c";
  game["dialog"]["losing_a"] = "losing_a";
  game["dialog"]["losing_b"] = "losing_b";
  game["dialog"]["losing_c"] = "losing_c";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x35f3aedf689b3b616", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("#x3c3aba4211bd929d6", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("#x38ede8e2ad5a90852", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("#x3ca04b5dd82a08991", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("#x39cdcfbbf4b02e891", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("#x3888bcc72d9c70419", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("#x327f5115a6743ee0d", 0);
  scripts\mp\utility\game::_id_C25D("mtmc", 0);
}

_id_D5AD() {
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
  level._id_7C8A = "icon_waypoint_target";
}

_id_ABAD() {
  _id_D5AD();

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(!isDefined(game["remainingTeams"])) {
    game["remainingTeams"] = level._id_EF89;
  }

  _id_8294();
  thread _id_D871();
  thread _id_E6B1();
}

_id_E6B1() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  wait 15.0;

  foreach(var_1 in level._id_A8E8) {
    var_1 _id_07D6::_id_D61B(level._id_7C74);
    var_1 _id_07D6::_id_5260();
    var_1 _id_07D6::_id_D8E0("any");
    var_1 _id_07D6::_id_15DF("any");
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 30, 0, 30);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_322C = scripts\mp\utility\dvars::_id_509C("captureDecay", 1, 0, 1);
  level._id_3236 = scripts\mp\utility\dvars::_id_509C("captureType", 1, 0, 3);
  level._id_A8EC = scripts\mp\utility\dvars::_id_509A("objScalar", 4, 1, 10);
}

_id_8294() {
  _id_0817::_id_D461("MTMC", "Crit_Default");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  var_0 = _id_0817::_id_6D4E("mp_mtmc_spawn_start");

  foreach(var_2 in game["remainingTeams"]) {
    _id_0817::_id_C2B8(var_2, var_0);
  }

  level._id_E6E2 = [];

  foreach(var_5 in var_0) {
    if(!isDefined(var_5.target) || var_5.target == "") {
      continue;
    }
    if(!isDefined(var_5._id_039B) || var_5._id_039B == "") {}

    if(int(var_5._id_039B) != game["remainingTeams"].size) {
      continue;
    }
    var_6 = level._id_E6E2[var_5.target];

    if(isDefined(var_6)) {
      var_6._id_E34D[var_6._id_E34D.size] = var_5;
      continue;
    }

    var_7 = scripts\engine\utility::getstruct(var_5.target, "targetname");
    var_8 = spawnStruct();
    var_8.origin = var_7.origin;
    var_8.angles = var_7.angles;
    var_8._id_E34D = [];
    var_8._id_E34D[0] = var_5;
    var_8._id_84EF = 0;
    level._id_E6E2[var_5.target] = var_8;
  }

  foreach(var_11, var_6 in level._id_E6E2) {
    _id_0817::_id_C2B9(var_11, var_6._id_E34D);
    _id_0817::_id_0EFF(var_11);
  }

  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  _id_0817::_id_4388();

  if(!isDefined(level._id_EFAA)) {
    level._id_EFAA = [];
  }

  var_0 = level._id_EFAA[self.team];

  if(isDefined(var_0)) {
    var_1 = _id_0817::_id_6D4A(self, self.team, var_0, undefined, "bad");
    return var_1;
  }

  var_2 = [];

  foreach(var_0, var_4 in level._id_E6E2) {
    if(var_4._id_84EF) {
      continue;
    }
    var_2[var_2.size] = var_0;
  }

  var_1 = _id_0817::_id_6D4A(self, self.team, var_2, undefined, "bad");
  level._id_E6E2[var_1.target]._id_84EF = 1;
  level._id_EFAA[self.team] = var_1.target;
  return var_1;
}

_id_D871() {
  var_0 = getEntArray("mtmc_dom", "targetname");

  if(!var_0.size) {
    return;
  }
  foreach(var_2 in var_0) {
    if(!isDefined(var_2._id_039B) || var_2._id_039B == "") {}

    if(int(var_2._id_039B) != game["remainingTeams"].size) {
      continue;
    }
    var_3 = scripts\mp\gametypes\obj_dom::_id_D896(var_2, 1);
    var_3 _id_07D6::_id_D61B(level._id_7C8A);
    var_3 _id_07D6::_id_4AD1();
    var_3 _id_07D6::_id_D8E0("any");
    var_3 _id_07D6::_id_15DF("none");
    level._id_A8E8[var_3._id_A8E1] = var_3;
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::_id_88F6(var_4.basename)) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_ABA4() {}

onplayerconnect(var_0) {
  var_0._id_F90E = undefined;
  var_0._id_F90F = undefined;
  var_0 thread onplayerspawned();
}

onplayerspawned(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["captures"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["captures"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["defends"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["defends"]);
    }
  }
}

_id_AAEF(var_0, var_1, var_2, var_3, var_4, var_5) {
  _id_0A8D::_id_E775("secured" + self._id_A8E1, var_3, 1);
  var_6 = scripts\mp\utility\game::_id_6BE2(var_3);

  foreach(var_8 in var_6) {
    _id_0A8D::_id_E775("lost_" + self._id_A8E1, var_8, 1);
  }

  _id_07D6::_id_D8E0("none");
  _id_07D6::_id_15DF("none");

  if(isDefined(self._id_5C3F)) {
    self._id_5C3F hide();
  }

  if(!isDefined(level._id_C31F)) {
    level._id_C31F = level._id_A8E8.size;
  }

  level._id_C31F--;

  if(level._id_C31F == 0) {
    _id_D6A5();
  }
}

_id_1D1A() {
  var_0 = self getEye();
  var_1 = self getplayerangles();
  var_2 = anglesToForward(var_1);
  var_3 = cos(10);
  var_4 = 250000;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;

  foreach(var_11 in level._id_A8E8) {
    var_12 = vectornormalize(var_11.trigger.origin - var_0);
    var_13 = vectordot(var_2, var_12);
    var_14 = distancesquared(var_11.trigger.origin, var_0);

    if(!isDefined(var_5) || var_5 < var_13) {
      var_5 = var_13;
      var_7 = var_14;
      var_6 = var_11;
    }

    if(!isDefined(var_8) || var_8 > var_14) {
      var_8 = var_14;
      var_9 = var_11;
    }
  }

  var_11 = undefined;
  var_16 = undefined;
  var_17 = undefined;

  if(isDefined(var_5) && var_5 > var_3) {
    var_11 = var_6;
    var_18 = _func_00D6(var_11._id_A8E1, 1, 2);

    if(var_11._id_ADAE == "neutral") {
      var_16 = self.name + ": Capture " + var_18 + "!";
      var_17 = "capture";
    } else if(var_11._id_ADAE == self.team) {
      var_16 = self.name + ": Defend" + var_18 + "!";
      var_17 = "defend";
    } else {
      var_16 = self.name + ": Assault " + var_18 + "!";
      var_17 = "assault";
    }
  } else if(isDefined(var_8) && var_8 < var_4) {
    var_11 = var_9;
    var_18 = _func_00D6(var_11._id_A8E1, 1, 2);

    if(var_11._id_ADAE == "neutral") {
      var_16 = self.name + ": Capture " + var_18 + "!";
      var_17 = "capture";
    } else if(var_11._id_ADAE == self.team) {
      var_16 = self.name + ": Defend" + var_18 + "!";
      var_17 = "defend";
    } else {
      var_16 = self.name + ": Assault " + var_18 + "!";
      var_17 = "assault";
    }
  }

  if(isDefined(var_11)) {
    thread _id_0793::_id_19D5(var_11, var_16, var_17);
  }

  return isDefined(var_11);
}

_id_103AB(var_0, var_1) {
  var_2 = 0;

  switch (var_0) {
    case "capture":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
    case "defend":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
    case "assault":
      if(var_1.team == self.team) {
        var_2 = 1;
      }

      break;
  }

  return var_2;
}

_id_AAA3(var_0) {
  if(var_0 == "all") {
    _id_D6A5();
  } else {
    var_1 = scripts\mp\utility\teams::_id_6A01(var_0);
    var_2 = [];

    foreach(var_4 in var_1) {
      var_2[var_4] = 0;
    }

    if(!istrue(level._id_4AE8)) {
      foreach(var_4 in var_1) {
        foreach(var_8 in scripts\mp\utility\teams::_id_6DCA(var_4, "players")) {
          if(!istrue(var_8._id_75B4)) {
            continue;
          }
          var_2[var_4] = var_2[var_4] + var_8.pers["lives"];
        }
      }
    }

    var_11 = [];

    foreach(var_4 in var_1) {
      if(scripts\mp\utility\teams::_id_6DCA(var_4, "aliveCount") || var_2[var_4]) {
        var_11[var_11.size] = var_4;
      }
    }

    if(var_11.size == 1) {
      _id_D6A5(var_11[0]);
    }
  }
}

_id_D6A5(var_0) {
  if(istrue(level._id_C320)) {
    return;
  }
  level._id_C320 = 1;
  game["remainingTeams"] = [];

  foreach(var_2 in level._id_A8E8) {
    if(var_2._id_ADAE == "neutral") {
      continue;
    }
    if(!scripts\engine\utility::array_contains(game["remainingTeams"], var_2._id_ADAE)) {
      game["remainingTeams"][game["remainingTeams"].size] = var_2._id_ADAE;
    }
  }

  if(isDefined(var_0) && !scripts\engine\utility::array_contains(game["remainingTeams"], var_0) && game["remainingTeams"].size < level._id_A8E8.size) {
    game["remainingTeams"][game["remainingTeams"].size] = var_0;
  }

  foreach(var_5 in level.players) {
    if(scripts\engine\utility::array_contains(level._id_EF89, var_5.team)) {
      if(!scripts\engine\utility::array_contains(game["remainingTeams"], var_5.team)) {
        var_5 _id_07F2::_id_1176("spectator");
      }
    }
  }

  if(game["remainingTeams"].size == 1) {
    scripts\mp\gamescore::_id_7001(game["remainingTeams"][0], 1, 0);
    thread scripts\mp\gamelogic::_id_52F7(game["remainingTeams"][0], game["end_reason"]["enemies_eliminated"]);
  } else
    thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["objective_completed"]);
}