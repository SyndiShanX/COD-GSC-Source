/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\dom.gsc
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
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 200);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2AA("dom", 1, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_9FE8 = ::_id_ABA4;
  level._id_8FA1 = gettime();
  level._id_AB42 = ::_id_AAEF;

  if(level._id_A782) {
    thread _id_FD1B();
  }

  level._id_60CD = ::_id_1D1A;
  level._id_60CE = ::_id_103AB;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_B84F = 0;
  game["dialog"]["gametype"] = "mp_glob_domi_bchr_z064";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_domi_bchr_z068";
  }

  game["dialog"]["offense_obj"] = "mp_glob_gene_bchr_z251";
  game["dialog"]["defense_obj"] = "mp_glob_gene_bchr_z252";
  game["dialog"]["securing_a"] = "mp_glob_domi_bchr_atka";
  game["dialog"]["securing_b"] = "mp_glob_domi_bchr_atkb";
  game["dialog"]["securing_c"] = "mp_glob_domi_bchr_atkc";
  game["dialog"]["securing_d"] = "mp_glob_domi_bchr_z089";
  game["dialog"]["securing_e"] = "mp_glob_domi_bchr_z090";
  game["dialog"]["securing_f"] = "mp_glob_domi_bchr_z091";
  game["dialog"]["secured_a"] = "mp_glob_domi_bchr_aona";
  game["dialog"]["secured_b"] = "mp_glob_domi_bchr_aonb";
  game["dialog"]["secured_c"] = "mp_glob_domi_bchr_aonc";
  game["dialog"]["secured_d"] = "mp_glob_domi_bchr_z086";
  game["dialog"]["secured_e"] = "mp_glob_domi_bchr_z087";
  game["dialog"]["secured_f"] = "mp_glob_domi_bchr_z088";
  game["dialog"]["losing_a"] = "mp_glob_domi_bchr_etka";
  game["dialog"]["losing_b"] = "mp_glob_domi_bchr_etkb";
  game["dialog"]["losing_c"] = "mp_glob_domi_bchr_etkc";
  game["dialog"]["losing_d"] = "mp_glob_domi_bchr_z075";
  game["dialog"]["losing_e"] = "mp_glob_domi_bchr_z076";
  game["dialog"]["losing_f"] = "mp_glob_domi_bchr_z077";
  game["dialog"]["lost_a"] = "mp_glob_domi_bchr_alsa";
  game["dialog"]["lost_b"] = "mp_glob_domi_bchr_alsb";
  game["dialog"]["lost_c"] = "mp_glob_domi_bchr_alsc";
  game["dialog"]["lost_d"] = "mp_glob_domi_bchr_z078";
  game["dialog"]["lost_e"] = "mp_glob_domi_bchr_z079";
  game["dialog"]["lost_f"] = "mp_glob_domi_bchr_z080";
  game["dialog"]["enemy_captured_2"] = "captured_2_enemy";
  game["dialog"]["friendly_captured_2"] = "captured_2_friendly";
  game["dialog"]["gamestate_domlosing"] = "mp_glob_domi_bchr_z073";
  game["dialog"]["gamestate_domwinning"] = "mp_glob_domi_bchr_z074";
  game["dialog"]["halfway_enemy_score"] = "mp_glob_arms_bchr_z207";
  game["dialog"]["halfway_friendly_score"] = "mp_glob_domi_bchr_z084";
  game["dialog"]["winning"] = "mp_glob_domi_bchr_z085";
  game["dialog"]["winning_time"] = "mp_glob_domi_bchr_z085";
  game["dialog"]["winning_score"] = "mp_glob_domi_bchr_z085";
  game["dialog"]["losing"] = "mp_glob_domi_bchr_z083";
  game["dialog"]["losing_time"] = "mp_glob_domi_bchr_z083";
  game["dialog"]["losing_score"] = "mp_glob_domi_bchr_z083";
  game["dialog"]["mission_success"] = "mp_glob_gmst_bchr_dwin";
  game["dialog"]["mission_failure"] = "mp_glob_domi_bchr_dlos";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3db66ce407376113d", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("#x3b50461c98722083b", getmatchrulesdata("domData", "flagsRequiredToScore"));
  setdynamicdvar("#x3c856676fc86cdac4", getmatchrulesdata("domData", "pointsPerFlag"));
  setdynamicdvar("#x31c18409807b36a6f", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("#x39453362e2cc7b39a", getmatchrulesdata("domData", "numFlagsScoreOnKill"));
  setdynamicdvar("#x366a2d0af33418b89", getmatchrulesdata("domData", "objScalar"));
  setdynamicdvar("#x3e004e9d136a32508", getmatchrulesdata("siegeData", "preCapPoints"));
  setdynamicdvar("#x3d5c4c22a5e012f6", getmatchrulesdata("captureData", "captureType"));
  setdynamicdvar("#x335d62b4bf44482cc", getmatchrulesdata("captureData", "captureDecay"));
  setdynamicdvar("#x3aacb3551a99056dc", 0);
  scripts\mp\utility\game::_id_C25D("dom", 0);
}

_id_D5AD() {
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C50 = "waypoint_defending";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
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

  if(level._id_CC0E["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_3 = game["attackers"];
    var_4 = game["defenders"];
    game["attackers"] = var_4;
    game["defenders"] = var_3;
  }

  if(scripts\cp_mp\utility\game_utility::shouldadjustspawnsforsmallmap()) {
    level.adjustsmallmapspawns = 1;
  }

  _id_8294();
  thread _id_4D2B();
  thread _id_FC52();
  thread _id_C492();
  thread _id_B160();
  scripts\mp\gametypes\bradley_spawner::_id_82A8();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  setdvarifuninitialized("#x386b12880a7d57d13", 0);
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("flagCaptureTime", 10, 0, 30);
  level._id_5C47 = scripts\mp\utility\dvars::_id_509C("flagsRequiredToScore", 1, 1, 3);
  level._id_B9C1 = scripts\mp\utility\dvars::_id_509C("pointsPerFlag", 1, 1, 300);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_322C = scripts\mp\utility\dvars::_id_509C("captureDecay", 1, 0, 1);
  level._id_3236 = scripts\mp\utility\dvars::_id_509C("captureType", 1, 0, 3);
  level._id_A782 = scripts\mp\utility\dvars::_id_509C("numFlagsScoreOnKill", 0, 0, 3);
  level._id_A8EC = scripts\mp\utility\dvars::_id_509A("objScalar", 4, 1, 10);
}

_id_8294() {
  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    _id_0817::_id_D461("BigTDM", "Crit_Default");
  } else if(istrue(level.adjustsmallmapspawns)) {
    var_0 = getsmallmapdomtype();

    switch (var_0) {
      case 1:
        _id_0817::_id_D461("Default", "Crit_Default");
        break;
      case 2:
        _id_0817::_id_D461("SmallMap", "Crit_Default");
        break;
      case 3:
        _id_0817::_id_D461("SmallMap2", "Crit_Default");
        break;
      default:
        _id_0817::_id_D461("Domination", "Crit_Default");
        level.adjustsmallmapspawns = 0;
        break;
    }
  } else if(getdvarint("#x3cc16764af8ec5f29", 0) == 1)
    _id_0817::_id_D461("Domination", "Crit_Frontline");
  else {
    _id_0817::_id_D461("Domination", "Crit_Default");
  }

  if(getdvarint("#x3a6e1a518ba5d320", 0) == 1) {
    level._id_60D6 = [];
    level._id_60D6["allies"] = "mp_dom_spawn_allies_start";
    level._id_60D6["axis"] = "mp_dom_spawn_axis_start";
    level._id_60D5 = [];
    level._id_60D5["allies"] = "mp_dom_spawn";
    level._id_60D5["axis"] = "mp_dom_spawn";
  }

  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_dom_spawn_allies_start");
  _id_0817::_id_113A("mp_dom_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_dom_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_dom_spawn_axis_start");
  var_1 = _id_0817::_id_6D4E("mp_dom_spawn_allies_start");
  var_2 = _id_0817::_id_6D4E("mp_dom_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_1);
  _id_0817::_id_C2B9("start_defenders", var_2);
  _id_0817::_id_1136("allies", "mp_dom_spawn");
  _id_0817::_id_1136("axis", "mp_dom_spawn");
  _id_0817::_id_1136("allies", "mp_dom_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_dom_spawn_secondary", 1, 1);
  var_3 = _id_0817::_id_6D4E("mp_dom_spawn");
  var_4 = _id_0817::_id_6D4E("mp_dom_spawn_secondary");
  _id_0817::_id_C2B9("dom", var_3);
  _id_0817::_id_C2B9("dom_fallback", var_4);

  if(istrue(level.adjustsmallmapspawns)) {
    _id_0817::_id_C2B9("normal", var_3);
    _id_0817::_id_C2B9("fallback", var_4);
  }

  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = _id_6DCB(var_0);
  var_2 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  var_3 = _id_6DCB(var_2);
  var_4 = _id_6C84(var_1, var_3, var_0, var_2);
  var_5 = [];
  var_5["preferredDomPoints"] = var_4["preferred"];
  var_5["secondaryDomPoints"] = var_4["secondary"];

  if(istrue(level.adjustsmallmapspawns)) {
    if(_id_0817::_id_DC06()) {
      if(var_0 == game["attackers"]) {
        var_6 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
      } else {
        var_6 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
      }
    } else
      var_6 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");
  } else if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_6 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined, undefined, var_5);
    } else {
      var_6 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined, undefined, var_5);
    }
  } else
    var_6 = _id_0817::_id_6D4A(self, var_0, "dom", "dom_fallback", undefined, var_5);

  return var_6;
}

_id_6DCB(var_0) {
  var_1 = [];

  foreach(var_3 in level._id_A8E8) {
    if(var_3._id_ADAE == var_0) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_6C84(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(var_0.size == level._id_A8E8.size) {
    var_5 = level._id_24D4[var_3];

    foreach(var_7 in var_0) {
      if(var_7 != var_5) {
        var_4[var_4.size] = var_7;
      }
    }
  } else if(var_0.size > 0) {
    foreach(var_7 in var_0) {
      var_4[var_4.size] = var_7;
    }
  } else if(var_0.size == 0) {
    var_11 = level._id_24D4[var_2];

    if(var_1.size > 0 && var_1.size < level._id_A8E8.size) {
      var_11 = scripts\mp\gametypes\obj_dom::_id_6E25(var_2);
    }

    var_4[var_4.size] = var_11;
  }

  var_12 = 0;
  var_13 = 0;

  foreach(var_7 in var_4) {
    if(var_7 _id_07D6::_id_695F() == "none") {
      var_12 = var_12 | var_7._id_E2EB;
      continue;
    }

    var_13 = var_13 | var_7._id_E2EB;
  }

  if(var_12 & 1 && var_12 & 2) {
    var_12 = var_12 | 32;
  }

  if(var_12 & 4 && var_12 & 2) {
    var_12 = var_12 | 64;
  }

  if(var_12 & 1 && var_12 & 4) {
    var_12 = var_12 | 128;
  }

  var_16 = [];
  var_16["preferred"] = var_12;
  var_16["secondary"] = var_13;
  return var_16;
}

getsmallmapdomtype() {
  var_0 = scripts\cp_mp\utility\game_utility::_id_6B2D();
  var_1 = 0;

  if(!isDefined(var_0)) {
    return var_1;
  }

  if(issubstr(var_0, "shipment") || var_0 == "mp_shipmas_s4") {
    var_1 = getdvarint("#x3fae2f895404566b9", 0);
  } else if(var_0 == "mp_dome2") {
    var_1 = getdvarint("#x3294a265c9322edbc", 0);
  } else if(var_0 == "mp_whitehouse_2") {
    var_1 = getdvarint("#x331f1740a4ba36688", 0);
  }

  if(var_1 < 0 || var_1 > 3) {
    var_1 = 0;
  }

  return var_1;
}

_id_4D2B() {
  var_0 = [];
  level._id_33E1 = 0;

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    var_1 = getEntArray("flag_primary", "targetname");

    foreach(var_3 in var_1) {
      if(isDefined(var_3._id_039B) && var_3._id_039B == level._id_96CC) {
        var_0[var_0.size] = var_3;
        continue;
      }

      var_3 delete();
    }
  } else {
    level._id_33E1 = getdvarint("#x3937b70f8373a6a3d", 0);
    var_0 = getEntArray("flag_primary", "targetname");
  }

  var_5 = getEntArray("flag_secondary", "targetname");

  if(var_0.size + var_5.size < 2) {
    return;
  }
  if(level._id_33E1 == 3) {
    setomnvar("ui_num_dom_flags", level._id_33E1);
  } else {
    setomnvar("ui_num_dom_flags", var_0.size);
  }

  var_6 = [];

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    var_6[var_6.size] = var_0[var_7];
  }

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6[var_6.size] = var_5[var_7];
  }

  if(level._id_33E1 == 3 || level.mapname == "mp_rust") {
    foreach(var_9 in var_6) {
      var_9 _id_C324();
    }
  }

  foreach(var_9 in var_6) {
    if(level._id_33E1 == 3) {
      if(var_9._id_CD99 == "_d" || var_9._id_CD99 == "_e" || var_9._id_CD99 == "_f" || var_9._id_CD99 == "_g") {
        continue;
      }
    }

    _id_A011(var_9);
    var_12 = scripts\mp\gametypes\obj_dom::_id_D896(var_9, undefined, 1, 1);
    level._id_A8E8[var_12._id_A8E1] = var_12;
  }

  var_14 = _id_0817::_id_6D4E("mp_dom_spawn_axis_start");
  var_15 = _id_0817::_id_6D4E("mp_dom_spawn_allies_start");
  level._id_0405["allies"] = var_15[0].origin;
  level._id_0405["axis"] = var_14[0].origin;
  level._id_24D4 = [];
  level._id_24D4["allies"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("allies", undefined);
  level._id_24D4["axis"] = ::scripts\mp\gametypes\obj_dom::_id_6E25("axis", level._id_24D4["allies"]);
  _id_5C46();
  thread _id_9FF9();

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  foreach(var_3 in level._id_A8E8) {
    var_17 = scripts\mp\gametypes\obj_dom::_id_6CED(var_3._id_A8E1);
    var_3 _id_07D6::_id_C579(1, 1, var_17);

    if(isDefined(var_3._id_A908)) {
      _func_0179(var_3._id_A908, "icon_medium");
    }

    var_3._id_ABCB = scripts\mp\gametypes\obj_dom::_id_4D4F;
    var_3._id_AA79 = scripts\mp\gametypes\obj_dom::_id_4D50;
    var_3._id_ABD4 = scripts\mp\gametypes\obj_dom::_id_4D52;
    var_3._id_AAC2 = scripts\mp\gametypes\obj_dom::_id_4D51;
    var_3._id_AA8D = scripts\mp\gametypes\obj_dom::_id_4D47;
    var_3._id_ABC7 = scripts\mp\gametypes\obj_dom::_id_4D4C;
    var_3._id_ABC8 = scripts\mp\gametypes\obj_dom::_id_4D4D;
    var_3._id_AB54 = scripts\mp\gametypes\obj_dom::_id_4D4B;
    var_3._id_ABC9 = scripts\mp\gametypes\obj_dom::_id_4D4E;
    var_3._id_E86E = scripts\mp\gametypes\obj_dom::_id_4D55;
    var_3 _id_07D6::_id_D61B("waypoint_defend", "waypoint_target");
    var_3 _id_07D6::_id_D8E0("any");
    var_3 scripts\mp\gametypes\obj_dom::_id_4D27();
  }

  if(level._id_BB6F) {
    thread scripts\mp\gametypes\obj_dom::_id_BB6E();
  }

  if(level.codcasterenabled) {
    thread _id_FD6E();
  }
}

_id_A011(var_0) {
  switch (level.mapname) {
    case "mp_piccadilly":
      switch (var_0._id_CD99) {
        case "_a":
          var_0.origin = (983, 303, 110);
          break;
        case "_b":
          var_0.origin = (-1064, -525, 110);
          break;
        case "_c":
          var_0.origin = (-1605, -2298, 60);
          break;
      }

      break;
  }
}

_id_C324() {
  if(level.mapname == "mp_aniyah" || level.mapname == "mp_aniyah_pm") {
    if(self._id_CD99 == "_e" && !isDefined(self._id_C327)) {
      self._id_CD99 = "_c";
      self._id_C327 = 1;
    } else if(self._id_CD99 == "_c" && !isDefined(self._id_C327)) {
      self._id_CD99 = "_e";
      self._id_C327 = 1;
    }
  } else if(level.mapname == "mp_rust") {
    if(self._id_CD99 == "_a") {
      self._id_CD99 = "_b";
    } else if(self._id_CD99 == "_b") {
      self._id_CD99 = "_a";
    }
  }
}

_id_FC52() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("prematch_done");

  while(!level.gameended) {
    var_2 = 5.0;
    var_3 = scripts\mp\gamelogic::_id_6DE8();

    if(var_3 < 5000 && var_3 > 0) {
      var_2 = var_3 / 1000;
    }

    wait(var_2);
    scripts\mp\hostmigration::waittillhostmigrationdone();
    var_4 = _id_6C00();

    if(!isDefined(level._id_CC24)) {
      level._id_CC24 = [];
    }

    foreach(var_6 in level._id_EF89) {
      level._id_CC24[var_6] = 0;
    }

    if(var_4.size) {
      for(var_8 = 1; var_8 < var_4.size; var_8++) {
        var_9 = var_4[var_8];
        var_10 = gettime() - var_9._id_3235;

        for(var_11 = var_8 - 1; var_11 >= 0 && var_10 > gettime() - var_4[var_11]._id_3235; var_11--) {
          var_4[var_11 + 1] = var_4[var_11];
        }

        var_4[var_11 + 1] = var_9;
      }

      foreach(var_9 in var_4) {
        var_13 = var_9 _id_07D6::_id_6C02();
        var_0 = _func_00DB(var_13);
        var_14 = scripts\mp\gametypes\obj_dom::_id_6DCE(var_13);

        if(var_14 >= level._id_5C47) {
          level._id_CC24[var_13] = level._id_CC24[var_13] + level._id_B9C1;
        }
      }
    }

    _id_FD1C();
    _id_34F9(var_4.size);
  }
}

_id_FD1C() {
  var_0 = [];

  foreach(var_2 in level._id_EF89) {
    var_3 = game["teamScores"][var_2] + level._id_CC24[var_2];

    if(var_3 >= level._id_C948) {
      var_0[var_0.size] = var_2;
    }
  }

  if(var_0.size == 1) {
    level._id_CC24[var_0[0]] = level._id_C948 - game["teamScores"][var_0[0]];
  }

  var_5 = scripts\mp\gamescore::_id_2F03();

  foreach(var_2 in level._id_EF89) {
    if(level._id_CC24[var_2] > 0) {
      scripts\mp\gamescore::_id_7001(var_2, level._id_CC24[var_2], 1, undefined, 1);
    }
  }

  var_8 = scripts\mp\gamescore::_id_2F03();

  if(var_5 != var_8) {
    scripts\mp\gamescore::_id_B8D0(var_8, 1, var_5);
  }
}

_id_34F9(var_0) {
  var_1 = gettime() - level._id_8FA1;

  if(scripts\mp\utility\game::matchmakinggame() && var_0 < 2 && var_1 > 120000) {
    level._id_5E90 = 1;
    thread scripts\mp\gamelogic::_id_52F7("none", game["end_reason"]["time_limit_reached"]);
    return;
  }

  if(level._id_A8E8.size == 3 && level._id_B84F && var_1 > 30000) {
    foreach(var_3 in level._id_EF89) {
      if(scripts\mp\gametypes\obj_dom::_id_6DCE(var_3) == 2) {
        var_4 = scripts\mp\utility\game::_id_6BE2(var_3)[0];
        _id_0A8D::_id_E775("enemy_captured_2", var_4);
        _id_0A8D::_id_E775("friendly_captured_2", var_3);
        level._id_B84F = 0;
        break;
      }
    }
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

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(level._id_EFA5[var_1.team]) {
    scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  }
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

_id_9FF9() {
  if(level.mapname == "mp_frontier") {
    foreach(var_1 in level._id_A8E8) {
      if(var_1._id_A8E1 == "_b") {
        var_1.trigger._id_9FF8 = 1;
      }
    }
  }
}

_id_ABA4() {
  thread _id_FCC2();
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
  level._id_FED4 = 0;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = scripts\mp\utility\game::_id_6BE2(var_3)[0];

  if(scripts\mp\utility\game::_id_8701() && scripts\mp\gametypes\obj_dom::_id_6DCE(var_3) == level._id_A8E8.size) {
    _id_0A8D::_id_9136("captured_all_friendly", var_3);
    _id_0A8D::_id_9136("captured_all_enemy", var_8);
  }

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

  if(scripts\mp\utility\game::isbasegametype()) {
    var_9 = "base_cap";
  } else {
    var_9 = "dom_cap";
  }

  var_2 thread _id_07BC::creategametypechallenegeevent(var_9);
}

_id_FD1B() {
  wait 1;
  level._id_AB3F = ::_id_AB3F;
  level._id_EFA5 = [];

  foreach(var_1 in level._id_EF89) {
    level._id_EFA5[var_1] = 0;
  }

  var_3 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_pointsPerKill"));

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  level._id_CC0E["kill"] = var_3;
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
      var_6 _id_07D6::_id_D8D2(10);

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
      var_6._id_5BC6 = 1;
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

_id_FCC2() {
  level endon("game_ended");
  self setclientomnvar("ui_match_status_hint_text", 27);
}

_id_FD6E() {
  level endon("game_ended");
  level waittill("prematch_done");

  while(!level.gameended) {
    foreach(var_1 in level.players) {
      var_2 = 0;

      foreach(var_4 in level._id_A8E8) {
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