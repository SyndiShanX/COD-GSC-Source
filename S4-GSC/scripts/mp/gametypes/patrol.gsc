/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\patrol.gsc
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
  var_0[3] = "patrol";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 300);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 200);
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
  level._id_AB8C = ::_id_6CEF;
  level._id_8FA1 = gettime();
  level._id_FE81 = 1;
  level._id_FEF8 = 1;
  level._id_97C9 = 1;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_8FA2 = undefined;
  level._id_BC37 = undefined;
  setomnvar("ui_hq_num_alive", 0);
  setomnvar("ui_hq_ownerteam", -1);
  game["dialog"]["gametype"] = "mp_glob_patr_bchr_in13";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "mp_glob_patr_bchr_in14";
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_hardpoint";
  game["dialog"]["offense_obj"] = "mp_glob_gene_bchr_z251";
  game["dialog"]["defense_obj"] = "mp_glob_gene_bchr_z252";
  game["dialog"]["obj_destroyed"] = "obj_destroyed";
  game["dialog"]["obj_captured"] = "obj_captured";
  game["dialog"]["hp_first"] = "mp_glob_patr_bchr_z196";
  game["dialog"]["hp_new_location"] = "mp_glob_patr_bchr_z196";
  game["dialog"]["hp_captured_enemy"] = "mp_glob_patr_bchr_z198";
  game["dialog"]["hp_captured_friendly"] = "mp_glob_patr_bchr_z197";
  game["dialog"]["hp_contested"] = "mp_glob_patr_bchr_z200";
  game["dialog"]["hp_move_soon"] = "hp_move_soon";
  game["dialog"]["hp_capturing_enemy"] = "hp_capturing_enemy";
  game["dialog"]["hp_capturing_friendly"] = "patrol_secured";
  game["dialog"]["hp_neutral"] = "mp_glob_patr_bchr_z199";
  game["dialog"]["winning"] = "mp_glob_patr_bchr_z201";
  game["dialog"]["winning_time"] = "mp_glob_patr_bchr_z201";
  game["dialog"]["winning_score"] = "mp_glob_patr_bchr_z201";
  game["dialog"]["losing"] = "mp_glob_patr_bchr_z202";
  game["dialog"]["losing_time"] = "mp_glob_patr_bchr_z202";
  game["dialog"]["losing_score"] = "mp_glob_patr_bchr_z202";
  level._id_A5E0 = 1;
  thread _id_10FC8();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3bbf01151ec4391c1", getmatchrulesdata("patrolData", "zoneLifetime"));
  setdynamicdvar("#x3ef9ccd0d588daf39", getmatchrulesdata("patrolData", "zoneCaptureTime"));
  setdynamicdvar("#x3a94ae5fe7e247bb", getmatchrulesdata("patrolData", "firstZoneActivationDelay"));
  setdynamicdvar("#x3f4490aec061e02f5", getmatchrulesdata("patrolData", "zoneActivationDelay"));
  setdynamicdvar("#x3fa845982e7549bf4", getmatchrulesdata("patrolData", "randomLocationOrder"));
  setdynamicdvar("#x36d269b60d6432445", getmatchrulesdata("patrolData", "additiveScoring"));
  setdynamicdvar("#x3d2e99d14e4a42357", getmatchrulesdata("patrolData", "pauseTime"));
  setdynamicdvar("#x3839eafa2e5304952", getmatchrulesdata("patrolData", "delayPlayer"));
  setdynamicdvar("#x33582d7ca6778e40a", getmatchrulesdata("patrolData", "spawnDelay"));
  setdynamicdvar("#x3ed3f1013cc6315d3", getmatchrulesdata("patrolData", "useHQRules"));
  setdynamicdvar("#x3ed45e43380aeb2c", 0);
  scripts\mp\utility\game::_id_C25D("patrol", 0);
}

_id_ABAD() {
  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"OBJECTIVES/PATROL");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/PATROL");
    } else {
      scripts\mp\utility\game::_id_D61A(var_1, &"OBJECTIVES/PATROL_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_1, &"OBJECTIVES/PATROL_HINT");
  }

  if(level._id_CC0E["kill"] > 0) {
    game["dialog"]["offense_obj"] = "boost_groundwar";
    game["dialog"]["defense_obj"] = "boost_groundwar";
  }

  setclientnamemode("auto_change");
  thread patrolpathingfixes();
  level thread _id_D8CC();
  level thread _id_D8CA();
  _id_8294();
  _id_D5D7();
  _id_D5AD();
  level thread _id_74C8();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_110E3 = scripts\mp\utility\dvars::_id_509A("zoneLifetime", 0, 0, 300);
  level._id_110E0 = scripts\mp\utility\dvars::_id_509A("zoneCaptureTime", 0, 0, 30);
  level._id_5BE6 = scripts\mp\utility\dvars::_id_509A("firstZoneActivationDelay", 1, 0, 60);
  level._id_110DE = scripts\mp\utility\dvars::_id_509A("zoneActivationDelay", 0, 0, 60);
  level._id_110E8 = scripts\mp\utility\dvars::_id_509C("randomLocationOrder", 0, 0, 1);
  level._id_110DF = scripts\mp\utility\dvars::_id_509C("additiveScoring", 0, 0, 1);
  level._id_AF6F = scripts\mp\utility\dvars::_id_509C("pauseTime", 1, 0, 1);
  level._id_46D3 = scripts\mp\utility\dvars::_id_509C("delayPlayer", 0, 0, 1);
  level._id_E295 = scripts\mp\utility\dvars::_id_509A("spawnDelay", 0.5, 0, 10);
  level._id_FE83 = scripts\mp\utility\dvars::_id_509C("useHQRules", 0, 0, 1);
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
}

patrolpathingfixes() {
  if(!isDefined(level.mapname)) {
    return;
  }
  if(level.mapname == "mp_gavutu2") {
    var_0 = level._id_EA70["targetname"]["pf0_auto3170"];

    foreach(var_3, var_2 in var_0) {
      if(var_2.target == "pf0_auto3171") {
        var_2._id_0481 = undefined;
        var_2.target = undefined;
        var_2._id_039B = undefined;
        level._id_EA70["targetname"]["pf0_auto3170"] = ::scripts\engine\utility::array_remove(var_0, var_2);
      }
    }
  }
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
  var_1 = _id_6C21();
  var_2 = spawnStruct();
  var_2.player = level._id_110CF;
  var_2._id_56B9 = "hill_moved";
  var_2._id_033E = level._id_110CF.trigger.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_2);
  _id_07D1::_id_60C2("prematch_done");

  if(level._id_AF6F) {
    level scripts\mp\gamelogic::pausetimer();
  }

  setomnvar("ui_objective_timer_stopped", 0);
  var_3 = 1;
  level._id_110E4 = int(gettime() + level._id_5BE6 * 1000);
  setomnvar("ui_hardpoint_timer", level._id_110E4);
  setomnvar("ui_hq_status", 0);
  level._id_110E5 = 1;
  level thread scripts\mp\hud_message::_id_FCBF(undefined, 44, 44);
  level thread _id_1086A();
  level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_5BE6, level._id_110CF._id_4140 + level._id_110CF._id_A97E);

  if(!isDefined(level._id_AEE8)) {
    level._id_AEE8 = spawnStruct();
  }

  _id_FC46();

  if(level._id_5BE6) {
    wait(level._id_5BE6);
  }

  level._id_110E5 = 0;
  level thread scripts\mp\hud_message::_id_FCBF(undefined, 43, 43);
  var_4 = level._id_A8E8["1"]._id_A908;
  _id_07F9::update_objective_showbounds(var_4, 1);
  scripts\mp\utility\game::_id_D5FA(5, "free");
  thread _id_CA6A();

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
    _id_7B1A(var_3, var_0);
    var_0 = 0;
    var_3 = 0;
    setomnvar("ui_hq_status", 10);
    _id_0817::_id_3952();
    _id_7B16();
    var_5 = level._id_110CF _id_07D6::_id_6C02();

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::resumetimer();
    }

    level._id_8FA2 = undefined;
    level._id_110CF _id_8D85();
    level._id_110CF._id_0026 = 0;

    if(istrue(level._id_FE82)) {
      foreach(var_7 in level.players) {
        level._id_110CF scripts\mp\gametypes\obj_zonecapture::_id_7911(var_7);
      }
    }

    level._id_110CF _id_07D6::_id_4AD1();
    level._id_110CF _id_07D6::_id_15DF("none");
    level._id_110CF _id_07D6::_id_D639("neutral");
    _id_FD24("zone_shift", 0);
    level notify("zone_reset");
    setomnvar("ui_hq_status", -1);
    _id_E19F();
    wait 0.5;

    if(level._id_FE83) {
      thread _id_5EC8();
    }

    wait 0.5;
  }
}

_id_1086A() {
  if(istrue(level._id_7E80)) {
    wait 9.5;
  } else {
    wait 7.0;
  }

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_first", var_1, "patrol", undefined, undefined, undefined, 1);
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

_id_6C21() {
  var_0 = scripts\engine\utility::getstructarray("patrol_route_start", "targetname");
  return var_0;
}

_id_D89E() {
  var_0 = _id_6C21();
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0[0].origin);
  self _meth_80DB();
  self linkto(var_1);
  return var_1;
}

_id_CA6A() {
  level endon("game_ended");
  var_0 = _id_6C21();
  var_1 = undefined;
  var_2 = undefined;
  var_3 = undefined;

  if(!isDefined(level._id_AEE8)) {
    level._id_AEE8 = spawnStruct();
  }

  if(getdvarint("#x370d22b460e6a0e3d", 1)) {
    level._id_AEE8._id_110EE = 0;
  } else {
    level._id_AEE8._id_110EE = getdvarint("#x351da7cdb217b9c72", 50);
  }

  _id_D858();
  thread _id_FCD3();
  level._id_110CF.trigger.origin = level._id_AF45.origin;

  if(getdvarint("#x370d22b460e6a0e3d", 1)) {
    thread _id_A130();
  }

  for(;;) {
    if(!isDefined(var_1)) {
      var_1 = var_0[randomint(var_0.size)];

      if(!isDefined(level._id_AEE8.spawngrouparray)) {
        level._id_AEE8.spawngrouparray = findallspawngroups();
      }
    } else
      var_1 = var_2;

    if(isDefined(var_1._id_039B) && var_1._id_039B != "patrol_route" && var_1._id_039B != "patrol_route_start" && !isDefined(var_3) && getdvarint("#x36c624d438ba8277e", 1)) {
      var_4 = scripts\engine\utility::getstruct(var_1.target, "targetname");

      if(isDefined(var_4._id_039B) && var_4._id_039B == var_1._id_039B) {
        var_5 = scripts\engine\utility::getstructarray(var_1._id_039B, "script_noteworthy");
        var_5 = scripts\engine\utility::array_remove(var_5, var_1);
        var_2 = var_5[randomint(var_5.size)];
        var_3 = var_1._id_039B;
      } else {
        var_2 = var_4;

        if(isDefined(var_3)) {
          var_3 = undefined;
        }
      }
    } else if(getDvar("#x33bf51b15e16e3935", "") != "" && isDefined(var_1._id_0481) && var_1._id_0481 == "patrol_route_start") {
      var_2 = scripts\engine\utility::getstruct("pf0_" + getDvar("#x33bf51b15e16e3935", ""), "targetname");
      var_1 = var_2;
    } else {
      var_2 = scripts\engine\utility::getstruct(var_1.target, "targetname");

      if(isDefined(var_3)) {
        var_3 = undefined;
      }
    }

    level._id_AEE8._id_EED5 = var_2.origin;
    var_6 = distance(var_1.origin, var_2.origin);
    var_7 = var_2.origin - var_1.origin;
    var_8 = scripts\engine\utility::_id_5CDB(var_7);

    if(var_8 == (0, 0, 0)) {
      var_9 = 0;
    } else {
      var_9 = scripts\engine\math::_id_178B(var_8, (0, 1, 0));
    }

    if(var_8[0] < 0) {
      var_9 = 360 + var_9 * -1;
    }

    var_9 = var_9 + _func_00B9();
    var_10 = level._id_A8E8["1"]._id_A908;
    _id_07F9::update_objective_setboundsrotation(var_10, int(var_9));
    var_11 = _func_000B(vectortoangles(var_7));
    level._id_AF45 thread rotateentovertime(var_11, 0.5);

    if(getdvarint("#x370d22b460e6a0e3d", 1) && var_6 > 0) {
      if(level._id_AEE8._id_110EE == 0) {
        var_12 = -1;
      } else {
        var_12 = var_6 / level._id_AEE8._id_110EE;
      }

      level._id_AF45 thread _id_AF4B(var_2.origin, var_12);
      _id_FC46();
      level waittill("patrol_next_node");
      continue;
    }

    if(var_6 > 0 && level._id_AEE8._id_110EE > 0) {
      var_12 = var_6 / level._id_AEE8._id_110EE;
      level._id_AF45 moveto(var_2.origin, var_12, 0, 0);
      _id_FC46();
      wait(var_12);
    }
  }
}

rotateentovertime(var_0, var_1) {
  self notify("new_patrol_rotation");
  self endon("new_patrol_rotation");
  var_2 = gettime();
  var_3 = var_2 + var_1 * 1000;
  var_4 = self.angles;
  var_5 = var_2;
  var_6 = undefined;

  while(var_5 < var_3) {
    var_5 = gettime();
    var_7 = var_5 - var_2;
    var_8 = abs(var_4[1] - var_0[1]);

    if(var_8 >= 180) {
      if(var_4[1] > 0 && !isDefined(var_6)) {
        var_6 = var_1 * var_4[1] / (abs(var_0[1]) + var_4[1]);
      } else if(!isDefined(var_6)) {
        var_6 = var_1 * abs(var_4[1]) / (var_0[1] + abs(var_4[1]));
      }

      if(var_6 == 0 || var_7 == 0) {
        waitframe();
        continue;
      }

      if(var_4[1] == 180 && var_0[1] < 0) {
        self.angles = (self.angles[0], -180, self.angles[2]);
        thread rotateentovertime(var_0, var_1);
        break;
      } else if(var_4[1] == -180 && var_0[1] >= 0) {
        self.angles = (self.angles[0], 180, self.angles[2]);
        thread rotateentovertime(var_0, var_1);
        break;
      }

      var_9 = undefined;

      if(var_4[1] > 0) {
        var_9 = (var_0[0], 180, var_0[2]);
      } else {
        var_9 = (var_0[0], -180, var_0[2]);
      }

      var_10 = _func_025E(var_4, var_9, var_7 / (var_6 * 1000));

      if(var_10[1] >= 180) {
        self.angles = (var_10[0], -360 + var_10[1], var_10[2]);
        thread rotateentovertime(var_0, var_1 - var_6);
        break;
      } else if(var_10[1] <= -180) {
        self.angles = (var_10[0], 360 - var_10[1], var_10[2]);
        thread rotateentovertime(var_0, var_1 - var_6);
        break;
      } else
        self.angles = var_10;
    } else {
      var_10 = _func_025E(var_4, var_0, var_7 / (var_1 * 1000));
      self.angles = var_10;
    }

    waitframe();
  }
}

_id_AF4B(var_0, var_1) {
  level notify("patrol_movement_update");
  level endon("patrol_movement_update");
  level endon("game_ended");

  if(var_1 < 0) {
    self moveto(self.origin, 1, 0, 0);
    return;
  }

  var_2 = distance(self.origin, var_0);

  if(var_2 > 1) {
    self moveto(var_0, var_1, 0, 0);
    wait(var_1);
  }

  level notify("patrol_next_node");
}

_id_A130() {
  level endon("game_ended");
  var_0 = level._id_110CF _id_07D6::_id_6C02();
  var_1 = gettime();
  var_2 = getdvarint("#x351da7cdb217b9c72", 50);
  var_3 = getdvarint("#x3f7529e7b6c4bf0b0", 40);
  var_4 = getdvarint("#x3ad06ce81b445b3bf", 30);
  var_5 = getdvarint("#x3e67e90edaee5d501", 10);
  var_6 = getdvarint("#x36bf3abe6ceafe36b", 0);

  for(;;) {
    if(istrue(level._id_110CF.iscontested) && level._id_AEE8._id_110EE != var_5) {
      if(var_5 > 0) {
        var_1 = gettime();
        var_7 = distance(level._id_AF45.origin, level._id_AEE8._id_EED5);
        var_8 = var_7 / var_5;
      } else
        var_8 = -1;

      level._id_AF45 thread _id_AF4B(level._id_AF45.origin, var_8);
      level._id_AEE8._id_110EE = var_5;
    } else if(level._id_110CF._id_ADAE != var_0 && !istrue(level._id_110CF.iscontested)) {
      var_0 = level._id_110CF _id_07D6::_id_6C02();

      if(var_0 == "neutral") {
        if(var_4 > 0) {
          var_1 = gettime();
          var_7 = distance(level._id_AF45.origin, level._id_AEE8._id_EED5);
          var_8 = var_7 / var_4;
        } else
          var_8 = -1;

        level._id_AF45 thread _id_AF4B(level._id_AEE8._id_EED5, var_8);
        level._id_AEE8._id_110EE = var_4;
        waitframe();
        continue;
      } else if(var_6 != 0) {
        var_1 = gettime();
        var_7 = distance(level._id_AF45.origin, level._id_AEE8._id_EED5);
        var_8 = var_7 / var_3;
        level._id_AF45 thread _id_AF4B(level._id_AEE8._id_EED5, var_8);
      }
    } else if(level._id_110CF._id_ADAE != "neutral" && !istrue(level._id_110CF.iscontested)) {
      var_9 = gettime() - var_1;

      if(var_9 < var_6 * 1000) {
        var_10 = 1;

        if(var_6 != 0) {
          var_10 = min(var_9 / (var_6 * 1000), 1);
        }

        level._id_AEE8._id_110EE = var_3 + (var_2 - var_3) * var_10;
        var_7 = distance(level._id_AF45.origin, level._id_AEE8._id_EED5);
        var_8 = var_7 / level._id_AEE8._id_110EE;

        if(var_7 > 1) {
          level._id_AF45 thread _id_AF4B(level._id_AEE8._id_EED5, var_8);
          wait 0.5;
        }
      } else if(level._id_AEE8._id_110EE < var_2 && !istrue(level._id_110CF.iscontested)) {
        var_10 = 1;

        if(var_6 != 0) {
          var_10 = min(var_9 / (var_6 * 1000), 1);
        }

        level._id_AEE8._id_110EE = var_3 + (var_2 - var_3) * var_10;
        var_7 = distance(level._id_AF45.origin, level._id_AEE8._id_EED5);
        var_8 = var_7 / level._id_AEE8._id_110EE;

        if(var_7 > 1) {
          level._id_AF45 thread _id_AF4B(level._id_AEE8._id_EED5, var_8);
          wait 0.5;
        }
      }
    }

    waitframe();
  }
}

_id_FC46() {
  if(getdvarint("#x37eba2de83929edd3", 0) == 1 || getdvarint("#x37eba2de83929edd3", 0) == 3) {
    runhardpointspawns();

    if(getdvarint("#x37eba2de83929edd3", 0) == 1) {
      return;
    }
  } else if(getdvarint("#x37eba2de83929edd3", 0) == 2) {
    runtdmspawns();
    return;
  }

  var_0 = level._id_AEE8.spawngrouparray;
  var_1 = _id_0817::_id_6D4E("mp_patrol_spawn");

  if(!_id_0817::_id_1B0C()) {
    _id_0817::_id_FD32();
  }

  if(!isDefined(var_0)) {
    level._id_AEE8.spawngrouparray = findallspawngroups();
    var_0 = level._id_AEE8.spawngrouparray;
  }

  var_0 = validatespawngrouparray(var_0);
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = getdvarint("#x324547a6b523fcaf9", 1500);
  var_18 = getdvarint("#x3b48b1a580b9adf7a", 2250.0);
  var_19 = getdvarint("#x3def92b7d2d7fd1b8", 5);
  var_20 = findwinningteam();

  if(var_20 == "tie") {
    var_11 = findteamplayerrep(game["attackers"]);
    var_6 = findteamplayerrep(game["defenders"]);
  } else if(var_20 == "allies") {
    var_11 = findteamplayerrep("allies");
    var_6 = findteamplayerrep("axis");
  } else {
    var_11 = findteamplayerrep("axis");
    var_6 = findteamplayerrep("allies");
  }

  foreach(var_22 in var_0) {
    var_23 = level._id_AF45 findspawngroupdist(var_22);

    if(var_23 < var_17 * var_17) {
      continue;
    }
    if(level._id_AF45 isspawnsetinfront(var_22)) {
      if(isDefined(var_6)) {
        var_6 _id_0818::_id_FD31(var_1, 1);
        var_12 = var_6 patrol_checkspawnquality(var_22, var_1);
      } else
        var_12 = 0;

      if(var_23 < var_18) {
        var_12 = var_12 + var_19;
      }

      if(!isDefined(var_2)) {
        var_2 = var_22;
        var_4 = var_23;
        var_13 = var_12;
        continue;
      }

      if(var_12 > var_13) {
        var_3 = var_2;
        var_2 = var_22;
        var_5 = var_4;
        var_4 = var_23;
        var_14 = var_13;
        var_13 = var_12;
      } else if(!isDefined(var_3)) {
        var_3 = var_22;
        var_5 = var_23;
        var_14 = var_12;
      } else if(var_12 > var_14) {
        var_3 = var_22;
        var_5 = var_23;
        var_14 = var_12;
      }

      continue;
    }

    if(isDefined(var_11)) {
      var_11 _id_0818::_id_FD31(var_1, 1);
      var_12 = var_11 patrol_checkspawnquality(var_22, var_1);
    } else
      var_12 = 0;

    if(var_23 < var_18) {
      var_12 = var_12 + var_19;
    }

    if(!isDefined(var_7)) {
      var_7 = var_22;
      var_9 = var_23;
      var_15 = var_12;
      continue;
    }

    if(var_12 > var_15) {
      var_8 = var_7;
      var_7 = var_22;
      var_10 = var_9;
      var_9 = var_23;
      var_16 = var_15;
      var_15 = var_12;
      continue;
    }

    if(!isDefined(var_8)) {
      var_8 = var_22;
      var_10 = var_23;
      var_16 = var_12;
      continue;
    }

    if(var_12 > var_16) {
      var_8 = var_22;
      var_10 = var_23;
      var_16 = var_12;
    }
  }

  var_25 = undefined;

  if(!isDefined(var_2)) {
    var_25 = findalternatespawnset(var_7, var_8, var_3, var_6);
    var_2 = var_25;
  }

  if(!isDefined(var_7) || isDefined(var_2) && var_7 == var_2 || isDefined(var_3) && var_7 == var_3) {
    var_25 = findalternatespawnset(var_2, var_3, var_8, var_11);
    var_7 = var_25;
  }

  if(!isDefined(var_3) || isDefined(var_2) && var_3 == var_2 || isDefined(var_7) && var_3 == var_7 || isDefined(var_8) && var_3 == var_8) {
    var_25 = findalternatespawnset(var_7, var_8, var_2, var_6);
    var_3 = var_25;
  }

  if(!isDefined(var_8) || isDefined(var_7) && var_8 == var_7 || isDefined(var_2) && var_8 == var_2 || isDefined(var_3) && var_8 == var_3) {
    var_25 = findalternatespawnset(var_2, var_3, var_7, var_11);
    var_8 = var_25;
  }

  thread setupnewspawnsets(var_7, var_8, var_2, var_3);
}

setupnewspawnsets(var_0, var_1, var_2, var_3) {
  level notify("setupNewSpawnSets");
  level endon("setupNewSpawnSets");
  var_4 = getdvarfloat("#x31016689a6ad8c858", 10.0);
  var_5 = level._id_110CF.winningspawnset;
  var_6 = level._id_110CF.winningfallbackspawnset;
  var_7 = level._id_110CF.losingspawnset;
  var_8 = level._id_110CF.losingfallbackspawnset;

  if(!isDefined(var_5) || !isDefined(var_7)) {
    level._id_110CF.winningspawnset = "patrol_" + var_0;
    level._id_110CF.winningfallbackspawnset = "patrol_fallback_" + var_1;
    level._id_110CF.losingspawnset = "patrol_" + var_2;
    level._id_110CF.losingfallbackspawnset = "patrol_fallback_" + var_3;
  } else {
    if(var_2 == var_5 && var_0 == var_7) {
      return;
    }
    if(var_2 == var_5) {
      level._id_110CF.winningspawnset = "patrol_" + var_0;
      level._id_110CF.winningfallbackspawnset = "patrol_fallback_" + var_1;
      wait(var_4);
      level._id_110CF.losingspawnset = "patrol_" + var_2;
      level._id_110CF.losingfallbackspawnset = "patrol_fallback_" + var_3;
    } else {
      if(var_0 == var_7) {
        level._id_110CF.losingspawnset = "patrol_" + var_2;
        level._id_110CF.losingfallbackspawnset = "patrol_fallback_" + var_3;
        wait(var_4);
        level._id_110CF.winningspawnset = "patrol_" + var_0;
        level._id_110CF.winningfallbackspawnset = "patrol_fallback_" + var_1;
        return;
      }

      level._id_110CF.winningspawnset = "patrol_" + var_0;
      level._id_110CF.winningfallbackspawnset = "patrol_fallback_" + var_1;
      level._id_110CF.losingspawnset = "patrol_" + var_2;
      level._id_110CF.losingfallbackspawnset = "patrol_fallback_" + var_3;
    }
  }
}

findallspawngroups(var_0) {
  var_1 = _id_0817::_id_6D4E("mp_patrol_spawn");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4._id_039B;

    if(!scripts\engine\utility::array_contains(var_2, var_5)) {
      var_2[var_2.size] = var_5;
    }
  }

  if(!isDefined(var_0) || !var_0) {
    var_2 = validatespawngrouparray(var_2);
  }

  return var_2;
}

validatespawngrouparray(var_0) {
  foreach(var_2 in var_0) {
    var_3 = 1;

    foreach(var_6, var_5 in level._id_E2F4._id_E37C) {
      if(var_6 == "patrol_" + var_2) {
        var_3 = 0;
        break;
      }
    }

    if(var_3) {
      var_0 = scripts\engine\utility::array_remove(var_0, var_2);
    }
  }

  return var_0;
}

patrol_checkspawnquality(var_0, var_1) {
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4._id_039B == var_0) {
      var_5 = _id_0818::_id_F0D4(var_4);

      if(var_5 == "primary") {
        var_2 = var_2 + 2;
      } else if(var_5 == "secondary") {
        var_2 = var_2 + 1;
      }
    }
  }

  return var_2;
}

findwinningteam() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_4, var_3 in game["teamScores"]) {
    if(!isDefined(var_0)) {
      var_0 = var_4;
      var_1 = var_3;
      continue;
    }

    if(var_3 == var_1) {
      return "tie";
    } else if(var_3 > var_1) {
      return var_4;
    } else {
      return var_0;
    }
  }
}

findteamplayerrep(var_0) {
  foreach(var_2 in level.players) {
    if(var_2.team == var_0) {
      return var_2;
    }
  }
}

isspawnsetinfront(var_0) {
  var_1 = _id_0817::_id_6D4E("mp_patrol_spawn");

  foreach(var_3 in var_1) {
    if(var_3._id_039B == var_0) {
      return scripts\engine\math::_id_867F(var_3.origin);
    }
  }

  return 0;
}

findspawngroupdist(var_0) {
  var_1 = _id_0817::_id_6D4E("mp_patrol_spawn");
  var_2 = undefined;
  var_3 = 0;
  var_4 = 0;

  foreach(var_6 in var_1) {
    if(var_6._id_039B == var_0) {
      var_3 = var_3 + distancesquared(self.origin, var_6.origin);
      var_4++;
    }
  }

  var_2 = var_3 / var_4;
  return var_2;
}

findalternatespawnset(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  var_8 = undefined;
  var_9 = undefined;
  var_10 = undefined;
  var_11 = undefined;
  var_12 = undefined;
  var_13 = undefined;
  var_14 = getdvarint("#x324547a6b523fcaf9", 1500);
  var_15 = getdvarint("#x3b48b1a580b9adf7a", 2250.0);
  var_16 = getdvarint("#x3def92b7d2d7fd1b8", 5);
  var_17 = _id_0817::_id_6D4E("mp_patrol_spawn");
  var_18 = level._id_AEE8.spawngrouparray;

  if(isDefined(var_3)) {
    var_3 _id_0818::_id_FD31(var_17, 1);
  }

  if(!isDefined(var_18)) {
    level._id_AEE8.spawngrouparray = findallspawngroups();
    var_18 = level._id_AEE8.spawngrouparray;
  }

  if(!isDefined(var_0)) {
    var_0 = var_18[0];
  }

  if(!isDefined(var_1)) {
    var_1 = var_0;
  }

  if(!isDefined(var_2)) {
    var_2 = var_0;
  }

  foreach(var_20 in var_17) {
    if(var_20._id_039B == var_0) {
      var_4 = var_20.origin;
      break;
    }
  }

  foreach(var_23 in var_18) {
    if(var_23 == var_0 || var_23 == var_1 || var_23 == var_2) {
      continue;
    }
    if(isDefined(var_3)) {
      var_6 = var_3 patrol_checkspawnquality(var_23, var_17);
    }

    var_24 = level._id_AF45 findspawngroupdist(var_23);

    if(!isDefined(var_13) || var_12 < var_24) {
      var_13 = var_23;
      var_12 = var_24;
    }

    if(!isDefined(var_11) || var_24 < var_10 && var_10 > var_14 * var_14 / 2) {
      var_10 = var_24;
      var_11 = var_23;
    }

    if(var_24 < var_14 * var_14) {
      continue;
    }
    if(isDefined(var_3) && var_24 < var_15) {
      var_6 = var_6 + var_16;
    }

    if(!isDefined(var_7)) {
      var_7 = var_23;
      var_8 = var_24;

      if(isDefined(var_6)) {
        var_9 = var_6;
      }

      continue;
    }

    if(isDefined(var_6) && var_6 > var_9 || !isDefined(var_6) && var_24 < var_8) {
      var_7 = var_23;
      var_8 = var_24;

      if(isDefined(var_6)) {
        var_9 = var_6;
      }
    }
  }

  if(!isDefined(var_7) && isDefined(var_11)) {
    var_7 = var_11;
  } else if(!isDefined(var_7)) {
    var_7 = var_13;
  }

  return var_7;
}

runhardpointspawns() {
  var_0 = undefined;
  var_1 = undefined;

  foreach(var_3 in level._id_74C9) {
    var_4 = distancesquared(var_3.origin, level._id_110CF.trigger.origin);

    if(!isDefined(var_0) || !isDefined(var_1) || var_4 < var_1) {
      var_1 = var_4;
      var_0 = var_3;
    }
  }

  level._id_110CF._id_E37A = var_0._id_E37A;
  level._id_110CF._id_5966 = var_0._id_5966;
}

runtdmspawns() {}

_id_D858() {
  foreach(var_1 in level._id_110CF._id_3572) {
    var_1 _meth_80DB();
    var_1 linkto(level._id_AF45);
  }
}

_id_FCD3() {
  level endon("game_ended");
  var_0 = level._id_110CF._id_A908;
  _id_07F9::_id_FB93(var_0, level._id_AF45);
  _id_07F9::_id_FB9D(var_0, 100);
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
      _id_0A8D::_id_E775("obj_generic_capture", var_3, "patrol", undefined, undefined, undefined, 1);
    }
  } else {
    foreach(var_3 in level._id_EF89) {
      _id_0A8D::_id_E775("hp_new_location", var_3, "patrol", undefined, undefined, undefined, 1);
    }
  }

  level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_74C7();
  level._id_110CF _id_07D6::_id_15DF("none");

  if(istrue(var_0)) {} else if(level._id_110DE) {
    level._id_110CF _id_07D6::_id_D61B(level._id_7C8A);
    _id_FD24("zone_activation_delay", 0);
    level._id_110E4 = int(gettime() + 1000 * level._id_110DE);
    setomnvar("ui_hardpoint_timer", level._id_110E4);
    setomnvar("ui_hq_status", 12);

    if(level._id_AF6F) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level._id_110E5 = 1;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 44, 44);
    level._id_110CF thread scripts\mp\gametypes\obj_zonecapture::_id_96F8(level._id_110DE, level._id_110CF._id_4140 + level._id_110CF._id_A97E);
    wait(level._id_110DE);
    level._id_110E5 = 0;
    level thread scripts\mp\hud_message::_id_FCBF(undefined, 43, 43);
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
    _id_0AA2::_id_B8F1("ui_mp_patrol_point_controlled", var_1);
    _id_0AA2::_id_B8F1("ui_mp_patrol_point_lost", scripts\mp\utility\game::_id_6BE2(var_1)[0]);

    if(level._id_FE83 && level._id_110E3 > 0) {
      thread _id_A27F(level._id_110E3);
    }

    level waittill("zone_destroyed", var_2);

    if(isDefined(var_2)) {
      level._id_110CF _id_07D6::_id_D639(var_2);
    } else {
      level._id_110CF _id_07D6::_id_D639("none");
      level thread playneutralvo();
    }

    if(level._id_FE83) {
      setomnvar("ui_hq_status", -1);
      break;
    }
  }
}

playneutralvo() {
  level endon("zone_captured");
  level endon("game_ended");
  wait 10.0;

  foreach(var_1 in level._id_EF89) {
    _id_0A8D::_id_E775("hp_neutral", var_1, "patrol", undefined, undefined, undefined, 1);
  }
}

_id_8294() {
  _id_0817::_id_D461("Default", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  var_0 = getdvarint("#x37eba2de83929edd3", 0);
  _id_0817::_id_113A("mp_patrol_spawn_allies_start");
  _id_0817::_id_113A("mp_patrol_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_patrol_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_patrol_spawn_axis_start");
  var_1 = _id_0817::_id_6D4E("mp_patrol_spawn_allies_start");
  var_2 = _id_0817::_id_6D4E("mp_patrol_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_1);
  _id_0817::_id_C2B9("start_defenders", var_2);

  if(var_0 == 1 || var_0 == 3) {
    _id_0817::_id_1136("allies", "mp_koth_spawn", 1);
    _id_0817::_id_1136("axis", "mp_koth_spawn", 1);
    _id_0817::_id_1136("allies", "mp_koth_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_koth_spawn_secondary", 1, 1);
  }

  if(!isDefined(level._id_E34D) || istrue(level._id_11A9) || var_0 == 2) {
    _id_0817::_id_1136("allies", "mp_tdm_spawn");
    _id_0817::_id_1136("axis", "mp_tdm_spawn");
    _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
    var_3 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_4 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
    _id_0817::_id_C2B9("normal", var_3);
    _id_0817::_id_C2B9("fallback", var_4);
  }

  if(var_0 == 0 || var_0 == 3) {
    _id_0817::_id_1136("allies", "mp_patrol_spawn", 1);
    _id_0817::_id_1136("axis", "mp_patrol_spawn", 1);
    _id_0817::_id_1136("allies", "mp_patrol_spawn_secondary", 1, 1);
    _id_0817::_id_1136("axis", "mp_patrol_spawn_secondary", 1, 1);
  }

  var_5 = findallspawngroups();
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  if(istrue(level._id_11A9)) {
    return;
  }
  foreach(var_7 in level._id_A8E8) {
    var_7._id_6041 = 0;
    var_7._id_E34D = [];
    var_7._id_5965 = [];
  }

  if(var_0 == 1 || var_0 == 3) {
    foreach(var_7 in level._id_74C9) {
      var_7._id_6041 = 0;
      var_7._id_E34D = [];
      var_7._id_5965 = [];
    }
  }

  foreach(var_12 in level.patrolspawnsets) {
    var_12._id_6041 = 0;
    var_12._id_E34D = [];
    var_12._id_5965 = [];
  }

  foreach(var_15 in level._id_E34D) {
    _id_2EFC(var_15);
    var_16 = _id_0817::_id_6BDE(var_15);

    if(isDefined(level._id_8E3C) && isDefined(level._id_8E3C[var_16])) {
      foreach(var_18 in level._id_8E3C[var_16]) {
        var_7 = level._id_A8E8[var_18];
        var_7._id_E34D[var_7._id_E34D.size] = var_15;
      }
    }

    var_20 = 0;
    var_21 = var_15.classname == "mp_patrol_spawn_allies_start" || var_15.classname == "mp_patrol_spawn_axis_start";
    var_22 = var_15.classname == "mp_patrol_spawn";
    var_23 = var_15.classname == "mp_patrol_spawn_secondary";
    var_24 = var_15.classname == "mp_koth_spawn";
    var_25 = var_15.classname == "mp_koth_spawn_secondary";

    if(var_21) {
      continue;
    }
    if(level.mapname == "mp_jalo_oasis") {
      if(var_25) {
        continue;
      }
    }

    if(var_22 || var_23) {
      if(isDefined(var_15._id_039B) && var_15._id_039B != "") {
        var_20 = 1;
        var_26 = strtok(var_15._id_039B, " ");

        foreach(var_18 in var_26) {
          if(!_id_BA5D(var_18)) {
            var_7 = level._id_A8E8[var_18];

            if(isDefined(var_7) && var_22) {
              var_7._id_E34D[var_7._id_E34D.size] = var_15;
            } else if(isDefined(var_7)) {
              var_7._id_5965[var_7._id_5965.size] = var_15;
            }

            var_12 = level.patrolspawnsets[var_18];

            if(isDefined(var_12) && var_22) {
              var_12._id_E34D[var_12._id_E34D.size] = var_15;
              continue;
            }

            if(isDefined(var_12)) {
              var_12._id_5965[var_12._id_5965.size] = var_15;
            }
          }
        }
      }
    }

    if(var_24 || var_25) {
      if(isDefined(var_15._id_039B) && var_15._id_039B != "") {
        var_20 = 1;
        var_26 = strtok(var_15._id_039B, " ");

        foreach(var_18 in var_26) {
          if(!_id_BA5D(var_18)) {
            var_7 = level._id_A8E8[var_18];

            if(isDefined(var_7) && var_24) {
              var_7._id_E34D[var_7._id_E34D.size] = var_15;
            } else if(isDefined(var_7)) {
              var_7._id_5965[var_7._id_5965.size] = var_15;
            }

            var_30 = level._id_74C9[var_18];

            if(isDefined(var_30) && var_24) {
              var_30._id_E34D[var_30._id_E34D.size] = var_15;
            } else if(isDefined(var_30)) {
              var_30._id_5965[var_30._id_5965.size] = var_15;
            }
          }
        }
      }
    }

    if(!var_20 && var_0 != 2) {
      foreach(var_7 in level._id_A8E8) {
        if(var_22 || var_24) {
          var_7._id_E34D[var_7._id_E34D.size] = var_15;
          continue;
        }

        var_7._id_5965[var_7._id_5965.size] = var_15;
      }

      foreach(var_12 in level.patrolspawnsets) {
        if(var_22) {
          var_12._id_E34D[var_12._id_E34D.size] = var_15;
          continue;
        }

        var_12._id_5965[var_12._id_5965.size] = var_15;
      }

      if(var_0 == 1 || var_0 == 3) {
        foreach(var_7 in level._id_74C9) {
          if(var_24) {
            var_7._id_E34D[var_7._id_E34D.size] = var_15;
            continue;
          }

          var_7._id_5965[var_7._id_5965.size] = var_15;
        }
      }
    }
  }

  if(var_0 == 1 || var_0 == 3) {
    foreach(var_40, var_7 in level._id_A8E8) {
      var_7._id_E37A = "koth_" + var_40;
      var_7._id_5966 = "koth_fallback_" + var_40;
    }

    foreach(var_40, var_7 in level._id_74C9) {
      var_7._id_E37A = "koth_" + var_40;
      _id_0817::_id_C2B9(var_7._id_E37A, var_7._id_E34D);
      var_7._id_5966 = "koth_fallback_" + var_40;
      _id_0817::_id_C2B9(var_7._id_5966, var_7._id_5965);
    }
  }

  if(var_0 == 0 || var_0 == 3) {
    foreach(var_40, var_7 in level._id_A8E8) {
      var_7._id_E37A = "patrol_" + var_40;
      var_7._id_5966 = "patrol_fallback_" + var_40;
    }

    foreach(var_40, var_44 in level.patrolspawnsets) {
      if(level._id_E2F4._id_E37C.size >= 32) {
        continue;
      }
      var_44._id_E37A = "patrol_" + var_40;
      _id_0817::_id_C2B9(var_44._id_E37A, var_44._id_E34D);
      var_44._id_5966 = "patrol_fallback_" + var_40;
      _id_0817::_id_C2B9(var_44._id_5966, var_44._id_5965);
    }
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
  var_0 = _id_6EA6("patrol_zone");
  var_1 = [];
  var_1[var_1.size] = var_0[0];
  level._id_AF45 = var_1[0] _id_D89E();
  level._id_A8E8 = [];
  var_2 = scripts\mp\gametypes\obj_zonecapture::_id_D896(var_1[0]);
  level._id_A8E8[var_2._id_A8E1] = var_2;
  var_3 = _id_0817::_id_6D4E("mp_patrol_spawn_axis_start");
  var_4 = _id_0817::_id_6D4E("mp_patrol_spawn_allies_start");
  level._id_0405["allies"] = var_4[0].origin;
  level._id_0405["axis"] = var_3[0].origin;
  level.patrolspawnsets = [];
  var_5 = findallspawngroups(1);

  foreach(var_7 in var_5) {
    level.patrolspawnsets[var_7] = spawnStruct();
  }

  if(getdvarint("#x37eba2de83929edd3", 0) == 1 || getdvarint("#x37eba2de83929edd3", 0) == 3) {
    level._id_74C9 = [];
    var_9 = _id_6EA6("hardpoint_zone");

    foreach(var_11 in var_9) {
      level._id_74C9[var_11._id_A8E1] = var_11;
    }
  }

  setdynamicdvar("#x39d926b5216be9575", var_1[0]._id_0359);
  return 1;
}

_id_D8CA() {
  level._id_A437 = [];
  level._id_3BEF = [];
  level._id_5FC0 = [];
  level._id_5434 = [];
  var_0 = _id_6EA6("patrol_zone_visual");
  var_1 = _id_6EA6("patrol_zone_visual_contest");
  var_2 = _id_6EA6("patrol_zone_visual_friend");
  var_3 = _id_6EA6("patrol_zone_visual_enemy");

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

    if(getdvarint("#x37eba2de83929edd3", 0) == 1) {
      var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF._id_E37A, level._id_110CF._id_5966, "bad", var_2);
    } else if(getdvarint("#x37eba2de83929edd3", 0) == 2) {
      var_3 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback", "bad", var_2);
    } else if(var_0 == game["attackers"]) {
      if(getdvarint("#x37eba2de83929edd3", 0) == 3) {
        if(var_0 == level._id_10A24 || level._id_10A24 == "none") {
          var_3 = _id_0817::_id_6D4A(self, var_0, [level._id_110CF.winningspawnset, level._id_110CF._id_E37A], [level._id_110CF.winningfallbackspawnset, level._id_110CF._id_5966], "bad", var_2);
        } else {
          var_3 = _id_0817::_id_6D4A(self, var_0, [level._id_110CF.losingspawnset, level._id_110CF._id_E37A], [level._id_110CF.losingfallbackspawnset, level._id_110CF._id_5966], "bad", var_2);
        }
      } else if(var_0 == level._id_10A24 || level._id_10A24 == "none")
        var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF.winningspawnset, level._id_110CF.winningfallbackspawnset, "bad", var_2);
      else {
        var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF.losingspawnset, level._id_110CF.losingfallbackspawnset, "bad", var_2);
      }
    } else if(getdvarint("#x37eba2de83929edd3", 0) == 3) {
      if(var_0 == level._id_10A24) {
        var_3 = _id_0817::_id_6D4A(self, var_0, [level._id_110CF.winningspawnset, level._id_110CF._id_E37A], [level._id_110CF.winningfallbackspawnset, level._id_110CF._id_5966], "bad", var_2);
      } else {
        var_3 = _id_0817::_id_6D4A(self, var_0, [level._id_110CF.losingspawnset, level._id_110CF._id_E37A], [level._id_110CF.losingfallbackspawnset, level._id_110CF._id_5966], "bad", var_2);
      }
    } else if(var_0 == level._id_10A24)
      var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF.winningspawnset, level._id_110CF.winningfallbackspawnset, "bad", var_2);
    else {
      var_3 = _id_0817::_id_6D4A(self, var_0, level._id_110CF.losingspawnset, level._id_110CF.losingfallbackspawnset, "bad", var_2);
    }
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
  var_12 = var_1.team;

  if(var_12 != var_10) {
    if(var_11 istouching(level._id_110CF.trigger)) {
      var_1 thread scripts\mp\rank::_id_CC00("assault");
      var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
      var_1 scripts\mp\utility\stats::_id_7DAE("assaults", 1);
      var_1 scripts\mp\persistence::_id_E770("round", "assaults", var_1.pers["assaults"]);
      var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["assaults"]);

      if(getdvarint("#x384c945dc7e18a88b", 0)) {
        scripts\mp\gamescore::_id_7001(var_1.team, getdvarint("#x337a6e8fc65438c5f", 1), 0);
      }
    }
  } else if(var_1 istouching(level._id_110CF.trigger)) {
    var_1 thread scripts\mp\rank::_id_CC00("defend");
    var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
    var_1 scripts\mp\utility\stats::_id_D551(var_1.pers["defends"]);

    if(getdvarint("#x3708031b7d8feb0a2", 0)) {
      scripts\mp\gamescore::_id_7001(var_1.team, getdvarint("#x337a6e8fc65438c5f", 1), 0);
    }
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
    if(!_id_8A15(var_5)) {
      var_6 = spawnStruct();
      var_6.player = var_5;
      var_6._id_56B9 = "capture";
      var_6._id_033E = var_5.origin;
      _id_06E2::_id_4C2A("callback_on_game_event", var_6);
      var_5 thread scripts\mp\rank::_id_CC00("patrol_secure");
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

  if(level._id_110DF) {
    var_0 = 2;
  } else {
    var_0 = 1;
  }

  var_1 = 1;
  var_2 = [2, 3, 4];

  while(!level.gameended) {
    var_3 = 0.0;

    while(var_3 < var_0 && !level.gameended) {
      wait(level._id_5F3A);
      scripts\mp\hostmigration::waittillhostmigrationdone();
      var_3 = var_3 + level._id_5F3A;

      if(level._id_110CF._id_E57B) {
        var_3 = 0.0;
      }
    }

    var_4 = level._id_110CF _id_07D6::_id_6C02();

    if(var_4 == "neutral") {
      continue;
    }
    if(level.gameended) {
      break;
    }

    if(level._id_FE83) {
      if(level._id_110DF) {
        var_1 = level._id_110CF._id_F396[var_4].size;
      }

      scripts\mp\gamescore::_id_7001(var_4, var_1, 0);
      continue;
    }

    if(!level._id_110CF._id_E57B && !level.gameended) {
      if(level._id_110DF) {
        var_5 = min(level._id_110CF._id_F396[var_4].size, var_2.size);
        var_1 = var_2[int(var_5 - 1)];
      }

      scripts\mp\gamescore::_id_7001(var_4, var_1, 0);

      foreach(var_7 in level._id_110CF._id_F396[var_4]) {
        var_7.player scripts\mp\utility\stats::_id_7DAE("objTime", 1);
        var_7.player thread on_patrol_1minute();

        if(isDefined(var_7.player._id_F208[level._id_8E3D])) {
          var_7.player._id_F208[level._id_8E3D]++;
        } else {
          var_7.player._id_F208[level._id_8E3D] = 1;
        }

        var_7.player scripts\mp\persistence::_id_E770("round", "objTime", var_7.player.pers["objTime"]);
        var_7.player scripts\mp\utility\stats::_id_D550(var_7.player.pers["objTime"]);
        var_7.player scripts\mp\gamescore::_id_6FCF("koth_in_obj", 10);
      }
    }
  }
}

on_patrol_1minute() {
  level endon("game_ended");

  if(isDefined(self.pers["patrol_counter_started"]) && self.pers["patrol_counter_started"]) {
    return;
  } else {
    self.pers["patrol_counter_started"] = 1;
  }

  while(isDefined(self.pers["objTime"]) && self.pers["objTime"] < 60) {
    wait 1;
  }

  thread _id_07BC::creategametypechallenegeevent("patrol_1min");
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
  scripts\mp\gamelogic::_id_D8E5("koth_destroy", 0, "enemy", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_defend", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_defending", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFENDING_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_neutral", 0, "neutral", "MP_INGAME_ONLY/OBJ_CAPTURE_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_contested", 0, "contest", "MP_INGAME_ONLY/OBJ_CONTESTED_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_losing", 0, "enemy", "MP_INGAME_ONLY/OBJ_LOSING_CAPS", "icon_waypoint_koth", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_target", 0, "neutral", "MP_INGAME_ONLY/OBJ_TARGET_CAPS", "icon_waypoint_locked", 0);
  scripts\mp\gamelogic::_id_D8E5("koth_taking", 0, "friendly", "MP_INGAME_ONLY/OBJ_DESTROYING_CAPS", "icon_waypoint_koth", 1);
}

_id_FCC2() {
  level endon("game_ended");

  if(istrue(level._id_110E5)) {
    self setclientomnvar("ui_match_status_hint_text", 44);
  } else {
    self setclientomnvar("ui_match_status_hint_text", 43);
  }
}