/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\grnd.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "dz_flare";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 7500);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = scripts\mp\gametypes\koth::_id_AB70;
  level._id_AB8C = scripts\mp\gametypes\koth::_id_6CEF;
  game["dialog"]["gametype"] = "gametype_dropzone";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["offense_obj"] = "boost_dropzone";
  game["dialog"]["defense_obj"] = "boost_dropzone";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_new_location"] = "dz_new_location";
  game["dialog"]["hp_captured_enemy"] = "dz_captured_enemy";
  game["dialog"]["hp_captured_friendly"] = "dz_captured_friendly";
  game["dialog"]["hp_contested"] = "dz_contested";
  game["dialog"]["hp_move_soon"] = "dz_move_soon";
  game["dialog"]["hp_capturing_enemy"] = "dz_capturing_enemy";
  game["dialog"]["hp_capturing_friendly"] = "dz_capturing_friendly";
  setomnvar("ui_hq_status", -1);
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3722735429b8feffb", getmatchrulesdata("grndData", "dropTime"));
  setdynamicdvar("#x3c7a57a3e8683fac3", getmatchrulesdata("grndData", "enableVariantDZ"));
  setdynamicdvar("#x313b41e648a646022", getmatchrulesdata("kothData", "zoneLifetime"));
  setdynamicdvar("#x3b7dafd8fbfb2bbd4", getmatchrulesdata("kothData", "zoneCaptureTime"));
  setdynamicdvar("#x31157aa0cf508db1c", getmatchrulesdata("kothData", "zoneActivationDelay"));
  setdynamicdvar("#x38c127f2541b57955", getmatchrulesdata("kothData", "randomLocationOrder"));
  setdynamicdvar("#x390df45eb5980dac4", getmatchrulesdata("kothData", "additiveScoring"));
  setdynamicdvar("#x3d195a9e05bb20942", getmatchrulesdata("kothData", "pauseTime"));
  setdynamicdvar("#x36da06b5dfa21e60b", getmatchrulesdata("kothData", "delayPlayer"));
  setdynamicdvar("#x3bd0a25ac30c15bcf", 0);
  scripts\mp\utility\game::_id_C25D("grnd", 0);
  setdynamicdvar("#x3a31dfa9e481324d1", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/GRND");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/GRND");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/GRND_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/DOM_HINT");
  }

  level thread _id_D8CC();
  _id_D5F0();
  _id_8294();
  level thread _id_50CF();

  if(level._id_506E > 0) {
    level thread _id_BFF8();
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_506E = scripts\mp\utility\dvars::_id_509A("dropTime", 15, 0, 60);
  level._id_110E3 = scripts\mp\utility\dvars::_id_509A("zoneLifetime", 60, 0, 300);
  level._id_110E0 = scripts\mp\utility\dvars::_id_509A("zoneCaptureTime", 0, 0, 30);
  level._id_5BE6 = scripts\mp\utility\dvars::_id_509A("firstZoneActivationDelay", 30, 0, 120);
  level._id_110DE = scripts\mp\utility\dvars::_id_509A("zoneActivationDelay", 30, 0, 120);
  level._id_110E8 = scripts\mp\utility\dvars::_id_509C("randomLocationOrder", 0, 0, 1);
  level._id_110DF = scripts\mp\utility\dvars::_id_509C("additiveScoring", 0, 0, 1);
  level._id_AF6F = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 0, 0, 1);
  level._id_5271 = scripts\mp\utility\dvars::_id_509C("enableVariantDZ", 0, 0, 1);
  level._id_FE83 = 0;
  level._id_FE81 = 1;
}

_id_D5F0() {
  var_0 = _func_00D6(level.mapname, 0, 7);

  switch (var_0) {
    case "mp_aniyah":
      level._id_E10F = 1000;
      level._id_39CF = 10000;
      level._id_9C35 = 225000000;
      level._id_9C30 = 7000;
      level._id_53E3 = 12250000;
      break;
    case "mp_shipment":
      level._id_E10F = 500;
      level._id_39CF = 10000;
      level._id_9C35 = 25000000;
      level._id_9C30 = 6000;
      level._id_53E3 = 12250000;
      break;
    default:
      level._id_E10F = 1000;
      level._id_39CF = 10000;
      level._id_9C35 = 25000000;
      level._id_9C30 = 6000;
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
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
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
  foreach(var_3 in level._id_A8E8) {
    var_3._id_6041 = 0;
    var_3._id_E34D = [];
    var_3._id_5965 = [];
  }

  foreach(var_6 in level._id_E34D) {
    _id_2EFC(var_6);
    var_7 = _id_0817::_id_6BDE(var_6);

    if(isDefined(level._id_71A1) && isDefined(level._id_71A1[var_7])) {
      foreach(var_9 in level._id_71A1[var_7]) {
        var_3 = level._id_A8E8[var_9];
        var_3._id_E34D[var_3._id_E34D.size] = var_6;
      }
    }

    var_11 = 0;
    var_12 = var_6.classname == "mp_tdm_spawn_allies_start" || var_6.classname == "mp_tdm_spawn_axis_start";
    var_13 = var_6.classname == "mp_tdm_spawn";
    var_14 = var_6.classname == "mp_tdm_spawn_secondary";

    if(var_12) {
      continue;
    }
    if(var_13 || var_14) {
      if(isDefined(var_6._id_039B) && var_6._id_039B != "") {
        var_11 = 1;
        var_15 = strtok(var_6._id_039B, " ");

        foreach(var_9 in var_15) {
          var_3 = level._id_A8E8[var_9];

          if(var_13) {
            var_3._id_E34D[var_3._id_E34D.size] = var_6;
            continue;
          }

          var_3._id_5965[var_3._id_5965.size] = var_6;
        }
      }
    }

    if(!var_11) {
      foreach(var_3 in level._id_A8E8) {
        if(var_6._id_CF35._id_4BB9[var_3.trigger getentitynumber()] < level._id_39CF || var_6._id_CF35._id_4BB9[var_3.trigger getentitynumber()] > level._id_9C35) {
          var_6._id_C51C = 1;
        }

        if(var_13) {
          if(!isDefined(var_6._id_C51C)) {
            var_3._id_E34D[var_3._id_E34D.size] = var_6;
          }
        } else
          var_3._id_5965[var_3._id_5965.size] = var_6;

        var_6._id_C51C = undefined;
      }
    }
  }

  foreach(var_22, var_3 in level._id_A8E8) {
    var_3._id_E37A = "dropzone_" + var_22;
    _id_0817::_id_C2B9(var_3._id_E37A, var_3._id_E34D);
    var_3._id_5966 = "dropzone_fallback_" + var_22;
    _id_0817::_id_C2B9(var_3._id_5966, var_3._id_5965);
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

    var_0._id_CF35._id_4BB9[var_2.trigger getentitynumber()] = var_3;

    if(var_3 > var_2._id_6041) {
      var_2._id_6041 = var_3;
    }
  }
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

_id_D8CC() {
  var_0 = _id_6EA6("grnd");

  if(level.mapname == "mp_piccadilly") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1547, -1512, 165)) < 10) {
        var_2.origin = var_2.origin - (0, 0, 10);
      }
    }
  } else if(level.mapname == "mp_aniyah") {
    foreach(var_2 in var_0) {
      if(distance(var_2.origin, (-1117, 2295, 398)) < 10) {
        var_2.origin = var_2.origin - (0, 0, 10);
        continue;
      }

      if(distance(var_2.origin, (-4501, -2, 322)) < 10) {
        var_2._id_CD99 = "9";
        continue;
      }

      if(distance(var_2.origin, (-4474, 1159, 388)) < 10) {
        var_2.origin = var_2.origin - (0, 0, 20);
      }
    }
  }

  var_6 = [];
  var_7 = scripts\engine\utility::getStructArray("dz_flare", "targetname");

  if(level.mapname == "mp_shipment") {
    var_8 = [];

    foreach(var_2 in var_0) {
      if(var_2._id_CD99 == "1" && distance(var_2.origin, (-333, 1999, 119)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2._id_CD99 == "2" && distance(var_2.origin, (189, 1564, 75)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2._id_CD99 == "3" && distance(var_2.origin, (-751, 2416, 81)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2._id_CD99 == "4" && distance(var_2.origin, (165, 2420, 79)) < 5) {
        var_8[var_8.size] = var_2;
        continue;
      }

      if(var_2._id_CD99 == "5" && distance(var_2.origin, (-823, 1536, 68)) < 5) {
        var_8[var_8.size] = var_2;
      }
    }

    var_0 = scripts\engine\utility::_id_1BBF(var_0, var_8);
    var_11 = [];

    foreach(var_13 in var_7) {
      if(distance(var_13.origin, (192.944, 1583.51, 16.344)) < 5) {
        var_11[var_11.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-743.056, 2447.51, 17.844)) < 5) {
        var_11[var_11.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (152.944, 2415.51, 16.344)) < 5) {
        var_11[var_11.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-334.5, 1990.5, 17.25)) < 5) {
        var_11[var_11.size] = var_13;
        continue;
      }

      if(distance(var_13.origin, (-751.056, 1479.51, 16.844)) < 5) {
        var_11[var_11.size] = var_13;
      }
    }

    var_7 = scripts\engine\utility::_id_1BBF(var_7, var_11);
  }

  foreach(var_13 in var_7) {
    var_16 = spawn("script_model", var_13.origin);
    var_16.angles = var_13.angles;
    var_16 setModel("dz_flare_scriptable");
    var_13._id_03A9 = var_16;
  }

  var_18 = [];
  level._id_A8E8 = [];

  for(var_19 = 0; var_19 < var_7.size; var_19++) {
    var_20 = 0;
    var_13 = var_7[var_19];
    var_2 = undefined;

    for(var_21 = 0; var_21 < var_0.size; var_21++) {
      if(var_13._id_03A9 istouching(var_0[var_21])) {
        if(isDefined(var_2)) {
          var_6[var_6.size] = "flare at " + var_13.origin + " is touching more than one \"flaretrigger\" trigger";
          var_20 = 1;
          break;
        }

        var_2 = var_0[var_21];
        break;
      }
    }

    if(!isDefined(var_2)) {
      if(!var_20) {
        var_6[var_6.size] = "flare at " + var_13.origin + " is not inside any \"flaretrigger\" trigger";
        continue;
      }
    }

    var_18 = [];
    var_18[0] = var_13._id_03A9;
    var_22 = scripts\mp\gametypes\obj_zonecapture::_id_D896(var_2, var_18);
    var_22.origin = var_2.origin;
    level._id_A8E8[var_22._id_A8E1] = var_22;
  }

  if(var_6.size > 0) {
    for(var_19 = 0; var_19 < var_6.size; var_19++) {}
  } else {}
}

_id_50CF() {
  level endon("game_ended");
  _id_D5AD();
  _id_82B9();
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  level._id_110CF = _id_6A41();
  var_0 = 1;
  level._id_8E3D = 0;

  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_0F05();
  level._id_59EB = level._id_110CF;
  level._id_110CF._id_0026 = 1;
  level._id_110CF _id_07D6::_id_D8E0("any");
  level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
  var_1 = spawnStruct();
  var_1.player = level._id_110CF;
  var_1._id_56B9 = "hill_moved";
  var_1._id_033E = level._id_110CF.trigger.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_1);
  _id_07D1::_id_60C2("prematch_done");
  setomnvar("ui_objective_timer_stopped", 0);
  var_2 = 0;

  if(level._id_5BE6) {
    var_2 = 1;
    level._id_110E4 = int(gettime() + level._id_5BE6 * 1000);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 6);
    level._id_110E5 = 1;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 42, 42);
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_5BE6, level._id_110CF._id_4140 + level._id_110CF._id_A97E);
    wait(level._id_5BE6);
    level._id_110E5 = 0;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 41, 41);
  }

  _id_0AA2::_id_B8F1("mp_dropzone_obj_new");

  for(;;) {
    level._id_110CF._id_10430[0] setscriptablepartstate("smoke", "idle", 0);
    level._id_A8F0 = 1;
    waittillframeend;
    level._id_110CF _id_07D6::_id_5260();
    level._id_110CF._id_3229 = 0;

    if(level.codcasterenabled) {
      level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_F403();
    }

    _id_0817::_id_3952();
    _id_7B1A(var_2, var_0);
    var_0 = 0;
    var_2 = 0;
    setomnvar("ui_hq_status", 8);
    _id_0817::_id_3952();
    _id_7B16();
    var_3 = level._id_110CF _id_07D6::_id_6C02();

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level._id_8FA2 = undefined;
    level._id_110CF._id_0026 = 0;

    if(istrue(level._id_FE82)) {
      foreach(var_5 in level.players) {
        level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_7911(var_5);
      }
    }

    level._id_110CF _id_07D6::_id_4AD1();
    level._id_110CF _id_07D6::_id_15DF("none");
    level._id_110CF _id_07D6::_id_D639("neutral");
    _id_FD24("zone_shift", 0);
    level notify("zone_reset");
    setomnvar("ui_hq_status", -1);
    _id_E19F();

    if(scripts\mp\utility\game::getgametype() == "grnd" && level._id_8E3D == 1) {}

    setomnvar("ui_hq_status", -1);
    wait 1;
  }
}

_id_6A41() {
  var_0 = level._id_A8E8["1"];
  level._id_BC6E = 1;
  return var_0;
}

_id_6B96() {
  if(level._id_110E8) {
    var_0 = [];

    foreach(var_2 in level._id_EF89) {
      var_0[var_2] = (0, 0, 0);
    }

    var_4 = scripts\mp\utility\game::_id_6C7B();

    foreach(var_6 in var_4) {
      if(var_6.team == "spectator") {
        continue;
      }
      var_0[var_6.team] = var_0[var_6.team] + var_6.origin;
    }

    var_8 = [];

    foreach(var_2 in level._id_EF89) {
      var_10 = scripts\mp\utility\teams::_id_6DCA(var_2, "players");
      var_11 = max(var_10.size, 1);
      var_8[var_2] = var_0[var_2] / var_11;
    }

    if(!isDefined(level._id_BC6F) || isDefined(level._id_BC6F) && level._id_BC6F.size == level._id_A8E8.size - 1) {
      level._id_BC6F = [];
    }

    level._id_BC6F[level._id_BC6F.size] = level._id_BC6E;
    var_13 = 0.7;
    var_14 = 0.3;
    var_15 = undefined;
    var_16 = undefined;

    foreach(var_18 in level._id_A8E8) {
      var_19 = 0;

      foreach(var_21 in level._id_BC6F) {
        if(var_18._id_A8E1 == scripts\engine\utility::_id_EA52(var_21)) {
          var_19 = 1;
          break;
        }
      }

      if(var_19) {
        continue;
      }
      var_23 = var_18;
      var_24 = 0;

      foreach(var_2 in level._id_EF89) {
        var_24 = var_24 + distance2dsquared(var_23._id_4140, var_8[var_2]);
      }

      var_27 = distance2dsquared(var_23._id_4140, level._id_110CF._id_4140);
      var_28 = var_24 * var_13 + var_27 * var_14;

      if(!isDefined(var_16) || var_28 > var_16) {
        var_16 = var_28;
        var_15 = var_18._id_A8E1;
      }
    }

    var_23 = level._id_A8E8[var_15];
    level._id_BC6E = var_15;
  } else {
    level._id_BC6E++;

    if(level._id_BC6E > level._id_A8E8.size) {
      level._id_BC6E = 1;
    }

    var_23 = level._id_A8E8[scripts\engine\utility::_id_EA52(level._id_BC6E)];
  }

  return var_23;
}

_id_E19F() {
  _id_10FC4();
  level._id_110CF._id_10430[0] setscriptablepartstate("smoke", "off", 0);
  level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_4392();
  level._id_110CF = _id_6B96();
  level._id_8E3D++;
  level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_0F05();
  level._id_59EB = level._id_110CF;
  level._id_110CF._id_0026 = 1;
  level._id_110CF._id_8F83 = gettime();

  if(level._id_110DE > 0) {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
  } else {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C74);
  }

  var_0 = spawnStruct();
  var_0.player = level._id_110CF;
  var_0._id_56B9 = "hill_moved";
  var_0._id_033E = level._id_110CF.trigger.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_0);
}

_id_7B1A(var_0, var_1) {
  if(var_1) {
    foreach(var_3 in level._id_EF89) {
      _id_0A8D::_id_E775("obj_generic_capture", var_3);
    }
  } else {
    foreach(var_3 in level._id_EF89) {
      _id_0A8D::_id_E775("hp_new_location", var_3);
    }
  }

  _id_0AA2::_id_B8F1("mp_dropzone_obj_new");
  level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
  level._id_110CF _id_07D6::_id_15DF("none");

  if(istrue(var_0)) {} else if(level._id_110DE) {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
    _id_FD24("zone_activation_delay", 0);
    level._id_110E4 = int(gettime() + 1000 * level._id_110DE);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 6);
    level._id_110E5 = 1;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 42, 42);
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_110DE, level._id_110CF._id_4140 + level._id_110CF._id_A97E);
    wait(level._id_110DE);
    level._id_110E5 = 0;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 41, 41);
  }

  level._id_110CF _id_07D6::_id_D61B(level._id_7C74);
  _id_FD24("neutral", 0);

  if(level._id_110E3) {
    _id_FD24("neutral", 0);
    thread _id_A27F(level._id_110E3);
    level._id_110E4 = int(gettime() + 1000 * level._id_110E3);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
  } else
    level._id_110E2 = 0;
}

_id_9709() {
  level endon("zone_captured");

  for(;;) {
    level._id_110E4 = int(gettime() + 1000 * level._id_110E3);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    waitframe();
  }
}

_id_7B16() {
  level endon("game_ended");
  level endon("zone_moved");
  level._id_7B17 = gettime();

  for(;;) {
    level._id_110CF _id_07D6::_id_15DF("enemy");
    level._id_110CF _id_07D6::_id_D8E0("any");
    level._id_110CF _id_07D6::_id_D8D1(&"MP/SECURING_POSITION");
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
    level._id_110CF _id_07D6::_id_316A(1);

    if(isDefined(level._id_9BEC) && level._id_9BEC) {
      level thread _id_BFF8();
    }

    var_0 = level scripts\engine\utility::_id_10897("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    }
    var_1 = level._id_110CF _id_07D6::_id_6C02();
    _id_0AA2::_id_B8F1("mp_dropzone_captured_positive", var_1);
    _id_0AA2::_id_B8F1("mp_dropzone_captured_negative", scripts\mp\utility\game::_id_6BE2(var_1)[0]);
    thread _id_FD12();
    level waittill("zone_destroyed", var_2);
    level._id_E295 = undefined;

    if(isDefined(var_2)) {
      level._id_110CF _id_07D6::_id_D639(var_2);
      continue;
    }

    level._id_110CF _id_07D6::_id_D639("none");
  }
}

_id_1FC4() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("zone_moved");
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

      if(level._id_110CF._id_E57B) {
        var_2 = 0.0;
      }
    }

    var_3 = level._id_110CF _id_07D6::_id_6C02();

    if(var_3 == "neutral") {
      continue;
    }
    if(!level._id_110CF._id_E57B && !level.gameended) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_3].size;
      }

      scripts\mp\gamescore::_id_7001(var_3, var_1, 0);

      foreach(var_5 in level._id_110CF._id_F396[var_3]) {
        var_5.player scripts\mp\utility\stats::_id_7DAE("objTime", 1);

        if(isDefined(var_5.player._id_F208[level._id_8E3D])) {
          var_5.player._id_F208[level._id_8E3D]++;
        } else {
          var_5.player._id_F208[level._id_8E3D] = 1;
        }

        var_5.player scripts\mp\persistence::_id_E770("round", "objTime", var_5.player.pers["objTime"]);
        var_5.player scripts\mp\utility\stats::_id_D550(var_5.player.pers["objTime"]);
        var_5.player scripts\mp\gamescore::_id_6FCF("koth_in_obj", 10);
      }
    }
  }
}

_id_A27F(var_0) {
  level notify("startMoveTimer");
  level endon("startMoveTimer");
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
      var_5 thread scripts\mp\rank::_id_CC00("dz_capture");
      var_5 thread _id_07B1::_id_6FB9("mode_hp_secure");

      if(isDefined(level._id_110CF._id_8F83) && gettime() - level._id_110CF._id_8F83 <= 2100) {
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

_id_BFF8() {
  level endon("game_ended");
  _id_07D1::_id_60C2("prematch_done");
  level._id_71A0 = [];

  for(;;) {
    var_0 = _id_6911();
    var_1 = 1;

    if(isDefined(var_0) && scripts\mp\utility\killstreak::currentactivevehiclecount() < scripts\mp\utility\killstreak::maxvehiclesallowed() && level._id_59E1 + var_1 < scripts\mp\utility\killstreak::maxvehiclesallowed() && scripts\cp_mp\killstreaks\airdrop::_id_6BB2() < 8) {
      var_2 = _id_69F8();
      var_3 = _func_00B6(level._id_110CF.trigger);

      if(_id_DB39(var_2) && isDefined(var_3) && var_3.size > 0) {
        var_4 = randomintrange(0, var_3.size);
        var_5 = var_3[var_4];
        var_6 = _func_02AB(var_5.origin);
        var_7 = var_5.origin;
        var_8 = var_6;
        var_9 = scripts\engine\trace::_id_3EE5(0, 1, 1, 1, 0, 1, 0);
        var_10 = [];
        var_11 = scripts\engine\trace::ray_trace(var_7, var_8, var_10, var_9);
        var_5 = var_11["position"];
      } else
        var_5 = _id_69F7() + (randomintrange(-50, 50), randomintrange(-50, 50), 0);

      if(var_2 == "mega") {
        var_12 = spawnStruct();
        var_12.cratetype = undefined;
        var_12._id_A777 = undefined;
        var_12.usephysics = undefined;
        _id_09AA::_id_138B(var_0, var_0.team, var_5, randomfloat(360), var_5, var_12);
      } else {
        scripts\cp_mp\vehicles\vehicle_tracking::_id_C59B();
        scripts\cp_mp\killstreaks\airdrop::_id_5039(var_0, var_0.team, var_2, var_5, randomfloat(360), var_5, 1);
      }

      var_13 = level._id_506E;
    } else
      var_13 = 0.5;

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_13);
  }
}

_id_DB39(var_0) {
  if(var_0 == "mega") {
    return 0;
  }

  if(level.mapname == "mp_vacant") {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "4") {
      return 0;
    }
  } else if(issubstr(level.mapname, "mp_aniyah")) {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "1") {
      return 0;
    }
  } else if(level.mapname == "mp_raid") {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "6") {
      return 0;
    }
  } else if(level.mapname == "mp_petrograd") {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "1") {
      return 0;
    }
  } else if(issubstr(level.mapname, "mp_hackney")) {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "4") {
      return 0;
    }
  } else if(issubstr(level.mapname, "mp_shipment")) {
    if(isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "1") {
      return 0;
    }
  } else if(issubstr(level.mapname, "mp_emporium"))
    return 0;

  return 1;
}

_id_69F7() {
  if(level.mapname == "mp_vacant" && isDefined(level._id_110CF.trigger._id_CD99) && level._id_110CF.trigger._id_CD99 == "4") {
    return (1760, 701, 122);
  }

  if(level.mapname == "mp_emporium" && isDefined(level._id_110CF.trigger._id_CD99)) {
    switch (level._id_110CF.trigger._id_CD99) {
      case "1":
        return (-732, -136, 608);
      case "2":
        return (672, -1336, 608);
      case "3":
        return (44, 968, 608);
      case "4":
        return (-680, -1552, 608);
      case "5":
        return (832, 4, 608);
    }
  }

  return level._id_110CF.origin;
}

_id_6911() {
  var_0 = undefined;
  var_1 = 0;
  var_2 = level._id_110CF _id_07D6::_id_6C02();

  if(var_2 == "neutral") {
    return var_0;
  }

  foreach(var_4 in level._id_110CF._id_F396[var_2]) {
    if(var_1 == 0 || var_1 > var_4._id_E72D) {
      var_1 = var_4._id_E72D;
      var_0 = var_4.player;
    }
  }

  return var_0;
}

_id_69F8() {
  var_0 = undefined;

  if(!isDefined(level._id_71A0["mega"]) && randomintrange(0, 100) < 5) {
    var_0 = "mega";
  } else {
    if(level._id_71A0.size) {
      for(var_1 = 200; var_1; var_1--) {
        var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();

        if(isDefined(level._id_71A0[var_0])) {
          var_0 = undefined;
          continue;
        }

        break;
      }
    }

    if(!isDefined(var_0)) {
      var_0 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
    }
  }

  level._id_71A0[var_0] = 1;

  if(level._id_71A0.size == 15) {
    level._id_71A0 = [];
  }

  return var_0;
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = _id_6BC5();
  var_2 = [];
  var_2["activeKOTHZoneNumber"] = level._id_110CF._id_10430[0] getentitynumber();
  var_2["maxSquaredDistToObjective"] = level._id_110CF._id_10430[0]._id_6041;
  var_2["kothZoneDeadzoneDistSq"] = var_1 * var_1;
  var_2["closestEnemyInfluenceDistSq"] = level._id_53E3;

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined, undefined, var_2);
    } else {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined, undefined, var_2);
    }
  } else {
    if(!isDefined(level._id_EC32)) {
      level._id_EC32 = 1;
      _id_0817::_id_D461("DZ", "Crit_Default");
    }

    var_4 = _id_C525(level._id_110CF._id_E34D);
    var_5 = _id_C525(level._id_110CF._id_5965);
    var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF._id_E37A, level._id_110CF._id_5966, "bad", var_2);
  }

  return var_3;
}

_id_6BC5() {
  return level._id_E10F;
}

_id_C525(var_0) {
  var_1 = [];

  if(isDefined(var_0)) {
    foreach(var_3 in var_0) {
      if(!_func_011A(var_3.origin, level._id_110CF.trigger)) {
        var_1[var_1.size] = var_3;
      }
    }
  }

  return var_1;
}

onplayerconnect(var_0) {
  var_0._id_A775 = 0;
  var_0._id_3214 = 0;
  var_0._id_F208 = [];
  var_0 scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(var_0.pers["objTime"])) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["objTime"]);
  }

  var_0 scripts\mp\utility\stats::_id_D551(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["defends"]);
  }
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");
  }
}

_id_ABA4() {
  _id_0A99::_id_D5EA(0);
  thread _id_FCC2();
  level._id_B027 = 30;
}

_id_6AAA(var_0) {
  if(var_0 == "allies") {
    var_1 = 2;
  } else if(var_0 == "axis") {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  return var_1;
}

_id_FD24(var_0, var_1) {
  var_2 = -1;

  if(var_1) {
    var_2 = -2;
  } else if(scripts\mp\utility\teams::_id_8878(var_0)) {
    var_3 = thread _id_6C03(var_0);

    if(isDefined(var_3)) {
      var_2 = var_3 getentitynumber();
    }
  } else {
    switch (var_0) {
      case "zone_activation_delay":
        var_2 = -3;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_hardpoint", var_2);
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
    level._id_E295 = (var_1 - var_2) / 1000 + 0.1;
    waitframe();
  }
}

_id_D5AD() {
  level._id_7C8A = "dz_target";
  level._id_7C74 = "dz_neutral";
  level._id_7C42 = "dz_enemy";
  level._id_7C4B = "dz_friendly";
  level._id_7C48 = "dz_contested";
  level._id_7C87 = "dz_taking";
  level._id_7C6F = "dz_losing";
  level._id_7C50 = "dz_defending";
}

_id_82B9() {
  scripts\mp\gamelogic::_id_D8E5("dz_enemy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_friendly", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_dz", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::_id_D8E5("dz_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_TAKING_CAPS", "icon_waypoint_dz", 1);
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

_id_10FC4() {
  if(level._id_8E3D < 24) {
    setmatchdata("alliesRoundScore", level._id_8E3D, _func_00DB("allies"));
    setmatchdata("axisRoundScore", level._id_8E3D, _func_00DB("axis"));
  }
}

_id_FCC2() {
  level endon("game_ended");

  if(istrue(level._id_110E5)) {
    self setclientomnvar("ui_match_status_hint_text", 42);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 41);
  }
}