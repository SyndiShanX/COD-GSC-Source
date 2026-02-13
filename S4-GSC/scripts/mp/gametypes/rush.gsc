/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rush.gsc
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
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_8FA1 = gettime();
  level._id_322C = 1;
  game["dialog"]["gametype"] = "gametype_domination";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "capture_objs";
  game["dialog"]["defense_obj"] = "capture_objs";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3b2a349dc8a8f0193", getmatchrulesdata("rushData", "activationDelay"));
  setdynamicdvar("#x32cb1667faa403262", getmatchrulesdata("rushData", "captureDuration"));
  setdynamicdvar("#x3f2622b0ed413ea5e", getmatchrulesdata("rushData", "extraTimeBonus"));
}

_id_D5AD() {
  level._id_7C42 = "hq_destroy";
  level._id_7C48 = "hq_contested";
  level._id_7C4B = "hq_defend";
  level._id_7C6F = "hq_losing";
  level._id_7C74 = "hq_neutral";
  level._id_7C87 = "hq_taking";
  level._id_7C8A = "hq_target";
}

_id_ABAD() {
  _id_D5AD();

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/RUSH");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/RUSH");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/RUSH_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/RUSH_HINT");
  }

  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(scripts\mp\utility\game::_id_82D1()) {
    game["overtimeProgress"] = 0;
    game["overtimeProgressFrac"] = 0;
    game["attackers"] = ::scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "axis", "allies");
    game["defenders"] = ::scripts\engine\utility::ter_op(game["overtimeRoundsPlayed"] == 0, "allies", "axis");

    if(!isDefined(game["overtimeLimit"]) || !isDefined(game["overtimeLimit"][game["attackers"]])) {
      game["overtimeLimit"][game["attackers"]] = 1.0;
    }

    scripts\mp\utility\game::_id_D635(game["overtimeLimit"][game["attackers"]]);
  } else {
    game["attackers"] = ::scripts\engine\utility::ter_op(!istrue(game["switchedsides"]), "axis", "allies");
    game["defenders"] = ::scripts\engine\utility::ter_op(!istrue(game["switchedsides"]), "allies", "axis");
  }

  level scripts\mp\gamelogic::_id_5263();
  _id_8296();
  thread _id_9846();
  _id_D899();
  _id_8294();
  thread _id_E6B1();
  thread _id_9A27();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_0F0F = scripts\mp\utility\dvars::_id_509A("activationDelay", 30, 0, 60);
  level._id_322D = scripts\mp\utility\dvars::_id_509A("captureDuration", 40, 0, 60);
  level._id_5857 = scripts\mp\utility\dvars::_id_509A("extraTimeBonus", 60, 0, 300);
}

_id_D899() {
  var_0 = getEntArray("rush_flag", "targetname");
  var_1 = getEntArray("rush_flag_override", "targetname");

  if(var_0.size == 0) {
    return;
  }
  var_2 = [];

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_2[var_2.size] = var_0[var_3];
  }

  var_4 = [];

  if(var_1.size > 0) {
    foreach(var_6 in var_1) {
      var_7 = var_6._id_039B;
      var_4[var_7] = var_6;
    }
  }

  foreach(var_6 in var_2) {
    var_7 = var_6._id_039B;

    if(var_7 == "0" || var_7 == "4") {
      continue;
    }
    if(isDefined(var_4[var_7])) {
      var_6 = var_4[var_7];
    }

    var_6._id_A8E1 = var_7;
    var_6 _id_9ABF(var_7);
    var_10 = scripts\mp\gametypes\obj_dom::_id_D896(var_6);
    var_10 _id_4D48();
    level._id_A8E8[var_10._id_A8E1] = var_10;
    var_10._id_AA79 = ::_id_4D46;
    var_10._id_ABD4 = ::_id_4D52;
    var_10._id_ABCB = ::_id_4D4F;
    var_10._id_AAC2 = ::_id_4D4A;
    var_10._id_AA8D = ::_id_4D47;
    var_10._id_ABC7 = ::_id_4D4C;
    var_10._id_AAB5 = ::_id_4D48;
    var_10._id_AAC1 = ::_id_4D49;
    var_10._id_AA6E = ::_id_4D45;
    var_10 thread scripts\mp\gametypes\obj_dom::_id_FC64("off", 0);
    var_10._id_45BE = game["defenders"];
    var_10._id_AD59 = game["attackers"];
    var_10._id_7D35 = 1;
    var_10._id_450C = 5.0;
    var_10._id_B009 = [0.33, 0.66];
  }
}

_id_E6B1() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  _id_07D1::_id_60C2("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  level._id_41DE = 1;
  _id_FC44(level._id_41DE);
}

_id_9A27() {
  for(;;) {
    waitframe();

    if(istrue(level._id_F263)) {
      level._id_31B5 = 0;
      continue;
    }

    if(isDefined(level._id_41DC)) {
      level._id_31B5 = level._id_41DC._id_F396[game["attackers"]].size == 0;
    }
  }
}

_id_FC44(var_0) {
  if(!isDefined(level._id_A8E8[scripts\engine\utility::_id_EA52(var_0)])) {
    return;
  }
  if(isDefined(level._id_41DC) && isDefined(level._id_41DC._id_AAB5)) {
    level._id_41DC[[level._id_41DC._id_AAB5]]();
  }

  level._id_41DE = var_0;
  level._id_41DC = level._id_A8E8[scripts\engine\utility::_id_EA52(var_0)];
  _id_FD36("rush_" + level._id_41DE);

  if(isDefined(level._id_41DC._id_AAC1)) {
    level._id_41DC[[level._id_41DC._id_AAC1]]();
  }

  if(level._id_0F0F > 0) {
    level scripts\mp\gamelogic::pausetimer();
    var_1 = int(gettime() + level._id_0F0F * 1000);
    setomnvar("ui_hardpoint_timer", var_1);
    wait(level._id_0F0F);
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level._id_41DC._id_AA6E)) {
    level._id_41DC[[level._id_41DC._id_AA6E]]();
  }

  var_2 = 0;

  switch (var_0) {
    case 1:
      var_2 = 10;
      break;
    case 2:
      var_2 = 10;
      break;
    case 3:
      var_2 = 10;
      break;
  }

  scripts\mp\gamelogic::_id_FD85(var_2);
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0817::_id_113A("mp_rush_spawn_allies_start");
  _id_0817::_id_113A("mp_rush_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_rush_spawn_allies", 1);
  _id_0817::_id_1136("axis", "mp_rush_spawn_axis", 1);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  foreach(var_1 in level._id_A8E8) {
    var_1._id_E34D = [];
    var_1._id_E34D["allies"] = [];
    var_1._id_E34D["axis"] = [];
  }

  foreach(var_4 in level._id_E34D) {
    if(isDefined(var_4._id_039B)) {
      var_5 = var_4._id_039B;

      if(var_5 == "0" || var_5 == "4") {
        continue;
      }
      if(var_4.classname == "mp_rush_spawn_allies") {
        level._id_A8E8[var_5]._id_E34D["allies"][level._id_A8E8[var_5]._id_E34D["allies"].size] = var_4;
        continue;
      }

      if(var_4.classname == "mp_rush_spawn_axis") {
        level._id_A8E8[var_5]._id_E34D["axis"][level._id_A8E8[var_5]._id_E34D["axis"].size] = var_4;
      }
    }
  }

  foreach(var_8, var_1 in level._id_A8E8) {
    var_1._id_E34F = [];
    var_1._id_E34F["allies"] = "rush_allies_" + var_8;
    var_1._id_E34F["axis"] = "rush_axis_" + var_8;
    _id_0817::_id_C2B9(var_1._id_E34F["allies"], var_1._id_E34D["allies"]);
    _id_0817::_id_C2B9(var_1._id_E34F["axis"], var_1._id_E34D["axis"]);
  }

  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_rush_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
    self._id_E725 = var_2;
  } else
    var_2 = _id_0817::_id_6D4A(self, var_0, level._id_41DC._id_E34F[var_0]);

  return var_2;
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

_id_9ABF(var_0) {
  self._id_7C73 = "";
}

_id_4AA5() {
  thread scripts\mp\gametypes\obj_dom::_id_FC64("off", 0);
}

_id_1FC4() {
  level endon("game_ended");
  level notify("awardCapturePointsRunning");
  level endon("awardCapturePointsRunning");
  var_0 = 1;
  var_1 = 1;

  while(!level.gameended) {
    var_2 = 0.0;

    while(var_2 < var_0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level._id_5F3A;

      if(self._id_E57B) {
        var_2 = 0.0;
      }
    }

    var_3 = self._id_37F6;

    if(var_3 == "none") {
      continue;
    }
    if(!self._id_E57B) {
      foreach(var_5 in self._id_F396[var_3]) {
        var_5.player thread _id_0A9F::_id_7003("cop_in_obj");
      }
    }
  }
}

_id_4D46(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
  self._id_497A = 1;
}

_id_4D52(var_0, var_1, var_2, var_3) {
  scripts\mp\gametypes\obj_dom::_id_4D52(var_0, var_1, var_2, var_3);

  if(scripts\mp\utility\game::_id_82D1()) {
    var_4 = self._id_EF94[game["attackers"]] / self._id_FEE7;

    if(var_4 > game["overtimeProgressFrac"]) {
      game["overtimeProgressFrac"] = var_4;
    }

    var_5 = game["overtimeProgress"] + game["overtimeProgressFrac"];

    if(game["overtimeRoundsPlayed"] == 1 && scripts\mp\utility\game::_id_D6B6(var_0, var_5 * 60.0) == var_0) {
      thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["objective_completed"]);
    }
  }
}

_id_4D4F(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
  var_1 = _id_07D6::_id_6C02();
  level._id_FED4 = 0;
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  thread scripts\mp\utility\print::_id_BD0C(var_1, var_2, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);
  scripts\mp\gamescore::_id_7001(var_1, 1, 0);
  var_3 = level._id_41DE;
  var_3++;

  if(var_3 == 4) {
    var_4 = scripts\mp\gamelogic::_id_6DE8();
    var_4 = var_4 / 60000.0;
    game["overtimeLimit"][var_1] = max(1.0, var_4);

    if(scripts\mp\utility\game::_id_82D1()) {
      var_5 = scripts\mp\utility\game::_id_D6B6(var_1, 180.0);
      thread scripts\mp\gamelogic::_id_52F7(var_5, game["end_reason"]["objective_completed"]);
      return;
    }

    thread scripts\mp\gamelogic::_id_52F7(var_1, game["end_reason"]["objective_completed"]);
    return;
  } else {
    if(level._id_5857 > 0) {
      level._id_5856 = level._id_41DE * level._id_5857;
      var_4 = scripts\mp\gamelogic::_id_6DE8();
      setgameendtime(gettime() + int(var_4));
    }

    if(scripts\mp\utility\game::_id_82D1()) {
      game["overtimeProgress"]++;
      game["overtimeProgressFrac"] = 0;
    }

    _id_FC44(var_3);
  }
}

_id_4D4A(var_0, var_1, var_2) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
}

_id_4D47() {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D47();
}

_id_4D4C(var_0) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);
  self._id_497A = 1;
  var_1 = _id_07D6::_id_6C02();
  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  var_1 = _id_07D6::_id_6C02();
}

_id_4D48() {
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_4AD1();
  _id_07D6::_id_C60A();
  _id_07D6::_id_C300();
  self notify("useObjectDecay");
  scripts\engine\utility::delaythread(0.1, ::_id_4AA5);
}

_id_4D49() {
  _id_07D6::_id_C579(1, 1);
  _id_07D6::_id_5260();
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_D61B(level._id_7C8A);

  if(isDefined(self._id_45BE)) {
    _id_07D6::_id_D639(self._id_45BE);
    thread scripts\mp\gametypes\obj_dom::_id_FC64(self._id_45BE, 0);
  } else {
    _id_07D6::_id_D639("neutral");
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
  }
}

_id_4D45() {
  _id_0AA2::_id_B8F1("mp_combat_outpost_activateobj");
  _id_07D6::_id_15DF("enemy");
  thread _id_1FC4();
  level._id_5C3B = level._id_322D;
  _id_07D6::_id_D8D2(level._id_5C3B);
  _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
}

_id_8296() {
  level._id_E3EA = [];
  level._id_41F3 = "rush_1";
  var_0 = scripts\engine\utility::getstructarray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;
    var_4 = scripts\engine\utility::getstructarray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_CD99) {
        case "to_allies_camera":
          _id_D714(var_3, "allies", var_6);
          break;
        case "to_axis_camera":
          _id_D714(var_3, "axis", var_6);
          break;
      }
    }
  }
}

_id_D714(var_0, var_1, var_2) {
  if(!isDefined(level._id_E3EA[var_0])) {
    level._id_E3EA[var_0] = [];
  }

  level._id_E3EA[var_0][var_1] = var_2;
}

_id_E727() {
  waitframe();
  scripts\mp\utility\player::_id_FD26("spectator");
  _id_081A::_id_D512();

  if(isDefined(self._id_8FB8)) {
    self setplayerangles(self._id_8FB8);
  }

  wait 0.1;
  scripts\mp\utility\player::_id_D51E();
  var_0 = level._id_E3EA[level._id_41F3][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self._id_4411 = var_1;
  self._id_4410 = var_2;
  var_3 = spawn("script_model", self getvieworigin());
  var_3 setModel("tag_origin");
  var_3.angles = var_2;
  self._id_E3E9 = var_3;
  self._id_8AD7 = 1;
  self cameralinkto(var_3, "tag_origin", 1);
  thread _id_4CF1();
  var_3 _id_A227(self, var_1, var_2);
}

_id_4CF1() {
  wait 0.4;
  thread _id_B8DB();
  _id_19EE();
}

_id_534B() {
  if(!isDefined(self._id_E3E9)) {
    return;
  }
  _id_C533();
  thread _id_CA72();
}

_id_FD36(var_0) {
  level._id_41F3 = var_0;

  foreach(var_2 in level.players) {
    if(isDefined(var_2._id_E3E9)) {
      var_3 = var_2.team;
      var_4 = getdvarint("#x3c983a2d215ea1115", -1);

      if(var_4 != -1) {
        var_3 = scripts\engine\utility::ter_op(var_4 == 0, "allies", "axis");
      }

      var_5 = level._id_E3EA[level._id_41F3][var_3];
      var_2._id_E3E9 _id_A227(var_2, var_5.origin, var_5.angles);
    }
  }
}

_id_A227(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveto(var_1, 1.0, 0.5, 0.5);
  var_0 _meth_82FD("spawn_cam", 0.5, "mix");
  self rotateto(var_2, 1.0, 0.5, 0.5);
  var_0 thread _id_E705();
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0._id_E3E9)) {
    self moveto(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

_id_CA72() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::_id_FD26("spectator");
  self cameralinkto(self._id_E3E9, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self._id_E3E9 moveto(var_0, 0.5);
  self _meth_8078(0.5);
  self._id_E3E9 rotateto(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread _id_B8DB();
  scripts\mp\utility\player::_id_FD26("playing");
  self _meth_8060();
  self._id_E3E9 delete();
}

_id_B8DB() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

_id_E705() {
  self endon("game_ended");
  self waittill("spawned_player");
  wait 0.5;
}

_id_19EE() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self _meth_840B();
}

_id_C533() {
  self _meth_840A();
}

_id_9846() {
  var_0 = 1;

  for(;;) {
    if(getdvarint("#x3caae75b25d1aedb3", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var_1 = getdvarint("#x35bca28613750fdb0", -1);

      if(var_1 != -1) {
        var_0 = var_1;
      }

      _id_FD36("rush_" + var_0);
      var_2 = getdvarfloat("#x339ededb1f31e7ac3", 1.0);
      wait(var_2);
      var_0++;

      if(var_0 > 3) {
        var_0 = 1;
      }

      if(getdvarint("#x3caae75b25d1aedb3", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}