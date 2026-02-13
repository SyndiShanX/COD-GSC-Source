/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\control.gsc
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
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 90);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  update_gametype_dvars();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_A543 = 1;
  level._id_ABAD = ::control_onstartgametype;
  level.onplayerconnect = ::control_onplayerconnect;
  level._id_AB63 = ::control_onplayerdisconnect;
  level._id_6D4A = ::control_getspawnpoint;
  level._id_AB70 = ::control_onplayerkilled;
  level._id_AB47 = ::control_ononeleftevent;
  level._id_9FE8 = ::control_onspawnplayer;
  level._id_8FA1 = gettime();
  level._id_AB42 = ::control_onflagcapture;
  level._id_ABC0 = ::control_ontimelimit;
  level._id_AB37 = ::control_onmaprestart;
  level.onnorespawnsevent = ::onnorespawnsevent;
  level._id_FBF8 = ::control_updatecontrolaliveomnvars;

  if(level._id_A782) {
    thread _id_FD1B();
  }

  level._id_60CD = ::control_assigngamemodecallout;
  level._id_60CE = ::control_verifygamemodecallout;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_B84F = 0;
  level._id_4A82 = 1;
  game["dialog"]["gametype"] = "mp_glob_cont_bchr_z000";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_cont_bchr_z004";
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "mp_glob_cont_bchr_z028";
  game["dialog"]["defense_obj"] = "mp_glob_cont_bchr_z029";
  game["dialog"]["securing_a"] = "mp_glob_cont_bchr_z030";
  game["dialog"]["securing_b"] = "mp_glob_cont_bchr_z032";
  game["dialog"]["securing_c"] = "mp_glob_cont_bchr_z034";
  game["dialog"]["securing_d"] = "mp_glob_domi_bchr_z089";
  game["dialog"]["securing_e"] = "mp_glob_domi_bchr_z090";
  game["dialog"]["securing_f"] = "mp_glob_domi_bchr_z091";
  game["dialog"]["secured_a"] = "mp_glob_cont_bchr_z006";
  game["dialog"]["secured_b"] = "mp_glob_cont_bchr_z010";
  game["dialog"]["secured_c"] = "mp_glob_cont_bchr_z012";
  game["dialog"]["secured_d"] = "mp_glob_domi_bchr_z086";
  game["dialog"]["secured_e"] = "mp_glob_domi_bchr_z087";
  game["dialog"]["secured_f"] = "mp_glob_domi_bchr_z088";
  game["dialog"]["attack_last_flag"] = "mp_glob_cont_bchr_z014";
  game["dialog"]["contest_attacker_a"] = "mp_glob_cont_bchr_z016";
  game["dialog"]["contest_defender_a"] = ["mp_glob_cont_bchr_z017", "mp_glob_domi_bchr_etka"];
  game["dialog"]["contest_attacker_b"] = "mp_glob_cont_bchr_z020";
  game["dialog"]["contest_defender_b"] = ["mp_glob_cont_bchr_z021", "mp_glob_domi_bchr_etkb"];
  game["dialog"]["contest_attacker_c"] = "mp_glob_cont_bchr_z022";
  game["dialog"]["contest_defender_c"] = ["mp_glob_cont_bchr_z023", "mp_glob_domi_bchr_etkc"];
  game["dialog"]["contest_attacker_all"] = "mp_glob_cont_bchr_z018";
  game["dialog"]["contest_defender_all"] = "mp_glob_cont_bchr_z019";
  game["dialog"]["losing_a"] = "mp_glob_cont_bchr_z031";
  game["dialog"]["losing_b"] = "mp_glob_cont_bchr_z033";
  game["dialog"]["losing_c"] = "mp_glob_cont_bchr_z035";
  game["dialog"]["losing_d"] = "mp_glob_domi_bchr_z075";
  game["dialog"]["losing_e"] = "mp_glob_domi_bchr_z076";
  game["dialog"]["losing_f"] = "mp_glob_domi_bchr_z077";
  game["dialog"]["lost_a"] = "mp_glob_cont_bchr_z007";
  game["dialog"]["lost_b"] = "mp_glob_cont_bchr_z011";
  game["dialog"]["lost_c"] = "mp_glob_cont_bchr_z013";
  game["dialog"]["lost_d"] = "mp_glob_domi_bchr_z078";
  game["dialog"]["lost_e"] = "mp_glob_domi_bchr_z079";
  game["dialog"]["lost_f"] = "mp_glob_domi_bchr_z080";
  game["dialog"]["defend_last_flag"] = "mp_glob_cont_bchr_z015";
  game["dialog"]["team_low_lives"] = "mp_glob_cont_bchr_z024";
  game["dialog"]["enemy_low_lives"] = "mp_glob_cont_bchr_z025";
  game["dialog"]["team_no_lives"] = "mp_glob_cont_bchr_z026";
  game["dialog"]["enemy_no_lives"] = "mp_glob_cont_bchr_z027";
  game["dialog"]["gamestate_domlosing"] = "mp_glob_cont_bchr_z009";
  game["dialog"]["gamestate_domwinning"] = "mp_glob_cont_bchr_z008";
  game["dialog"]["winning_time"] = "mp_glob_domi_bchr_z085";
  game["dialog"]["winning_score"] = "mp_glob_domi_bchr_z085";
  game["dialog"]["losing_time"] = "mp_glob_domi_bchr_z083";
  game["dialog"]["losing_score"] = "mp_glob_domi_bchr_z083";
  game["dialog"]["mission_success"] = "mp_glob_gmst_bchr_dwin";
  game["dialog"]["mission_failure"] = "mp_glob_domi_bchr_dlos";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3cc192c32a89fbdf8", getmatchrulesdata("controlData", "flagCaptureTime"));
  setdynamicdvar("#x33a74975173645ac4", getmatchrulesdata("controlData", "flagsRequiredToScore"));
  setdynamicdvar("#x37e5f71d09151b799", getmatchrulesdata("controlData", "pointsPerFlag"));
  setdynamicdvar("#x3669b6eab3e3f4250", getmatchrulesdata("controlData", "flagNeutralization"));
  setdynamicdvar("#x3d0156237c7c46f0b", getmatchrulesdata("controlData", "numFlagsScoreOnKill"));
  setdynamicdvar("#x3d7b5c112b29c6d4c", getmatchrulesdata("controlData", "objScalar"));
  setdynamicdvar("#x3fb76852897c6161b", getmatchrulesdata("controlData", "preCapPoints"));
  setdynamicdvar("#x34f06ebad6211a20b", getmatchrulesdata("controlData", "captureType"));
  setdynamicdvar("#x313efbe0ae6ae0553", getmatchrulesdata("controlData", "captureDecay"));
  setdynamicdvar("#x36d0b5515545e16d2", getmatchrulesdata("controlData", "extraTimeOnSegmentCapture"));
  setdynamicdvar("#x326918c35b5a238e5", getmatchrulesdata("controlData", "disableMajorityCapProgress"));
  setdynamicdvar("#x32786b04f0977d4d9", getmatchrulesdata("controlData", "suicideTeamKillLowersLives"));
  setdynamicdvar("#x377359830f3ca75fe", getmatchrulesdata("controlData", "captureExtraTime"));
  setdynamicdvar("#x31739d10a7d62f378", getmatchrulesdata("controlData", "pauseTimer"));
  setdynamicdvar("#x360c8073000fc9f68", getmatchrulesdata("controlData", "useSegments"));
  setdynamicdvar("#x3bff087abcdcfea99", getmatchrulesdata("controlData", "captureRateIncrease"));
  setdynamicdvar("#x33c662660f400ba8b", getmatchrulesdata("controlData", "numTeamLives"));
  setdynamicdvar("#x35d617830ab85c570", getmatchrulesdata("controlData", "overtimeDefenders"));
  setdynamicdvar("#x37e314a31f26cb79d", getmatchrulesdata("controlData", "segmentCaptureExtraTime"));
  setdynamicdvar("#x3aacb3551a99056dc", 0);
  scripts\mp\utility\game::_id_C25D("dom", 0);
}

set_icon_names() {
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C50 = "waypoint_defending";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
}

control_onstartgametype() {
  var_0 = game["attackers"];
  var_1 = game["defenders"];
  level._id_EF6A[var_0]["livesCount"] = level.numteamlives;
  level._id_EF6A[var_1]["livesCount"] = level.numteamlives;
  level._id_EF6A[var_0]["controlUILivesCount"] = level._id_EF6A[var_0]["livesCount"];
  level._id_EF6A[var_1]["controlUILivesCount"] = level._id_EF6A[var_1]["livesCount"];
  set_icon_names();

  foreach(var_3 in level._id_EF89) {
    if(var_3 == var_0) {
      scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/CONTROL_ATTACKER");
    } else {
      scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/CONTROL_DEFENDER");
    }

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/CONTROL");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/CONTROL_SCORE");
    }

    if(var_3 == var_0) {
      scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/CONTROL_ATTACKER_HINT");
      continue;
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/CONTROL_DEFENDER_HINT");
  }

  setclientnamemode("auto_change");

  if(level._id_CC0E["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  if(!isDefined(game["match_kills"])) {
    game["match_kills"][var_1] = 0;
    game["match_kills"][var_0] = 0;
  }

  if(!isDefined(game["segment_captures"])) {
    game["segment_captures"][var_1] = 0;
    game["segment_captures"][var_0] = 0;
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(level.overtimedefenders != 0 && game["roundsWon"][var_1] == level._id_10E52 - 1 && game["roundsWon"][var_0] == level._id_10E52 - 1) {
    var_5 = control_getovertimedefenders();

    if(var_5 == game["attackers"]) {
      game["attackers"] = var_1;
      game["defenders"] = var_0;
    }
  } else if(game["switchedsides"]) {
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  if(level.mapname == "mp_shipment") {
    level._id_11A9 = 1;
  }

  level init_spawns();
  thread setup_control_zones();
  thread _id_C492();
  thread _id_B160();
  thread inituilives();
  scripts\mp\gametypes\bradley_spawner::_id_82A8();
  level.announcedlowlivesa = 0;
  level.announcedlowlivesd = 0;
  level._id_EF6A[var_0]["uncountedDeaths"] = 0;
  level._id_EF6A[var_1]["uncountedDeaths"] = 0;
}

inituilives() {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done");
  }

  level update_ui_lives_remaining();
}

update_gametype_dvars() {
  scripts\mp\gametypes\common::_id_FC39();
  setdvarifuninitialized("#x386b12880a7d57d13", 0);
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("flagCaptureTime", 60, 0, 120);
  level._id_5C47 = scripts\mp\utility\dvars::_id_509C("flagsRequiredToScore", 2, 1, 3);
  level._id_B9C1 = scripts\mp\utility\dvars::_id_509C("pointsPerFlag", 1, 1, 300);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_322C = scripts\mp\utility\dvars::_id_509C("captureDecay", 1, 0, 1);
  level._id_3236 = scripts\mp\utility\dvars::_id_509C("captureType", 1, 0, 3);
  level._id_A782 = scripts\mp\utility\dvars::_id_509C("numFlagsScoreOnKill", 0, 0, 3);
  level._id_A8EC = scripts\mp\utility\dvars::_id_509A("objScalar", 4, 1, 10);
  level._id_3230 = scripts\mp\utility\dvars::_id_509C("numCaptureSegments", 3, 0, 3);
  level.extratimeonsegementcapture = scripts\mp\utility\dvars::_id_509C("extraTimeOnSegmentCapture", 0, 0, 1);
  level.disablemajoritycapprogress = scripts\mp\utility\dvars::_id_509C("disableMajorityCapProgress", 1, 0, 1);
  level.suicideteamkilllowerslives = scripts\mp\utility\dvars::_id_509C("suicideTeamKillLowersLives", 0, 0, 1);
  level.captureextratime = scripts\mp\utility\dvars::_id_509A("captureExtraTime", 60, 30, 300);
  level.pausetimer = scripts\mp\utility\dvars::_id_509C("pauseTimer", 1, 0, 1);
  level.usesegments = scripts\mp\utility\dvars::_id_509C("useSegments", 1, 0, 1);
  level.capturerateincrease = scripts\mp\utility\dvars::_id_509C("captureRateIncrease", 1, 0, 1);
  level.numteamlives = control_getteamlives();
  level.overtimedefenders = scripts\mp\utility\dvars::_id_509C("overtimeDefenders", 2, 0, 2);
  level.segmentcaptureextratime = scripts\mp\utility\dvars::_id_509A("segmentCaptureExtraTime", 20, 15, 60);

  if(!level.usesegments) {
    level._id_3230 = 0;
  }

  if(!level.capturerateincrease) {
    level.objectivescalar = 1;
  }

  level.allow_legacy_spawns = 0;
  level._id_FE83 = 1;
  level._id_FE81 = 0;
  level._id_110E7 = scripts\mp\utility\dvars::_id_509A("zonePreviewTime", 10, 0, 60);
}

control_getteamlives() {
  var_0 = scripts\mp\utility\dvars::_id_509C("numTeamLives", 30, 0, 100);
  var_1 = scripts\mp\utility\game::_id_6C73();

  if(var_1 == "" || scripts\mp\utility\game::isanymlgmatch() || getdvarint("#x35a99404093785953") != 0) {
    return var_0;
  }

  var_2 = _id_07EF::get_max_team_size();

  if(!isDefined(var_2)) {
    return var_0;
  }

  if(var_2 >= getdvarint("#x34d64ce9b3bf53828", 15)) {
    var_0 = 60;
  } else if(var_2 >= getdvarint("#x34d71c09b3c032de3", 12)) {
    var_0 = 50;
  } else if(var_2 >= getdvarint("#x34d6d5a9b3bfe57ba", 9)) {
    var_0 = 40;
  }

  return var_0;
}

init_spawns() {
  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    _id_0817::_id_D461("BigTDM", "Crit_Default");
  } else {
    _id_0817::_id_D461("Default", "Crit_Frontline");
  }

  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  var_0 = _id_0817::_id_6D4E("mp_control_spawn_attacker_start");

  if(var_0.size > 0) {
    _id_0817::_id_113A("mp_control_spawn_attacker_start", 0, "allies");
    _id_0817::_id_1136("allies", "mp_control_spawn_attacker_start");
  } else if(level.allow_legacy_spawns) {
    var_1 = "mp_control_spawn_allies_start";
    var_0 = _id_0817::_id_6D4E(var_1);
    _id_0817::_id_113A(var_1, 0, "allies");
    _id_0817::_id_1136("allies", var_1);
  }

  _id_0817::_id_C2B9("start_attackers", var_0);
  var_2 = _id_0817::_id_6D4E("mp_control_spawn_defender_start");

  if(var_2.size > 0) {
    _id_0817::_id_113A("mp_control_spawn_defender_start", 0, "axis");
    _id_0817::_id_1136("axis", "mp_control_spawn_defender_start");
  } else if(level.allow_legacy_spawns) {
    var_3 = "mp_control_spawn_axis_start";
    var_2 = _id_0817::_id_6D4E(var_3);
    _id_0817::_id_113A(var_3, 0, "axis");
    _id_0817::_id_1136("axis", var_3);
  }

  _id_0817::_id_C2B9("start_defenders", var_2);
  var_4 = _id_0817::_id_6D4E("mp_control_spawn_attacker");
  _id_0817::_id_1136("allies", "mp_control_spawn_attacker", 1);
  _id_0817::_id_C2B9("normal_attackers", var_4);
  var_5 = _id_0817::_id_6D4E("mp_control_spawn_defender");
  _id_0817::_id_1136("axis", "mp_control_spawn_defender", 1);
  _id_0817::_id_C2B9("normal_defenders", var_5);
  var_6 = _id_0817::_id_6D4E("mp_control_spawn_attacker_secondary");
  _id_0817::_id_1136("allies", "mp_control_spawn_attacker_secondary", 1, 1);
  _id_0817::_id_C2B9("secondary_attackers", var_6);
  var_7 = _id_0817::_id_6D4E("mp_control_spawn_defender_secondary");
  _id_0817::_id_1136("axis", "mp_control_spawn_defender_secondary", 1, 1);
  _id_0817::_id_C2B9("secondary_defenders", var_7);

  if(level.allow_legacy_spawns) {
    _id_0817::_id_1136("allies", "mp_control_spawn", 1, 1);
    _id_0817::_id_1136("axis", "mp_control_spawn", 1, 1);
    var_8 = _id_0817::_id_6D4E("mp_control_spawn");
    _id_0817::_id_C2B9("mp_control_spawn", var_8);
  }

  var_9 = _id_0817::_id_6D4E("mp_tdm_spawn");
  _id_0817::_id_C2B9("mp_tdm_spawn", var_9);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

control_getspawnpoint() {
  var_0 = self.pers["team"];
  var_1 = undefined;

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", "normal_attackers");
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", "normal_defenders");
    }
  } else {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "normal_attackers", "secondary_attackers");
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "normal_defenders", "secondary_defenders");
    }

    if(level.allow_legacy_spawns && (!isDefined(var_1) || isDefined(var_1._id_038F) && var_1._id_038F == "bad")) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "mp_control_spawn");
    }
  }

  return var_1;
}

setup_control_zones() {
  var_0 = [];
  level._id_33E1 = 0;

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    var_1 = getEntArray("control_zone", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_039B) && var_3._id_039B == level._id_96CC) {
        var_0[var_0.size] = var_3;
        continue;
      }

      if(isDefined(var_3.target)) {
        var_0[var_0.size] = var_3;
        continue;
      }

      var_3 delete();
    }
  } else {
    level._id_33E1 = getdvarint("#x3937b70f8373a6a3d", 0);
    var_1 = getEntArray("control_zone", "targetname");

    foreach(var_3 in var_1) {
      var_0[var_0.size] = var_3;
    }
  }

  if(var_0.size != 2) {
    return;
  }
  setomnvar("ui_num_dom_flags", var_0.size);
  var_7 = [];

  for(var_8 = 0; var_8 < var_0.size; var_8++) {
    var_7[var_7.size] = var_0[var_8];
  }

  foreach(var_10 in var_7) {
    modify_trigger_locations(var_10);
    var_11 = setup_control_objective(var_10, undefined, 1, 1);
    var_11 setup_control_chevrons(var_10.target, var_10._id_CD99);
    level._id_A8E8[var_11._id_A8E1] = var_11;
  }

  var_13 = _id_0817::_id_6D4E("mp_control_spawn_attacker_start");

  if(level.allow_legacy_spawns && var_13.size == 0) {
    var_13 = _id_0817::_id_6D4E("mp_control_spawn_allies_start");
  }

  var_14 = _id_0817::_id_6D4E("mp_control_spawn_defender_start");

  if(level.allow_legacy_spawns && var_14.size == 0) {
    var_14 = _id_0817::_id_6D4E("mp_control_spawn_axis_start");
  }

  if(isDefined(var_13) && isDefined(var_13[0])) {
    level._id_0405["allies"] = var_13[0].origin;
  } else {
    level._id_0405["allies"] = level._id_E721["allies"];
  }

  if(isDefined(var_14) && isDefined(var_14[0])) {
    level._id_0405["axis"] = var_14[0].origin;
  } else {
    level._id_0405["axis"] = level._id_E721["axis"];
  }

  level._id_24D4 = [];
  level._id_24D4["allies"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("allies", undefined);
  level._id_24D4["axis"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("axis", level._id_24D4["allies"]);
  _id_5C46();

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level._id_A8E8) {
    var_16 = scripts\mp\gametypes\obj_dom::_id_6CED(var_3._id_A8E1);
    var_3 _id_07D6::_id_C579(1, 1, var_16);

    if(isDefined(var_3._id_A908)) {
      _func_0179(var_3._id_A908, "icon_medium");
      _func_046F(var_3._id_A908, 0);
    }

    var_3._id_ABCB = ::control_onuse;
    var_3._id_AA79 = ::control_onbeginuse;
    var_3._id_ABD4 = ::control_onuseupdate;
    var_3._id_AAC2 = ::control_onenduse;
    var_3._id_AA8D = ::control_oncontested;
    var_3._id_ABC7 = ::control_onuncontested;
    var_3._id_ABC8 = ::control_onunoccupied;
    var_3._id_AB54 = ::control_onpinnedstate;
    var_3._id_ABC9 = ::control_onunpinnedstate;
    var_3._id_E86E = ::control_stompprogressreward;
    var_3.onsegmentcapture = ::control_onsegmentcapture;
    var_3 _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    var_3 _id_07D6::_id_D8E0("any");
  }

  if(level._id_BB6F) {
    foreach(var_3 in level._id_A8E8) {
      var_3 scripts\mp\gametypes\obj_dom::_id_D560(game["defenders"], "neutral", undefined, 1);
    }
  }

  if(level.codcasterenabled) {
    thread _id_FD6E();
  }
}

setup_control_objective(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0.origin;
  var_6 = 1;
  var_7 = getEntArray("control_flagui", "script_noteworthy");

  foreach(var_9 in var_7) {
    if(scripts\engine\utility::is_equal(var_9._id_0398, var_0._id_0398)) {
      var_5 = var_9.origin;
      var_6 = 0;
      var_9 delete();
    }
  }

  var_11 = var_5 + (0, 0, 64);
  var_12 = var_5 + (0, 0, -64);
  var_13 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
  var_14 = [];
  var_15 = scripts\engine\trace::ray_trace(var_11, var_12, var_14, var_13);

  if(var_6) {
    var_5 = var_15["position"] + (0, 0, 72);
  }

  var_16 = [];
  var_16[0] = spawn("script_model", var_5);
  var_16[0].angles = (0, 0, 0);

  if(!isDefined(level._id_5C3B)) {
    level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 60, 0, 60);
  }

  if(isDefined(var_0._id_A8E1)) {
    var_17 = var_0._id_A8E1;
  } else {
    var_17 = var_0._id_CD99;
  }

  if(isDefined(var_0._id_7C73)) {
    var_18 = var_0._id_7C73;
  } else {
    var_18 = var_0._id_CD99;
  }

  if(istrue(var_2)) {
    var_19 = scripts\mp\gametypes\obj_dom::_id_6CED(var_17);
  } else {
    var_19 = undefined;
  }

  if(!isDefined(var_1)) {
    var_1 = "neutral";
  }

  var_20 = _id_07D6::_id_406E(var_1, var_0, var_16, var_5 - var_0.origin, var_19, var_3, var_4);

  if(level.codcasterenabled) {
    var_20 _id_07D6::_id_15DF("any");
  } else {
    var_20 _id_07D6::_id_15DF("enemy");
  }

  var_20 _id_07D6::_id_316A(1);
  var_20 _id_07D6::_id_D8D2(level._id_5C3B);

  if(isDefined(level._id_3236)) {
    var_20 _id_07D6::_id_D4B2(scripts\mp\gametypes\obj_dom::_id_694D());
  }

  var_20._id_A8E1 = var_17;
  var_20._id_7C73 = var_18;

  if(!istrue(var_3)) {
    var_20 _id_07D6::_id_D8E0("any");
    var_20._id_ABCB = ::control_onuse;
    var_20._id_AA79 = ::control_onbeginuse;
    var_20._id_ABD4 = ::control_onuseupdate;
    var_20._id_AAC2 = ::control_onenduse;
    var_20._id_AA8D = ::control_oncontested;
    var_20._id_ABC7 = ::control_onuncontested;
    var_20._id_ABC8 = ::control_onunoccupied;
    var_20._id_AB54 = ::control_onpinnedstate;
    var_20._id_ABC9 = ::control_onunpinnedstate;
    var_20._id_E86E = ::control_stompprogressreward;
  }

  var_20._id_A6C4 = 1;
  var_20._id_7C8C = "domFlag";
  var_20._id_37F3 = level._id_5C3B * 1000;
  var_20._id_5BC6 = 0;
  var_20 _id_07D6::_id_B0E7();
  var_21 = scripts\mp\gametypes\obj_dom::_id_3529(var_20);
  var_20._id_22B7 = var_15["position"] + var_21;
  var_22 = vectortoangles(var_15["normal"]);
  var_23 = scripts\mp\gametypes\obj_dom::_id_3528(var_20, var_22);
  var_20._id_22B6 = anglesToForward(var_23);
  var_20._id_103BF = "";
  var_20._id_A5D5 = 1;

  if(istrue(level._id_A2FC)) {
    var_20._id_A5D5 = 1;
  }

  var_20 scripts\mp\gametypes\obj_dom::_id_81E4();
  return var_20;
}

control_onuse(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
}

control_onbeginuse(var_0) {
  if(level.pausetimer && self._id_ADAE != var_0.team && !istrue(self._id_5C3E)) {
    self._id_5C3E = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
  update_chevrons();
}

control_onenduse(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);

  if(var_2) {
    thread set_chevron_state("off");
  } else {
    update_chevrons();
  }
}

control_onuseupdate(var_0, var_1, var_2, var_3) {
  scripts\mp\gametypes\obj_dom::_id_4D52(var_0, var_1, var_2, var_3);

  if(var_2 > 0 && (!isDefined(self._id_3225) || self._id_3225 == "normal") && var_0 != self._id_ADAE) {
    if(!istrue(self.playedlosingsound)) {
      self.playedlosingsound = 1;
      var_3 playsoundtoteam("ui_mp_control_point_losing", self._id_ADAE);
    }
  } else
    self.playedlosingsound = 0;
}

control_oncontested() {
  if(level.pausetimer) {
    self._id_5C3E = 1;
    scripts\mp\gamelogic::pausetimer();
  }

  self.playedlosingsound = 0;
  scripts\mp\gametypes\obj_dom::_id_4D47();
  update_chevrons();
  var_0 = _id_07D6::_id_6C02();
  var_1 = scripts\mp\utility\game::_id_6BE2(var_0);

  if(isDefined(self._id_A8E1)) {
    level._id_A8E8[self._id_A8E1]._id_3BEC = 1;
  }

  var_2 = 0;

  foreach(var_4 in level._id_A8E8) {
    if(istrue(var_4._id_3BEC)) {
      var_2++;
    }
  }

  if(var_2 == 0) {
    return;
  } else if(level._id_A8E8.size > 1 && var_2 == level._id_A8E8.size) {
    _id_0A8D::_id_E775("contest_defender_all", var_0);

    foreach(var_7 in var_1) {
      _id_0A8D::_id_E775("contest_attacker_all", var_7);
    }
  } else {
    _id_0A8D::_id_E775("contest_defender" + self._id_A8E1, var_0);

    foreach(var_7 in var_1) {
      _id_0A8D::_id_E775("contest_attacker" + self._id_A8E1, var_7);
    }
  }
}

control_onuncontested(var_0) {
  if(self._id_ADAE == var_0) {
    self._id_5C3E = 0;

    if(!istimerpausedbyflags(self)) {
      scripts\mp\gamelogic::resumetimer();
    }
  }

  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);
  scripts\engine\utility::delaythread(0.05, ::update_chevrons);

  if(isDefined(self._id_A8E1)) {
    level._id_A8E8[self._id_A8E1]._id_3BEC = 0;
  }
}

control_onunoccupied() {
  self._id_5C3E = 0;
  self.playedlosingsound = 0;

  if(!istimerpausedbyflags(self) && (!isDefined(level.isesportstimerpaused) || !level.isesportstimerpaused)) {
    scripts\mp\gamelogic::resumetimer();
  }

  scripts\mp\gametypes\obj_dom::_id_4D4D();
  update_chevrons();
}

control_onpinnedstate(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D4B(var_0);
  update_chevrons();
}

control_onunpinnedstate() {
  scripts\mp\gametypes\obj_dom::_id_4D4E();
  update_chevrons();
}

control_stompprogressreward(var_0) {
  scripts\mp\gametypes\obj_dom::_id_4D55(var_0);
}

setup_control_chevrons(var_0, var_1) {
  wait 1.0;
  var_2 = _func_03C0(var_0, "targetname");
  var_3 = [];

  foreach(var_5 in var_2) {
    var_6 = var_3.size;
    var_3[var_6] = var_5;
    var_3[var_6]._id_A776 = 1;
  }

  self._id_3572 = var_3;
  set_chevron_state("idle");
}

set_chevron_state(var_0) {
  self notify("updateChevrons");
  self endon("updateChevrons");

  while(!isDefined(self._id_3572)) {
    waitframe();
  }

  var_1 = "chevron_";

  if(scripts\mp\utility\game::isholidayenabled(3)) {
    var_1 = "chevron_control_vday_";
  }

  foreach(var_3 in self._id_3572) {
    for(var_4 = 0; var_4 < var_3._id_A776; var_4++) {
      var_3 setscriptablepartstate(var_1 + var_4, var_0);
    }
  }
}

update_chevrons() {
  if(isDefined(self._id_D030) && self._id_D030 >= level._id_3230 || self._id_ADAE == game["attackers"]) {
    thread set_chevron_state("off");
  } else if(self._id_E57B) {
    thread set_chevron_state("contested");
  } else if(self._id_8ABF) {
    thread set_chevron_state("idle");
  } else {
    thread set_chevron_state(self._id_A1AF);
  }
}

modify_trigger_locations(var_0) {}

remap_control_trigger_script_label() {}

control_onplayerkilled(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1) && isPlayer(var_1) && var_1 != self && var_1.team != self.team) {
    var_10 = var_1.team == game["attackers"];
    var_11 = self;
    var_12 = var_1.team;

    foreach(var_14 in level._id_A8E8) {
      if(!isDefined(var_14.trigger)) {
        continue;
      }
      var_15 = var_1 istouching(var_14.trigger);
      var_16 = var_11 istouching(var_14.trigger);

      if(var_10) {
        if(var_15) {
          var_1 scripts\mp\utility\stats::_id_7DAE("objectiveKills", 1);
          var_1 scripts\mp\utility\stats::_id_D550(var_1.pers["objectiveKills"]);
          var_1 _id_07BF::_id_7D94(13, 1);
        }

        continue;
      }

      if(var_16) {
        var_1 scripts\mp\utility\stats::_id_7DAE("objectiveKills", 1);
        var_1 scripts\mp\utility\stats::_id_D550(var_1.pers["objectiveKills"]);
        var_1 _id_07BF::_id_7D94(13, 1);
      }
    }

    if(var_10) {
      var_1 _id_07BF::_id_7D94(12, 1);
    } else {
      var_1 _id_07BF::_id_7D94(11, 1);
    }

    scripts\mp\gametypes\obj_dom::_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
  }

  var_18 = self.team;
  var_19 = wassuicide(var_0, var_1, var_3, var_4);
  var_20 = wasteamkill(var_0, var_1);

  if(isDefined(self._id_8BDA) && self._id_8BDA != "spectator") {
    var_18 = scripts\mp\utility\game::_id_6BE2(self._id_8BDA)[0];
  }

  if((var_19 || var_20) && !level.suicideteamkilllowerslives && !istrue(self._id_EC33)) {
    if(scripts\mp\utility\teams::_id_6DCA(var_18, "noRespawns")) {
      waitframe();
      thread scripts\mp\playerlogic::_id_E285();
    }

    level thread control_uncounteddeaths(self, var_18);
    return;
  }

  game["match_kills"][scripts\mp\utility\game::_id_6BE2(var_18)[0]]++;
  control_removelife(self, var_18);
}

control_removelife(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount");
  var_3 = scripts\mp\utility\teams::_id_6DCA(var_1, "aliveCount");
  var_4 = scripts\mp\utility\teams::_id_6DCA(var_1, "uncountedDeaths");
  var_5 = var_2 - var_3 - var_4;
  level._id_EF6A[var_1]["controlUILivesCount"]--;
  level update_ui_lives_remaining();

  if(scripts\mp\utility\teams::_id_6DCA(var_0.team, "noRespawns")) {
    var_0._id_9CCD = 0;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(var_1, "noRespawns") && scripts\mp\utility\teams::_id_6DCA(var_1, "livesCount") == var_5) {
    control_setnorespawns(var_1);
  }

  var_6 = get_lives(var_1, 1);

  if(var_6 == 0 && level.numteamlives != 0 || var_2 == 0) {
    var_7 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
    level thread scripts\mp\gamelogic::_id_52F7(var_7, game["end_reason"]["enemies_eliminated"], game["end_reason"]["friendlies_eliminated"]);
    _id_07BF::_id_FC32();
  }
}

wassuicide(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1) && var_1 == self) {
    return 1;
  }

  if(isDefined(var_2) && (var_2 == "MOD_TRIGGER_HURT" || var_2 == "MOD_SUICIDE")) {
    return 1;
  }

  if(scripts\mp\utility\entity::_id_8811(var_0)) {
    return 1;
  }

  return 0;
}

wasteamkill(var_0, var_1) {
  if(!isDefined(var_1)) {
    return 0;
  }

  if(!isPlayer(var_1) && !isDefined(var_1.team)) {
    return 0;
  }

  if(self.team != var_1.team) {
    return 0;
  }

  if(self == var_1) {
    return 0;
  }

  return 1;
}

control_ononeleftevent(var_0) {
  level thread control_delayedlastplayerwarning(var_0);
}

control_delayedlastplayerwarning(var_0) {
  waittillframeend;
  var_1 = scripts\mp\utility\game::_id_6AF7(var_0);
  var_1 thread control_givelastonteamwarning();
}

control_givelastonteamwarning() {
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

onnorespawnsevent(var_0) {
  if(scripts\mp\utility\game::_id_6DE6() < 5000) {
    return;
  }
  scripts\mp\utility\game::_id_D5FA(24, var_0);
  _id_0A8D::_id_E775("team_no_lives", var_0, "lives");

  foreach(var_2 in scripts\mp\utility\game::_id_6BE2(var_0)) {
    _id_0A8D::_id_E775("enemy_no_lives", var_2, "lives");
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level._id_EFA5[var_1.team]) {
    scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  }

  level update_ui_lives_remaining();
}

_id_6C00() {
  var_0 = [];

  foreach(var_2 in level._id_A8E8) {
    if(var_2 _id_07D6::_id_6C02() != "neutral" && isDefined(var_2._id_3235)) {
      var_0[var_0.size] = var_2;
    }
  }

  return var_0;
}

_id_6A45() {
  return _id_07D6::_id_6C02();
}

_id_5C46() {
  foreach(var_1 in level._id_A8E8) {
    var_1._id_E2EB = _id_6A44(var_1._id_A8E1);
  }

  var_3 = level._id_E34D;

  foreach(var_5 in var_3) {
    var_5._id_CF35._id_4D2A = _id_6D50(var_5);
  }
}

_id_6A44(var_0) {
  switch (var_0) {
    case "_a":
      return 1;
    case "_b":
      return 2;
    case "_c":
      return 4;
    case "_d":
      return 8;
    case "_e":
      return 16;
  }

  return undefined;
}

_id_6D50(var_0) {
  if(scripts\cp_mp\utility\game_utility::_id_875F()) {
    if(var_0._id_039B == "1" || var_0._id_039B == "2" || var_0._id_039B == "3") {
      var_0._id_039B = "";
    }
  }

  if(!isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_0._id_039B) && var_0._id_039B != "") {
    var_1 = _id_AE6E(var_0._id_039B);

    if(isDefined(var_1)) {
      return var_1;
    }
  }

  var_2 = _id_5AF6(var_0.origin);
  return var_2._id_E2EB;
}

_id_AE6E(var_0) {
  var_0 = tolower(var_0);

  switch (var_0) {
    case "a":
      return 1;
    case "b":
      return 2;
    case "c":
      return 4;
    case "d":
      return 8;
    case "e":
      return 16;
    case "ba":
    case "ab":
      return 32;
    case "bc":
    case "cb":
      return 64;
    case "ca":
    case "ac":
      return 128;
    default:
      break;
  }
}

_id_5AF6(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    var_3._id_A3E0 = _func_02AB(var_3.trigger.origin);
    var_1[var_1.size] = var_3._id_A3E0;
  }

  var_5 = _func_034C(var_1, _func_02AB(var_0));
  var_6 = undefined;

  if(!isDefined(var_5)) {
    var_7 = undefined;

    foreach(var_3 in level._id_A8E8) {
      var_9 = distancesquared(var_3.trigger.origin, var_0);

      if(!isDefined(var_6) || var_9 < var_7) {
        var_6 = var_3;
        var_7 = var_9;
      }
    }
  } else {
    foreach(var_3 in level._id_A8E8) {
      if(distance2dsquared(var_3._id_A3E0, var_5) < 1.0) {
        var_6 = var_3;
        break;
      }
    }
  }

  return var_6;
}

_id_3B05(var_0, var_1) {
  var_2 = int(var_0._id_A8E1);
  var_3 = int(var_1._id_A8E1);

  if(!isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(!isDefined(var_2) && isDefined(var_3)) {
    return 1;
  }

  if(isDefined(var_2) && !isDefined(var_3)) {
    return 0;
  }

  if(var_2 > var_3) {
    return 1;
  }

  return 0;
}

_id_6EA6(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_3._id_A8E1 = var_3._id_CD99;
  }

  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  var_5 = 1;

  for(var_6 = var_1.size; var_5; var_6--) {
    var_5 = 0;

    for(var_7 = 0; var_7 < var_6 - 1; var_7++) {
      if(_id_3B05(var_1[var_7], var_1[var_7 + 1])) {
        var_8 = var_1[var_7];
        var_1[var_7] = var_1[var_7 + 1];
        var_1[var_7 + 1] = var_8;
        var_5 = 1;
      }
    }
  }

  return var_1;
}

control_onspawnplayer() {
  thread _id_FCC2();

  if(scripts\mp\utility\teams::_id_6DCA(self.team, "livesCount") == 0 && scripts\mp\utility\teams::_id_6DCA(self.team, "noRespawns") == 0 && level.numteamlives != 0) {
    control_setnorespawns(self.team);
  }
}

_id_FC41() {
  if(!isDefined(self._id_3E28)) {
    self._id_A775 = 0;
    self._id_3E28 = 0;
  }

  self._id_A775++;

  if(scripts\mp\utility\game::_id_6B5F() < 1) {
    return;
  }
  self._id_3E28 = self._id_A775 / scripts\mp\utility\game::_id_6B5F();
}

_id_694E() {
  if(self._id_3E28 < 4) {
    return 1;
  } else {
    return 0.25;
  }
}

control_onplayerconnect(var_0) {
  var_0._id_F90E = undefined;
  var_0._id_F90F = undefined;
  var_0 thread onplayerspawned();
  var_0 thread _id_AB6B();
}

_id_AB6B() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_team");

    if(scripts\mp\utility\teams::_id_6DCA(self.team, "noRespawns") && self.team != "none" && self.team != "spectator") {
      self._id_9CCD = 0;
      continue;
    }

    self._id_9CCD = undefined;
  }
}

control_onplayerdisconnect(var_0) {
  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    control_removelife(var_0, var_0.team);
  }
}

control_uncounteddeaths(var_0, var_1) {
  level._id_EF6A[var_1]["uncountedDeaths"]++;
  var_0.uncounteddeath = 1;
  var_0 scripts\engine\utility::waittill_any_2("spawned", "disconnect");
  level._id_EF6A[var_1]["uncountedDeaths"]--;
  var_0.uncounteddeath = undefined;
}

update_ui_lives_remaining() {
  var_0 = scripts\mp\utility\teams::_id_6DCA("allies", "aliveCount");
  var_1 = scripts\mp\utility\teams::_id_6DCA("axis", "aliveCount");

  if(level.numteamlives == 0) {
    setomnvar("ui_allies_alive", scripts\mp\utility\teams::_id_6DCA("allies", "teamCount"));
    setomnvar("ui_axis_alive", scripts\mp\utility\teams::_id_6DCA("axis", "teamCount"));
    setomnvar("ui_allies_lives_remaining", scripts\mp\utility\teams::_id_6DCA("allies", "teamCount"));
    setomnvar("ui_axis_lives_remaining", scripts\mp\utility\teams::_id_6DCA("axis", "teamCount"));
    return;
  } else if(var_0 > level.numteamlives || var_1 > level.numteamlives) {
    var_2 = scripts\engine\utility::ter_op(var_0 > var_1, var_0, var_1);
    update_team_to_new_lives("allies", var_2);
    update_team_to_new_lives("axis", var_2);
    level.numteamlives = var_2;
  }

  setomnvar("ui_allies_alive", get_lives("allies", 1));
  setomnvar("ui_axis_alive", get_lives("axis", 1));
  setomnvar("ui_allies_lives_remaining", get_lives("allies", 1));
  setomnvar("ui_axis_lives_remaining", get_lives("axis", 1));
  var_3 = level._id_EF6A["allies"]["teamCount"];

  if(scripts\mp\utility\teams::_id_6DCA("allies", "livesCount") <= 10 && !level.announcedlowlivesa && level.numteamlives - var_3 > 10) {
    _id_0A8D::_id_E775("team_low_lives", "allies", "lives");
    _id_0A8D::_id_E775("enemy_low_lives", "axis", "lives");
    level.announcedlowlivesa = 1;
  }

  var_4 = level._id_EF6A["axis"]["teamCount"];

  if(scripts\mp\utility\teams::_id_6DCA("axis", "livesCount") <= 10 && !level.announcedlowlivesd && level.numteamlives - var_4 > 10) {
    _id_0A8D::_id_E775("team_low_lives", "axis", "lives");
    _id_0A8D::_id_E775("enemy_low_lives", "allies", "lives");
    level.announcedlowlivesd = 1;
  }
}

update_team_to_new_lives(var_0, var_1) {
  var_2 = scripts\mp\utility\teams::_id_6DCA(var_0, "aliveCount");
  var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "livesCount");
  var_4 = scripts\mp\utility\teams::_id_6DCA(var_0, "controlUILivesCount");

  if(var_1 < var_4 || var_1 < var_2 + var_3) {
    return;
  }
  if(var_2 + var_3 < var_1) {
    var_5 = var_1 - (var_2 + var_3);
    level._id_EF6A[var_0]["livesCount"] = level._id_EF6A[var_0]["livesCount"] + var_5;
    level._id_EF6A[var_0]["noRespawns"] = 0;
  }

  if(var_4 != var_1) {
    level._id_EF6A[var_0]["controlUILivesCount"] = var_1;
  }
}

control_updatecontrolaliveomnvars() {
  level update_ui_lives_remaining();
}

get_lives(var_0, var_1) {
  var_2 = undefined;

  if(istrue(var_1)) {
    var_2 = level._id_EF6A[var_0]["controlUILivesCount"];
  } else {
    var_3 = scripts\mp\utility\teams::_id_6DCA(var_0, "livesCount");
    var_4 = scripts\mp\utility\teams::_id_6DCA(var_0, "aliveCount");
    var_2 = var_3 + var_4;
  }

  if(!isDefined(var_2) || var_2 < 0) {
    var_2 = 0;
  }

  return var_2;
}

get_string_from_int(var_0) {
  var_1 = [];
  var_1[var_1.size] = &"SKULLS_MODE/0";
  var_1[var_1.size] = &"SKULLS_MODE/1";
  var_1[var_1.size] = &"SKULLS_MODE/2";
  var_1[var_1.size] = &"SKULLS_MODE/3";
  var_1[var_1.size] = &"SKULLS_MODE/4";
  var_1[var_1.size] = &"SKULLS_MODE/5";
  var_1[var_1.size] = &"SKULLS_MODE/6";
  var_1[var_1.size] = &"SKULLS_MODE/7";
  var_1[var_1.size] = &"SKULLS_MODE/8";
  var_1[var_1.size] = &"SKULLS_MODE/9";
  return var_1[var_0];
}

onplayerspawned(var_0) {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    scripts\mp\utility\stats::_id_D550(0);

    if(isDefined(self.pers["objectiveKills"])) {
      scripts\mp\utility\stats::_id_D550(self.pers["objectiveKills"]);
    }

    scripts\mp\utility\stats::_id_D551(0);

    if(isDefined(self.pers["defends"])) {
      scripts\mp\utility\stats::_id_D551(self.pers["defends"]);
    }

    level update_ui_lives_remaining();
  }
}

control_onflagcapture(var_0, var_1, var_2, var_3, var_4, var_5) {
  level._id_FED4 = 0;
  var_6 = undefined;
  var_7 = undefined;
  game["segment_captures"][var_3]++;
  var_8 = scripts\mp\utility\game::_id_6BE2(var_3)[0];

  if(scripts\mp\gametypes\obj_dom::_id_6DCE(var_3) == level._id_A8E8.size) {
    var_6 = "mp_dom_flag_captured_all";
    var_7 = "mp_dom_flag_lost_all";
  } else {
    var_6 = "mp_dom_flag_captured";
    var_7 = "mp_dom_flag_lost";
  }

  thread scripts\mp\utility\print::_id_BD0C(var_3, var_8, undefined, undefined, var_6, var_7, var_2);

  if(scripts\mp\gametypes\obj_dom::_id_6DCE(var_3) < level._id_A8E8.size) {
    _id_0A8D::_id_E775("secured" + self._id_A8E1, var_3);

    if(isDefined(var_4) && var_4 == "neutral") {
      if(isDefined(level._id_A8E8) && level._id_A8E8.size == 5 && (self._id_A8E1 == "_c" || self._id_A8E1 == "_d") || self._id_A8E1 == "_b") {
        _id_0A8D::_id_E775("lost" + self._id_A8E1, var_8);
      }
    } else
      _id_0A8D::_id_E775("lost" + self._id_A8E1, var_8);
  } else {
    _id_0A8D::_id_E775("gamestate_domwinning", var_3);
    _id_0A8D::_id_E775("gamestate_domlosing", var_8);
  }

  if(!isDefined(level.control_capture_count)) {
    level.control_capture_count = 0;
  }

  level.control_capture_count++;

  if(level.control_capture_count == level._id_A8E8.size - 1) {
    _id_0A8D::_id_E775("attack_last_flag", var_3, "finale");
    _id_0A8D::_id_E775("defend_last_flag", var_8, "finale");
  }

  if(level.control_capture_count == level._id_A8E8.size) {
    level thread scripts\mp\gamelogic::_id_52F7(game["attackers"], game["end_reason"]["control_allzones_win"], game["end_reason"]["control_allzones_loss"]);
    _id_07BF::_id_FC32();
  } else {
    var_5._id_5C3E = 0;
    var_9 = scripts\engine\utility::array_remove(level._id_A8E8, var_5)[0];

    if(!istrue(var_9._id_5C3E)) {
      scripts\mp\gamelogic::resumetimer();
    }

    if(!level.extratimeonsegementcapture) {
      thread add_extra_game_time(level.captureextratime, istrue(var_9._id_5C3E));
    } else {
      thread add_extra_game_time(level.segmentcaptureextratime, istrue(var_9._id_5C3E));
    }
  }

  var_2 thread _id_07BC::creategametypechallenegeevent("control_capture");
  scripts\mp\gametypes\obj_dom::_id_C4F2(var_5);
}

control_onsegmentcapture(var_0, var_1, var_2) {
  var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(self._id_D030 != level._id_3230) {
    game["segment_captures"][var_0]++;
  }

  if(scripts\mp\gametypes\obj_dom::_id_6DCE(var_0) == level._id_A8E8.size) {
    var_4 = "mp_dom_flag_captured_all";
    var_5 = "mp_dom_flag_lost_all";
  } else {
    var_4 = "mp_dom_flag_captured";
    var_5 = "mp_dom_flag_lost";
  }

  thread scripts\mp\utility\print::_id_BD0C(var_0, var_3, undefined, undefined, var_4, var_5, var_1);
  var_1 _id_07BF::_id_7D94(10, 1);
  var_6 = var_2 != level._id_3230;

  if(level.extratimeonsegementcapture) {
    thread add_extra_game_time(level.segmentcaptureextratime, var_6);
  }
}

add_extra_game_time(var_0, var_1) {
  if(scripts\mp\utility\dvars::getwatcheddvar("timelimit") == 0) {
    return;
  }
  if(!isDefined(level._id_5856)) {
    level._id_5856 = 0;
  }

  level._id_5856 = level._id_5856 + var_0;
  scripts\mp\gamelogic::resumetimer();
  waitframe();

  if(level.pausetimer && istrue(var_1)) {
    waitframe();
    scripts\mp\gamelogic::pausetimer();
  }
}

_id_FD1B() {
  wait 1;
  level._id_AB3F = ::_id_AB3F;
  level._id_EFA5 = [];

  foreach(var_1 in level._id_EF89) {
    level._id_EFA5[var_1] = 0;
  }

  level._id_CC0E["kill"] = 1;
}

_id_C492() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3806a10bc0145262", "") != "") {
      var_0 = getDvar("#x3806a10bc0145262", "");

      foreach(var_2 in level._id_A8E8) {
        if(isDefined(var_2._id_A8E1) && var_2._id_A8E1 == var_0) {
          var_2 _id_07D6::_id_15DF("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2._id_1041A = "none";
          var_2 _id_07D6::_id_D61B(undefined);
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

_id_B160() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3dfcdef2d7e684127", "") != "") {
      var_0 = getDvar("#x3dfcdef2d7e684127", "");
      var_1 = spawnStruct();
      var_1.origin = level.players[0].origin;
      var_1.angles = level.players[0].angles;
      var_2 = spawn("trigger_radius", var_1.origin, 0, 120, 128);
      var_1.trigger = var_2;
      var_1.trigger._id_CD99 = var_0;
      var_1._id_ADAE = "neutral";
      var_3 = var_1.origin + (0, 0, 32);
      var_4 = var_1.origin + (0, 0, -32);
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, undefined, scripts\engine\trace::_id_3EF6(1));
      var_1.origin = var_5["position"];
      var_1._id_FB2F = vectortoangles(var_5["normal"]);
      var_1._id_01D7 = anglesToForward(var_1._id_FB2F);
      var_1._id_0376 = anglestoright(var_1._id_FB2F);
      var_1._id_10430[0] = spawn("script_model", var_1.origin);
      var_1._id_10430[0].angles = var_1.angles;
      var_6 = _id_07D6::_id_406E("neutral", var_1.trigger, var_1._id_10430, (0, 0, 100));
      var_6 _id_07D6::_id_15DF("enemy");
      var_6 _id_07D6::_id_D8D2(60);

      if(isDefined(var_2._id_A8E1)) {
        var_6._id_A8E1 = var_2._id_A8E1;
      } else {
        var_6._id_A8E1 = var_6 _id_07D6::_id_6AF1();
      }

      if(isDefined(var_2._id_7C73)) {
        var_6._id_7C73 = var_2._id_7C73;
      } else {
        var_6._id_7C73 = var_6 _id_07D6::_id_6AF1();
      }

      var_6 _id_07D6::_id_D61B(level._id_7C4B, level._id_7C74);
      var_6 _id_07D6::_id_D8E0("any");
      var_6._id_ABCB = scripts\mp\gametypes\obj_dom::_id_4D4F;
      var_6._id_AA79 = scripts\mp\gametypes\obj_dom::_id_4D50;
      var_6._id_ABD4 = scripts\mp\gametypes\obj_dom::_id_4D52;
      var_6._id_AAC2 = scripts\mp\gametypes\obj_dom::_id_4D51;
      var_6._id_A6C4 = 1;
      var_6._id_7C8C = "domFlag";
      var_6._id_5BC6 = 0;
      var_6._id_37F3 = 10000;
      var_6._id_450E = 50;
      var_3 = var_1._id_10430[0].origin + (0, 0, 32);
      var_4 = var_1._id_10430[0].origin + (0, 0, -32);
      var_7 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
      var_8 = [];
      var_5 = scripts\engine\trace::ray_trace(var_3, var_4, var_8, var_7);
      var_6._id_22B7 = var_5["position"];
      var_9 = vectortoangles(var_5["normal"]);
      var_6._id_22B6 = anglesToForward(var_9);
      var_6 scripts\mp\gametypes\obj_dom::_id_81E4();
      var_6 thread scripts\mp\gametypes\obj_dom::_id_4D27();
      level._id_A8E8[var_6._id_A8E1] = var_6;
      setdynamicdvar("#x3dfcdef2d7e684127", "");
    }

    wait 1;
  }
}

control_assigngamemodecallout() {
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

control_verifygamemodecallout(var_0, var_1) {
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

istimerpausedbyflags(var_0) {
  var_1 = level._id_A8E8;

  if(isDefined(var_0)) {
    var_1 = scripts\engine\utility::array_remove(var_1, var_0);
  }

  foreach(var_3 in var_1) {
    if(istrue(var_3._id_5C3E)) {
      return 1;
    }
  }

  return 0;
}

_id_FCC2() {
  level endon("game_ended");

  if(self.team == game["attackers"]) {
    self setclientomnvar("ui_match_status_hint_text", 45);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 46);
  }

  level update_ui_lives_remaining();
}

_id_FD6E() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      foreach(var_4 in level._id_A8E8) {
        if(!isDefined(var_4.trigger)) {
          continue;
        }
        if(var_1 istouching(var_4.trigger) && isalive(var_1)) {
          var_2 = scripts\mp\gametypes\obj_dom::_id_6CED(var_4._id_A8E1) + 1;
          break;
        }
      }

      if(!isDefined(var_1._id_9FB1) || var_1._id_9FB1 != var_2) {
        var_1 _meth_8779(var_2);
        var_1._id_9FB1 = var_2;
        var_1 _meth_80CB(1);
      }

      if(var_2 == 0) {
        var_1 _meth_80CB(0);
      }
    }

    waitframe();
  }
}

control_ontimelimit() {
  if(!isDefined(level.alreadyhittimelimit)) {
    level thread scripts\mp\gamelogic::_id_52F7(game["defenders"], game["end_reason"]["time_limit_reached"]);
    _id_07BF::_id_FC32();
    level.alreadyhittimelimit = 1;
  }
}

control_onmaprestart() {
  _id_07BF::_id_CB40();
}

control_setnorespawns(var_0) {
  scripts\mp\utility\teams::_id_D70F(var_0, "noRespawns", 1);

  if(!isDefined(level.timerespawnsdisabled)) {
    level.timerespawnsdisabled = [];
  }

  level.timerespawnsdisabled[var_0] = gettime();

  if(isDefined(level.onnorespawnsevent)) {
    [[level.onnorespawnsevent]](var_0);
  }
}

control_getovertimedefenders() {
  var_0 = game["attackers"];
  var_1 = game["defenders"];

  if(level.overtimedefenders == 2) {
    if(game["segment_captures"][var_0] > game["segment_captures"][var_1]) {
      return var_0;
    } else if(game["segment_captures"][var_1] > game["segment_captures"][var_0]) {
      return var_1;
    }
  }

  var_2[var_0] = game["match_kills"][var_0];
  var_2[var_1] = game["match_kills"][var_1];

  if(var_2[var_0] > var_2[var_1]) {
    return var_0;
  } else if(var_2[var_1] > var_2[var_0]) {
    return var_1;
  } else if(randomint(2) == 0) {
    return var_0;
  } else {
    return var_1;
  }
}