/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\kspoint.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "hardpoint";
  var_0[2] = "tdm";
  _id_07D6::main(var_0);

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
  level._id_7B17 = 0;
  level._id_CC11 = undefined;
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_AB3F = scripts\mp\gametypes\war::_id_AB3F;
  level._id_AB8C = ::_id_6CEF;
  level._id_8FA1 = gettime();
  level._id_FE81 = 1;
  level._id_FEF8 = 1;
  level._id_AF6F = 0;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
  game["dialog"]["gametype"] = "gametype_hardpoint";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_hardpoint";
  game["dialog"]["offense_obj"] = "boost_hardpoint";
  game["dialog"]["defense_obj"] = "boost_hardpoint";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "hp_first";
  game["dialog"]["hp_new_location"] = "hp_new_location";
  game["dialog"]["hp_captured_enemy"] = "hp_captured_enemy";
  game["dialog"]["hp_captured_friendly"] = "hp_captured_friendly";
  game["dialog"]["hp_contested"] = "hp_contested";
  game["dialog"]["hp_move_soon"] = "hp_move_soon";
  game["dialog"]["hp_capturing_enemy"] = "hp_capturing_enemy";
  game["dialog"]["hp_capturing_friendly"] = "hp_capturing_friendly";
  level._id_A5E0 = 1;
  thread _id_10FC8();
}

override_car_package_drop_trajectory(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(level.kspoint_care_package_drop_overrides)) {
    level.kspoint_care_package_drop_overrides = [];
  }

  var_5 = spawnStruct();
  var_5.origin = var_1;
  var_5.angles = var_2;
  var_5.noplane = istrue(var_3);
  var_5.overrideplaneangles = var_4;
  level.kspoint_care_package_drop_overrides[var_0] = var_5;
}

drop_kspoint_package(var_0) {
  var_1 = var_0._id_A8E1;

  if(isDefined(level.kspoint_care_package_drop_overrides) && isDefined(level.kspoint_care_package_drop_overrides[var_1])) {
    var_2 = level.kspoint_care_package_drop_overrides[var_1];

    if(var_2.noplane) {
      var_3 = var_2.origin;
      playFX(scripts\engine\utility::getfx("vfx_codmas_krampus_spawn"), var_3);
      var_4 = scripts\cp_mp\killstreaks\airdrop::_id_6995(var_3, 0);
      var_5 = scripts\cp_mp\killstreaks\airdrop::_id_6996(var_4, scripts\cp_mp\killstreaks\airdrop::_id_6994(var_4, 0));
      var_6 = scripts\cp_mp\killstreaks\airdrop::getrandomkillstreak();
      var_7 = scripts\cp_mp\killstreaks\airdrop::getkillstreakcratedatabystreakname(var_6, 0);
      var_8 = scripts\cp_mp\killstreaks\airdrop::createcrate(undefined, undefined, "killstreak_no_owner", var_3, var_2.angles, var_5, 0, 0, var_7);
      var_8.breakglassonimpact = 1;

      if(!isDefined(var_8)) {
        return;
      }
      var_8._id_5FB8 hide();
      var_8 show();
      var_8 scripts\cp_mp\killstreaks\airdrop::_id_3E99();
      return;
    }

    if(isDefined(var_2.overrideplaneangles)) {
      var_9 = var_2.overrideplaneangles;
    } else {
      var_9 = (0, 180, 0);
    }

    var_10 = scripts\cp_mp\killstreaks\airdrop::_id_5039(undefined, "neutral", undefined, var_2.origin, var_9, undefined, 1);
    return;
  } else
    var_10 = scripts\cp_mp\killstreaks\airdrop::_id_5039(undefined, "neutral", undefined, var_0._id_4140, (0, 180, 0), undefined, 1);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3f23594c48b22fd29", getmatchrulesdata("kspointData", "zoneLifetime"));
  setdynamicdvar("#x3839d27b4fe5e6d8f", getmatchrulesdata("kspointData", "zonePreviewTime"));
  setdynamicdvar("#x31265b8fc90c86b91", getmatchrulesdata("kspointData", "zoneCaptureTime"));
  setdynamicdvar("#x3c2cd8b806e80d613", getmatchrulesdata("kspointData", "firstZoneActivationDelay"));
  setdynamicdvar("#x3841cb5d6d63a7a0d", getmatchrulesdata("kspointData", "zoneActivationDelay"));
  setdynamicdvar("#x3d1cefd3cb2665d8c", getmatchrulesdata("kspointData", "randomLocationOrder"));
  setdynamicdvar("#x332b56ae9aa96f77d", getmatchrulesdata("kspointData", "additiveScoring"));
  setdynamicdvar("#x389528ef7d876119f", getmatchrulesdata("kspointData", "pauseTime"));
  setdynamicdvar("#x3bf430d55b08b447a", getmatchrulesdata("kspointData", "delayPlayer"));
  setdynamicdvar("#x3b44253dd9de3c852", getmatchrulesdata("kspointData", "spawnDelay"));
  setdynamicdvar("#x3ec25b387eb30408b", getmatchrulesdata("kspointData", "useHQRules"));
  setdynamicdvar("#x318a111b482eddbe4", 0);
  scripts\mp\utility\game::_id_C25D("koth", 0);
}

_id_ABAD() {
  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/KOTH");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/KOTH");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/KOTH_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/KOTH_HINT");
  }

  if(level._id_CC0E["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  level thread _id_D8CC();
  level thread _id_D8CA();

  if(level.mapname == "mp_shipment") {
    level._id_FEDC = 1;
    level._id_11A9 = 1;
  }

  _id_8294();
  _id_D5D7();
  _id_D5AD();

  if(!level._id_110E8) {
    _id_C325();
  }

  level thread _id_10C33();
  level thread _id_74C8();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_110E3 = scripts\mp\utility\dvars::_id_509A("zoneLifetime", 60, 0, 300);
  level._id_110E0 = scripts\mp\utility\dvars::_id_509A("zoneCaptureTime", 0, 0, 30);
  level._id_5BE6 = scripts\mp\utility\dvars::_id_509A("firstZoneActivationDelay", 30, 0, 60);
  level._id_110DE = scripts\mp\utility\dvars::_id_509A("zoneActivationDelay", 0, 0, 60);
  level._id_110E8 = scripts\mp\utility\dvars::_id_509C("randomLocationOrder", 0, 0, 1);
  level._id_110DF = scripts\mp\utility\dvars::_id_509C("additiveScoring", 0, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 0, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 0.5, 0, 10);
  level._id_FE83 = scripts\mp\utility\dvars::_id_509C("useHQRules", 0, 0, 1);
  level._id_110E7 = scripts\mp\utility\dvars::_id_509A("zonePreviewTime", 10, 0, 60);
}

_id_D5AD() {
  level._id_7C8A = "koth_target";
  level._id_7C74 = "koth_neutral";
  level._id_7C42 = "koth_destroy";
  level._id_7C4B = "koth_defend";
  level._id_7C48 = "koth_contested";
  level._id_7C87 = "koth_taking";
  level._id_7C6F = "koth_losing";
  level._id_7C50 = "koth_defending";
  level._id_7C75 = "koth_next";
}

_id_74C8() {
  level endon("game_ended");
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

  if(level._id_AF6F) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var_2 = 0;

  if(level._id_5BE6) {
    var_2 = 1;
    level._id_110E4 = int(gettime() + level._id_5BE6 * 1000);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 15);
    level._id_110E5 = 1;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 47, 47);
    level thread _id_1086A();
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_5BE6, level._id_110CF._id_4140 + level._id_110CF._id_A97E);
    wait(level._id_5BE6);
    level._id_110E5 = 0;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 48, 48);
    scripts\mp\utility\game::_id_D5FA(5, "free");
  }

  for(;;) {
    if(!isDefined(level._id_9AAB)) {
      level thread _id_D8CB();
    }

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
    setomnvar("ui_hq_status", 13);
    _id_0817::_id_3952();
    _id_7B16();
    var_3 = level._id_110CF _id_07D6::_id_6C02();

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level._id_8FA2 = undefined;
    level._id_110CF _id_8D85();
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

    wait 0.5;

    if(level._id_FE83) {
      thread _id_5EC8();
    }

    wait 0.5;
    _id_7912();
  }
}

_id_1086A() {
  if(istrue(level._id_7E80)) {
    wait 9.5;
  } else {
    wait 7.0;
  }

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_first", var_1);
  }
}

_id_8D85() {
  foreach(var_1 in level.players) {
    foreach(var_3 in var_1._id_0C1E) {
      var_1._id_0C1E = scripts\engine\utility::array_remove(var_1._id_0C1E, var_3);

      if(isDefined(var_3)) {
        var_3 delete();
      }
    }
  }

  if(isDefined(self._id_A434) && self._id_A434.size > 0) {
    foreach(var_3 in self._id_A434) {
      var_3 delete();
    }
  }

  self._id_A434 = [];
}

_id_C325() {
  switch (level.mapname) {
    case "mp_hackney_am":
    case "mp_hackney_yard":
      level._id_C326 = ["1", "4", "3", "9", "8"];
      break;
    case "mp_spear":
    case "mp_spear_pm":
      level._id_C326 = ["5", "4", "3", "2", "6"];
      break;
    case "mp_cave_am":
    case "mp_cave":
      level._id_C326 = ["1", "5", "2", "3", "4"];
      break;
    case "mp_petrograd":
      level._id_C326 = ["1", "9", "4", "5", "2"];
      break;
    case "mp_deadzone":
      level._id_C326 = ["12", "11", "3", "1", "2"];
      break;
    case "mp_raid":
      level._id_C326 = ["20", "2", "8", "9", "5"];
      break;
    case "mp_piccadilly":
      level._id_C326 = ["1", "5", "7", "3", "8"];
      break;
    case "mp_crash2_pm":
    case "mp_crash2":
      level._id_C326 = ["1", "20", "5", "4", "19"];
      break;
    case "mp_emporium":
      level._id_C326 = ["1", "2", "3", "4", "5"];
      break;
    default:
      break;
  }
}

_id_6A41() {
  if(isDefined(level._id_C326)) {
    var_0 = level._id_A8E8[level._id_C326[0]];
    level._id_BC6E = 0;
  } else {
    var_0 = level._id_A8E8["1"];
    level._id_BC6E = 1;
  }

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
  } else if(isDefined(level._id_C326)) {
    level._id_BC6E++;

    if(level._id_BC6E > level._id_C326.size - 1) {
      level._id_BC6E = 0;
    }

    var_23 = level._id_A8E8[level._id_C326[level._id_BC6E]];
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
  level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_4392();

  if(isDefined(level._id_A4EA)) {
    level._id_110CF = level._id_A4EA;
  } else {
    level._id_110CF = _id_6B96();
  }

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

  level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
  level._id_110CF _id_07D6::_id_15DF("none");

  if(istrue(var_0)) {} else if(level._id_110DE) {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
    _id_FD24("zone_activation_delay", 0);
    level._id_110E4 = int(gettime() + 1000 * level._id_110DE);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 15);

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level._id_110E5 = 1;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 47, 47);
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_110DE, level._id_110CF._id_4140 + level._id_110CF._id_A97E);
    wait(level._id_110DE);
    level._id_110E5 = 0;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 48, 48);
    scripts\mp\utility\game::_id_D5FA(5, "free");
  }

  level._id_110CF _id_07D6::_id_D61B(level._id_7C74);
  _id_FD24("neutral", 0);

  if(level._id_110E3) {
    _id_FD24("neutral", 0);

    if(level._id_FE83) {
      thread _id_9709();
    } else {
      thread _id_A27F(level._id_110E3);
      level._id_110E4 = int(gettime() + 1000 * level._id_110E3);
      setomnvar("ui_hardpoint_timer", level._id_110E4);
    }
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

    if(!level._id_FE83) {
      level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
      level._id_110CF _id_07D6::_id_316A(1);
    }

    if(isDefined(level._id_9BEC) && level._id_9BEC) {
      level thread scripts\mp\gametypes\grnd::_id_BFF8();
    }

    var_0 = level scripts\engine\utility::_id_10897("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    }
    var_1 = level._id_110CF _id_07D6::_id_6C02();

    if(level._id_FE83 && level._id_110E3 > 0) {
      thread _id_A27F(level._id_110E3);
    }

    level waittill("zone_destroyed", var_2);

    if(isDefined(var_2)) {
      level._id_110CF _id_07D6::_id_D639(var_2);
    } else {
      level._id_110CF _id_07D6::_id_D639("none");
    }

    if(level._id_FE83) {
      setomnvar("ui_hq_status", -1);
      break;
    }
  }
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_koth_spawn_allies_start");
  _id_0817::_id_113A("mp_koth_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_koth_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_koth_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_koth_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_koth_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_koth_spawn", 1);
  _id_0817::_id_1136("axis", "mp_koth_spawn", 1);
  _id_0817::_id_1136("allies", "mp_koth_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_koth_spawn_secondary", 1, 1);

  if(!isDefined(level._id_E34D) || istrue(level._id_11A9)) {
    _id_0817::_id_1136("allies", "mp_tdm_spawn");
    _id_0817::_id_1136("axis", "mp_tdm_spawn");
    _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
    _id_0817::_id_C2B9("normal", var_2);
    _id_0817::_id_C2B9("fallback", var_3);
  }

  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  if(istrue(level._id_11A9)) {
    return;
  }
  foreach(var_5 in level._id_A8E8) {
    var_5._id_6041 = 0;
    var_5._id_E34D = [];
    var_5._id_5965 = [];
  }

  foreach(var_8 in level._id_E34D) {
    _id_2EFC(var_8);
    var_9 = _id_0817::_id_6BDE(var_8);

    if(isDefined(level._id_8E3C) && isDefined(level._id_8E3C[var_9])) {
      foreach(var_11 in level._id_8E3C[var_9]) {
        var_5 = level._id_A8E8[var_11];
        var_5._id_E34D[var_5._id_E34D.size] = var_8;
      }
    }

    var_13 = 0;
    var_14 = var_8.classname == "mp_koth_spawn_allies_start" || var_8.classname == "mp_kspoint_spawn_axis_start";
    var_15 = var_8.classname == "mp_koth_spawn";
    var_16 = var_8.classname == "mp_koth_spawn_secondary";

    if(var_14) {
      continue;
    }
    if(var_15 || var_16) {
      if(isDefined(var_8._id_039B) && var_8._id_039B != "") {
        var_13 = 1;
        var_17 = strtok(var_8._id_039B, " ");

        foreach(var_11 in var_17) {
          if(!_id_BA5D(var_11)) {
            var_5 = level._id_A8E8[var_11];

            if(var_15) {
              var_5._id_E34D[var_5._id_E34D.size] = var_8;
              continue;
            }

            var_5._id_5965[var_5._id_5965.size] = var_8;
          }
        }
      }
    }

    if(!var_13) {
      foreach(var_5 in level._id_A8E8) {
        if(var_15) {
          var_5._id_E34D[var_5._id_E34D.size] = var_8;
          continue;
        }

        var_5._id_5965[var_5._id_5965.size] = var_8;
      }
    }
  }

  foreach(var_24, var_5 in level._id_A8E8) {
    var_5._id_E37A = "koth_" + var_24;
    _id_0817::_id_C2B9(var_5._id_E37A, var_5._id_E34D);
    var_5._id_5966 = "koth_fallback_" + var_24;
    _id_0817::_id_C2B9(var_5._id_5966, var_5._id_5965);
  }

  _id_0817::_id_0EE5();
}

_id_2EFC(var_0) {
  var_0._id_CF35._id_4BB9 = [];

  foreach(var_2 in level._id_A8E8) {
    var_3 = _func_00C4(var_0.origin, var_2.trigger._id_2323, 5000);

    if(var_3 < 0) {
      var_3 = scripts\engine\utility::_id_4B8C(var_0.origin, var_2.trigger._id_2323);
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
  var_0 = _id_6EA6("hardpoint_zone");
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_1[var_1.size] = var_0[var_2];
  }

  level._id_A8E8 = [];

  foreach(var_4 in var_1) {
    var_5 = scripts\mp\gametypes\obj_zonecapture::_id_D896(var_4);
    level._id_A8E8[var_5._id_A8E1] = var_5;
  }

  var_7 = _id_0817::_id_6D4E("mp_koth_spawn_axis_start");
  var_8 = _id_0817::_id_6D4E("mp_koth_spawn_allies_start");
  level._id_0405["allies"] = var_8[0].origin;
  level._id_0405["axis"] = var_7[0].origin;
  return 1;
}

_id_D8CA() {
  level._id_A437 = [];
  level._id_3BEF = [];
  level._id_5FC0 = [];
  level._id_5434 = [];
  var_0 = _id_6EA6("hardpoint_zone_visual");
  var_1 = _id_6EA6("hardpoint_zone_visual_contest");
  var_2 = _id_6EA6("hardpoint_zone_visual_friend");
  var_3 = _id_6EA6("hardpoint_zone_visual_enemy");

  if(!isDefined(var_0)) {
    level._id_FE82 = 0;
  } else {
    level._id_FE82 = 1;
  }

  if(istrue(level._id_FE82)) {
    foreach(var_5 in var_0) {
      level._id_A437[var_5._id_CD99] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_1) {
      level._id_3BEF[var_5._id_CD99] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_2) {
      level._id_5FC0[var_5._id_CD99] = var_5;
      var_5 hide();
    }

    foreach(var_5 in var_3) {
      level._id_5434[var_5._id_CD99] = var_5;
      var_5 hide();
    }

    _id_BA5C();
    thread _id_9BA9();
  }
}

_id_BA5C() {
  if(level.mapname == "mp_parkour") {
    for(var_0 = 0; var_0 < level._id_A437.size; var_0++) {
      if(level._id_A437[var_0]._id_CD99 == "1") {
        level._id_A437[var_0] hide();
        var_1 = spawn("script_model", (0, 0, 0));
        var_1 setModel("mp_parkour_hardpoint_floor_01");
        var_1.angles = (0, 0, 0);
        var_1._id_CD99 = "1";
        level._id_A437[var_0] = var_1;
      }
    }

    for(var_0 = 0; var_0 < level._id_3BEF.size; var_0++) {
      if(level._id_3BEF[var_0]._id_CD99 == "1") {
        level._id_3BEF[var_0] hide();
        var_2 = spawn("script_model", (0, 0, 0));
        var_2 setModel("mp_parkour_hardpoint_floor_01_contest");
        var_2.angles = (0, 0, 0);
        var_2._id_CD99 = "1";
        level._id_3BEF[var_0] = var_2;
      }
    }

    for(var_0 = 0; var_0 < level._id_5FC0.size; var_0++) {
      if(level._id_5FC0[var_0]._id_CD99 == "1") {
        level._id_5FC0[var_0] hide();
        var_3 = spawn("script_model", (0, 0, 0));
        var_3 setModel("mp_parkour_hardpoint_floor_01_friend");
        var_3.angles = (0, 0, 0);
        var_3._id_CD99 = "1";
        level._id_5FC0[var_0] = var_3;
      }
    }

    for(var_0 = 0; var_0 < level._id_5434.size; var_0++) {
      if(level._id_5434[var_0]._id_CD99 == "1") {
        level._id_5434[var_0] hide();
        var_4 = spawn("script_model", (0, 0, 0));
        var_4 setModel("mp_parkour_hardpoint_floor_01_enemy");
        var_4.angles = (0, 0, 0);
        var_4._id_CD99 = "1";
        level._id_5434[var_0] = var_4;
      }
    }
  }
}

_id_9BA9() {
  foreach(var_1 in level._id_A8E8) {
    var_1._id_A432 = level._id_A437[var_1._id_A8E1];
    var_1._id_540C = level._id_5434[var_1._id_A8E1];
    var_1._id_3BED = level._id_3BEF[var_1._id_A8E1];
    var_1._id_5FA3 = level._id_5FC0[var_1._id_A8E1];
  }
}

_id_D8CB() {
  var_0 = undefined;
  var_1 = undefined;
  var_2 = undefined;
  var_3 = level._id_110CF._id_10430[0];

  foreach(var_5 in level._id_2F7C._id_1A53) {
    var_1 = _func_011A(var_3._id_2323, var_5);
    var_2 = isDefined(var_3._id_039B) && isDefined(var_5._id_039B) && var_3._id_039B == var_5._id_039B;

    if(var_1 || var_2) {
      var_0 = level._id_2F7C._id_1A51[var_5._id_039B];

      foreach(var_7 in level.players) {
        if(isDefined(var_0)) {
          var_7 setclientomnvar("ui_hp_callout_id", var_0);
        }
      }

      break;
    }
  }

  scripts\mp\utility\game::_id_D5FA(4, "free");
}

_id_5EC8() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || isalive(var_2)) {
      continue;
    }
    var_2 notify("force_spawn");
    waitframe();
  }
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = _id_6AF0();
  var_2 = [];
  var_2["activeKOTHZoneNumber"] = level._id_110CF.trigger getentitynumber();
  var_2["maxSquaredDistToObjective"] = level._id_110CF._id_6041;
  var_2["kothZoneDeadzoneDistSq"] = var_1 * var_1;
  var_2["closestEnemyInfluenceDistSq"] = 12250000;

  if(istrue(level._id_11A9)) {
    if(_id_0817::_id_DC06()) {
      if(var_0 == game["attackers"]) {
        var_3 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
      } else {
        var_3 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
      }
    } else
      var_3 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");
  } else if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined, undefined, var_2);
    } else {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined, undefined, var_2);
    }
  } else {
    if(!isDefined(level._id_EC32)) {
      level._id_EC32 = 1;
      _id_0817::_id_D461("Hardpoint", "Crit_Default");
    }

    var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF._id_E37A, level._id_110CF._id_5966, "bad", var_2);
  }

  return var_3;
}

_id_6AF0() {
  return 1000;
}

_id_ABA4() {
  _id_0A99::_id_D5EA(0);
  self._id_5EC6 = undefined;
  thread _id_FCC2();
}

_id_DCD8() {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  var_0 = level._id_110E6 - level._id_110E7;

  if(var_0 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }

  level._id_A4EA = scripts\mp\gametypes\koth::_id_6B96();

  if(!isDefined(level._id_A4EA._id_A908) || level._id_A4EA._id_A908 == -1) {
    level._id_A4EA _id_07D6::_id_C579(1, 1, 1, 1, 0);
  }

  level._id_A4EA _id_07D6::_id_D8E0("any");
  level._id_A4EA _id_07D6::_id_D61B(level._id_7C75);
}

_id_7912() {
  foreach(var_1 in level.players) {
    _id_07F9::_id_A8CF(level._id_A4EA._id_A908, var_1);
  }

  level._id_A4EA _id_07D6::_id_D8E0("none");
  level._id_A4EA _id_07D6::_id_C579(1, 1, 0, 1, 0);
  level._id_A4EA = undefined;
}

_id_A27F(var_0) {
  level endon("game_ended");
  level endon("zone_reset");
  level endon("dev_force_zone");
  level._id_110E6 = var_0;
  level._id_110E2 = 0;

  if(level._id_110E7 > 0) {
    thread _id_DCD8();
  }

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
  if(!isDefined(level._id_110CF)) {
    return;
  }
  var_10 = level._id_110CF._id_ADAE;

  if(!isDefined(var_10)) {
    return;
  }
  if(getdvarint("#x389288d1dc7fc3abe", 0) && isDefined(var_4) && scripts\mp\utility\weapon::_id_88F6(var_4.basename)) {
    return;
  }
  scripts\mp\gamescore::_id_7001(var_1.pers["team"], 1, 0);
  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;
  var_14 = var_1 istouching(level._id_110CF.trigger);
  var_15 = var_11 istouching(level._id_110CF.trigger);

  if(var_13 != var_10) {
    if(level._id_110E0 > 0 && var_14) {
      var_1 thread _id_0A9F::_id_7003("capture_kill");
      var_1 _id_07BF::_id_7D94(13, 1);
    } else if(var_15) {
      var_1 thread scripts\mp\rank::_id_CC00("assault");
      var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
      var_1 _id_07BF::_id_7D94(13, 1);
    }
  } else if(var_14) {
    var_1 thread scripts\mp\rank::_id_CC00("defend");
    var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 _id_07BF::_id_7D94(13, 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
    var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
  }
}

_id_6ED1(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  level._id_8FA1 = gettime();
  var_5 = var_4;

  if(isDefined(var_5.owner)) {
    var_5 = var_5.owner;
  }

  if(isPlayer(var_5)) {
    var_6 = spawnStruct();
    var_6.player = var_5;
    var_6._id_56B9 = "capture";
    var_6._id_033E = var_5.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_6);

    if(!_id_8A15(var_5)) {
      var_5 thread _id_07B1::_id_6FB9("mode_hp_secure");
    } else {
      var_5 thread _id_07B1::_id_6FB9("mode_hp_secure_reduced");
    }

    if(isDefined(level._id_110CF._id_8F83) && gettime() - level._id_110CF._id_8F83 <= 2100) {
      var_5 thread _id_07B1::_id_6FB9("mode_hp_quick_cap");
    }

    if(var_5._id_9000 + 500 > gettime()) {} else
      var_5 scripts\mp\gametypes\obj_zonecapture::_id_D4F0(var_5);
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

    while(var_2 < var_0 && !level.gameended) {
      wait(level._id_5F3A);
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
    if(level.gameended) {
      break;
    }

    if(level._id_FE83) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_3].size;
      }

      add_score_to_killstreak_summon(level._id_110CF);
      continue;
    }

    if(!level._id_110CF._id_E57B && !level.gameended) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_3].size;
      }

      add_score_to_killstreak_summon(level._id_110CF);

      foreach(var_5 in level._id_110CF._id_F396[var_3]) {
        var_5.player scripts\mp\utility\stats::_id_7DAE("objTime", 1);
        var_5.player _id_07BF::_id_7D94(2, 1);
        var_6 = "obj" + level._id_110CF.trigger._id_CD99 + "Time";

        if(isDefined(var_5.player.pers[var_6])) {
          var_5.player scripts\mp\utility\stats::_id_7DAE(var_6, 1);
        }

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

add_score_to_killstreak_summon(var_0) {
  if(!isDefined(level.kspoint_killstreak_points)) {
    level.kspoint_killstreak_points = 0;
  }

  level.kspoint_killstreak_points++;

  if(level.kspoint_killstreak_points > getdvarint("#x3328ea99917ca3650", 10)) {
    level.kspoint_killstreak_points = 0;
    drop_kspoint_package(level._id_110CF);
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

  if(isDefined(var_0.pers["objTime"])) {
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["objTime"]);
  }

  var_0 scripts\mp\utility\stats::_id_D551(0);

  if(isDefined(var_0.pers["defends"])) {
    var_0 scripts\mp\utility\stats::_id_D551(var_0.pers["defends"]);
  }

  thread onplayerspawned(var_0);

  foreach(var_2 in level._id_A8E8) {
    if(istrue(level._id_FE82)) {
      var_2 scripts\mp\gametypes\obj_zonecapture::_id_7911(var_0);
    }
  }

  var_0 thread _id_C1A9();
}

onplayerspawned(var_0) {
  for(;;) {
    var_0 waittill("spawned");

    foreach(var_2 in level._id_A8E8) {
      if(istrue(var_2._id_0026)) {
        if(var_2._id_ADAE == "neutral") {
          var_2 scripts\mp\gametypes\obj_zonecapture::_id_B84D();
          continue;
        }

        var_2 scripts\mp\gametypes\obj_zonecapture::_id_DC8D(var_2._id_ADAE, var_0);
      }
    }
  }
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

_id_C1A9() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "mlg_view_change") {
      foreach(var_3 in level._id_A8E8) {
        if(var_3._id_ADAE != "neutral") {
          var_3 scripts\mp\gametypes\obj_zonecapture::_id_DC8D(var_3._id_ADAE, self);
        }
      }
    }
  }
}

_id_6CEF() {
  if(!level._id_46D3) {
    return undefined;
  }

  var_0 = level._id_110CF._id_ADAE;

  if(isDefined(var_0)) {
    if(self.pers["team"] == var_0) {
      if(!level._id_E295) {
        return undefined;
      }

      return level._id_E295;
    }
  }
}

_id_BA5D(var_0) {
  if(level.mapname == "mp_fallen" && var_0 == "5") {
    return 1;
  }

  return 0;
}

_id_10FC8() {
  level waittill("game_ended");
  _id_10FC4();
}

_id_10FC4() {
  if(level._id_8E3D < 24) {
    setmatchdata("alliesRoundScore", level._id_8E3D, _func_00DB("allies"));
    setmatchdata("axisRoundScore", level._id_8E3D, _func_00DB("axis"));
  }
}

_id_D5D7() {
  scripts\mp\gamelogic::_id_D8E5("koth_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_koth", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_koth", 0, 1);
  scripts\mp\gamelogic::_id_D8E5("koth_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_koth", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_koth", 1, 0);
  scripts\mp\gamelogic::_id_D8E5("koth_next", 0, "neutral", "MP_INGAME_ONLY/OBJ_NEXT_CAPS", "icon_waypoint_locked", 0, 1);
}

_id_FCC2() {
  level endon("game_ended");

  if(istrue(level._id_110E5)) {
    self setclientomnvar("ui_match_status_hint_text", 47);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 48);
  }
}

_id_10C33() {
  level endon("game_ended");

  for(;;) {
    level waittill("zone_moved");
    _id_ABE2();
  }
}

_id_ABE2() {
  foreach(var_1 in level.players) {
    var_1 _id_07BF::_id_7D9A(3, 1);
  }
}

_id_1FC5() {
  level endon("game_ended");
  level endon("stop_contested_stats_thread");
  level endon("zone_moved");
  level endon("zone_destroyed");
  var_0 = level._id_5F3A;

  for(;;) {
    waitframe();

    foreach(var_2 in level._id_EF89) {
      foreach(var_4 in level._id_110CF._id_F396[var_2]) {
        var_4.player _id_07BF::_id_7D9A(5, var_0);
      }
    }
  }
}