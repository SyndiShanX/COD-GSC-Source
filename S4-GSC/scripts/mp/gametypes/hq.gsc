/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\hq.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = "hqloc";
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
  level._id_9FE9 = ::_id_ABB3;
  level._id_AB70 = ::_id_AB70;
  level._id_AB8C = ::_id_6CEF;
  level._id_9FEA = ::_id_9FEA;
  level._id_31E0 = ::_id_31E0;
  level._id_8FA1 = gettime();
  level._id_FE83 = 1;
  level._id_FEF8 = 1;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
  game["dialog"]["gametype"] = "gametype_hq";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_hq";
  game["dialog"]["offense_obj"] = "boost_hq";
  game["dialog"]["defense_obj"] = "boost_hq";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "hq_first";
  game["dialog"]["hp_active"] = "hq_active";
  game["dialog"]["hp_new_location"] = "hq_new_location";
  game["dialog"]["hp_captured_enemy"] = "hq_captured_enemy";
  game["dialog"]["hp_captured_friendly"] = "hq_captured_friendly";
  game["dialog"]["hp_contested"] = "hq_contested";
  game["dialog"]["hp_move_soon"] = "hq_move_soon";
  game["dialog"]["hp_capturing_enemy"] = "hq_capturing_enemy";
  game["dialog"]["hp_capturing_friendly"] = "hq_securing";
  game["dialog"]["hp_lost"] = "hq_lost";
  game["dialog"]["hp_timeout"] = "hq_timeout";
  game["dialog"]["hp_secured_friendly"] = "hq_secured";
  game["dialog"]["hp_owned_lost"] = "hq_disabled";
  game["dialog"]["hp_disabling_enemy"] = "hq_disabling_enemy";
  game["dialog"]["hp_disabling_friendly"] = "hq_disabling_friendly";
  game["dialog"]["hp_dead"] = "hq_dead";
  thread _id_10FC8();
  level._effect["hq_explode"] = loadfx("vfx/iw8_mp/gamemode/vfx_hq_box_destroy.vfx");
  level._id_A5E0 = 1;
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x32e5271c49ce04920", getmatchrulesdata("hqData", "zoneTimeout"));
  setdynamicdvar("#x3150f23ba567e88a6", getmatchrulesdata("hqData", "zoneLifetime"));
  setdynamicdvar("#x3e404912e813abc80", getmatchrulesdata("hqData", "zoneCaptureTime"));
  setdynamicdvar("#x38fcd61ea82837924", getmatchrulesdata("hqData", "firstZoneActivationDelay"));
  setdynamicdvar("#x31ef853b0c9b10c68", getmatchrulesdata("hqData", "zoneActivationDelay"));
  setdynamicdvar("#x3639222ac3ff10080", getmatchrulesdata("hqData", "zoneSelectionDelay"));
  setdynamicdvar("#x39f91f937fdcbff9", getmatchrulesdata("hqData", "randomLocationOrder"));
  setdynamicdvar("#x374fc7a68c71e3338", getmatchrulesdata("hqData", "additiveScoring"));
  setdynamicdvar("#x3e548cead7faee9de", getmatchrulesdata("hqData", "pauseTime"));
  setdynamicdvar("#x3f532ddc30041c957", getmatchrulesdata("hqData", "delayPlayer"));
  setdynamicdvar("#x3a51c5483717fed71", getmatchrulesdata("hqData", "useHPRules"));
  setdynamicdvar("#x35e563520e1141f3", 0);
  scripts\mp\utility\game::_id_C25D("hq", 0);
}

_id_ABAD() {
  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/HQ");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/HQ");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/HQ_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/HQ_HINT");
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
  _id_D5AD();

  if(!level._id_110E8) {
    _id_C325();
  }

  level thread _id_7B1F();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_110EB = scripts\mp\utility\dvars::_id_509A("zoneTimeout", 60, 0, 300);
  level._id_110E3 = scripts\mp\utility\dvars::_id_509A("zoneLifetime", 60, 0, 300);
  level._id_110E0 = scripts\mp\utility\dvars::_id_509A("zoneCaptureTime", 0, 0, 30);
  level._id_5BE6 = scripts\mp\utility\dvars::_id_509A("firstZoneActivationDelay", 30, 0, 120);
  level._id_110DE = scripts\mp\utility\dvars::_id_509A("zoneActivationDelay", 30, 0, 120);
  level._id_110EA = scripts\mp\utility\dvars::_id_509A("zoneSelectionDelay", 15, 0, 120);
  level._id_110E8 = scripts\mp\utility\dvars::_id_509C("randomLocationOrder", 0, 0, 1);
  level._id_110DF = scripts\mp\utility\dvars::_id_509C("additiveScoring", 0, 0, 1);
  level._id_AF6F = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 0, 0, 1);
  level._id_FE81 = scripts\mp\utility\dvars::_id_509C("useHPRules", 0, 0, 1);
}

_id_7B1F() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  setomnvar("ui_hq_status", -1);
  level._id_110CF = _id_6A41();
  var_0 = 1;
  level._id_8E3D = 0;
  level._id_110CF._id_10430[0] _meth_82CB("iw8_mp_military_hq_crate_close");

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
    level thread _id_10870();
    var_2 = 1;
    level._id_110E4 = int(gettime() + level._id_5BE6 * 1000);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 1);
    level thread _id_1086A();
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_5BE6, level._id_110CF._id_10430[0].origin + (0, 0, 70));
    wait(level._id_5BE6);
    scripts\mp\utility\game::_id_D5FA(7, "free");
  }

  setomnvar("ui_objective_timer_stopped", 0);
  _id_0AA2::_id_B8F1("mp_hq_activate_sfx");

  for(;;) {
    if(!isDefined(level._id_9AAB)) {
      level thread _id_D8CB();
    }

    level._id_A8F0 = 1;
    waittillframeend;

    if(!var_2) {
      foreach(var_4 in level.players) {
        _id_07F9::_id_A8CF(level._id_110CF._id_A908, var_4);
      }
    }

    level._id_110CF _id_07D6::_id_5260();
    level._id_110CF._id_3229 = 0;

    if(level.codcasterenabled) {
      level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_F403();
    }

    _id_0817::_id_3952();
    _id_7B1A(var_2, var_0);
    var_0 = 0;
    var_2 = 0;
    setomnvar("ui_hq_status", 2);
    _id_0817::_id_3952();
    level._id_110CF._id_10430[0] _meth_82CB("iw8_mp_military_hq_crate_open");
    level._id_110CF._id_10430[0] playLoopSound("mp_iw8_hq_crate_active_idle");
    _id_7B16();
    var_6 = level._id_110CF _id_07D6::_id_6C02();
    setomnvar("ui_hq_ownerteam", 0);
    level._id_E3E2[game["attackers"]]._id_15B5 = 0;
    level._id_E3E2[game["defenders"]]._id_15B5 = 0;

    if(level._id_FE81) {
      if(level._id_AF6F) {
        level scripts\mp\gamelogic::resumetimer();
      }
    }

    level._id_8FA2 = undefined;
    level._id_110CF _id_8D85();
    level._id_110CF._id_0026 = 0;

    if(istrue(level._id_FE82)) {
      foreach(var_4 in level.players) {
        level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_7911(var_4);
      }
    }

    level._id_110CF _id_07D6::_id_4AD1();
    level._id_110CF _id_07D6::_id_15DF("none");
    level._id_110CF _id_07D6::_id_D639("neutral");
    _id_FD24("zone_shift", 0);
    level notify("zone_reset");
    level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_4392();
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 16, 16);
    setomnvar("ui_hq_status", 5);
    var_9 = int(gettime() + level._id_110EA * 1000 + 500);
    setomnvar("ui_hardpoint_timer", var_9);

    if(!level._id_FE81) {
      if(level._id_110EA > 0) {
        if(level._id_AF6F) {
          level scripts\mp\gamelogic::pausetimer();
        }

        _id_0817::_id_D461("HQTDM", "Crit_Frontline");
        level._id_FEDC = 1;
      }

      thread _id_5EC8();

      if(level._id_110EA >= 10) {
        thread scripts\mp\gametypes\obj_zonecapture::_id_7B14(level._id_110EA);
      }

      wait(level._id_110EA);

      if(!istrue(level._id_11A9)) {
        _id_0817::_id_4391("normal");
        level._id_FEDC = undefined;
        _id_0817::_id_D461("Hardpoint", "Crit_Default");
      }
    }

    _id_E19F();
    wait 0.5;
  }
}

_id_1086A() {
  if(istrue(level._id_7E80)) {
    wait 8.5;
  } else {
    wait 6.0;
  }

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_first", var_1);
  }
}

_id_10870() {
  if(istrue(level._id_7E80)) {
    wait 6.5;
  } else {
    wait 5.5;
  }

  level thread scripts\mp\hud_message::_id_A6B6("hq_located", "hq_located", "allies");
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
  level._id_110CF = _id_6B96();
  level._id_8E3D++;
  level._id_110CF _id_C654();
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
  var_0._id_033E = level.trigger._id_110CF.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_0);
}

_id_C654() {
  self._id_8FAD = "none";
  self._id_902E = "none";
  self._id_ADAE = "neutral";
  self._id_BC52 = "neutral";
  self._id_4143 = 0;
  var_0 = getarraykeys(self._id_EF94);

  foreach(var_2 in var_0) {
    self._id_EF94[var_2] = 0;
  }

  _id_07F9::_id_FB96(self._id_A908, undefined);
  _id_07F9::_id_A8B4(self._id_A908, 0);
  _id_07F9::_id_A8C4(self._id_A908, 0);
}

_id_7B1A(var_0, var_1) {
  if(!var_1) {
    foreach(var_3 in level._id_EF89) {
      _id_0A8D::_id_E775("hp_new_location", var_3);
    }
  }

  _id_0AA2::_id_B8F1("mp_hq_activate_sfx");
  level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
  level._id_110CF _id_07D6::_id_15DF("none");

  if(istrue(var_0)) {} else if(level._id_110DE) {
    level thread scripts\mp\hud_message::_id_A6B6("hq_located", "hq_located", "allies");
    level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
    _id_FD24("zone_activation_delay", 0);
    level._id_110E4 = int(gettime() + 1000 * level._id_110DE);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 1);

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_110DE, level._id_110CF._id_10430[0].origin + (0, 0, 70));
    wait(level._id_110DE);
    scripts\mp\utility\game::_id_D5FA(7, "free");
  }

  foreach(var_3 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_active", var_3);
  }

  level thread scripts\mp\hud_message::_id_A6B6("hq_capture", "hq_capture", "allies");

  if(level._id_AF6F) {
    level scripts\mp\gamelogic::resumetimer();
  }

  level._id_110CF _id_07D6::_id_D61B(level._id_7C74);
  _id_FD24("neutral", 0);

  if(level._id_110E3) {
    _id_FD24("neutral", 0);

    if(level._id_110EB == 0 && !level._id_FE81) {
      thread _id_9709();
    } else {
      var_7 = scripts\engine\utility::ter_op(level._id_FE81, level._id_110E3, level._id_110EB);
      thread _id_A27F(var_7);
      level._id_110E4 = int(gettime() + 1000 * var_7);
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

    if(level._id_FE81) {
      level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
      level._id_110CF _id_07D6::_id_316A(1);
    }

    if(isDefined(level._id_9BEC) && level._id_9BEC) {
      level thread scripts\mp\gametypes\grnd::_id_BFF8();
    }

    var_0 = level scripts\engine\utility::_id_10897("zone_captured", "zone_destroyed");

    if(var_0 == "zone_destroyed") {
      continue;
    } else if(!level._id_FE81) {
      level._id_110E4 = int(gettime() + 1000 * level._id_110E3);
      setomnvar("ui_hardpoint_timer", level._id_110E4);
      setomnvar("ui_hq_status", 3);
    }

    var_1 = level._id_110CF _id_07D6::_id_6C02();
    thread _id_FD12();

    if(!level._id_FE81 && level._id_110E3 > 0) {
      thread _id_A27F(level._id_110E3);
    }

    if(!level._id_FE81 && level._id_110E0 > 0) {
      var_2 = scripts\mp\utility\teams::_id_6DCA(var_1, "players");
      level thread scripts\mp\hud_message::_id_A6B6("hq_captured", "hq_destroy", var_1, var_2);
    }

    level thread scripts\mp\hud_message::_id_FCBF(var_1, 17, 29);
    scripts\mp\utility\game::_id_D5FA(8, var_1);
    level waittill("zone_destroyed", var_3);
    scripts\mp\utility\game::_id_D5FA(9, "free");

    if(!level._id_FE81 && level._id_110E0 > 0) {
      level thread scripts\mp\hud_message::_id_A6B6("hq_destroyed", "hq_destroyed", "allies");
    }

    level thread scripts\mp\hud_message::_id_FCBF(undefined, 16, 16);
    level._id_E295 = undefined;

    if(isDefined(var_3)) {
      level._id_110CF _id_07D6::_id_D639(var_3);
    } else {
      level._id_110CF _id_07D6::_id_D639("none");
    }

    if(!level._id_FE81) {
      setomnvar("ui_hardpoint_timer", 0);
      setomnvar("ui_hq_status", -1);
      break;
    }
  }
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
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);
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
    var_14 = var_8.classname == "mp_koth_spawn_allies_start" || var_8.classname == "mp_koth_spawn_axis_start";
    var_15 = var_8.classname == "mp_koth_spawn";
    var_16 = var_8.classname == "mp_koth_spawn_secondary";
    var_17 = var_8.classname == "mp_tdm_spawn";
    var_18 = var_8.classname == "mp_tdm_spawn_secondary";

    if(var_14) {
      continue;
    }
    if(var_15 || var_16) {
      if(isDefined(var_8._id_039B) && var_8._id_039B != "") {
        var_13 = 1;
        var_19 = strtok(var_8._id_039B, " ");

        foreach(var_11 in var_19) {
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

    if(!var_13 && !var_17 && !var_18) {
      foreach(var_5 in level._id_A8E8) {
        if(var_15) {
          var_5._id_E34D[var_5._id_E34D.size] = var_8;
          continue;
        }

        var_5._id_5965[var_5._id_5965.size] = var_8;
      }
    }
  }

  foreach(var_26, var_5 in level._id_A8E8) {
    var_5._id_E37A = "koth_" + var_26;
    _id_0817::_id_C2B9(var_5._id_E37A, var_5._id_E34D);
    var_5._id_5966 = "koth_fallback_" + var_26;
    _id_0817::_id_C2B9(var_5._id_5966, var_5._id_5965);
  }

  _id_0817::_id_0EE5();
}

_id_2EFC(var_0) {
  var_0._id_CF35._id_4BB9 = [];

  foreach(var_2 in level._id_A8E8) {
    var_3 = _func_00C4(var_0.origin, var_2.trigger.origin, 5000);

    if(var_3 < 0) {
      var_3 = scripts\engine\utility::_id_4B8C(var_0.origin, var_2.trigger.origin);
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
  var_2 = 0;
  var_3 = getEntArray("hqloc", "targetname");
  var_4 = [];

  if(var_0.size != var_3.size) {
    var_1[var_1.size] = "Number of hqloc Radios and hardpoint_zone triggers are not equal";
    var_2 = 1;

    foreach(var_6 in var_0) {
      var_7 = 0;

      foreach(var_9 in var_3) {
        if(var_9 istouching(var_6)) {
          var_7 = 1;
          break;
        }
      }

      if(!var_7) {
        var_1[var_1.size] = "hardpoint_zone: " + var_6._id_CD99 + " has no hqloc radio inside it";
      }
    }
  }

  level._id_A8E8 = [];

  for(var_12 = 0; var_12 < var_3.size; var_12++) {
    var_9 = var_3[var_12];
    var_6 = undefined;

    for(var_13 = 0; var_13 < var_0.size; var_13++) {
      if(var_9 istouching(var_0[var_13])) {
        if(isDefined(var_6)) {
          var_1[var_1.size] = "Radio at " + var_9.origin + " is touching more than one \"hardpoint_zone\" trigger";
          var_2 = 1;
          break;
        }

        var_6 = var_0[var_13];
        break;
      }
    }

    if(!isDefined(var_6)) {
      if(!var_2) {
        var_1[var_1.size] = "Radio at " + var_9.origin + " is not inside any \"hardpoint_zone\" trigger";
        var_2 = 1;
        continue;
      }
    }

    var_4 = [];
    var_4[0] = var_9;
    var_14 = getEntArray(var_9.target, "targetname");

    for(var_15 = 0; var_15 < var_14.size; var_15++) {
      var_4[var_4.size] = var_14[var_15];
    }

    var_16 = scripts\mp\gametypes\obj_zonecapture::_id_D896(var_6, var_4);
    level._id_A8E8[var_16._id_A8E1] = var_16;
  }

  if(var_1.size > 0) {
    for(var_12 = 0; var_12 < var_1.size; var_12++) {}
  } else {
    var_17 = _id_0817::_id_6D4E("mp_koth_spawn_axis_start");
    var_18 = _id_0817::_id_6D4E("mp_koth_spawn_allies_start");
    level._id_0405["allies"] = var_18[0].origin;
    level._id_0405["axis"] = var_17[0].origin;
  }
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

  scripts\mp\utility\game::_id_D5FA(6, "free");
}

_id_5EC8() {
  var_0 = level.players;

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = var_0[var_1];

    if(!isDefined(var_2) || istrue(var_2._id_59E0) && var_2 scripts\mp\utility\player::_id_8ACE() || isalive(var_2) && !istrue(var_2._id_59E0)) {
      continue;
    }
    _id_07F9::_id_A8CF(level._id_110CF._id_A908, var_2);
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

  if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_3 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else if(istrue(level._id_FEDC))
    var_3 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");
  else {
    var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF._id_E37A, level._id_110CF._id_5966, "bad", var_2);
  }

  return var_3;
}

_id_6AF0() {
  if(!istrue(level._id_110CF._id_0026)) {
    return 2000;
  } else {
    return 1000;
  }
}

_id_ABA4() {
  self setclientomnvar("ui_hq_norespawn", 0);

  if(isDefined(level._id_110CF) && isDefined(level._id_110CF._id_ADAE) && level._id_110CF._id_ADAE != "neutral") {
    setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::_id_6DCA(level._id_110CF._id_ADAE, "aliveCount"));
  }

  self._id_5EC6 = undefined;
  self._id_DDC7 = undefined;
  thread _id_FCC2();
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

  foreach(var_2 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_timeout", var_2);
  }

  scripts\mp\utility\game::_id_D5FA(9, "free");
  level notify("zone_moved");
  level notify("zone_destroyed");
}

_id_ABB3(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::_id_6DCA(var_0.team, "aliveCount"));
}

_id_9FEA(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::_id_6DCA(var_0._id_916E, "aliveCount"));
}

_id_31E0(var_0) {
  var_1 = level._id_110CF._id_ADAE == var_0.team;
  return !var_1;
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = level._id_110CF._id_ADAE;

  if(!isPlayer(var_1) || var_1.team == self.team) {
    if(var_10 != "neutral") {
      self._id_DDC7 = 1;
    }

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
  if(isDefined(var_4) && scripts\mp\utility\weapon::_id_88F6(var_4.basename)) {
    return;
  }
  var_11 = self;
  var_12 = 0;
  var_13 = var_1.team;

  if(var_10 != "neutral") {
    level _id_FC87(var_10);
  }

  if(var_10 == var_11.team) {
    var_11._id_DDC7 = 1;
  }

  if(level._id_110CF._id_0026) {
    if(level._id_110E0 > 0 && var_1 istouching(level._id_110CF.trigger)) {
      if(var_10 != var_13) {
        var_12 = 1;
      }
    }

    if(var_13 != var_10) {
      if(var_12) {
        var_1 thread _id_0A9F::_id_7003("capture_kill");
      } else if(var_11 istouching(level._id_110CF.trigger)) {
        var_1 thread scripts\mp\rank::_id_CC00("assault");
        var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
      }
    } else if(var_1 istouching(level._id_110CF.trigger)) {
      var_1 thread scripts\mp\rank::_id_CC00("defend");
      var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
      var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
      var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
      var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);
    }
  }

  thread _id_34DE();
}

_id_34DE() {
  if(level._id_110CF._id_ADAE == "neutral") {
    return;
  }
  if(!scripts\mp\utility\teams::_id_6DCA(level._id_110CF._id_ADAE, "aliveCount")) {
    level._id_E3E2[level._id_110CF._id_ADAE]._id_15B5 = 1;
    _id_081A::_id_FD35();
  }
}

_id_FC87(var_0) {
  setomnvar("ui_hq_num_alive", scripts\mp\utility\teams::_id_6DCA(var_0, "aliveCount"));
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
      var_5 thread scripts\mp\rank::_id_CC00("hq_secure");
      var_5 thread _id_07B1::_id_6FB9("mode_hp_secure");
      var_5 thread scripts\mp\s4_quips_mp::triggerquip("quiptrigger_012");

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
      var_5 scripts\mp\utility\stats::_id_D550(var_9.pers["captures"]);
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

    while(var_2 < var_0) {
      waitframe();
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_2 = var_2 + level._id_5F3A;

      if(level._id_FE81) {
        if(level._id_110CF._id_E57B) {
          var_2 = 0.0;
        }
      }
    }

    var_3 = level._id_110CF _id_07D6::_id_6C02();

    if(var_3 == "neutral") {
      continue;
    }
    if(!level._id_FE81) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_3].size;
      }

      scripts\mp\gamescore::_id_7001(var_3, var_1, 0);

      if(!istrue(level._id_CC08)) {
        _id_11A3(var_3);
      }

      continue;
    }

    if(!level._id_110CF._id_E57B && !level.gameended) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_3].size;
      }

      scripts\mp\gamescore::_id_7001(var_3, var_1, 0);
    }
  }
}

_id_11A3(var_0) {
  if(!level._id_AF6F) {
    return;
  }
  var_1 = scripts\mp\gamescore::_id_0C0F(var_0);
  var_2 = scripts\mp\gamescore::_id_0C0F(scripts\mp\utility\game::_id_6BE2(var_0)[0]);

  if(var_1 > var_2) {
    level._id_CC08 = 1;
    level scripts\mp\gamelogic::resumetimer();
  } else
    level scripts\mp\gamelogic::pausetimer();
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
  var_0 setclientomnvar("ui_hq_norespawn", 0);
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

_id_FCC2() {
  level endon("game_ended");

  if(isDefined(level._id_110CF)) {
    if(isDefined(level._id_110CF._id_ADAE)) {
      if(level._id_110CF._id_ADAE == "neutral") {
        self setclientomnvar("ui_match_status_hint_text", 16);
      } else if(level._id_110CF._id_ADAE == self.team) {
        self setclientomnvar("ui_match_status_hint_text", 17);
      } else {
        self setclientomnvar("ui_match_status_hint_text", 29);
      }
    }
  }
}

_id_DCDE() {
  self endon("death_or_disconnect");
  self setclientomnvar("ui_hq_norespawn", 1);
  wait 5;
  self setclientomnvar("ui_hq_norespawn", 0);
}

_id_BA5D(var_0) {
  if(level.mapname == "mp_fallen" && var_0 == "5") {
    return 1;
  }

  return 0;
}

_id_D5AD() {
  level._id_7C8A = "hq_target";
  level._id_7C74 = "hq_neutral";
  level._id_7C42 = "hq_destroy";
  level._id_7C4B = "hq_defend";
  level._id_7C48 = "hq_contested";
  level._id_7C87 = "hq_taking";
  level._id_7C6F = "hq_losing";
  level._id_7C50 = "hq_defending";
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