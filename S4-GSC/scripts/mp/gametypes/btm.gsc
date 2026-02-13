/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\btm.gsc
*************************************************/

main() {
  var_0 = spawnStruct();
  level._id_2C6A = var_0;

  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_1[0] = ::scripts\mp\utility\game::getgametype();
  var_1[1] = "hardpoint";
  var_1[2] = "tdm";
  var_1[3] = "hq";
  var_1[4] = "dom";
  var_1[5] = "sd";
  var_1[6] = "bombzone";
  var_1[7] = "blocker";
  _id_07D6::main(var_1);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level._id_CC11 = undefined;
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_ABBE = ::_id_ABBE;
  level._id_AB3F = ::_id_AB3F;
  level._id_8FA1 = gettime();
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  level._id_8E3E = 0;
  level._id_7B1B = 60;
  level._id_BDA4 = 1;
  level._id_5851 = 1;
  game["dialog"]["gametype"] = "gametype_hardpoint";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
  game["dialog"]["offense_obj"] = "hint_killall";
  game["dialog"]["defense_obj"] = "hint_killall";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3c744d2679bb7b23e", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("#x358fd022a3e2a05a8", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("#x3a98393f65af0da90", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("#x32c19aa7f9d6f4781", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("#x327f89bda93b12ee0", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("#x349a29b4cdc046df6", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("#x3fa26e168be99222f", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("#x3dee07d0e9553df14", getmatchrulesdata("kothData", "useHQRules"));
  setdynamicdvar("#x3f8d056b65fee1f85", getmatchrulesdata("tdefData", "spawnDelay"));
  setdynamicdvar("#x368ebcafc6dc03c6a", getmatchrulesdata("btmData", "juggHealth"));
  setdynamicdvar("#x3bdf7e77567979b91", getmatchrulesdata("btmData", "juggSwitchTime"));
  setdynamicdvar("#x395c14158e602c4f3", getmatchrulesdata("btmData", "ppkAsJugg"));
  setdynamicdvar("#x35a8a57624d63e28e", getmatchrulesdata("btmData", "ppkOnJugg"));
  setdynamicdvar("#x3aea0f9e745aeeea9", getmatchrulesdata("btmData", "ppkJuggOnJugg"));
  setdynamicdvar("#x38e11187f46ccd19c", 0);
  scripts\mp\utility\game::_id_C25D("koth", 0);
}

_id_ABAD() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/KOTH_HINT");
  }

  setclientnamemode("auto_change");
  level._id_A8E8 = [];
  thread _id_A8EF();
  _id_D8A7();
  _id_D853();
  thread _id_4D40();
  thread _id_7B1F();
  level thread _id_1097C();
  level thread _id_1097B();
  level thread _id_1097A();
  _id_D5F0();
  _id_8294();
  _id_D5AD();
  _id_D8C5();
  level._id_FE52 = 0;
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_110E3 = scripts\mp\utility\dvars::_id_509A("zoneLifetime", 60, 0, 300);
  level._id_110E0 = scripts\mp\utility\dvars::_id_509A("zoneCaptureTime", 0, 0, 30);
  level._id_110DE = 30;
  level._id_110E8 = scripts\mp\utility\dvars::_id_509C("randomLocationOrder", 0, 0, 1);
  level._id_110DF = scripts\mp\utility\dvars::_id_509C("additiveScoring", 0, 0, 1);
  level._id_AF70 = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 1, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 5, 0, 30);
  level._id_FE83 = 1;
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 10, 0, 30);
  level._id_5C47 = scripts\mp\utility\dvars::_id_509C("flagsRequiredToScore", 1, 1, 3);
  level._id_B9C1 = scripts\mp\utility\dvars::_id_509C("pointsPerFlag", 10, 1, 300);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_BB6F = scripts\mp\utility\dvars::_id_509C("preCapPoints", 0, 0, 1);
  level._id_322C = scripts\mp\utility\dvars::_id_509C("captureDecay", 1, 0, 1);
  level._id_3236 = scripts\mp\utility\dvars::_id_509C("captureType", 1, 0, 3);
  level._id_A782 = scripts\mp\utility\dvars::_id_509C("numFlagsScoreOnKill", 0, 0, 3);
  level._id_A8EC = scripts\mp\utility\dvars::_id_509A("objScalar", 4, 1, 10);
  level._id_8C86 = scripts\mp\utility\dvars::_id_509C("juggHealth", 1000, 1000, 10000);
  level._id_8C8E = scripts\mp\utility\dvars::_id_509A("juggSwitchTime", 60, 10, 180);
  level._id_BB29 = scripts\mp\utility\dvars::_id_509C("ppkAsJugg", 20, 1, 100);
  level._id_BB2B = scripts\mp\utility\dvars::_id_509C("ppkOnJugg", 50, 1, 100);
  level._id_BB2A = scripts\mp\utility\dvars::_id_509C("ppkJuggOnJugg", 50, 1, 100);
}

_id_D5F0() {
  var_0 = _func_00D6(level.mapname, 0, 7);

  switch (var_0) {
    case "mp_vill":
    case "mp_offs":
    case "mp_dome":
    case "mp_cras":
    case "mp_hack":
    case "mp_cave":
      level._id_E10F = 1000;
      level._id_39CF = 10000;
      level._id_9C35 = 25000000;
      level._id_9C30 = 6000;
      level._id_53E3 = 12250000;
      break;
    default:
      level._id_E10F = 1000;
      level._id_39CF = 10000;
      level._id_9C35 = 225000000;
      level._id_9C30 = 5000;
      level._id_53E3 = 12250000;
      break;
  }
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B9("normal", "mp_tdm_spawn");
  _id_0817::_id_C2B9("fallback", "mp_tdm_spawn_secondary");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _func_0384("mp_tdm_spawn");
  level._id_E34D = _id_0817::_id_6D4E("mp_tdm_spawn");

  if(!level._id_E34D.size) {
    return;
  }
  foreach(var_1 in level._id_A8E8) {
    var_1._id_6041 = 0;
    var_1._id_E34D = [];
    var_1._id_5965 = [];
  }

  foreach(var_4 in level._id_E34D) {
    _id_2EFC(var_4);
    var_5 = _id_0817::_id_6BDE(var_4);

    if(isDefined(level._id_2C6B) && isDefined(level._id_2C6B[var_5])) {
      foreach(var_7 in level._id_2C6B[var_5]) {
        var_1 = level._id_A8E8[var_7];
        var_1._id_E34D[var_1._id_E34D.size] = var_4;
      }
    }

    var_9 = 0;
    var_10 = var_4.classname == "mp_tdm_spawn";
    var_11 = var_4.classname == "mp_tdm_spawn_secondary";

    if(var_10 || var_11) {
      if(isDefined(var_4._id_039B) && var_4._id_039B != "") {
        var_9 = 1;
        var_12 = strtok(var_4._id_039B, " ");

        foreach(var_7 in var_12) {
          var_1 = level._id_A8E8[var_7];

          if(var_10) {
            var_1._id_E34D[var_1._id_E34D.size] = var_4;
            continue;
          }

          var_1._id_5965[var_1._id_5965.size] = var_4;
        }
      }
    }

    if(!var_9) {
      foreach(var_1 in level._id_A8E8) {
        if(var_4._id_CF35._id_4BB9[var_1 getentitynumber()] < level._id_39CF || var_4._id_CF35._id_4BB9[var_1 getentitynumber()] > level._id_9C35) {
          var_1._id_C51C = 1;
        }

        if(var_10) {
          if(!isDefined(var_1._id_C51C)) {
            var_1._id_E34D[var_1._id_E34D.size] = var_4;
          }

          continue;
        }

        var_1._id_5965[var_1._id_5965.size] = var_4;
      }
    }
  }

  foreach(var_19, var_1 in level._id_A8E8) {
    var_1._id_E37A = "btm_" + var_19;
    _id_0817::_id_C2B9(var_1._id_E37A, var_1._id_E34D);
    var_1._id_5966 = "btm_fallback_" + var_19;
    _id_0817::_id_C2B9(var_1._id_5966, var_1._id_5965);
  }

  _id_0817::_id_0EE5();
}

_id_2EFC(var_0) {
  var_0._id_CF35._id_4BB9 = [];

  foreach(var_2 in level._id_A8E8) {
    var_3 = _func_00C4(var_0.origin, var_2.origin, level._id_9C30);

    if(var_3 < 0) {
      var_3 = scripts\engine\utility::_id_4B8C(var_0.origin, var_2.origin);
    } else {
      var_3 = var_3 * var_3;
    }

    var_0._id_CF35._id_4BB9[var_2 getentitynumber()] = var_3;

    if(var_3 > var_2._id_6041) {
      var_2._id_6041 = var_3;
    }
  }
}

_id_D8A7() {
  var_0 = [];
  var_1 = getEntArray("hq_hardpoint", "targetname");

  if(var_1.size < 2) {
    var_0[var_0.size] = "There are not at least 2 entities with targetname \"radio\"";
  }

  var_2 = getEntArray("radiotrigger", "targetname");

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = 0;
    var_5 = var_1[var_3];
    var_5._id_F587 = undefined;

    for(var_6 = 0; var_6 < var_2.size; var_6++) {
      if(var_5 istouching(var_2[var_6])) {
        if(isDefined(var_5._id_F587)) {
          var_0[var_0.size] = "Radio at " + var_5.origin + " is touching more than one \"radiotrigger\" trigger";
          var_4 = 1;
          break;
        }

        var_5._id_F587 = var_2[var_6];
        break;
      }
    }

    if(!isDefined(var_5._id_F587)) {
      if(!var_4) {
        var_0[var_0.size] = "Radio at " + var_5.origin + " is not inside any \"radiotrigger\" trigger";
      }

      var_5._id_F587 = spawn("trigger_radius", var_5.origin, 0, 128, 128);
      var_4 = 0;
    }

    var_5._id_F63C = var_5._id_F587.origin;
    var_7 = [];
    var_7[0] = var_5;
    var_8 = getEntArray(var_5.target, "targetname");

    for(var_6 = 0; var_6 < var_8.size; var_6++) {
      var_7[var_7.size] = var_8[var_6];
    }

    var_5._id_10430 = var_7;
    var_5 _id_07D6::_id_D5FD(0);
    var_5._id_60D8 = _id_07D6::_id_406E("neutral", var_5._id_F587, var_5._id_10430, var_5.origin - var_5._id_F63C + (0, 0, 60));
    var_5._id_60D8 _id_07D6::_id_4AD1();
    var_5._id_60D8 _id_07D6::_id_D5FD(0);
    var_5._id_F587._id_FE90 = var_5._id_60D8;
  }

  if(var_0.size > 0) {
    for(var_3 = 0; var_3 < var_0.size; var_3++) {}
  }

  foreach(var_10 in var_1) {
    level._id_A8E8[level._id_A8E8.size] = var_10;
  }

  level._id_BF38 = var_1;
  level._id_BF39 = var_1;
  level._id_BC58 = undefined;
  level._id_BC59 = undefined;
  return 1;
}

_id_D853() {
  var_0 = getEntArray("btm_flag_primary", "targetname");

  if(var_0.size == 0) {
    var_1 = getEntArray("flag_primary", "targetname");
    var_2 = getEntArray("flag_secondary", "targetname");

    for(var_3 = 0; var_3 < var_1.size; var_3++) {
      level._id_BCCF[level._id_BCCF.size] = var_1[var_3];
    }

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      level._id_BCCF[level._id_BCCF.size] = var_2[var_3];
    }

    level thread _id_CA63(var_1, var_2);
  } else {
    level._id_BCCF = var_0;
    level._id_BCD0 = var_0;
    level._id_BC1F = undefined;
    level._id_BC20 = undefined;
    level thread _id_CA25();
  }

  foreach(var_5 in level._id_BCCF) {
    level._id_A8E8[level._id_A8E8.size] = var_5;
  }
}

_id_4D40() {
  level endon("game_ended");
  level thread _id_FC52();
}

_id_CA25() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    level waittill("spawn_btm_dom");
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 0, 0);
    _id_0817::_id_D461("Hardpoint", "Crit_Default");
    var_0 = _id_B06C();
    var_0._id_CD99 = "_a";
    var_1 = "_a";
    var_2 = scripts\mp\gametypes\obj_dom::_id_D896(var_0);
    var_2.origin = var_0.origin;
    var_2 _id_07D6::_id_15DF("none");
    var_2 _id_07D6::_id_D8E0("any");
    var_2 _id_07D6::_id_D61B(level._id_7C6E);
    var_2._id_7D35 = 1;
    level._id_2C6C = var_2;
    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    _id_0AA2::_id_B8F1("ui_aar_sidebar");
    wait 30;
    _id_0AA2::_id_B8F1("iw8_new_objective_sfx");

    foreach(var_4 in level._id_EF89) {
      _id_0A8D::_id_9136("obj_capture", var_4);

      if(scripts\mp\utility\teams::_id_6DCA(var_4, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/CAPTURE_FLAG", var_4, 4);
      }
    }

    level._id_2C6C _id_07D6::_id_15DF("enemy");
    level._id_2C6C scripts\mp\gametypes\obj_dom::_id_4D27();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 14, 14);
    wait 60;
    _id_0AA2::_id_B8F1("mp_sar_enemy_eliminated");

    foreach(var_4 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_4, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/OBJ_OFFLINE", var_4, 4);
      }
    }

    level._id_2C6C scripts\mp\gametypes\obj_dom::_id_4D27();
    level _id_C492(var_1);
    level._id_2C6C = undefined;
    _id_0817::_id_D461("Default", "Crit_Default");
    level _id_6B88("dom");
  }
}

_id_CA63(var_0, var_1) {
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    level waittill("spawn_btm_dom");
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 0, 0);

    switch (level._id_FE52) {
      case 0:
        var_2 = "_b";
        break;
      case 1:
        var_2 = "_a";
        break;
      case 2:
        var_2 = "_c";
        break;
      default:
        var_2 = "_b";
        break;
    }

    _id_0817::_id_D461("Hardpoint", "Crit_Default");
    var_3 = [];

    for(var_4 = 0; var_4 < var_0.size; var_4++) {
      var_3[var_3.size] = var_0[var_4];
    }

    for(var_4 = 0; var_4 < var_1.size; var_4++) {
      var_3[var_3.size] = var_1[var_4];
    }

    foreach(var_6 in var_3) {
      if(var_6._id_CD99 == var_2) {
        var_7 = scripts\mp\gametypes\obj_dom::_id_D896(var_6);
        var_7 _id_07D6::_id_15DF("none");
        var_7 _id_07D6::_id_D8E0("any");
        var_7 _id_07D6::_id_D61B(level._id_7C6E);
        var_7._id_7D35 = 1;
        level._id_2C6C = var_7;
        break;
      }
    }

    setomnvar("ui_btm_timer", int(30000 + gettime()));
    setomnvar("ui_btm_status", 2);
    _id_0AA2::_id_B8F1("ui_aar_sidebar");
    wait 30;
    _id_0AA2::_id_B8F1("iw8_new_objective_sfx");

    foreach(var_10 in level._id_EF89) {
      _id_0A8D::_id_9136("obj_capture", var_10);

      if(scripts\mp\utility\teams::_id_6DCA(var_10, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/CAPTURE_FLAG", var_10, 4);
      }
    }

    level._id_2C6C _id_07D6::_id_15DF("enemy");
    level._id_2C6C scripts\mp\gametypes\obj_dom::_id_4D27();
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 14, 14);
    wait 60;
    _id_0AA2::_id_B8F1("mp_sar_enemy_eliminated");

    foreach(var_10 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_10, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/OBJ_OFFLINE", var_10, 4);
      }
    }

    level._id_2C6C scripts\mp\gametypes\obj_dom::_id_4D27();
    level _id_C492(var_2);
    level._id_2C6C = undefined;
    _id_0817::_id_D461("Default", "Crit_Default");
    level _id_6B88("dom");
  }
}

_id_FC52() {
  level endon("game_ended");
  level waittill("spawn_btm_dom");
  var_0 = undefined;
  var_1 = undefined;

  while(!level.gameended) {
    wait 5.0;
    scripts\mp\hostmigration::waittillhostmigrationdone();

    if(!isDefined(level._id_CC24)) {
      level._id_CC24 = [];
    }

    foreach(var_3 in level._id_EF89) {
      level._id_CC24[var_3] = 0;
    }

    if(isDefined(level._id_2C6C)) {
      var_5 = level._id_2C6C _id_07D6::_id_6C02();

      if(var_5 == "neutral") {
        continue;
      }
      level._id_CC24[var_5] = level._id_CC24[var_5] + level._id_B9C1;
      _id_FD1C();
    }
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

  foreach(var_2 in level._id_EF89) {
    if(level._id_CC24[var_2] > 0) {
      scripts\mp\gamescore::_id_7001(var_2, level._id_CC24[var_2], 1);
    }
  }
}

_id_C492(var_0) {
  self endon("game_ended");
  level._id_2C6C _id_07D6::_id_15DF("none");
  level._id_2C6C _id_07D6::_id_D8E0("none");
  level._id_2C6C _id_07D6::_id_C300();
  level._id_2C6C.trigger = undefined;
  level._id_2C6C notify("deleted");
  level._id_2C6C._id_1041A = "none";
  level._id_2C6C._id_03A9 delete();
  level._id_2C6C._id_5C3F delete();
}

_id_B06C() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3._id_4B85 = 0;

    if(var_3.team == "allies") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level._id_BCCF.size == 0) {
      level._id_BCCF = level._id_BCD0;
    }

    for(var_5 = level._id_BCCF[randomint(level._id_BCCF.size)]; isDefined(level._id_BC1F) && var_5 == level._id_BC1F; var_5 = level._id_BCCF[randomint(level._id_BCCF.size)]) {}

    level._id_BC20 = level._id_BC1F;
    level._id_BC1F = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_0.size; var_7++) {
      var_8 = distancesquared(var_0[var_6].origin, var_0[var_7].origin);
      var_0[var_6]._id_4B85 = var_0[var_6]._id_4B85 + var_8;
      var_0[var_7]._id_4B85 = var_0[var_7]._id_4B85 + var_8;
    }
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6]._id_4B85 = var_1[var_6]._id_4B85 + var_8;
      var_1[var_7]._id_4B85 = var_1[var_7]._id_4B85 + var_8;
    }
  }

  var_9 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3._id_4B85 < var_9._id_4B85) {
      var_9 = var_3;
    }
  }

  var_12["allies"] = var_9.origin;
  var_9 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3._id_4B85 < var_9._id_4B85) {
      var_9 = var_3;
    }
  }

  var_12["axis"] = var_1[0].origin;
  var_15 = undefined;
  var_16 = undefined;

  for(var_6 = 0; var_6 < level._id_BCCF.size; var_6++) {
    var_5 = level._id_BCCF[var_6];
    var_17 = abs(distance(var_5.origin, var_12["allies"]) - distance(var_5.origin, var_12["axis"]));

    if(isDefined(level._id_BC1F) && var_5 == level._id_BC1F) {
      continue;
    }
    if(isDefined(level._id_BC20) && var_5 == level._id_BC20) {
      if(level._id_BCCF.size > 2) {
        continue;
      } else {
        var_17 = var_17 + 512;
      }
    }

    if(!isDefined(var_16) || var_17 < var_16) {
      var_16 = var_17;
      var_15 = var_5;
    }
  }

  level._id_BC20 = level._id_BC1F;
  level._id_BC1F = var_15;
  return var_15;
}

_id_7B1F() {
  level endon("game_ended");
  level._id_7B21 = -100000;
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    level waittill("spawn_btm_hq");
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 0, 0);
    _id_0817::_id_D461("Default", "Crit_Default");
    setomnvar("ui_btm_timer", 0);
    setomnvar("ui_btm_status", -1);
    _id_0817::_id_D461("Hardpoint", "Crit_Default");
    var_0 = _id_B075();
    var_0 _id_9A06();
    _id_0AA2::_id_B8F1("ui_aar_sidebar");
    var_1 = var_0._id_60D8;
    var_1 _id_07D6::_id_B0E7();
    var_1 _id_07D6::_id_D5FD(1);
    var_1 _id_07D6::_id_D8E0("any");
    var_1 _id_07D6::_id_D61B(level._id_7C6E, level._id_7C6E);
    level._id_BF37 = var_1;
    level._id_7B21 = gettime();

    if(level._id_110DE) {
      setomnvar("ui_btm_timer", int(30000 + gettime()));
      setomnvar("ui_btm_status", 2);
      wait(level._id_110DE);
    }

    waittillframeend;
    _id_0AA2::_id_B8F1("iw8_new_objective_sfx");

    foreach(var_3 in level._id_EF89) {
      _id_0A8D::_id_9136("obj_capture", var_3);

      if(scripts\mp\utility\teams::_id_6DCA(var_3, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/CAPTURE_HQ", var_3, 4);
      }
    }

    var_1 _id_07D6::_id_15DF("any");
    var_1 _id_07D6::_id_D8D2(level._id_110E0);
    var_1 _id_07D6::_id_D61B(level._id_7C67, level._id_7C67);
    var_1 _id_07D6::_id_D8E0("any");
    var_1._id_ABCB = ::_id_AB84;
    var_1._id_AA79 = ::_id_AA79;
    var_1._id_AAC2 = ::_id_AAC2;
    var_1._id_ABC7 = ::_id_ABC7;
    var_1._id_AA8D = ::_id_AA8D;
    var_1._id_7C8C = "hardpoint";
    var_1 _id_07D6::_id_B0E7();
    var_1 _id_07D6::_id_D4B2("normal");
    level._id_BF37 = var_1;
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 3);
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 16, 16);
    thread _id_4854(60);
    var_5 = level scripts\engine\utility::_id_10897("hq_captured", "hq_destroyed");

    if(var_5 == "hq_captured") {
      var_6 = var_1 _id_07D6::_id_6C02();
      var_7 = scripts\mp\utility\game::_id_6BE2(var_6);

      if(level._id_7B1B) {
        thread _id_4854(level._id_7B1B, var_6);
      } else {
        level._id_7B1C = 0;
      }

      for(;;) {
        var_6 = var_1 _id_07D6::_id_6C02();
        var_7 = scripts\mp\utility\game::_id_6BE2(var_6);

        if(var_6 == "allies") {} else {}

        var_1 _id_07D6::_id_15DF("enemy");
        var_1 _id_07D6::_id_D61B(level._id_7C65, level._id_7C63);

        if(!level._id_8E3E) {
          var_1 _id_07D6::_id_D8D1(&"MP_DESTROYING_HQ");
        }

        var_1._id_ABCB = ::_id_AB85;
        level waittill("hq_destroyed");

        if(!level._id_8E3E || level._id_7B1C) {
          break;
        }

        thread _id_5ECA(var_6);
        var_1 _id_07D6::_id_D639(scripts\mp\utility\game::_id_6BE2(var_6)[0]);
      }
    }

    _id_0AA2::_id_B8F1("mp_sar_enemy_eliminated");

    foreach(var_3 in level._id_EF89) {
      if(scripts\mp\utility\teams::_id_6DCA(var_3, "teamCount") > 0) {
        scripts\mp\utility\print::_id_EF7B("OBJECTIVES/HQ_OFFLINE", var_3, 4);
      }
    }

    var_6 = var_1 _id_07D6::_id_6C02();
    var_1 _id_07D6::_id_15DF("none");
    var_1 _id_07D6::_id_D61B(level._id_7C67, level._id_7C67);
    var_1 _id_07D6::_id_D639("neutral");
    var_1 _id_07D6::_id_D5FD(0);
    var_0 _id_9A07();
    level._id_BF37 = undefined;

    if(var_6 != "neutral") {
      thread _id_5ECA(var_6, level._id_5851);
    }

    level._id_FE52++;

    if(level._id_FE52 == 3) {
      level._id_FE52 = 0;
    }

    _id_0817::_id_D461("Default", "Crit_Default");
    wait 1;
    level _id_6B88("koth");
  }
}

_id_5ECA(var_0, var_1) {
  if(isDefined(var_1)) {
    foreach(var_3 in level.players) {
      if(isalive(var_3)) {
        continue;
      }
      if(var_3.pers["team"] == var_0) {
        var_3 _id_0A99::_id_D5EA(9, int(gettime() + var_1 * 1000));
      }
    }

    wait(var_1);
  }

  foreach(var_3 in level.players) {
    if(var_3.pers["team"] == var_0) {
      var_3 _id_0A99::_id_D5EA(0);

      if(!isalive(var_3)) {
        var_3._id_5EC6 = 1;
      }

      var_3 notify("force_spawn");
    }
  }
}

_id_AA79(var_0) {
  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C68, level._id_7C66);
  } else {
    _id_07D6::_id_D61B(level._id_7C68, level._id_7C66);
  }
}

_id_AAC2(var_0, var_1, var_2) {
  var_3 = _id_07D6::_id_6C02();

  if(var_2) {
    return;
  }
  if(var_3 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C67, level._id_7C67);
  } else {
    _id_07D6::_id_D61B(level._id_7C65, level._id_7C63);
    return;
  }
}

_id_AA8D() {
  _id_07D6::_id_D61B(level._id_7C64);
}

_id_ABC7(var_0) {
  var_1 = _id_07D6::_id_6C02();

  if(var_0 == "none" || var_1 == "neutral") {
    _id_07D6::_id_D61B(level._id_7C67);
  } else {
    _id_07D6::_id_D61B(level._id_7C63, level._id_7C65);
  }
}

_id_AB84(var_0) {
  var_1 = var_0.pers["team"];
  scripts\mp\gamescore::_id_6FCF("capture", var_0);

  foreach(var_3 in self._id_F396[var_1]) {
    var_4 = var_3.player;
    var_4 scripts\mp\utility\stats::_id_7DAE("captures", 1);
    var_4 scripts\mp\persistence::_id_E770("round", "captures", var_0.pers["captures"]);
  }

  var_6 = spawnStruct();
  var_6.player = var_0;
  var_6._id_56B9 = "capture";
  var_6._id_033E = var_0.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_6);
  var_7 = _id_07D6::_id_6C02();
  _id_07D6::_id_D639(var_1);

  if(!level._id_8E3E) {
    _id_07D6::_id_D8D2(level._id_110E0);
  }

  var_8 = "axis";

  if(var_1 == "axis") {
    var_8 = "allies";
  }

  thread _id_0AA2::_id_B8F1("mp_dom_flag_captured", var_1);
  thread _id_0AA2::_id_B8F1("mp_dom_flag_lost", var_8);
  level thread _id_1FC7(var_1);
  var_0 notify("objective", "captured");
  level notify("hq_captured");
  level thread scripts\mp\hud_message::_id_FCBF(var_1, 17, 16);
}

_id_AB85(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = "axis";

  if(var_1 == "axis") {
    var_2 = "allies";
  }

  scripts\mp\gamescore::_id_6FCF("capture", var_0);

  foreach(var_4 in self._id_F396[var_1]) {
    var_5 = var_4.player;
    var_5 scripts\mp\utility\stats::_id_7DAE("destructions", 1);
    var_5 scripts\mp\persistence::_id_E770("round", "destructions", var_0.pers["destructions"]);
  }

  var_7 = spawnStruct();
  var_7.player = var_0;
  var_7._id_56B9 = "destroy";
  var_7._id_033E = var_0.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_7);

  if(level._id_8E3E) {} else {}

  thread _id_0AA2::_id_B8F1("mp_dom_flag_captured", var_1);
  thread _id_0AA2::_id_B8F1("mp_dom_flag_lost", var_2);
  level notify("hq_destroyed");

  if(level._id_8E3E) {
    level thread _id_1FC7(var_1);
  } else {
    scripts\mp\gamescore::_id_7001(var_1, 20);
  }
}

_id_4854(var_0, var_1) {
  level endon("game_ended");
  level endon("hq_reset");
  level notify("hq_reset_timeout");
  level endon("hq_reset_timeout");
  level._id_7B1D = gettime() + var_0 * 1000;
  level._id_7B1C = 0;
  wait(var_0);
  level._id_7B1C = 1;

  if(isDefined(var_1)) {
    scripts\mp\gamescore::_id_7001(var_1, 5);
  }

  level notify("hq_destroyed");
}

_id_1FC7(var_0) {
  level endon("game_ended");
  level endon("hq_destroyed");
  level notify("awardHQPointsRunning");
  level endon("awardHQPointsRunning");
  var_1 = 12;
  var_2 = 5;
  var_3 = 5;
  var_4 = 5;

  if(level._id_BDA4) {
    var_5 = int(level._id_7B1B / var_1);
  } else {
    var_5 = 5;
  }

  var_6 = 0;

  while(!level.gameended) {
    scripts\mp\gamescore::_id_7001(var_0, 15);
    var_6++;
    wait(var_5);
    scripts\mp\hostmigration::waittillhostmigrationdone();
  }
}

_id_9A06() {
  self._id_60D8 _id_07D6::_id_D5FD(0);
  self._id_60D8 _id_07D6::_id_316A(1);
  self._id_60D8 _id_07D6::_id_5260();
  self._id_60D8._id_7D35 = 1;
  self._id_F587._id_FE90 = self._id_60D8;
}

_id_9A07() {
  self._id_60D8 _id_07D6::_id_C300();
  self._id_60D8 _id_07D6::_id_D8E0("none");
  self._id_60D8 _id_07D6::_id_15DF("none");
  level._id_BF38 = scripts\engine\utility::array_remove(level._id_BF38, self);
}

_id_B075() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3._id_4B85 = 0;

    if(var_3.team == "allies") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  if(!var_0.size || !var_1.size) {
    if(level._id_BF38.size == 0) {
      level._id_BF38 = level._id_BF39;
    }

    for(var_5 = level._id_BF38[randomint(level._id_BF38.size)]; isDefined(level._id_BC58) && var_5 == level._id_BC58; var_5 = level._id_BF38[randomint(level._id_BF38.size)]) {}

    level._id_BC59 = level._id_BC58;
    level._id_BC58 = var_5;
    return var_5;
  }

  for(var_6 = 0; var_6 < var_0.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_0.size; var_7++) {
      var_8 = distancesquared(var_0[var_6].origin, var_0[var_7].origin);
      var_0[var_6]._id_4B85 = var_0[var_6]._id_4B85 + var_8;
      var_0[var_7]._id_4B85 = var_0[var_7]._id_4B85 + var_8;
    }
  }

  for(var_6 = 0; var_6 < var_1.size; var_6++) {
    for(var_7 = var_6 + 1; var_7 < var_1.size; var_7++) {
      var_8 = distancesquared(var_1[var_6].origin, var_1[var_7].origin);
      var_1[var_6]._id_4B85 = var_1[var_6]._id_4B85 + var_8;
      var_1[var_7]._id_4B85 = var_1[var_7]._id_4B85 + var_8;
    }
  }

  var_9 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3._id_4B85 < var_9._id_4B85) {
      var_9 = var_3;
    }
  }

  var_12["allies"] = var_9.origin;
  var_9 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3._id_4B85 < var_9._id_4B85) {
      var_9 = var_3;
    }
  }

  var_12["axis"] = var_1[0].origin;
  var_15 = undefined;
  var_16 = undefined;

  for(var_6 = 0; var_6 < level._id_BF38.size; var_6++) {
    var_5 = level._id_BF38[var_6];
    var_17 = abs(distance(var_5.origin, var_12["allies"]) - distance(var_5.origin, var_12["axis"]));

    if(isDefined(level._id_BC58) && var_5 == level._id_BC58) {
      continue;
    }
    if(isDefined(level._id_BC59) && var_5 == level._id_BC59) {
      if(level._id_BF38.size > 2) {
        continue;
      } else {
        var_17 = var_17 + 512;
      }
    }

    if(!isDefined(var_16) || var_17 < var_16) {
      var_16 = var_17;
      var_15 = var_5;
    }
  }

  level._id_BC59 = level._id_BC58;
  level._id_BC58 = var_15;
  return var_15;
}

_id_FD12() {
  level endon("game_ended");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var_0 = gettime();

  if(level._id_110E3 > 0) {
    var_1 = var_0 + level._id_110E3 * 1000;
  } else {
    var_1 = var_0 + scripts\mp\utility\game::_id_6DE5() * 1000 - scripts\mp\utility\game::_id_6DE6();
  }

  var_2 = var_0;

  while(var_2 < var_1) {
    var_2 = gettime();
    level._id_E295 = (var_1 - var_2) / 1000;
    waitframe();
  }
}

_id_ABBE(var_0, var_1, var_2) {}

_id_1097C() {
  level endon("game_ended");
  level waittill("spawn_btm_vip");
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  level._id_E2C0 = 1;
  level._id_7A9A = _id_B0B8();
  _id_0817::_id_D461("Default", "Crit_Default");
  level._id_ABBE = undefined;
  level._id_7A8B = [];
  level._id_7A96[0] = ::scripts\mp\tac_ops\hostage_utility::_id_E2FE(level._id_7A9A, "neutral");
  level thread _id_E2E5();
  _id_0AA2::_id_B8F1("iw8_new_objective_sfx");

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_9136("obj_capture", var_1);

    if(scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount") > 0) {
      scripts\mp\utility\print::_id_EF7B("OBJECTIVES/CAPTURE_VIP", var_1, 4);
    }
  }

  level thread scripts\mp\hud_message::_id_FCBF(undefined, 10, 10);
}

_id_E2E5() {
  level endon("game_ended");
  level._id_1040B = [];
  var_0 = _id_6A26();
  var_1 = _id_6A26(var_0);
  _id_D86C(var_0, "allies");
  _id_D86C(var_1, "axis");
}

_id_6A26(var_0) {
  var_1 = 0;
  var_2 = undefined;
  var_3 = 1000000;

  foreach(var_5 in level._id_BCD0) {
    var_6 = scripts\engine\utility::_id_4B8C(level._id_7A9A, var_5.origin);

    if(isDefined(var_0)) {
      if(var_6 > var_3 && var_0 != var_5.origin) {
        var_2 = var_5;
      }

      continue;
    }

    if(var_6 > 1000000) {
      var_2 = var_5;
    }
  }

  return var_2.origin;
}

_id_D86C(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2.angles = (0, 270, 0);
  var_2.team = var_1;
  var_2._id_ADAE = var_1;
  var_2._id_4140 = var_0;
  var_2._id_A97E = (0, 0, 32);
  var_2._id_3B0A = [];
  var_2.type = "useObject";
  var_2 setModel("cop_marker_scriptable");
  var_2 setscriptablepartstate("marker", "red");
  var_2 playLoopSound("mp_flare_burn_lp");
  var_3 = spawn("trigger_radius", var_0, 0, 120, 128);
  var_2 _id_07D6::_id_C579(1, 1);
  var_2 _id_07D6::_id_D8E0("none");
  var_2 _id_07D6::_id_D61B(level._id_7C58, level._id_7C7D);
  var_3._id_7087 = var_2;
  var_3 thread _id_708F();
  level._id_1040B[var_1] = var_3;
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var_2, "tag_origin");
}

_id_708F() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(level._id_7A8A) && var_0 == level._id_7A8A && var_0.team == self._id_7087.team) {
      scripts\mp\tac_ops\hostage_utility::_id_5032(var_0, level._id_7A96[0], var_0.origin);
      level._id_7A96[0].trigger makeunusable();
      level._id_7A96[0] makeunusable();
      level._id_7A96[0]._id_FE90 unlink();
      level._id_7A96[0]._id_FE90 makeunusable();
      level._id_7A96[0]._id_F3FE _id_07D6::_id_15DF("none");
      level._id_7A96[0]._id_F3FE _id_07D6::_id_D8E0("none");
      level._id_7A96[0]._id_F3FE _id_07D6::_id_C300();
      level._id_7A96[0] notify("gameobject_deleted");
      level._id_7A96[0] delete();
      self._id_7087 _id_07D6::_id_D8E0("none");
      self._id_7087 _id_07D6::_id_C300();
      scripts\mp\gamescore::_id_7001(var_0.team, 200, 0);
      level notify("vip_scored");
      level._id_E2C0 = 0;
      self._id_3643 thread scripts\mp\gametypes\br_extract_chopper::_id_9592();
      _id_B35D(self._id_3643.team, "extract_littlebird_leaving_a_friendly", 10);

      foreach(var_2 in level._id_1040B) {
        stopFXOnTag(level._effect["vfx_smk_signal"], var_2._id_7087, "tag_origin");
        var_2._id_7087 stoploopsound();
        var_2._id_7087 delete();
        var_2._id_7087 = undefined;
        var_2 delete();
      }

      thread _id_0AA2::_id_B8F1("mp_dom_flag_captured", var_0.team);
      thread _id_0AA2::_id_B8F1("mp_dom_flag_lost", scripts\mp\utility\game::_id_6BE2(var_0.team)[0]);

      foreach(var_5 in level._id_EF89) {
        if(scripts\mp\utility\teams::_id_6DCA(var_5, "teamCount") > 0) {
          scripts\mp\utility\print::_id_EF7B("OBJECTIVES/VIP_CAPTURED", var_5, 4);
        }
      }

      level thread scripts\mp\hud_message::_id_FCBF(undefined, 0, 0);
      break;
    }

    waitframe();
  }

  level._id_A8EE._id_A8FA[2] = "skip";
  level _id_6B88("vip");
}

_id_EAF8(var_0) {
  if(!isDefined(var_0._id_3643)) {
    var_1 = scripts\mp\gametypes\br_extract_chopper::_id_E2E3(var_0, var_0.origin);
    var_1._id_852E = 1;
    var_0._id_3643 = var_1;
    self iprintlnbold("Extraction copter en route!");
    var_1._id_5849 = var_0;
    var_1._id_5844 = self.team;
    var_0._id_4140 = var_0.origin;
    var_0._id_A97E = (0, 0, 30);
    var_0 thread _id_5846(var_1);
  }
}

_id_5846(var_0) {
  level endon("game_ended");
  var_0 endon("bugOut");
  var_0 waittill("esc_littlebird_arrive");
  self._id_5832 = 1;
  _id_B35D(var_0._id_5844, "extract_littlebird_close_a_friendly", 10);
}

_id_B35D(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = "ustl";
  var_4 = "dx_mpa_" + var_3 + "_" + var_1 + "_" + var_2;

  if(_func_0205(var_4)) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_0) {
        var_6 _meth_8287(var_4, var_1, 2);
      }
    }
  }
}

_id_B0B8() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3._id_4B85 = 0;

    if(var_3.team == "allies") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = level._id_BCD0;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level._id_BC60) && var_6 == level._id_BC60; var_6 = var_5[randomint(var_5.size)]) {}

    level._id_BC61 = level._id_BC60;
    level._id_BC60 = var_6;
    return var_6.origin;
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_0.size; var_8++) {
      var_9 = distancesquared(var_0[var_7].origin, var_0[var_8].origin);
      var_0[var_7]._id_4B85 = var_0[var_7]._id_4B85 + var_9;
      var_0[var_8]._id_4B85 = var_0[var_8]._id_4B85 + var_9;
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7]._id_4B85 = var_1[var_7]._id_4B85 + var_9;
      var_1[var_8]._id_4B85 = var_1[var_8]._id_4B85 + var_9;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3._id_4B85 < var_10._id_4B85) {
      var_10 = var_3;
    }
  }

  var_13["allies"] = var_10.origin;
  var_10 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3._id_4B85 < var_10._id_4B85) {
      var_10 = var_3;
    }
  }

  var_13["axis"] = var_1[0].origin;
  var_16 = undefined;
  var_17 = undefined;

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6 = var_5[var_7];
    var_18 = abs(distance(var_6.origin, var_13["allies"]) - distance(var_6.origin, var_13["axis"]));

    if(isDefined(level._id_BC60) && var_6 == level._id_BC60) {
      continue;
    }
    if(isDefined(level._id_BC61) && var_6 == level._id_BC61) {
      if(var_5.size > 2) {
        continue;
      } else {
        var_18 = var_18 + 512;
      }
    }

    if(!isDefined(var_17) || var_18 < var_17) {
      var_17 = var_18;
      var_16 = var_6;
    }
  }

  level._id_BC61 = level._id_BC60;
  level._id_BC60 = var_16;
  return var_16.origin;
}

_id_1097B() {
  level endon("game_ended");
  level waittill("spawn_btm_jugg");
  level._id_E2BB = 1;
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0AA2::_id_B8F1("iw8_new_objective_sfx");

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_9136("obj_capture", var_1);

    if(scripts\mp\utility\teams::_id_6DCA(var_1, "teamCount") > 0) {
      scripts\mp\utility\print::_id_EF7B("OBJECTIVES/CAPTURE_JUGG", var_1, 4);
    }
  }

  level thread scripts\mp\hud_message::_id_FCBF(undefined, 19, 19);
  level._id_E2BB = 1;
  level._id_8C31 = _id_B0B8();
  _id_8200();
  level._id_2C6D = _id_4001(level._id_8C31, (0, 0, 0));
  setomnvar("ui_btm_timer", int(30000 + gettime()));
  setomnvar("ui_btm_status", 2);
  wait 30;
  level._id_2C6D thread _id_8C2D();
  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  _func_015D(level._id_8C2E, "icon_minimap_juggernaut");
}

_id_4001(var_0, var_1) {
  var_2 = getgroundposition(var_0, 32);
  var_3 = spawn("script_model", var_2 + (0, 0, 40));
  var_4 = spawn("script_model", var_2);
  var_3._id_3E95 = var_4;
  var_3._id_3E95.angles = var_1;
  var_3._id_3E95 setModel("military_crate_large_stackable_01_jugg");
  var_3._id_3E91 = var_3 getentitynumber();
  _id_4002(var_3);
  return var_3;
}

_id_8C2D() {
  level endon("game_ended");
  self endon("death");
  self setuserange(120);
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_MODE_RUGBY/CRATE_USE");
  self setuseholdduration("duration_long");
  self makeuseable();
  self._id_84EF = 0;
  thread _id_8C35();
  thread _id_8C34();
  thread _id_8C33();
}

_id_8C32(var_0) {
  _id_0EFA(var_0);
  _id_8C2C();
  level notify("jugg_scored");
  level._id_A8EE._id_A8FA[3] = "skip";
  level _id_6B88("jugg");
  self._id_3E95 delete();
  self delete();
}

_id_8C2C() {
  _id_07F9::_id_C799(self._id_A906);
}

_id_8C34() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    _id_8C32(var_0);
    return;
  }
}

_id_8C35() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger_progress", var_0);
    self._id_FF16 = var_0;
    self._id_84EF = 1;
    self._id_90BE = gettime();
  }
}

_id_8C33() {
  level endon("game_ended");
  self endon("death");
  var_0 = self._id_84EF;
  var_1 = self._id_FF16;

  for(;;) {
    wait 0.2;

    if(self._id_84EF) {
      if(self._id_90BE < gettime() - 200.0) {
        self._id_84EF = 0;
        self._id_FF16 = undefined;
        self._id_90BE = undefined;
        continue;
      }

      var_2 = isDefined(var_1) && isDefined(self._id_FF16) && var_1 != self._id_FF16;

      if(!var_0 || var_2) {
        _id_FC97(self);
      }
    } else if(var_0)
      _id_FC97(self);

    var_0 = self._id_84EF;
    var_1 = self._id_FF16;
  }
}

_id_4002(var_0) {
  var_1 = _id_07F9::_id_C57D(99);
  var_0._id_A906 = var_1;
  level._id_8C2E = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  _id_07F9::_id_A867(var_1, "current", var_2, level._id_7C6E);
  _id_07F9::_id_A8B1(var_1, 0);
  _id_07F9::_id_A8B2(var_1, 0);
  _id_07F9::_id_A8A2(var_1);
  _func_016A(var_1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  _func_0168(var_1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  _func_0169(var_1, "MP_MODE_RUGBY/CRATE_LOSING");
  _id_FC97(var_0);
}

_id_FC97(var_0) {
  var_1 = var_0._id_A906;
  var_2 = istrue(var_0._id_84EF);

  if(var_2) {
    _func_0182(var_1, var_0._id_FF16.team);
    _func_0174(var_1, 1);
  } else {
    _func_0182(var_1, undefined);
    _func_0174(var_1, 0);
  }
}

_id_0EFA(var_0) {
  var_1 = level._id_2C6A;
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_3 = var_0 getentitynumber();
  var_2._id_7C8C = var_3;
  var_1._id_0F4A[var_3] = var_0;
  var_0._id_2C6E = var_2;
  _id_D8A0(var_0);
  _id_4003(var_0, var_2);
}

_id_D8A0(var_0) {
  var_1 = level._id_2C6A._id_8C2A;
  var_0 _id_07E6::_id_8C08(var_1);
  var_0 givemaxammo(var_0._id_3808._id_968A);
  var_0 givemaxammo(var_0._id_3808._id_9699);
  var_0 scripts\mp\weapons::_id_FCCC();
  var_2 = scripts\mp\utility\teams::_id_6A01(var_0.team);
  var_3 = var_2[0];
  var_0._id_88DF = 1;
}

_id_4003(var_0, var_1) {
  var_2 = _id_07F9::_id_C57D(99);
  var_1._id_8C88 = var_2;
  _id_07F9::_id_A867(var_2, "current", var_0.origin, "icon_minimap_juggernaut");
  _id_07F9::_id_A8B1(var_2, 0);
  _id_07F9::_id_A8B2(var_2, 0);
  _id_07F9::_id_A8A2(var_2);
  _id_07F9::_id_FB93(var_2, var_0);
  _id_07F9::_id_FB9D(var_2, 90);
  _func_0182(var_2, var_0.team);
  _func_0168(var_2, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  _func_0169(var_2, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

_id_8200() {
  var_0 = _id_07E6::_id_8BED();
  level._id_2C6A._id_8C2A = var_0;
  var_1 = _id_6AD2();
  var_0.maxhealth = var_1;
  var_0._id_E6D3 = var_1;
  var_0._id_EAF7 = "iw8_juggernaut_mp_rugby";
  var_0._id_15D1["crouch"] = 0;
  var_0._id_15D1["sprint"] = 0;
  var_0._id_15D1["usability"] = 0;
  var_0._id_15D1["weapon_switch"] = undefined;
  var_0._id_3808._id_9683 = "iw8_lm_dblmg";
  var_0._id_3808._id_9685 = ["holo"];
  var_0._id_3808._id_9692 = "s4_pi_mike1911";
}

_id_3895(var_0) {
  _id_07F9::_id_C799(var_0._id_2C6E._id_8C88);
}

_id_6AD2() {
  return getdvarint("#x368ebcafc6dc03c6a");
}

_id_1097A() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  level waittill("spawn_btm_dd");
  level._id_265C = 0;
  level._id_A2F7 = 1;
  level._id_267E = 0;
  level._id_2682 = 45;
  level._id_4644 = 5;
  level._id_B1DA = 5;
  level._id_2697 = [];
  level._id_19B0 = 0;
  level._id_29EA = 0;
  level thread _id_19C7();
  var_0 = _id_6A3C();
  var_1 = _id_6D1B(var_0);
  var_0 = getgroundposition(var_0.origin, 64);
  var_1 = getgroundposition(var_1.origin, 64);
  level._id_C63B = 1;
  _id_0817::_id_D461("Default", "Crit_Default");
  var_2 = getEntArray("bombzone", "targetname");
  var_2 = scripts\mp\gametypes\sd::_id_C47C(var_2);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = getEntArray(var_2[var_3].target, "targetname");

    if(var_3 == 0) {
      var_2[var_3] = _id_A006(var_4, var_2[var_3], var_0);
      var_2[var_3].origin = var_0;
      var_4[0].origin = var_0;
    } else {
      var_2[var_3] = _id_A006(var_4, var_2[var_3], var_1);
      var_2[var_3].origin = var_1;
      var_4[0].origin = var_1;
    }

    var_5 = _id_07D6::_id_406E("neutral", var_2[var_3], var_4, (0, 0, 64));
    var_5 _id_07D6::_id_15DF("none");
    var_6 = var_2[var_3]._id_CD99;

    if(isDefined(var_2[var_3]._id_A8E1)) {
      var_5._id_A8E1 = var_2[var_3]._id_A8E1;
    } else {
      var_5._id_A8E1 = var_5 _id_07D6::_id_6AF1();
    }

    if(isDefined(var_2[var_3]._id_7C73)) {
      var_5._id_7C73 = var_2[var_3]._id_7C73;
    } else {
      var_5._id_7C73 = var_5 _id_07D6::_id_6AF1();
    }

    var_5._id_7C8C = "bomb_zone";
    var_5.trigger _meth_83A1(-300);
    var_5 _id_07D6::_id_D8D2(level._id_B1DA);
    var_5 _id_07D6::_id_D8E3(0);
    var_5 _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

    if(var_5._id_A8E1 == "_c") {
      var_5._id_A8E1 = "_a";
      var_5._id_7C73 = "_a";
    }

    var_5 _id_07D6::_id_D61B(level._id_7C6E);
    var_5 _id_07D6::_id_D8E0("any");
    var_5._id_AA79 = scripts\mp\gametypes\obj_bombzone::_id_268A;
    var_5._id_AAC2 = scripts\mp\gametypes\obj_bombzone::_id_268F;
    var_5._id_ABCB = scripts\mp\gametypes\obj_bombzone::_id_2691;
    var_5._id_AA80 = scripts\mp\gametypes\obj_bombzone::_id_268C;
    var_5.useweapon = makeweapon("briefcase_bomb_mp");
    var_5._id_2663 = 0;
    var_5._id_265C = undefined;
    var_5._id_C63B = level._id_C63B;

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      if(isDefined(var_4[var_7]._id_0397)) {
        var_5._id_57CB = var_4[var_7]._id_0397;
        var_4[var_7] thread scripts\mp\gametypes\obj_bombzone::_id_D886(var_5);
        break;
      }
    }

    var_5._id_2636 = getent(var_4[0].target, "targetname");
    var_5._id_2636.origin = var_5._id_2636.origin + (0, 0, -10000);
    var_5._id_2636.label = var_6;
    var_5._id_A6C9 = spawn("trigger_radius", var_5.trigger.origin, 0, 140, 100);
    level._id_A8E8[var_5._id_A8E1] = var_5;
    level._id_2697[level._id_2697.size] = var_5;
  }

  setomnvar("ui_btm_timer", int(30000 + gettime()));
  setomnvar("ui_btm_status", 2);
  wait 30;

  foreach(var_5 in level._id_2697) {
    var_5 _id_07D6::_id_15DF("any");
    var_5 _id_07D6::_id_D61B(level._id_7C79);
  }

  setomnvar("ui_btm_timer", 0);
  setomnvar("ui_btm_status", -1);
  level thread scripts\mp\hud_message::_id_FCBF(undefined, 20, 20);
}

_id_19C7() {
  foreach(var_1 in level.players) {
    if(!isai(var_1)) {
      var_1 setclientomnvar("ui_carrying_bomb", 1);
      var_1._id_8986 = 0;
      var_1._id_87F7 = 0;
      var_1._id_8783 = 1;
    }
  }
}

_id_C606() {
  _id_07D6::_id_D639("neutral");
  _id_07D6::_id_D61B(level._id_7C79);
  self._id_7C8C = "bomb_zone";
  _id_07D6::_id_D8D2(level._id_B1DA);
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self._id_265C = undefined;
  self._id_2663 = 0;
}

_id_265E(var_0, var_1, var_2) {
  level._id_267E = level._id_267E - 1;

  if(self._id_A8E1 == "_a") {
    level._id_19B0 = 0;
  } else {
    level._id_29EA = 0;
  }

  scripts\mp\gametypes\obj_bombzone::_id_D4A0();

  if(level.gameended) {
    return;
  }
  if(var_1 == "explode") {
    self._id_265C = 1;
    self._id_2663 = 0;
    _id_07D6::_id_C300();
    scripts\mp\gamescore::_id_7001(var_0.team, 100);

    if(level._id_265C > 1) {
      level._id_A8EE._id_A8FA[4] = "skip";
      level _id_6B88("dd");
    }
  } else {
    var_0 notify("bomb_defused" + self._id_A8E1);
    self notify("defused");
    _id_C606();
  }
}

_id_6D1B(var_0) {
  var_1 = 1000000;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in level.players) {
    if(var_5.team == "spectator") {
      continue;
    }
    if(!isalive(var_5)) {
      continue;
    }
    var_5._id_4B85 = 0;

    if(var_5.team == "allies") {
      var_2[var_2.size] = var_5;
      continue;
    }

    var_3[var_3.size] = var_5;
  }

  var_7 = level._id_BCD0;

  if(!var_2.size || !var_3.size) {
    for(var_8 = var_7[randomint(var_7.size)]; isDefined(level._id_BC12) && var_8 == level._id_BC12; var_8 = var_7[randomint(var_7.size)]) {}

    level._id_BC13 = level._id_BC12;
    level._id_BC12 = var_8;
    return var_8;
  }

  for(var_9 = 0; var_9 < var_2.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_2.size; var_10++) {
      var_11 = distancesquared(var_2[var_9].origin, var_2[var_10].origin);
      var_2[var_9]._id_4B85 = var_2[var_9]._id_4B85 + var_11;
      var_2[var_10]._id_4B85 = var_2[var_10]._id_4B85 + var_11;
    }
  }

  for(var_9 = 0; var_9 < var_3.size; var_9++) {
    for(var_10 = var_9 + 1; var_10 < var_3.size; var_10++) {
      var_11 = distancesquared(var_3[var_9].origin, var_3[var_10].origin);
      var_3[var_9]._id_4B85 = var_3[var_9]._id_4B85 + var_11;
      var_3[var_10]._id_4B85 = var_3[var_10]._id_4B85 + var_11;
    }
  }

  var_12 = var_2[0];

  foreach(var_5 in var_2) {
    if(var_5._id_4B85 < var_12._id_4B85) {
      var_12 = var_5;
    }
  }

  var_15["allies"] = var_12.origin;
  var_12 = var_3[0];

  foreach(var_5 in var_3) {
    if(var_5._id_4B85 < var_12._id_4B85) {
      var_12 = var_5;
    }
  }

  var_15["axis"] = var_3[0].origin;
  var_18 = undefined;
  var_19 = undefined;

  for(var_9 = 0; var_9 < var_7.size; var_9++) {
    var_8 = var_7[var_9];
    var_20 = abs(distance(var_8.origin, var_15["allies"]) - distance(var_8.origin, var_15["axis"]));

    if(isDefined(level._id_BC12) && var_8 == level._id_BC12) {
      continue;
    }
    if(isDefined(level._id_BC13) && var_8 == level._id_BC13) {
      if(var_7.size > 2) {
        continue;
      } else {
        var_20 = var_20 + 512;
      }
    }

    var_11 = scripts\engine\utility::_id_4B8C(var_0.origin, var_8.origin);

    if(isDefined(var_0)) {
      if(var_11 > var_1 && var_0.origin != var_8.origin) {
        var_18 = var_8;
      }
    } else if(var_11 > 1000000)
      var_18 = var_8;

    if(!isDefined(var_19) || var_20 < var_19) {
      var_19 = var_20;
      var_18 = var_8;
    }
  }

  level._id_BC13 = level._id_BC12;
  level._id_BC12 = var_18;
  return var_18;
}

_id_6A3C() {
  var_0 = [];
  var_1 = [];

  foreach(var_3 in level.players) {
    if(var_3.team == "spectator") {
      continue;
    }
    if(!isalive(var_3)) {
      continue;
    }
    var_3._id_4B85 = 0;

    if(var_3.team == "allies") {
      var_0[var_0.size] = var_3;
      continue;
    }

    var_1[var_1.size] = var_3;
  }

  var_5 = level._id_BCD0;

  if(!var_0.size || !var_1.size) {
    for(var_6 = var_5[randomint(var_5.size)]; isDefined(level._id_BC12) && var_6 == level._id_BC12; var_6 = var_5[randomint(var_5.size)]) {}

    level._id_BC13 = level._id_BC12;
    level._id_BC12 = var_6;
    return var_6;
  }

  for(var_7 = 0; var_7 < var_0.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_0.size; var_8++) {
      var_9 = distancesquared(var_0[var_7].origin, var_0[var_8].origin);
      var_0[var_7]._id_4B85 = var_0[var_7]._id_4B85 + var_9;
      var_0[var_8]._id_4B85 = var_0[var_8]._id_4B85 + var_9;
    }
  }

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    for(var_8 = var_7 + 1; var_8 < var_1.size; var_8++) {
      var_9 = distancesquared(var_1[var_7].origin, var_1[var_8].origin);
      var_1[var_7]._id_4B85 = var_1[var_7]._id_4B85 + var_9;
      var_1[var_8]._id_4B85 = var_1[var_8]._id_4B85 + var_9;
    }
  }

  var_10 = var_0[0];

  foreach(var_3 in var_0) {
    if(var_3._id_4B85 < var_10._id_4B85) {
      var_10 = var_3;
    }
  }

  var_13["allies"] = var_10.origin;
  var_10 = var_1[0];

  foreach(var_3 in var_1) {
    if(var_3._id_4B85 < var_10._id_4B85) {
      var_10 = var_3;
    }
  }

  var_13["axis"] = var_1[0].origin;
  var_16 = undefined;
  var_17 = undefined;

  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    var_6 = var_5[var_7];
    var_18 = abs(distance(var_6.origin, var_13["allies"]) - distance(var_6.origin, var_13["axis"]));

    if(isDefined(level._id_BC12) && var_6 == level._id_BC12) {
      continue;
    }
    if(isDefined(level._id_BC13) && var_6 == level._id_BC13) {
      if(var_5.size > 2) {
        continue;
      } else {
        var_18 = var_18 + 512;
      }
    }

    if(!isDefined(var_17) || var_18 < var_17) {
      var_17 = var_18;
      var_16 = var_6;
    }
  }

  level._id_BC13 = level._id_BC12;
  level._id_BC12 = var_16;
  return var_16;
}

_id_A006(var_0, var_1, var_2) {
  var_3 = var_1.origin;
  var_4 = _id_9FF7(var_1, var_3, var_0, var_2);
  return var_4;
}

_id_9FF7(var_0, var_1, var_2, var_3) {
  var_2[0].origin = var_3;
  var_2[0].angles = (0, 0, 0);
  var_0.origin = var_3;
  var_0.angles = (0, 0, 0);
  _id_D5FE((0, 0, 35), (0, 0, 0), var_1, var_2);
  _id_D548(var_1, var_2);
  return var_0;
}

_id_D5FE(var_0, var_1, var_2, var_3) {
  var_4 = getEntArray("script_brushmodel", "classname");

  foreach(var_6 in var_4) {
    if(isDefined(var_6._id_CD69) && var_6._id_CD69 == "bombzone") {
      if(distance(var_6.origin, var_2) < 100) {
        var_7 = spawn("script_model", var_3[0].origin + var_0);
        var_7.angles = var_1;
        var_7 clonebrushmodeltoscriptmodel(var_6);
        var_7 _meth_80B5();
        var_6 delete();
        break;
      }
    }
  }
}

_id_D548(var_0, var_1) {
  var_2 = getEntArray("script_model", "classname");

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isDefined(var_2[var_3]._id_0397)) {
      if(isDefined(var_2[var_3]._id_0481) && var_2[var_3]._id_0481 == "exploder" && distance(var_2[var_3].origin, var_0) < 100) {
        var_2[var_3].origin = var_1[0].origin;
        var_2[var_3].angles = var_1[0].angles;
      }
    }
  }
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else if(isDefined(level._id_BF37)) {
    var_1 = _id_C527(level._id_BF37._id_E34D);
    var_3 = _id_C527(level._id_BF37._id_5965);
    var_4 = _id_6BC5();
    var_5 = [];
    var_5["activeKOTHZoneNumber"] = level._id_BF37._id_10430[0] getentitynumber();
    var_5["maxSquaredDistToObjective"] = level._id_BF37._id_10430[0]._id_6041;
    var_5["kothZoneDeadzoneDistSq"] = var_4 * var_4;
    var_5["closestEnemyInfluenceDistSq"] = level._id_53E3;
    var_2 = _id_0817::_id_6D4A(self, var_0, level._id_BF37._id_10430[0]._id_E37A, level._id_BF37._id_10430[0]._id_5966, undefined, var_5);
  } else if(isDefined(level._id_2C6C)) {
    var_1 = _id_C526(level._id_2C6C.trigger._id_E34D);
    var_3 = _id_C526(level._id_2C6C.trigger._id_5965);
    var_4 = _id_6BC5();
    var_5 = [];
    var_5["activeKOTHZoneNumber"] = level._id_2C6C.trigger getentitynumber();
    var_5["maxSquaredDistToObjective"] = level._id_2C6C.trigger._id_6041;
    var_5["kothZoneDeadzoneDistSq"] = var_4 * var_4;
    var_5["closestEnemyInfluenceDistSq"] = level._id_53E3;
    var_2 = _id_0817::_id_6D4A(self, var_0, level._id_2C6C.trigger._id_E37A, level._id_2C6C.trigger._id_5966, undefined, var_5);
  } else
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_2;
}

_id_6BC5() {
  return level._id_E10F;
}

_id_C527(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!_func_011A(var_3.origin, level._id_BF37.trigger)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_C526(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!_func_011A(var_3.origin, level._id_2C6C.trigger)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

_id_5EC8() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }
    var_2 notify("force_spawn");
    wait 0.1;
  }
}

_id_ABA4() {
  _id_0A99::_id_D5EA(0);
  self._id_5EC6 = undefined;
  self setclientomnvar("ui_match_status_hint_text", -1);
  thread _id_FCC2();

  if(istrue(level._id_A2F7)) {
    self setclientomnvar("ui_carrying_bomb", 1);
    self._id_8986 = 0;
    self._id_87F7 = 0;
    self._id_8783 = 1;
  }
}

_id_A27F(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level._id_110E6 = var_0;
  level._id_110E2 = 0;
  scripts\mp\gametypes\obj_zonecapture::_id_110EC();
  level._id_110E2 = 1;
  level notify("zone_moved");
  level notify("zone_destroyed");
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(var_1 == self) {
    return;
  }
  if(isDefined(level._id_BF37)) {
    var_10 = level._id_BF37._id_ADAE;

    if(!isDefined(var_10)) {
      return;
    }
    if(isDefined(var_4) && scripts\mp\utility\weapon::_id_88F6(var_4.basename)) {
      return;
    }
    var_11 = self;
    var_12 = 0;
    var_13 = var_1.team;

    if(level._id_110E0 > 0 && var_1 istouching(level._id_BF37.trigger)) {
      if(var_10 != var_13) {
        var_12 = 1;
      }
    }

    if(var_13 != var_10) {
      if(var_11 istouching(level._id_BF37.trigger)) {
        if(var_12) {
          var_1 thread _id_0A9F::_id_7003("capture_kill");
        }

        var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
      }
    } else if(var_1 istouching(level._id_BF37.trigger)) {
      if(var_12) {
        var_1 thread _id_0A9F::_id_7003("capture_kill");
      }

      var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
      var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
      var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
      var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
    }
  }

  if(istrue(level._id_E2BB)) {
    if(var_3 == "MOD_SUICIDE" && var_4.basename == "none" && isDefined(self._id_10A21)) {
      return;
    }
    var_11 = self;

    if(isDefined(var_11._id_88DF)) {
      level._id_E2BB = 0;

      if(isDefined(var_11._id_8C89)) {
        var_11._id_8C89 destroy();
      }

      var_11._id_B7E4 = undefined;
      var_11._id_A5DF = 0;
      var_11 scripts\mp\utility\player::_id_0CF0("iw8_defaultsuit_mp");
      _id_3895(var_11);
    }

    if(isDefined(var_1) && isPlayer(var_1)) {
      var_14 = 0;
      var_15 = 0;
      var_16 = 0;
      var_17 = 0;
      var_18 = 0;
      var_19 = 0;

      if(var_1.team != var_11.team) {
        if(isDefined(var_11._id_88DF)) {
          if(isDefined(var_1._id_88DF)) {
            var_15 = 1;
          } else {
            var_16 = 1;
          }
        } else if(isDefined(var_1._id_88DF))
          var_17 = 1;
      }

      if(var_16) {
        var_1 thread _id_0A9F::_id_7003("kill_juggernaut");
        var_19 = level._id_BB2B;
      } else if(var_15)
        var_19 = level._id_BB2A;
      else if(var_17) {
        var_19 = level._id_BB29;
      }

      if(var_19) {
        var_1 scripts\mp\gamescore::_id_7001(var_1.pers["team"], var_19);
      }

      if(var_1.team != var_11.team && game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_AC9D[var_1.team]]) {
        var_1._id_5AA1 = 1;
      }
    }
  }
}

_id_A8EF() {
  level endon("game_ended");
  level._id_A8EE = spawnStruct();
  level._id_A8EE._id_A8FA = [];
  level._id_A8EE._id_A8FA[0] = "dom";
  level._id_A8EE._id_A8FA[1] = "koth";
  level._id_A8EE._id_A8FA[2] = "vip";
  level._id_A8EE._id_A8FA[3] = "jugg";
  level._id_A8EE._id_A8FA[4] = "dd";
  level._id_A8EE._id_BC50 = undefined;
  level._id_A8EE._id_41DB = undefined;
  level _id_6B88();
}

_id_6B88(var_0) {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");

  if(isDefined(var_0)) {
    level._id_A8EE._id_BC50 = var_0;

    for(;;) {
      var_1 = randomint(level._id_A8EE._id_A8FA.size);

      if(var_0 != level._id_A8EE._id_A8FA[var_1] && level._id_A8EE._id_A8FA[var_1] != "skip") {
        break;
      }

      waitframe();
    }

    setomnvar("ui_btm_timer", int(45000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 45;
  } else {
    var_1 = randomint(level._id_A8EE._id_A8FA.size);
    setomnvar("ui_btm_timer", int(60000 + gettime()));
    setomnvar("ui_btm_status", 1);
    wait 60;
  }

  switch (var_1) {
    case 0:
      _id_E685();
      break;
    case 1:
      _id_E6BD();
      break;
    case 2:
      _id_E73B();
      break;
    case 3:
      _id_E6DC();
      break;
    case 4:
      _id_E695();
      break;
    default:
      _id_E685();
      break;
  }
}

_id_E685() {
  level notify("spawn_btm_dom");
}

_id_E6BD() {
  level notify("spawn_btm_hq");
}

_id_E73B() {
  level notify("spawn_btm_vip");
}

_id_E6DC() {
  level notify("spawn_btm_jugg");
}

_id_E695() {
  level notify("spawn_btm_dd");
}

_id_6ED1(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level._id_8FA1 = gettime();
  var_5 = var_4;

  if(isDefined(var_5.owner)) {
    var_5 = var_5.owner;
  }

  if(isPlayer(var_5)) {
    if(!_id_8A15(var_5)) {
      var_6 = spawnStruct();
      var_6.player = var_5;
      var_6._id_56B9 = "capture";
      var_6._id_033E = var_5.origin;
      _id_06E2::_id_4C2A("callback_on_game_event", var_6);
      var_5 thread _id_07B1::_id_6FB9("mode_hp_secure");

      if(isDefined(level._id_BF37._id_8F83) && gettime() - level._id_BF37._id_8F83 <= 2100) {
        var_5 thread _id_07B1::_id_6FB9("mode_hp_quick_cap");
      }

      if(var_5._id_9000 + 500 > gettime()) {} else
        var_5 scripts\mp\gametypes\obj_zonecapture::_id_D4F0(var_5);
    }
  }

  var_7 = getarraykeys(var_0);

  for(var_8 = 0; var_8 < var_7.size; var_8++) {
    var_9 = var_0[var_7[var_8]].player;
    var_9 _id_FC25(var_3);

    if(!_id_8A15(var_9)) {
      var_9 scripts\mp\utility\stats::_id_7DAE("captures", 1);
      var_9 scripts\mp\persistence::_id_E770("round", "captures", var_9.pers["captures"]);
    } else {}

    wait 0.05;
  }
}

_id_FC25(var_0) {
  if(!isDefined(self._id_3214)) {
    self._id_A775 = 0;
    self._id_3214 = 0;
  }

  if(!isDefined(var_0) || var_0 == "neutral") {
    return;
  }
  self._id_A775++;
  var_1 = scripts\mp\utility\game::_id_6DE6() / 60000;

  if(isPlayer(self) && isDefined(self._id_F242["total"])) {
    var_1 = self._id_F242["total"] / 60;
  }

  self._id_3214 = self._id_A775 / var_1;

  if(self._id_3214 > self._id_A775) {
    self._id_3214 = self._id_A775;
  }
}

_id_8A15(var_0) {
  if(var_0._id_3214 > 3) {
    return 1;
  }

  return 0;
}

onplayerconnect(var_0) {
  var_0._id_0C1E = [];
  var_0._id_A775 = 0;
  var_0._id_3214 = 0;
  var_0._id_F208 = [];
  var_0 scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(var_0.pers["captures"])) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["captures"]);
  }

  var_0 scripts\mp\utility\stats::_id_D551(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["defends"]);
  }

  thread onplayerspawned(var_0);
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
  }
}

_id_6C03(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      var_1 = var_3;
      break;
    }
  }

  return var_1;
}

_id_6CEF() {
  if(!level._id_46D3) {
    return undefined;
  }

  if(!isDefined(level._id_BF37)) {
    return undefined;
  }

  var_0 = level._id_BF37._id_ADAE;

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level._id_E295) {
        return undefined;
      }

      return level._id_E295;
    }
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_FCC2() {
  level endon("game_ended");

  if(isDefined(level._id_2C6C)) {
    if(isDefined(level._id_2C6C._id_ADAE)) {
      if(level._id_2C6C._id_ADAE == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 15);
      } else {
        self setclientomnvar("ui_match_status_hint_text", 14);
      }
    }
  } else if(isDefined(level._id_BF37)) {
    if(isDefined(level._id_BF37._id_ADAE)) {
      if(level._id_BF37._id_ADAE == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 17);
      } else {
        self setclientomnvar("ui_match_status_hint_text", 16);
      }
    }
  } else if(istrue(level._id_E2C0)) {
    if(isDefined(level._id_7A8A)) {
      if(level._id_7A8A.team == self.team) {
        if(level._id_7A8A == self) {
          self setclientomnvar("ui_match_status_hint_text", 13);
        } else {
          self setclientomnvar("ui_match_status_hint_text", 11);
        }
      } else
        self setclientomnvar("ui_match_status_hint_text", 12);
    } else if(level._id_7A96[0].team == self.team)
      self setclientomnvar("ui_match_status_hint_text", 10);
    else {
      self setclientomnvar("ui_match_status_hint_text", 12);
    }
  } else if(istrue(level._id_E2BB))
    self setclientomnvar("ui_match_status_hint_text", 19);
  else {
    self setclientomnvar("ui_match_status_hint_text", 0);
  }
}

_id_D5AD() {
  level._id_7C74 = "waypoint_captureneutral";
  level._id_7C42 = "waypoint_capture";
  level._id_7C4B = "waypoint_defend";
  level._id_7C48 = "waypoint_contested";
  level._id_7C87 = "waypoint_taking";
  level._id_7C6F = "waypoint_losing";
  level._id_7C8A = "waypoint_dom_target";
  level._id_7C6E = "icon_waypoint_locked";
  level._id_7C69 = "hq_target";
  level._id_7C67 = "hq_neutral";
  level._id_7C63 = "hq_destroy";
  level._id_7C65 = "hq_defend";
  level._id_7C64 = "hq_contested";
  level._id_7C68 = "hq_taking";
  level._id_7C66 = "hq_losing";
  level._id_7C80 = "waypoint_recover_vip";
  level._id_7C55 = "waypoint_escort_vip_carrier";
  level._id_7C6A = "waypoint_kill_vip_carrier";
  level._id_7C58 = "waypoint_extract_vip";
  level._id_7C7D = "icon_waypoint_prevent_exfil";
  level._id_7C79 = "waypoint_target_btm";
}

_id_D8C5() {}