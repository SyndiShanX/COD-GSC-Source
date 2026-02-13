/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1830.gsc
*************************************************/

init() {
  thread _id_B680();
  _id_C1E0();
}

_id_B680() {
  for(;;) {
    level waittill("connected", var_0);

    if(isDefined(level._id_BA4D)) {
      var_0 setclientomnvar("post_game_state", level._id_BA4D);

      if(isDefined(var_0.pers["team"]) && level._id_10E53 == var_0.pers["team"]) {
        var_1 = _id_6472("win");
      } else {
        var_1 = _id_6472("fail");
      }

      var_0 setclientomnvar("ui_round_end_title", var_1);
    }
  }
}

_id_D685(var_0) {
  _func_01EA("post_game_state", var_0);
  level._id_BA4D = var_0;
}

_id_52F7(var_0, var_1, var_2, var_3) {
  if(_id_60B9()) {
    return;
  }
  _id_9B7E();
  level notify("begin_game_ended");

  foreach(var_5 in level.players) {
    var_5 notify("begin_game_ended");
  }

  foreach(var_5 in level.players) {
    if(istrue(var_5 _meth_86B8()) || istrue(var_5 isskydiving())) {
      var_5 _meth_86B4();
    }

    thread _id_073B::_id_788C(var_5);
  }

  if(isDefined(level._id_831A)) {
    foreach(var_10 in level._id_831A) {
      level._id_831A = scripts\engine\utility::array_remove(level._id_831A, var_10);
      _func_0354(var_10);
    }
  }

  if(var_1 == 3) {
    if(isDefined(level.cp_music_gameover)) {
      _func_01E3(level.cp_music_gameover);
    } else {
      _func_01E3("death_song");
    }

    foreach(var_5 in level.players) {
      var_5 playsoundtoplayer("zmb_exfil_fail", var_5);
      var_5 _meth_867F("cp_exfil_complete");
      var_5 thread _id_43E8(var_2);
    }

    thread play_game_over_narration();
  }

  if(isDefined(var_2) && !scripts\engine\utility::_id_5C00("beacon_trigger_used")) {
    _id_0987::objective_failed_splash(var_3);
    wait(var_2);
  }

  if(var_1 == 3 || var_1 == 2) {
    wait 1.5;

    foreach(var_5 in level.players) {
      level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_5, 1, 2);
    }

    wait 2;
  }

  setDvar("#x385ed7963c5e37386", "");
  _func_01E7(1);
  _id_0756::givematchbonusxp();
  level notify("game_ended", var_0);
  _id_5F61(1.0, "#x38bd4585c77e2050", 1);

  if(var_1 == 3) {
    wait 1;
  }

  var_16 = 0;
  var_17 = "";

  if(!scripts\cp\utility::_id_86C9()) {
    var_17 = "FAIL";

    switch (var_1) {
      case 1:
        var_17 = "SUCCESS";
        _id_0756::_id_C025("allies");
        break;
      case 4:
        var_17 = "HOST QUIT";
        _id_0756::_id_C025("axis");
        break;
      default:
        var_17 = "FAIL";
        _id_0756::_id_C025("axis");
        break;
    }

    if(isDefined(level._id_BB4E)) {
      [[level._id_BB4E]](var_17);
    }

    _id_0705::_id_9785(var_17);
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());
  setclientmatchdata("zombieOutcome", var_1);
  var_18 = 0;

  if(scripts\cp\utility::matchmakinggame() && (var_17 == "SUCCESS" || var_17 == "FAIL")) {
    var_18 = 1;
    _func_0435();
  }

  foreach(var_5 in level.players) {
    if(!isDefined(var_5)) {
      continue;
    }
    if(var_18) {
      var_5 scripts\cp_mp\utility\game_utility::_id_E912(var_17);
    }

    var_20 = _id_642F(var_5);
    var_21 = var_5 getplayerdata("cp", "alienSession", "kills");
    var_22 = var_5 getplayerdata("cp", "alienSession", "downed");
    var_23 = var_5 getplayerdata("cp", "alienSession", "revives");
    var_24 = var_5 getplayerdata("cp", "alienSession", "currency");
    var_25 = var_5 getplayerdata("cp", "EoGPlayer", var_5._id_399D, "assists");
    var_26 = var_5 getplayerdata("cp", "EoGPlayer", var_5._id_399D, "kills_critical");
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_5.name, "stat_type", "Kills", "count", var_21, "description", ""]);
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_5.name, "stat_type", "Last Stands", "count", var_22, "description", ""]);
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_5.name, "stat_type", "Revives", "count", var_23, "description", ""]);
    setclientmatchdata("player", var_5._id_399D, "xuidHigh", var_5 _meth_8585());
    setclientmatchdata("player", var_5._id_399D, "xuidLow", var_5 _meth_8586());
    setclientmatchdata("player", var_5._id_399D, "assists", var_25);
    setclientmatchdata("player", var_5._id_399D, "kills_critical", var_26);
    setclientmatchdata("player", var_5._id_399D, "score", var_24);
    setclientmatchdata("player", var_5._id_399D, "kills", var_21);
    setclientmatchdata("player", var_5._id_399D, "deaths", var_5._id_0157);
    var_27 = 1000 * (_func_00D7() - var_5.pers["utc_connect_time_s"]);
    setclientmatchdata("player", var_5._id_399D, "timeplayed", var_27);
    level._id_399E["player"][var_5._id_399D]["zombie_death"] = var_21;
    level._id_399E["player"][var_5._id_399D]["dropped_to_last_stand"] = var_22;
    level._id_399E["player"][var_5._id_399D]["revived_another_player"] = var_23;

    if(isDefined(var_5.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var_28 = var_5 _id_0756::getrank();
      setclientmatchdata("player", var_5._id_399D, "rank", var_28);
    }

    if(isDefined(var_5.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var_29 = var_5 _id_0756::_id_6C89();
      setclientmatchdata("player", var_5._id_399D, "prestige", var_29);
    }

    if(var_5 _meth_8687()) {
      setclientmatchdata("player", var_5._id_399D, "platform", "ps4");
    } else if(var_5 _meth_868A()) {
      setclientmatchdata("player", var_5._id_399D, "platform", "xb3");
    } else if(var_5 _meth_8685()) {
      setclientmatchdata("player", var_5._id_399D, "platform", "bnet");
    } else {
      setclientmatchdata("player", var_5._id_399D, "platform", "none");
    }

    var_5 _id_0740::_id_97A9(var_17);
  }

  level._id_7EB0 = 0;
  setomnvar("allow_server_pause", 0);
  waitframe();

  if(isDefined(level._id_F261)) {
    level._id_E72D = level._id_F261;
  }

  level._id_F1FB = int((gettime() - level._id_E72D) / 1000);

  if(isDefined(level._id_5536)) {}

  setomnvar("zm_time_survived", level._id_F1FB);
  _id_D685(1);
  setDvar("#x37c9b9af716ef3c26", 1);
  setDvar("#x3d66aa88265dae2e0", 0);
  setDvar("#x3ca984a865792777", 0);
  setDvar("#x3e19c1032e9641a7d", 1);
  setgameendtime(0);

  foreach(var_5 in level.players) {
    _id_3860(var_5);
  }

  level._id_24F0 = 1;

  foreach(var_34 in level.agentarray) {
    if(isDefined(var_34.isactive) && var_34.isactive) {
      var_34._id_0229 = 1;
      var_34 scripts\cp\utility::_id_51D4();
    }
  }

  if(var_1 == 3 || var_1 == 2) {
    foreach(var_5 in level.players) {
      level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_5, 0, 1.25, 1);
    }
  }

  _id_D685(0);
  level._id_10E53 = var_0;
  _id_4B78(var_0, var_1);
  var_38 = _id_DAB4(var_1);

  if(isDefined(var_38)) {
    if(isDefined(level._id_95D0)) {
      [[level._id_95D0]](var_1);
    }

    _id_95CF(var_38);
    return;
  } else {
    var_39 = _id_6472("exiting");

    foreach(var_5 in level.players) {
      var_5 setclientomnvar("ui_round_end_title", var_39);
    }
  }

  _id_072E::_id_C5C6();
  setDvar("#x3b53969f6ecda1869", "");

  if(isDefined(level._id_BB46)) {
    [[level._id_BB46]]();
  }

  if(!scripts\cp\utility::_id_857B()) {
    foreach(var_5 in level.players) {
      var_5 setclientdvar("#x32add9cc9e0c920a1", 1);
    }
  }

  var_44 = _id_6470(var_1);
  var_45 = _id_665F();
  _id_0705::_id_52F7(var_44, var_45);
  _id_C5DC();
  wait 1;
  var_46 = level._id_83CC;

  if(isDefined(level._id_4250)) {
    var_46 = level._id_4250;
  }

  wait 0.5;

  if(!scripts\cp\utility::_id_857B()) {
    foreach(var_5 in level.players) {
      var_5 thread[[var_46]](var_1);
    }
  }

  wait 5;
  level notify("exitLevel_called");
  exitlevel(0);
}

play_game_over_narration() {
  if(istrue(level.skip_endgame_vo)) {
    return;
  }
  var_0 = scripts\engine\utility::ter_op(level.mapname == "cp_zm_skorpion" || level.mapname == "cp_sumpf", ["zm_zohs_hbsk_krtx_hsja", "zm_zohs_hbsk_vlst_hsja"], ["zm_cmcp_obhb_vlst_hgfl", "zm_cmcp_obhb_krtx_hgfl"]);

  if(randomfloat(100) < 66) {
    thread _id_0720::play_narration(var_0);
    level waittill("dialogue_finished");
  } else
    _id_0720::play_event_narration("gg_no_re");
}

_id_DFE2() {
  level thread _id_DFE1("axis", _id_6472("host_end"));
}

_id_DFE1(var_0, var_1) {
  if(_id_60B9()) {
    return;
  }
  if(var_1 == 3 || var_1 == 2) {
    foreach(var_3 in level.players) {
      var_4 = game["music"]["spawn_player"].size;
      var_5 = randomint(var_4);
      var_3 setplayermusicstate(game["music"]["cp_roundloss"][var_5]);
      var_3 _meth_8078(0);
      var_3 _meth_867F("cp_matchend", 3);
      var_3 thread _id_DFE6(var_0);

      if(istrue(var_3._id_A360)) {
        var_3 playlocalsound("mp_jugg_mus_toggle_button");
        var_3 setscriptablepartstate("juggernaut", "neutral", 0);
      }
    }
  }

  if(var_1 == 1) {
    foreach(var_3 in level.players) {
      var_3 _meth_8078(0);

      if(istrue(var_3._id_A360)) {
        var_3 playlocalsound("mp_jugg_mus_toggle_button");
        var_3 setscriptablepartstate("juggernaut", "neutral", 0);
      }

      var_3 setplayermusicstate("mus_west_victory");
      var_3 _meth_867F("cp_matchend", 3);
    }
  }

  setDvar("#x385ed7963c5e37386", "");
  _func_01E7(1);
  _id_9B7E();
  level notify("game_ended", var_0);
  _id_0705::_id_9785(var_1);
  _id_5F61(1.0, "#x38bd4585c77e2050", 1);

  if(var_1 == 3) {
    wait 1;
  }

  setclientmatchdata("isPublicMatch", scripts\cp\utility::matchmakinggame());

  foreach(var_3 in level.players) {
    var_10 = _id_642F(var_3);
    var_11 = var_3 getplayerdata("cp", "alienSession", "kills");
    var_12 = var_3 getplayerdata("cp", "alienSession", "downed");
    var_13 = var_3 getplayerdata("cp", "alienSession", "revives");
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_3.name, "stat_type", "Kills", "count", var_11, "description", ""]);
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_3.name, "stat_type", "Last Stands", "count", var_12, "description", ""]);
    _func_03BF("dlog_event_cpdata_eog", ["levelname", level.script, "changelist", _func_007D(), "playername", var_3.name, "stat_type", "Revives", "count", var_13, "description", ""]);

    if(isDefined(var_3.pers["rank"]) && scripts\cp\utility::matchmakinggame()) {
      var_14 = var_3 _id_0756::getrank();
      setclientmatchdata("player", var_3._id_399D, "rank", var_14);
    }

    if(isDefined(var_3.pers["prestige"]) && scripts\cp\utility::matchmakinggame()) {
      var_15 = var_3 _id_0756::_id_6C89();
      setclientmatchdata("player", var_3._id_399D, "prestige", var_15);
    }

    setclientmatchdata("player", var_3._id_399D, "xuidHigh", var_3 _meth_8585());
    setclientmatchdata("player", var_3._id_399D, "xuidLow", var_3 _meth_8586());
    setclientmatchdata("player", var_3._id_399D, "zombie_death", var_11);
    setclientmatchdata("player", var_3._id_399D, "dropped_to_last_stand", var_12);
    setclientmatchdata("player", var_3._id_399D, "revived_another_player", var_13);

    if(var_3 _meth_8687()) {
      setclientmatchdata("player", var_3._id_399D, "platform", "ps4");
    } else if(var_3 _meth_868A()) {
      setclientmatchdata("player", var_3._id_399D, "platform", "xb3");
    } else if(var_3 _meth_8685()) {
      setclientmatchdata("player", var_3._id_399D, "platform", "bnet");
    } else {
      setclientmatchdata("player", var_3._id_399D, "platform", "none");
    }

    var_3 _id_0740::_id_97A9(var_1);
  }

  level._id_7EB0 = 0;
  waitframe();

  if(level._id_0F85 > -1) {
    level._id_F1FB = _id_DFE3();
  } else {
    level._id_F1FB = 0;
  }

  if(isDefined(level._id_5536)) {}

  setomnvar("zm_time_survived", level._id_F1FB);
  var_17 = _id_DFE4(var_0);

  if(var_17._id_E59A > 0) {
    setomnvar("ui_so_stars_given", var_17._id_E59A);
  }

  setomnvar("ui_so_next_score", var_17._id_A4D3);
  setomnvar("ui_so_iwbest", var_17._id_8B43);
  setDvar("#x37c9b9af716ef3c26", 1);
  setDvar("#x3d66aa88265dae2e0", 0);
  setDvar("#x3ca984a865792777", 0);
  setgameendtime(0);

  if(_id_86BD() && getdvarint("#x34e9ab8c76756925d")) {
    foreach(var_3 in level.players) {
      if(var_17._id_E59A > 0) {
        var_3 _id_DFE7(var_17._id_E59A, level._id_F1FB);
        var_19 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
        var_20 = tablelookupbyrow("cp/cp_so_mission_table.csv", var_19, 0);
        var_3 reportchallengeuserevent_iw8("spec_ops_end", var_20, var_17._id_E59A);
      }
    }
  }

  foreach(var_3 in level.players) {
    _id_3860(var_3);
  }

  foreach(var_25 in level.agentarray) {
    if(isDefined(var_25.isactive) && var_25.isactive) {
      var_25._id_0229 = 1;
    }
  }

  _id_DFE0(var_0, var_1);
  var_27 = _id_6470(var_1);
  var_28 = _id_665F();
  _id_0705::_id_52F7(var_27, var_28);
  _id_C5DC();

  if(_id_DFE8()) {
    wait 0.1;

    foreach(var_3 in level.players) {
      var_3 _meth_8680("cp_matchend", 2);
      var_3 _meth_8680("mp_matchend_music", 2);
    }

    _id_C6DB(0);
  } else
    exitlevel(0);
}

_id_DFE3() {
  var_0 = int(gettime() - level._id_0F85);
  var_0 = int(var_0 / 1000) * 1000;
  return var_0;
}

_id_86BD() {
  return getdvarint("#x3f64b0b45b3d5bd4a") && getdvarint("#x3fd2ad8fe5f24d203");
}

_id_DFE4(var_0) {
  var_1 = spawnStruct();
  var_1._id_E59A = 0;
  var_1._id_A4DA = 1;
  var_1._id_A4D3 = 0;
  var_2 = tablelookuprownum("cp/cp_so_mission_table.csv", 1, level.script);
  var_3[0] = int(tablelookupbyrow("cp/cp_so_mission_table.csv", var_2, 6));
  var_3[1] = int(tablelookupbyrow("cp/cp_so_mission_table.csv", var_2, 7));
  var_3[2] = int(tablelookupbyrow("cp/cp_so_mission_table.csv", var_2, 8));
  var_1._id_E59B = var_3;

  if(var_0 == "allies") {
    var_1._id_E59A = 1;

    for(var_4 = var_3.size - 1; var_4 >= 0; var_4--) {
      if(level._id_F1FB <= var_3[var_4]) {
        var_1._id_E59A = var_4 + 1;
        break;
      }
    }

    if(var_1._id_E59A == 3) {
      var_1._id_A4DA = 4;
      var_1._id_A4D3 = 1;
    } else
      var_1._id_A4DA = var_1._id_E59A + 1;
  }

  if(var_1._id_A4DA > 1 && var_1._id_A4DA < 4) {
    var_1._id_A4D3 = var_3[var_1._id_A4DA - 1];
  }

  var_1._id_8B43 = int(tablelookupbyrow("cp/cp_so_mission_table.csv", var_2, 5));
  return var_1;
}

_id_DFE7(var_0, var_1) {
  var_2 = self getplayerdata("cp", "ClassicSOStarCount", level.script);
  var_3 = self getplayerdata("cp", "ClassicSOBestScore", level.script);

  if(!isDefined(var_2) || !isDefined(var_3)) {
    return;
  }
  if(var_0 > var_2) {
    self setplayerdata("cp", "ClassicSOStarCount", level.script, var_0);
  }

  if(var_1 < var_3 || var_3 == 0) {
    self setplayerdata("cp", "ClassicSOBestScore", level.script, var_1);
  }
}

_id_DFE6(var_0) {
  var_1 = var_0 == self.pers["team"];

  if(var_1 && !scripts\cp_mp\utility\player_utility::_id_B667()) {
    visionsetpain("damage_dead", 0.2);
    self painvisionon();
    thread _id_43ED("death_overlay", "ui_player_death_overlay", 0, 1, 18);
  }

  self _meth_82EE(10, 1);
}

_id_DFE0(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_3B82) || var_3.pers["team"] == "spectator") {
      continue;
    }
    var_3 thread _id_DFE5(var_0, var_1);
    var_3 thread scripts\cp\utility::_id_5F63(1);
  }
}

_id_DFE5(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var_2 = self.pers["team"];

  if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
    var_2 = "allies";
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var_0 == var_2) {
    var_3 = _id_6472("win");
  } else {
    var_3 = _id_6472("fail");
  }

  self setclientomnvar("ui_round_end_title", var_3);

  if(isDefined(var_1)) {
    self setclientomnvar("ui_round_end_reason", var_1);
  }

  _id_D685(11);
}

_id_DFE8() {
  level._id_C76C = 0;
  level._id_C76D = 0;
  var_0 = 35;
  var_1 = 0.1;

  for(var_2 = 0; var_2 < level.players.size; var_2++) {
    setomnvar("ui_votesys_player" + var_2, 0);
  }

  var_3 = -1;
  var_4 = -1;
  var_5 = 1;

  foreach(var_7 in level.players) {
    var_7 thread _id_B5A2();
  }

  while(level._id_C76C < level.players.size) {
    var_9 = int(var_0);

    if(var_9 >= 0 && var_9 != var_4) {
      var_4 = var_0;
      setomnvar("ui_votesys_time", var_9);
    }

    if(var_0 <= 0) {
      var_5 = 0;
      break;
    }

    wait(var_1);
    var_0 = var_0 - var_1;
  }

  setomnvar("ui_votesys_time", 0);
  level notify("stop_player_retry_thread");

  if(!var_5) {
    return 0;
  }

  if(level._id_C76D == level.players.size) {
    return 1;
  }

  return 0;
}

_id_B5A2() {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  var_0 = -1;

  for(;;) {
    self waittill("luinotifyserver", var_1);

    if(var_1 == "retry_level") {
      if(var_0 < 0) {
        level._id_C76C = level._id_C76C + 1;
        level._id_C76D = level._id_C76D + 1;
        var_0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      } else if(var_0 == 0) {
        level._id_C76D = level._id_C76D + 1;
        var_0 = 1;
        setomnvar("ui_votesys_player" + self getentitynumber(), 1);
      }

      continue;
    }

    if(var_1 == "quit_level") {
      if(var_0 < 0) {
        level._id_C76C = level._id_C76C + 1;
      } else if(var_0 == 1) {
        level._id_C76D = level._id_C76D - 0;
      }

      var_0 = 0;
    }
  }
}

_id_C5DC() {
  foreach(var_1 in level.players) {
    var_1 setplayerdata("cp", "CPSession", "subParty", -1);
  }
}

_id_642F(var_0) {
  var_1 = getEntArray("p_ent_zone", "targetname");

  foreach(var_3 in var_1) {
    if(_func_011A(var_0.origin, var_3)) {
      return var_3._id_039B;
    }
  }
}

_id_3433() {}

_id_8D02() {
  var_0 = _func_0070("axis");

  foreach(var_2 in var_0) {}
}

_id_5E9F() {
  level thread _id_52F7("axis", _id_6472("host_end"));
}

_id_9B7E() {
  game["state"] = "postgame";
  level.gameended = 1;
}

_id_60B9() {
  return game["state"] == "postgame" || level.gameended;
}

_id_5F61(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  foreach(var_4 in level.players) {
    var_4 thread _id_5F64(var_0);
    var_4 thread _id_C93F(4.0);
    var_4 _id_5F53();
    var_4 _meth_82F6("#x3acf57c223df6ab1e", 1, "#x3e9de50fa971cd442", 0);

    if(isDefined(var_1) && isDefined(var_2)) {
      var_4 _meth_82F6(var_1, var_2);
    }
  }

  foreach(var_7 in level.agentarray) {
    var_7 scripts\cp\utility::_id_5F63(1);
  }
}

_id_5F64(var_0) {
  self endon("disconnect");
  scripts\cp\utility::_id_3959();

  if(!isDefined(var_0)) {
    var_0 = 0.05;
  }

  wait(var_0);
  scripts\cp\utility::_id_5F63(1);
}

_id_C93F(var_0) {
  self _meth_830B(0, 128, 512, 4000, 6, 1.8);
}

_id_665F() {
  var_0 = 0;

  if(isDefined(level._id_E72D)) {
    var_0 = gettime() - level._id_E72D;
  }

  return var_0;
}

_id_5F53() {
  if(isDefined(self._id_AFCF)) {
    if(isDefined(self._id_AFCF[0])) {
      self._id_AFCF[0] scripts\cp\utility::destroyelem();
      self._id_AFD3[0] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self._id_AFCF[1])) {
      self._id_AFCF[1] scripts\cp\utility::destroyelem();
      self._id_AFD3[1] scripts\cp\utility::destroyelem();
    }

    if(isDefined(self._id_AFCF[2])) {
      self._id_AFCF[2] scripts\cp\utility::destroyelem();
      self._id_AFD3[2] scripts\cp\utility::destroyelem();
    }
  }

  self notify("perks_hidden");
  self._id_98C4 scripts\cp\utility::destroyelem();
  self._id_98CB scripts\cp\utility::destroyelem();

  if(isDefined(self._id_BDC5)) {
    self._id_BDC5 scripts\cp\utility::destroyelem();
  }

  if(isDefined(self._id_BDC6)) {
    self._id_BDC6 scripts\cp\utility::destroyelem();
  }
}

_id_3860(var_0) {
  var_0 notify("select_mode");
  var_0 notify("reset_outcome");
  var_0.pers["stats"] = var_0._id_E76F;
  var_0 scripts\cp\utility::_id_1566(1);
  var_0 scripts\cp\utility::_id_3959();

  if(isDefined(var_0._id_AE0A)) {
    var_0._id_AE0A = [];
  }

  if(isDefined(var_0._id_BB26)) {
    var_0._id_BB26 = [];
  }

  if(isDefined(var_0._id_3BB4)) {
    var_0._id_3BB4 = [];
  }

  if(isDefined(var_0._id_BADE)) {
    var_0._id_BADE = [];
  }

  var_0 _id_38F9();
}

_id_DAB4(var_0) {
  if((var_0 == 1 || var_0 == 2) && getDvar("#x36d16f02578d0ee10") == "cp_jackal_ass") {
    return "cp_titan";
  }

  return undefined;
}

_id_95CF(var_0) {
  _id_8D1C();
  level scripts\engine\utility::_id_108A7(15, "intermission_over");
  setDvar("#x36d16f02578d0ee10", var_0);
  setDvar("#x315af23e89f368200", "aliens");
  var_1 = "map " + var_0;
}

_id_C6DB(var_0) {
  for(var_1 = 0; var_1 < level.players.size; var_1++) {
    level.players[var_1] setclientomnvar("ui_match_in_progress", 0);
    level.players[var_1] setclientomnvar("ui_hide_hud", 1);
  }

  _id_8D1C();
  setomnvar("allow_server_pause", 1);
  _id_D685(0);
  _func_01EA("reset_wave_loadout", 1);

  if(!isDefined(var_0)) {
    var_0 = 3;
  }

  for(var_1 = var_0; var_1 > 0; var_1--) {
    wait 1;
  }

  map_restart(1);
}

_id_8D1C() {
  foreach(var_1 in level.characters) {
    if(isPlayer(var_1)) {
      continue;
    }
    var_1 dodamage(100000, var_1.origin);
  }

  var_3 = _id_06FE::_id_6881("alien");

  foreach(var_5 in var_3) {
    var_5 suicide();
  }
}

_id_B78A(var_0, var_1) {
  if(_id_156F(var_1)) {
    if(istrue(level._id_5E02)) {
      return 1;
    }

    level._id_C76C = 0;
    level._id_C76D = 0;
    level._id_C76B = 0;
    level._id_C76A = 0;

    foreach(var_3 in level.players) {
      var_3 thread _id_4B6E(var_0, var_1);
    }

    for(var_5 = level.players.size - level._id_C76C; level._id_C76C < level.players.size; level._id_C76B = level._id_C76B + 0.5) {
      if(level._id_C76A != 0) {
        wait 1.0;
        return 0;
      }

      setomnvar("ui_votesys_time", 33 - int(level._id_C76B));

      if(level._id_C76B >= 33) {
        return 0;
      }

      var_6 = var_5;
      var_5 = level.players.size - level._id_C76C;

      if(var_5 != var_6) {
        iprintlnbold("Waiting for " + var_5 + " player's to vote");
      }

      wait 0.5;
    }

    if(level._id_C76D == level.players.size && level._id_C76A == 0) {
      wait 1.0;
      return 1;
    }
  } else
    wait 4.0;

  return 0;
}

_id_156F(var_0) {
  if(!getdvarint("#x3b616856846001992", 1)) {
    return 0;
  }

  if(isDefined(level._id_156F)) {
    return [[level._id_156F]](var_0);
  } else {
    return var_0 == 3;
  }
}

_id_4B6E(var_0, var_1) {
  level endon("stop_player_retry_thread");
  self endon("disconnect");
  wait 1.0;
  _id_073B::_id_38E4(self);

  if(!isDefined(self._id_3B82) || !(self.pers["team"] == "spectator")) {
    var_2 = self.pers["team"];

    if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
      var_2 = "allies";
    }

    if(isDefined(self.pers["team"]) && var_0 == var_2) {
      var_3 = _id_6472("win");
    } else {
      var_3 = _id_6472("fail");
    }

    if(isDefined(var_1)) {
      self setclientomnvar("ui_round_end_reason", var_1);
    }
  }

  _id_D685(10);
  var_4 = -1;
  self waittill("luinotifyserver", var_5);

  if(var_5 == "retry_level") {
    if(var_4 < 0) {
      level._id_C76C = level._id_C76C + 1;
      level._id_C76D = level._id_C76D + 1;
      var_4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
    } else if(var_4 == 0) {
      level._id_C76D = level._id_C76D + 1;
      var_4 = 1;
      setomnvar("ui_votesys_player" + self getentitynumber(), 1);
    }
  } else if(var_5 == "quit_level") {
    setomnvar("ui_votesys_player" + self getentitynumber(), 2);
    level._id_C76A = 1;
  }
}

_id_38F9() {
  if(isDefined(self._id_BADE)) {
    foreach(var_1 in getarraykeys(self._id_BADE)) {
      var_2 = self._id_BADE[var_1]._id_3411 * -1;

      if(isDefined(level._id_BA96)) {
        self[[level._id_BA96]](var_2);
      }
    }
  }

  if(isDefined(level._id_BAE0)) {
    self[[level._id_BAE0]]("secondary");
    self[[level._id_BAE0]]("primary");
  }
}

_id_6470(var_0) {
  switch (var_0) {
    case 1:
      return "win";
    case 3:
    case 2:
      return "died";
    case 4:
      return "host_quit";
    default:
  }
}

_id_4B6F() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", var_0);

    if(var_0 == "close_menu") {
      level._id_9637 = level._id_9637 + 1;
      continue;
    } else {
      switch (var_0) {
        case "dpad_team_ammo_stun":
        case "dpad_team_ammo_reg":
        case "dpad_team_ammo_ap":
        case "dpad_team_ammo_in":
          break;
        case "dpad_team_adrenaline":
        case "dpad_team_explosives":
        case "dpad_team_boost":
        case "dpad_team_armor":
          break;
        case "dpad_maaws":
        case "dpad_riotshield":
        case "dpad_death_machine":
        case "dpad_war_machine":
          break;
        case "perk_bullet_damage":
          waitframe();
          waitframe();
          break;
        case "perk_health":
          waitframe();
          waitframe();
          break;
        case "perk_rigger":
          waitframe();
          waitframe();
          break;
        case "perk_medic":
          waitframe();
          waitframe();
          break;
        case "perk_robotics":
          waitframe();
          waitframe();
          break;
        case "perk_demolition":
          waitframe();
          waitframe();
          break;
        case "perk_gunslinger":
          waitframe();
          waitframe();
          break;
        case "perk_hybrid":
          waitframe();
          waitframe();
          break;
        case "perk_pistol_magnum":
        case "perk_pistol_znrg":
        case "perk_pistol_zemc":
        case "perk_pistol_zg18":
          break;
        case "perk_skill_pet":
        case "perk_skill_electric_arc":
        case "perk_skill_mortar":
        case "perk_skill_drone":
        case "perk_skill_heal_ring":
        case "perk_skill_stasis":
        case "perk_skill_invulnerable":
        case "perk_skill_infinite_ammo":
          break;
        case "iw7_ake_mp":
        case "iw7_m1_mp":
        case "iw6_plasmaauto_mp":
        case "iw7_erad_mp":
        case "iw7_forge_mp":
        case "iw7_nrg_mp":
        case "iw6_mp443_mp":
        case "iw6_m27_mp":
        case "iw6_lsat_mp":
        case "iw6_dlcweap02_mp+dlcweap02scope":
        case "iw7_ar57_mp":
        case "iw7_m8_mp+m8scope":
        case "iw6_magnum_mp":
        case "iw6_m9a1_mp":
        case "iw6_aliendlc11li_mp":
        case "iw6_p226_mp":
        case "iw7_crb_mp":
        case "iw7_devastator_mp":
        case "iw6_fp6_mp":
        case "iw6_honeybadger_mp":
        case "iw6_cbjms_mp":
        case "iw6_mts255_mp":
        case "iw6_pdw_mp":
        case "iw6_vepr_mp":
        case "iw6_svu_mp":
        case "iw6_g28_mp":
        case "iw6_imbel_mp":
        case "iw6_microtar_mp":
        case "iw6_l115a3_mp+acogsniper":
        case "iw6_vks_mp+vksscope":
        case "iw6_cprgm_mp":
        case "iw6_cppanzerfaust3_mp":
        case "iw6_panzerfaust3_mp":
        case "iw6_kriss_mp":
        case "iw7_cheytac_mp+cheytacscope":
        case "iw7_kbs_mp+kbsscope":
        case "iw7_chargeshot_mp":
        case "iw7_spas_mp":
        case "iw6_pp19_mp":
        case "iw6_maul_mp":
        case "iw6_arx160_mp":
        case "iw6_kac_mp":
        case "iw7_glprox_mp":
          break;
      }
    }
  }
}

_id_4B78(var_0, var_1) {
  setomnvar("ui_match_over", 1);

  foreach(var_3 in level.players) {
    if(isDefined(var_3._id_3B82) || var_3.pers["team"] == "spectator") {
      continue;
    }
    var_3 thread _id_ACA7(var_0, var_1);
    var_3 thread scripts\cp\utility::_id_5F63(1);
  }

  level notify("game_win", var_0);
  _id_C942(3.0, 1);
}

_id_ACA7(var_0, var_1) {
  self endon("disconnect");
  self notify("reset_outcome");
  var_2 = self.pers["team"];

  if(!isDefined(var_2) || var_2 != "allies" && var_2 != "axis") {
    var_2 = "allies";
  }

  while(scripts\cp\cp_hud_message::_id_8808()) {
    wait 0.05;
  }

  self endon("reset_outcome");

  if(isDefined(self.pers["team"]) && var_0 == var_2) {
    var_3 = _id_6472("win");
  } else {
    var_3 = _id_6472("fail");
  }

  self setclientomnvar("ui_round_end_title", var_3);

  if(isDefined(var_1)) {
    self setclientomnvar("ui_round_end_reason", var_1);
  }

  _id_D685(5);
}

_id_C1E0() {
  if(isDefined(level._id_52A1)) {
    [[level._id_52A1]]();
  } else {
    _id_C1DD();
  }
}

_id_C1DD() {
  level._id_52A0 = [];
  level._id_52A0["win"] = 1;
  level._id_52A0["fail"] = 2;
  level._id_52A0["kia"] = 3;
  level._id_52A0["host_end"] = 4;
  level._id_52A0["restarting"] = 5;
  level._id_52A0["exiting"] = 6;
}

_id_6472(var_0) {
  return level._id_52A0[var_0];
}

_id_C942(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5._id_4CFD)) {
        continue;
      }
      if(!var_5 scripts\cp\cp_hud_message::_id_8808()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  if(!var_1) {
    wait(var_0);
    level notify("round_end_finished");
    return;
  }

  wait(var_0 / 2);
  level notify("give_match_bonus");
  wait(var_0 / 2);
  var_2 = 0;

  while(!var_2) {
    var_3 = level.players;
    var_2 = 1;

    foreach(var_5 in var_3) {
      if(!isDefined(var_5._id_4CFD)) {
        continue;
      }
      if(!var_5 scripts\cp\cp_hud_message::_id_8808()) {
        continue;
      }
      var_2 = 0;
    }

    wait 0.5;
  }

  level notify("round_end_finished");
}

_id_43E8(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  var_1 = self;
  var_1._id_0153 = spawnStruct();
  var_1._id_0153._id_7B92 = [];
  var_2 = 3.0;
  var_3 = 5;
  self setscriptablepartstate("deathsDoor", "inactive");
  self setscriptablepartstate("laststand", "inactive");

  if(istrue(var_1._id_DD9C)) {
    return;
  }
  if(!var_1 scripts\cp_mp\utility\player_utility::_id_B667()) {
    visionsetpain("damage_dead", 0.2);
    var_1 painvisionon();
    var_1 thread _id_43ED("death_overlay", "ui_player_death_overlay", 0, 0, 18);
  }

  if(isDefined(var_0)) {
    wait(var_0);
  }

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread _id_43ED("death_tunnel", "ui_player_death_tunnel_overlay", 1, 3, 19);
  var_1 thread _id_43ED("death_black", "ui_player_death_black_overlay", 1, var_2, 20);
  wait 1;

  if(!isDefined(var_1)) {
    return;
  }
  var_1 _meth_82EE(6, var_3);
}

_id_43ED(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  self endon("disconnect");
  var_5 = self;
  wait(var_2);

  if(!isDefined(var_5) || !isDefined(var_5._id_0153)) {
    return;
  }
  var_5._id_0153._id_7B92[var_0] = _id_3EF2();
  var_5._id_0153._id_7B92[var_0] setshader(var_1, 640, 480);

  if(var_3 > 0) {
    var_5._id_0153._id_7B92[var_0] fadeovertime(var_3);
  }

  var_5._id_0153._id_7B92[var_0].alpha = 1;
  var_5._id_0153._id_7B92[var_0].sort = var_4;
}

_id_3EF2() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0._id_03F0 = 1;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0._id_01D6 = 0;
  var_0._id_0288 = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 0;
  var_0._id_018D = 1;
  return var_0;
}