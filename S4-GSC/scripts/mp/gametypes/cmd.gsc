/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cmd.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = "cop";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 1200);

    if(1) {
      scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 5);
    } else {
      scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 0);
    }

    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_D635(300);
  }

  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_4A82 = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_ABC0 = ::_id_ABC0;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  level._id_8FA1 = gettime();
  level._id_C650 = scripts\mp\gametypes\obj_bombzone::_id_C650;
  level._id_150E = [];
  level._id_1FE3 = [];
  level._id_3A0E = "neutral";
  level._id_3A0F = "neutral";
  level._id_F263 = 0;
  level._id_5856 = 0;
  game["dialog"]["gametype"] = "intro_start";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["bomb_achieve"] = "bomb_achieve";
  game["dialog"]["bomb_taken"] = "bomb_taken";
  game["dialog"]["bomb_lost"] = "bomb_enemyowns";
  game["dialog"]["bomb_defusing"] = "bomb_enemydefusing";
  game["dialog"]["bomb_defused"] = "bomb_defused";
  game["dialog"]["bomb_planted"] = "bomb_planted";
  game["dialog"]["enemy_bomb_a"] = "bomb_enemy_a";
  game["dialog"]["enemy_bomb_b"] = "bomb_enemy_b";
  game["dialog"]["enemy_bomb_defused"] = "bomb_enemydefused";
  game["dialog"]["enemy_bomb_planted"] = "bomb_enemyplanted";
  game["dialog"]["offense_obj"] = "cop_obj_clock";
  game["dialog"]["defense_obj"] = "cop_obj_clock";
  game["dialog"]["cop_obj_0_mp_faridah"] = "obj_embassy";
  game["dialog"]["cop_obj_0_attack_mp_faridah"] = "embassy_attack";
  game["dialog"]["cop_obj_0_mp_euphrates"] = "obj_compound";
  game["dialog"]["cop_obj_0_attack_mp_euphrates"] = "compound_attack";
  game["dialog"]["cop_obj_1_mp_faridah"] = "obj_school";
  game["dialog"]["cop_obj_1_attack_mp_faridah"] = "school_attack";
  game["dialog"]["cop_obj_1_defend_mp_faridah"] = "school_defend";
  game["dialog"]["cop_obj_1_enemy_cap_mp_faridah"] = "school_enemycapture";
  game["dialog"]["cop_obj_1_enemy_hold_mp_faridah"] = "school_enemycaptured";
  game["dialog"]["cop_obj_1_mp_euphrates"] = "obj_buses";
  game["dialog"]["cop_obj_1_attack_mp_euphrates"] = "buses_attack";
  game["dialog"]["cop_obj_1_defend_mp_euphrates"] = "buses_defend";
  game["dialog"]["cop_obj_1_enemy_cap_mp_euphrates"] = "buses_enemycapture";
  game["dialog"]["cop_obj_1_enemy_hold_mp_euphrates"] = "buses_enemycaptured";
  game["dialog"]["cop_obj_2_mp_faridah"] = "obj_clock";
  game["dialog"]["cop_obj_2_attack_mp_faridah"] = "clock_attack";
  game["dialog"]["cop_obj_2_defend_mp_faridah"] = "clock_defend";
  game["dialog"]["cop_obj_2_mp_euphrates"] = "obj_underpass";
  game["dialog"]["cop_obj_2_attack_mp_euphrates"] = "underpass_attack";
  game["dialog"]["cop_obj_2_defend_mp_euphrates"] = "underpass_defend";
  game["dialog"]["cop_obj_2_enemy_cap_mp_euphrates"] = "underpass_enemycapture";
  game["dialog"]["cop_obj_2_enemy_hold_mp_euphrates"] = "underpass_enemycaptured";
  game["dialog"]["cop_obj_3_mp_faridah"] = "obj_warehouse";
  game["dialog"]["cop_obj_3_attack_mp_faridah"] = "warehouse_attack";
  game["dialog"]["cop_obj_3_defend_mp_faridah"] = "warehouse_defend";
  game["dialog"]["cop_obj_3_enemy_cap_mp_faridah"] = "warehouse_enemycapture";
  game["dialog"]["cop_obj_3_enemy_hold_mp_faridah"] = "warehouse_enemycaptured";
  game["dialog"]["cop_obj_3_mp_euphrates"] = "obj_construction";
  game["dialog"]["cop_obj_3_attack_mp_euphrates"] = "construction_attack";
  game["dialog"]["cop_obj_3_defend_mp_euphrates"] = "construction_defend";
  game["dialog"]["cop_obj_3_enemy_cap_mp_euphrates"] = "construction_enemycapture";
  game["dialog"]["cop_obj_3_enemy_hold_mp_euphrates"] = "construction_enemycaptured";
  game["dialog"]["cop_obj_4_mp_faridah"] = "obj_compound";
  game["dialog"]["cop_obj_4_defend_mp_faridah"] = "compound_defend";
  game["dialog"]["cop_obj_4_mp_euphrates"] = "obj_fob";
  game["dialog"]["cop_obj_4_attack_mp_euphrates"] = "fob_attack";
  game["dialog"]["cop_obj_4_defend_mp_euphrates"] = "fob_defend";
  game["dialog"]["cop_target_active"] = "gamestate_targetactive";
  game["dialog"]["cop_obj_contested"] = "obj_contested";
  game["dialog"]["cop_enemy_sec"] = "enemy_capturingneutral";
  game["dialog"]["cop_hold"] = "confirm_copsecurewait";
  game["dialog"]["cop_outpostcaptured"] = "confirm_copsecureyes";
  game["dialog"]["cop_bombplanted_atenemy"] = "bombplanted_atenemycop";
  game["dialog"]["cop_bombplanted_atfriendly"] = "bombplanted_atfriendlycop";
  game["dialog"]["cop_bombdefused"] = "compound_bombdefused";
  game["dialog"]["sitrep_0_mp_faridah"] = "sitrep_embspawn";
  game["dialog"]["sitrep_1_mp_faridah"] = "sitrep_schoolspawn";
  game["dialog"]["sitrep_2_mp_faridah"] = "sitrep_clockspawn";
  game["dialog"]["sitrep_3_mp_faridah"] = "sitrep_whspawn";
  game["dialog"]["sitrep_4_mp_faridah"] = "sitrep_comspawn";
  game["dialog"]["sitrep_0_mp_euphrates"] = "sitrep_comspawn";
  game["dialog"]["sitrep_1_mp_euphrates"] = "sitrep_busesspawn";
  game["dialog"]["sitrep_2_mp_euphrates"] = "sitrep_undspawn";
  game["dialog"]["sitrep_3_mp_euphrates"] = "sitrep_constspawn";
  game["dialog"]["sitrep_4_mp_euphrates"] = "sitrep_fobspawn";
  game["dialog"]["cop_order_attack"] = "order_attack";
  game["dialog"]["cop_order_fallback"] = "order_fallback";
  game["dialog"]["cop_killstreak_bradley"] = "killstreak_bradley";
  game["dialog"]["cop_enemy_bradley"] = "enemy_bradley";
  game["dialog"]["cop_hostage_located"] = "hostage_located";
  game["dialog"]["cop_hostage_extraction"] = "hostage_extraction";
  game["dialog"]["cop_breach_plant"] = "breach_plant";
  thread _id_AAF6();
  level._effect["vfx_smk_signal"] = loadfx("vfx/_requests/mp_gameplay/vfx_smk_signal");
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x31e0d20402df7bbfb", getmatchrulesdata("cmdData", "cmdRules"));
  setdynamicdvar("#x326cb81ac3aaad41e", getmatchrulesdata("cmdData", "activationDelayCenter"));
  setdynamicdvar("#x36a350217039acfbe", getmatchrulesdata("cmdData", "activationDelayHalf"));
  setdynamicdvar("#x3f3f699a8b0b26b76", getmatchrulesdata("cmdData", "activationDelayBase"));
  setdynamicdvar("#x33fc2907769ab9cdf", getmatchrulesdata("cmdData", "captureDurationCenter"));
  setdynamicdvar("#x3c2a3ececf451d37", getmatchrulesdata("cmdData", "captureDurationHalf"));
  setdynamicdvar("#x3b1b020587f831a47", getmatchrulesdata("cmdData", "captureDurationBase"));
  setdynamicdvar("#x3548f88b3e05db818", getmatchrulesdata("cmdData", "holdDurationCenter"));
  setdynamicdvar("#x39ac6ecf9a08f8588", getmatchrulesdata("cmdData", "holdDurationHalf"));
  setdynamicdvar("#x3115628e38c085524", getmatchrulesdata("cmdData", "holdDurationBase"));
  setdynamicdvar("#x32790e9e604a424a8", getmatchrulesdata("cmdData", "juggSpawnBehavior"));
  setdynamicdvar("#x3effb2eefc6590d9d", getmatchrulesdata("domData", "flagCaptureTime"));
  setdynamicdvar("#x3e6dc7792dd525f4f", getmatchrulesdata("domData", "flagNeutralization"));
  setdynamicdvar("#x38682d41a7f75bac3", getmatchrulesdata("ctfData", "captureCondition"));
  setdynamicdvar("#x3aacb3551a99056dc", 0);
  scripts\mp\utility\game::_id_C25D("dom", 0);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_3A10 = scripts\mp\utility\dvars::_id_509C("cmdRules", 1, 1, 3);
  level._id_F1E1 = [];
  level._id_F1E1[0] = ::scripts\mp\utility\dvars::_id_509A("activationDelayCenter", 15, 0, 60);
  level._id_F1E1[1] = ::scripts\mp\utility\dvars::_id_509A("activationDelayHalf", 15, 0, 60);
  level._id_F1E1[2] = ::scripts\mp\utility\dvars::_id_509A("activationDelayBase", 15, 0, 60);
  level._id_F1E2 = [];
  level._id_F1E2[0] = ::scripts\mp\utility\dvars::_id_509A("captureDurationCenter", 10, 0, 60);
  level._id_F1E2[1] = ::scripts\mp\utility\dvars::_id_509A("captureDurationHalf", 10, 0, 60);
  level._id_F1E2[2] = ::scripts\mp\utility\dvars::_id_509A("captureDurationBase", 10, 0, 60);
  level._id_F1E4 = [];
  level._id_F1E4[0] = ::scripts\mp\utility\dvars::_id_509A("holdDurationCenter", 30, 0, 60);
  level._id_F1E4[1] = ::scripts\mp\utility\dvars::_id_509A("holdDurationHalf", 30, 0, 60);
  level._id_F1E4[2] = ::scripts\mp\utility\dvars::_id_509A("holdDurationBase", 45, 0, 60);
  level._id_8C8D = scripts\mp\utility\dvars::_id_509C("juggSpawnBehavior", 1, 0, 3);
  level._id_5C3B = scripts\mp\utility\dvars::_id_509A("#x328f66aefdd04dd", 10, 0, 30);
  level._id_5C41 = scripts\mp\utility\dvars::_id_509C("flagNeutralization", 0, 0, 1);
  level._id_7C2C = scripts\mp\utility\dvars::_id_509C("captureCondition", 1, 0, 2);
  level._id_AD6F = scripts\mp\utility\dvars::_id_509A("overtimeLimit", 300, 0, 300);
  scripts\mp\utility\game::_id_D635(level._id_AD6F);
  level._id_B013 = 0;
  level._id_B017 = 1;

  if(istrue(level._id_B013)) {
    level._id_2682 = 60;
  } else {
    level._id_2682 = 30;
  }

  if(level._id_3A10 == 1) {
    level._id_B1DA = 2;
    level._id_4644 = 2;
  } else {
    level._id_B1DA = level._id_F1E2[2];
    level._id_4644 = level._id_F1E2[2];
    level._id_2682 = 3;
  }

  level._id_3C6A = 1;
  setDvar("#x3ea25b1382d5f2d90", 200.0);
  level._id_5E95 = getdvarint("#x319f91234a5e7f2f4", -1);

  if(level._id_5E95 != -1) {
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundLimit"), 2);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundswitch"), 1);
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
  }
}

_id_ABC0() {
  if(level._id_3A10 == 2) {
    if(level._id_3A0F != "neutral") {
      _id_3A0D(level._id_3A0F, game["end_reason"]["outpost_defended"]);
    } else {
      level thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["time_limit_reached"]);
    }
  } else if(scripts\mp\utility\game::_id_82D1())
    level thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["time_limit_reached"]);
  else {
    level thread scripts\mp\gamelogic::_id_52F7("overtime", game["end_reason"]["time_limit_reached"]);
  }
}

_id_D5AD() {
  level._id_7C42 = "icon_waypoint_capture";
  level._id_7C48 = "icon_waypoint_contested";
  level._id_7C4B = "icon_waypoint_defend";
  level._id_7C51 = "icon_waypoint_defusing";
  level._id_7C6F = "icon_waypoint_losing";
  level._id_7C74 = "icon_waypoint_neutral";
  level._id_7C7A = "icon_waypoint_planting";
  level._id_7C87 = "icon_waypoint_taking";
  level._id_7C8A = "icon_waypoint_target";
}

_id_ABAD() {
  _id_D5AD();

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/DOM");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/DOM");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/DOM_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/DOM_HINT");
  }

  setclientnamemode("auto_change");
  _id_8296();
  thread _id_9846();
  _id_D899();
  _id_8294();
  _id_D860();

  if(level.mapname == "mp_faridah") {
    _id_8008();
  }

  thread _id_E6B1();
  scripts\mp\gametypes\bradley_spawner::_id_82A8();
}

_id_8008() {
  _id_8281();
  thread _id_8207();
  thread _id_8277();
}

_id_8277() {
  _id_07D1::_id_60C2("prematch_done");
  var_0 = (435, 0, 625);
  var_1 = (0, 0, 0);
  level._id_BDB4 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  level._id_BDB4 show();
  level._id_BDB4 playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
}

_id_8281() {
  var_0 = (260, -1415, 150);
  var_1 = (0, 90, 0);
  var_2 = scripts\engine\utility::spawn_tag_origin(var_0, var_1);
  var_3 = spawnturret("misc_turret", var_2.origin, "tur_gun_faridah_mp", 0);
  var_3.angles = var_2.angles;
  var_3 linkto(var_2, "tag_origin", (0, 0, 16), (0, 0, 0));
  var_3 setModel("weapon_mg_bravo50_balcony");
  var_3 makeunusable();
  var_3 setnodeploy(1);
  var_3 setdefaultdroppitch(0);
  var_4 = makeweapon("tur_gun_faridah_mp");
  var_3.objweapon = var_4;
  var_5 = var_3 gettagorigin("tag_turret_pitch");
  var_6 = _id_07D6::_id_3FF0(var_5, "HINT_BUTTON", "hud_icon_turret", &"KILLSTREAKS_HINTS/SENTRY_USE_GL");
  var_6 linkto(var_3, "tag_turret_pitch", (0, 0, 5), (0, 0, 0));
  var_6 thread _id_F89A(var_3);
  var_3.killcament = spawn("script_model", (255, -1425, 210));
}

_id_F89A(var_0) {
  for(;;) {
    self waittill("trigger", var_1);
    self makeunusable();
    var_1._id_BC6B = var_1 getcurrentweapon();
    var_1.useweapon = "tur_gun_faridah_mp";
    var_1 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1.useweapon, undefined, undefined, 1);

    while(var_1 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1.useweapon, 1) == 0) {
      waitframe();
    }

    var_1 controlturreton(var_0);
    thread _id_5352(var_1, var_0);
    thread _id_5351(var_1);
    self waittill("end_turret_use");

    if(isDefined(var_1)) {
      var_1 _meth_8292(var_0);
      var_1 switchtoweaponimmediate(var_1._id_BC6B);
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1.useweapon);
    }

    self makeuseable();
  }
}

_id_5352(var_0, var_1) {
  var_0 endon("death_or_disconnect");

  while(var_0 useButtonPressed()) {
    waitframe();
  }

  for(;;) {
    if(var_0 useButtonPressed()) {
      self notify("end_turret_use");
      break;
    }

    waitframe();
  }
}

_id_5351(var_0) {
  var_0 waittill("death_or_disconnect");
  self notify("end_turret_use");
}

_id_8207() {
  wait 2.0;
  var_0 = (1125, -1675, 100);
  _id_6FAD("allies", var_0, "cruise_predator");
  var_0 = (-1150, -575, 100);
  _id_6FAD("allies", var_0, "chopper_gunner");
}

_id_8296() {
  level._id_E3EA = [];
  level._id_41F3 = "cop_2";
  var_0 = scripts\engine\utility::getStructArray("tac_ops_map_config", "targetname");

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;
    var_4 = scripts\engine\utility::getStructArray(var_2.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_CD99) {
        case "to_allies_camera":
          _id_D714(var_3, game["attackers"], var_6);
          break;
        case "to_axis_camera":
          _id_D714(var_3, game["defenders"], var_6);
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

_id_9846() {
  var_0 = 0;

  for(;;) {
    if(getdvarint("#x3caae75b25d1aedb3", 0) == 1) {
      if(isalive(level.players[0])) {
        level.players[0] suicide();
      }

      var_1 = getdvarint("#x35bca28613750fdb0", -1);

      if(var_1 != -1) {
        var_0 = var_1;
      }

      _id_FD36("cop_" + var_0);
      var_2 = getdvarfloat("#x339ededb1f31e7ac3", 1.0);
      wait(var_2);
      var_0++;

      if(var_0 > 4) {
        var_0 = 0;
      }

      if(getdvarint("#x3caae75b25d1aedb3", 0) == 0) {
        level.players[0] notify("force_spawn");
      }

      continue;
    }

    waitframe();
  }
}

_id_D860() {
  if(!isDefined(level._id_487E) || !isDefined(level._id_487E["destructible_door"])) {
    return;
  }
  foreach(var_1 in level._id_487E["destructible_door"]) {
    var_2 = _id_69F2(var_1._id_5526[0].origin);
    var_1 _id_07C7::_id_1D1E(scripts\mp\utility\teams::_id_6A01(var_2));
  }
}

_id_69F2(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  foreach(var_4 in level._id_A8E8) {
    if(!isDefined(var_4._id_45BE)) {
      continue;
    }
    var_5 = distance2dsquared(var_0, var_4._id_4140);

    if(!isDefined(var_1) || var_5 < var_2) {
      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1._id_45BE;
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0817::_id_113A("mp_cmd_spawn_allies_start");
  _id_0817::_id_113A("mp_cmd_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_cmd_spawn_allies", 1);
  _id_0817::_id_1136(game["defenders"], "mp_cmd_spawn_axis", 1);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);

  foreach(var_1 in level._id_A8E8) {
    var_1._id_E34D = [];
    var_1._id_E34D[game["attackers"]] = [];
    var_1._id_E34D[game["defenders"]] = [];
  }

  foreach(var_4 in level._id_E34D) {
    if(isDefined(var_4._id_039B)) {
      var_5 = var_4._id_039B;

      if(var_4.classname == "mp_cmd_spawn_allies") {
        level._id_A8E8[var_5]._id_E34D[game["attackers"]][level._id_A8E8[var_5]._id_E34D[game["attackers"]].size] = var_4;
      } else if(var_4.classname == "mp_cmd_spawn_axis") {
        level._id_A8E8[var_5]._id_E34D[game["defenders"]][level._id_A8E8[var_5]._id_E34D[game["defenders"]].size] = var_4;
      }
    }
  }

  foreach(var_8, var_1 in level._id_A8E8) {
    var_1._id_E37C = [];
    var_1._id_E37C[game["attackers"]] = "objSpawn_allies_" + var_8;
    _id_0817::_id_C2B9(var_1._id_E37C[game["attackers"]], var_1._id_E34D[game["attackers"]]);
    var_1._id_E37C[game["defenders"]] = "objSpawn_axis_" + var_8;
    _id_0817::_id_C2B9(var_1._id_E37C[game["defenders"]], var_1._id_E34D[game["defenders"]]);
  }

  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(_id_0817::_id_DC06()) {
    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    }

    var_1 = _id_0817::_id_6D4E("mp_cmd_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
    self._id_E725 = var_2;
  } else
    var_2 = _id_0817::_id_6D4A(self, var_0, level._id_41DC._id_E37C[var_0]);

  return var_2;
}

_id_D899() {
  level._id_41DC = undefined;
  level._id_A8E8 = [];
  _id_D84F();
  _id_D871();
  _id_D847();
  _id_D8B8();
  _id_FF4E();
  thread _id_F919();
  thread _id_4AD2();
  thread _id_D855();
}

_id_D84F() {
  var_0 = getEntArray("cop_bombzone", "targetname");

  if(var_0.size == 0) {
    return;
  }
  level._effect["bomb_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["faridah_bomb_explosion"] = loadfx("vfx/iw8_mp/killstreak/vfx_cruise_predator_explosion_large_2.vfx");
  level._id_436B = [];
  level._id_A2F7 = 1;
  level._id_267E = 0;
  level._id_265C = 0;
  level._id_2663 = 0;
  level._id_19B0 = 0;
  level._id_29EA = 0;

  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(var_3 == "5") {
      var_3 = "_b";
    } else {
      var_3 = "_a";
    }

    var_2._id_A8E1 = var_3;
    var_2 _id_9ABF();
    var_4 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_2);
    var_4 _id_268D();
    var_4 _id_07D6::_id_C300();
    level._id_A8E8[var_4._id_A8E1] = var_4;
    var_4._id_AA79 = ::_id_268A;
    var_4._id_AAC2 = ::_id_268F;
    var_4._id_ABCB = ::_id_2691;
    var_4._id_AAB5 = ::_id_268D;
    var_4._id_AAC1 = ::_id_268E;
    var_4._id_AA6E = ::_id_2689;

    if(var_3 == "_a") {
      var_4 _id_07D6::_id_D639(game["attackers"]);
      continue;
    }

    var_4 _id_07D6::_id_D639(game["defenders"]);
  }
}

_id_D871() {
  var_0 = getEntArray("cop_flag", "targetname");
  var_1 = getEntArray("cop_flag_override", "targetname");

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

    if(isDefined(var_4[var_7])) {
      var_6 = var_4[var_7];
    }

    var_6._id_A8E1 = var_7;
    var_6 _id_9ABF(var_7);
    var_10 = scripts\mp\gametypes\obj_dom::_id_D896(var_6);
    var_10._id_5C3F delete();
    var_10._id_5C3F = undefined;
    var_10._id_ACD6 = undefined;
    var_10 _id_4D48();
    level._id_A8E8[var_10._id_A8E1] = var_10;
    var_10._id_AA79 = ::_id_4D46;
    var_10._id_ABCB = ::_id_4D4F;
    var_10._id_AAC2 = ::_id_4D4A;
    var_10._id_AA8D = ::_id_4D47;
    var_10._id_ABC7 = ::_id_4D4C;
    var_10._id_AAB5 = ::_id_4D48;
    var_10._id_AAC1 = ::_id_4D49;
    var_10._id_AA6E = ::_id_4D45;
    var_10 thread scripts\mp\gametypes\obj_dom::_id_FC64("off", 0);
  }
}

_id_4AA5() {
  thread scripts\mp\gametypes\obj_dom::_id_FC64("off", 0);
}

_id_D847() {
  var_0 = getEntArray("cop_zone_visual", "targetname");
  var_1 = getEntArray("cop_zone_visual_contest", "targetname");
  var_2 = getEntArray("cop_zone_visual_friend", "targetname");
  var_3 = getEntArray("cop_zone_visual_enemy", "targetname");
  var_4 = getEntArray("cop_zone_visual_friend_pulse", "targetname");
  var_5 = getEntArray("cop_zone_visual_enemy_pulse", "targetname");

  foreach(var_7 in level._id_A8E8) {
    if(isDefined(var_7._id_03A9)) {
      var_7._id_03A9 delete();
      var_7._id_03A9 = undefined;
    }
  }

  if(isDefined(var_0)) {
    foreach(var_10 in var_0) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_A432)) {
        level._id_A8E8[var_11]._id_A432 = [];
      }

      level._id_A8E8[var_11]._id_A432[level._id_A8E8[var_11]._id_A432.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_1) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_3BED)) {
        level._id_A8E8[var_11]._id_3BED = [];
      }

      level._id_A8E8[var_11]._id_3BED[level._id_A8E8[var_11]._id_3BED.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_2) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_5FA3)) {
        level._id_A8E8[var_11]._id_5FA3 = [];
      }

      level._id_A8E8[var_11]._id_5FA3[level._id_A8E8[var_11]._id_5FA3.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_3) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_540C)) {
        level._id_A8E8[var_11]._id_540C = [];
      }

      level._id_A8E8[var_11]._id_540C[level._id_A8E8[var_11]._id_540C.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_4) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_5FBA)) {
        level._id_A8E8[var_11]._id_5FBA = [];
      }

      level._id_A8E8[var_11]._id_5FBA[level._id_A8E8[var_11]._id_5FBA.size] = var_10;
      var_10 hide();
    }

    foreach(var_10 in var_5) {
      var_11 = var_10._id_039B;

      if(!isDefined(level._id_A8E8[var_11]._id_5426)) {
        level._id_A8E8[var_11]._id_5426 = [];
      }

      level._id_A8E8[var_11]._id_5426[level._id_A8E8[var_11]._id_5426.size] = var_10;
      var_10 hide();
    }
  }
}

_id_D8B8() {
  var_0 = getEntArray("cop_outofbounds", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  foreach(var_2 in var_0) {
    var_3 = var_2._id_039B;

    if(!isDefined(level._id_A8E8[var_3]._id_ABEB)) {
      level._id_A8E8[var_3]._id_ABEB = [];
    }

    if(isDefined(var_2.target)) {
      var_4 = getscriptablearray(var_2.target, "targetname");
      var_5 = [];

      foreach(var_7 in var_4) {
        var_8 = var_5.size;
        var_5[var_8] = var_7;

        if(isDefined(var_7._id_039B)) {
          var_5[var_8]._id_4F3B = int(var_7._id_039B);
          continue;
        }

        var_5[var_8]._id_4F3B = 1;
      }

      var_2._id_10430 = var_5;
      var_2 thread _id_FCDF("off");
    }

    level._id_A8E8[var_3]._id_ABEB[var_2._id_CD99] = var_2;
  }
}

_id_FF4E() {
  if(level._id_A8E8.size == 0) {} else if((level._id_A8E8.size - 2) % 2 == 0) {}

  level._id_9E8D = int(floor((level._id_A8E8.size - 2) / 2));
  level._id_41DE = level._id_9E8D;
  level._id_BC3B = level._id_41DE;

  foreach(var_1 in level._id_A8E8) {
    if(level._id_3A10 == 1) {
      if(var_1._id_A8E1 == "_a" || var_1._id_A8E1 == "_b") {
        continue;
      }
    }

    var_2 = int(var_1._id_A8E1);
    var_3 = int(clamp(floor(abs(var_2 - 2)), 0, 2));
    var_1._id_F1E5 = var_3;
    var_1._id_0F0F = level._id_F1E1[var_3];
    var_1._id_322D = level._id_F1E2[var_3];
    var_1._id_79D4 = level._id_F1E4[var_3];
    var_1 _id_07D6::_id_4AD1();
    var_1._id_5BE0 = 1;

    if(level._id_3A10 == 1) {
      switch (var_3) {
        case 1:
        case 0:
          var_1 _id_07D6::_id_D4B2("persistent");
          var_1._id_7D35 = 1;
          break;
        case 2:
          if(var_2 < level._id_9E8D) {
            var_1._id_45BE = game["defenders"];
          } else {
            var_1._id_45BE = game["attackers"];
          }

          break;
      }

      continue;
    }

    var_1._id_5BE0 = 1;
    var_1 _id_07D6::_id_D4B2("normal");

    if(var_2 == level._id_9E8D) {
      continue;
    }
    if(var_2 < level._id_9E8D) {
      var_1._id_45BE = game["defenders"];
      continue;
    }

    var_1._id_45BE = game["attackers"];
  }
}

_id_E6B1() {
  level endon("game_ended");
  setomnvar("ui_objective_timer_stopped", 1);
  setomnvar("ui_hardpoint_timer", 0);
  _id_07D1::_id_60C2("prematch_done");
  _id_FD5D();
  setomnvar("ui_objective_timer_stopped", 0);

  if(level._id_3A10 == 2) {
    level scripts\mp\gamelogic::pausetimer();
  }

  _id_FC44(level._id_41DE);
}

_id_FC44(var_0) {
  if(level._id_5E95 != -1) {
    var_0 = level._id_5E95;
  }

  if(!isDefined(level._id_A8E8[scripts\engine\utility::_id_EA52(var_0)])) {
    return;
  }
  if(isDefined(level._id_41DC) && isDefined(level._id_41DC._id_AAB5)) {
    level._id_41DC[[level._id_41DC._id_AAB5]]();
  }

  level._id_BC3B = level._id_41DE;
  level._id_41DE = var_0;
  _id_FD36("cop_" + level._id_41DE);
  level._id_41DC = level._id_A8E8[scripts\engine\utility::_id_EA52(var_0)];
  setomnvar("ui_cmd_current_obj", var_0);
  _id_FCDE();

  if(isDefined(level._id_41DC._id_AAC1)) {
    level._id_41DC[[level._id_41DC._id_AAC1]]();
  }

  thread _id_F917();
  _id_FD5D();

  if(level._id_41DC._id_0F0F > 0) {
    if(level._id_3A10 == 2 && level._id_41DE == level._id_9E8D) {
      level scripts\mp\gamelogic::pausetimer();
    }

    level._id_0F10 = gettime();
    var_1 = level._id_41DC._id_0F0F;
    _id_F91A(var_1);
    _id_F91B(0);
    _id_F918("zone_activation_delay");
    _id_F916("zone_activation_delay", 0);
    wait 3.0;
    _id_DCE8("all", "cop_target");
    _id_0A8D::_id_E775(_id_6E48("allies", "next"), "allies", 1);
    _id_0A8D::_id_E775(_id_6E48("axis", "next"), "axis", 1);
    level._id_41DC._id_5BE0 = 0;
    var_2 = gettime();

    foreach(var_4 in level.players) {
      var_4._id_9046 = var_2;
    }

    wait(var_1 - 3.0);
    level._id_0F10 = undefined;
  }

  if(level._id_3A10 == 2 && level._id_41DE == level._id_9E8D) {
    level scripts\mp\gamelogic::resumetimer();
  }

  if(isDefined(level._id_41DC._id_AA6E)) {
    level._id_41DC[[level._id_41DC._id_AA6E]]();
  }

  _id_DCE8("all", "cop_activate");
  var_6 = 0;

  switch (level._id_41DC._id_F1E5) {
    case 0:
      var_6 = 0;
      break;
    case 1:
      var_6 = 5;
      break;
    case 2:
      var_6 = 10;
      break;
  }

  scripts\mp\gamelogic::_id_FD85(var_6);
  _id_0A8D::_id_E775("cop_target_active", "allies", 0);
  _id_0A8D::_id_E775("cop_target_active", "axis", 0);
}

_id_6A40(var_0) {
  var_1 = "cop_obj_" + level._id_41DE + "_" + level.mapname;
  return var_1;
}

_id_6E48(var_0, var_1) {
  var_2 = "";
  var_3 = 0;
  var_4 = var_0 == "allies" && level._id_BC3B > level._id_41DE || var_0 == "axis" && level._id_BC3B < level._id_41DE;

  if(var_1 == "next" && level._id_41DC._id_5BE0) {
    var_2 = _id_6A40(var_0);
  } else {
    switch (level._id_41DE) {
      case 4:
      case 0:
        var_3 = 0;

        switch (var_1) {
          case "next":
            var_2 = "cop_obj_" + level._id_41DE + scripts\engine\utility::ter_op(var_4, "_attack_", "_defend_") + level.mapname;
            break;
          case "bomb_planted":
            if(level._id_41DE == 0) {
              var_2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var_0 == "allies", "_atenemy", "_atfriendly");
            } else {
              var_2 = "cop_bombplanted" + scripts\engine\utility::ter_op(var_0 == "axis", "_atenemy", "_atfriendly");
            }

            break;
          case "bomb_defused":
            var_3 = 1;
            break;
        }

        break;
      case 3:
      case 2:
      case 1:
        switch (var_1) {
          case "next":
            var_2 = "cop_obj_" + level._id_41DE + scripts\engine\utility::ter_op(var_4, "_attack_", "_defend_") + level.mapname;
            break;
          case "hold_confirmed":
          case "enemy_sec":
          case "hold":
            var_3 = 1;
            break;
        }

        break;
    }

    if(var_2 == "") {
      if(var_3) {
        var_2 = "cop_" + var_1;
      } else {
        var_2 = "cop_obj_" + level._id_41DE + "_" + var_1 + "_" + level.mapname;
      }
    }
  }

  return var_2;
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(isDefined(var_4) && scripts\mp\utility\weapon::_id_88F6(var_4.basename)) {
    return;
  }
  switch (level._id_41DC._id_7C8C) {
    case "domFlag":
      scripts\mp\gametypes\obj_dom::_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
      break;
    case "bomb_zone":
      scripts\mp\gametypes\obj_bombzone::_id_2685(var_1, self);
      break;
  }
}

onplayerconnect(var_0) {
  var_0._id_F90E = undefined;
  var_0._id_F90F = undefined;

  foreach(var_2 in level._id_A8E8) {
    if(isDefined(var_2._id_A432)) {
      var_2 _id_78EE(var_0);
    }
  }

  var_0 thread _id_FC67();
}

_id_450D(var_0) {
  self endon("domPoint_HoldTimer");

  for(;;) {
    if(isDefined(var_0)) {
      self._id_EF7A[var_0] = self._id_EF7A[var_0] - level._id_5F3A;

      if(self._id_EF7A[var_0] <= 0.0) {
        self._id_EF7A[var_0] = 0.0;
        break;
      }
    }

    waitframe();
  }
}

_id_4D44(var_0, var_1) {
  level endon("gameEnded");
  self notify("domPoint_HoldTimer");
  self endon("domPoint_HoldTimer");
  level._id_82CF = 0;
  _id_F918(var_0);

  if(istrue(level._id_B017)) {
    var_2 = self._id_EF7A[var_0];
    self._id_79D2 = var_0;
  } else
    var_2 = level._id_41DC._id_79D4;

  var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

  if(var_2 > 0) {
    thread _id_450D(var_0);
    _id_0A8D::_id_E775(_id_6E48(var_3, "enemy_hold"), var_3, 1);
    var_4 = 0;

    if(level._id_41DE != 2 && var_2 > 5.0) {
      var_5 = _id_6973(level._id_41DC.trigger.origin, var_0);

      if(isDefined(var_5)) {
        level thread scripts\mp\battlechatter_mp::_id_F759(var_5, _id_694B("captured"));
        var_4 = var_4 + var_5 _id_6D20("captured");
      }
    }

    if(var_4 > 0) {
      wait(var_4);
    }

    var_6 = 0;
    var_5 = _id_6973(level._id_41DC.trigger.origin, var_0);

    if(isDefined(var_5) && var_2 > 5.0 + var_4) {
      var_6 = level thread scripts\mp\battlechatter_mp::_id_F759(var_5, "cop_confirm_copsecureask");

      if(!isDefined(var_6)) {
        var_6 = 0;
      }
    }

    var_4 = var_4 + var_6;
    wait(var_6);

    if(var_2 > 5.0 + var_4) {
      _id_0A8D::_id_E775(_id_6E48(var_0, "hold"), var_0, 1);
    }

    if(var_2 - var_4 > 0) {
      wait(var_2 - var_4);
    } else {
      wait(var_2);
    }

    var_3 = scripts\mp\utility\game::_id_6BE2(var_0)[0];

    if(istrue(level._id_3C6A) && level._id_41DC._id_F396[var_3].size > 0) {
      level._id_82CF = 1;
      _id_F916("overtime", level._id_41DC._id_E57B);

      for(;;) {
        if(level._id_41DC._id_F396[var_3].size == 0) {
          break;
        }

        waitframe();
      }

      level._id_82CF = 0;
    }
  }

  var_7 = 0;
  var_8 = level._id_41DE;

  if(var_0 == game["attackers"]) {
    var_8--;

    if(level._id_41DE <= level._id_9E8D) {
      var_7 = 1;

      if(level._id_41DC._id_F1E5 == 1) {
        _id_E314(var_0, "attacker");
        _id_E314(scripts\mp\utility\game::_id_6BE2(var_0)[0], "defender");
      } else if(level._id_41DC._id_F1E5 == 0) {
        if(isDefined(level._id_BDB4)) {
          level._id_BDB4 stoploopsound();
        }
      }
    }
  } else {
    var_8++;

    if(level._id_41DE >= level._id_9E8D) {
      var_7 = 1;

      if(level._id_41DC._id_F1E5 == 1) {
        _id_E314(var_0, "attacker");
        _id_E314(scripts\mp\utility\game::_id_6BE2(var_0)[0], "defender");
      } else if(level._id_41DC._id_F1E5 == 0) {
        if(isDefined(level._id_BDB4)) {
          level._id_BDB4 playLoopSound("tmp_emt_mp_faridah_propaganda_lp");
        }
      }
    }
  }

  if(0 && var_7) {
    scripts\mp\gamescore::_id_7001(var_0, 1, 0);
  }

  if(self._id_F1E5 == 0) {
    if(isDefined(var_1)) {
      var_1 thread givekillstreak("uav", 1);
    } else {
      var_5 = _id_6973(level._id_41DC.trigger.origin, var_0);
      var_5 thread givekillstreak("uav", 1);
    }
  }

  _id_FD5D();

  if(var_2 > 0) {
    _id_0A8D::_id_E775(_id_6E48(var_0, "hold_confirmed"), var_0, 1);
  }

  _id_DCE8(var_0, "cop_captured_friendly");
  _id_DCE8(var_3, "cop_captured_enemy");

  if(level._id_5E95 != -1) {
    scripts\mp\gamescore::_id_7001(var_0, 1, 0);
    _id_3A0D(var_0, game["end_reason"]["target_destroyed"]);
  } else if(scripts\mp\utility\game::_id_82D1())
    scripts\mp\gamescore::_id_7001(var_0, 1, 0);
  else {
    if(level._id_3A10 == 2 && level._id_41DE == level._id_9E8D) {
      level._id_5856 = level._id_5856 + 90;
      var_9 = scripts\mp\gamelogic::_id_6DE8();
      setgameendtime(gettime() + int(var_9));
      level scripts\mp\gamelogic::resumetimer();
    }

    _id_FC44(var_8);
  }
}

_id_4D43() {
  if(!istrue(level._id_B017)) {
    return;
  }
  var_0 = _id_07D6::_id_6C02();

  if(isDefined(self._id_79D2) && self._id_79D2 == var_0) {
    _id_F91B(1);
    self notify("domPoint_HoldTimer");
    self._id_79D2 = undefined;
  }
}

_id_6FAD(var_0, var_1, var_2) {}

_id_4008(var_0, var_1, var_2) {}

_id_3E9F(var_0, var_1) {
  self endon("restarting_physics");
  self endon("death");
  var_2 = scripts\engine\utility::_id_5000(self.origin + (7, 9, 0), 50, -200, (0, 0, 1));
  var_3 = spawn("script_model", var_2 + (0, 0, 0));
  var_3 setModel("offhand_wm_grenade_smoke");
  var_3.angles = self.angles + (-80, 120, 90);
  var_4 = spawn("script_model", var_3.origin);
  var_4 setModel("tag_origin");
  var_4.angles = self.angles + (0, 30, 0);
  var_4 playLoopSound("mp_flare_burn_lp");
  waitframe();
  playFXOnTag(level._effect["vfx_smk_signal"], var_4, "tag_origin");
  var_5 = &"KILLSTREAKS_HINTS/CRATE_PICKUP";
  var_6 = undefined;

  switch (var_1) {
    case "juggernaut":
      var_5 = &"KILLSTREAKS_HINTS/JUGGERNAUT_PICKUP_GL";
      var_6 = "icon_ks_jugg";
      break;
    case "cruise_predator":
      var_5 = &"KILLSTREAKS_HINTS/CRUISE_PREDATOR_PICKUP_GL";
      var_6 = "hud_icon_killstreak_cruise_missile";
      break;
    case "chopper_gunner":
      var_5 = &"KILLSTREAKS_HINTS/CHOPPER_GUNNER_PICKUP_GL";
      var_6 = "hud_icon_killstreak_apache";
      break;
  }

  self._id_FE90 = _id_07D6::_id_3FF0(self.origin + anglestoup(self.angles) * 24, "HINT_BUTTON", var_6, var_5, -1, undefined, "show", 250, 360, 100, 360);
  self._id_FE90 linkto(self);

  if(var_1 == "juggernaut") {
    thread _id_60A7(var_0);
    thread _id_C491(var_0);
  }

  for(;;) {
    self waittill("captured", var_7);

    if(isPlayer(var_7)) {
      var_7 setclientomnvar("ui_securing", 0);
      var_7._id_F913 = undefined;
    }

    switch (var_1) {
      case "juggernaut":
        if(!var_7 thread _id_6FA8()) {
          continue;
        }
        break;
      case "cruise_predator":
        var_7 thread givekillstreak("cruise_predator", 1);
        wait 3.0;
        break;
      case "chopper_gunner":
        var_7 thread givekillstreak("chopper_gunner", 1);
        wait 3.0;
        break;
    }

    var_7 playlocalsound("ammo_crate_use");
    stopFXOnTag(level._effect["vfx_smk_signal"], var_4, "tag_origin");
    var_4 stoploopsound();
    var_4 delete();
    var_4 = undefined;
    var_3 delete();
    var_3 = undefined;
    scripts\cp_mp\killstreaks\airdrop::_id_4843();
  }
}

_id_60A7(var_0) {
  self endon("death");

  foreach(var_2 in level.players) {
    if(var_2.team == var_0 && istrue(var_2._id_88DF)) {
      self disableplayeruse(var_2);
    }
  }

  for(;;) {
    level waittill("gained_juggernaut", var_2);

    if(var_2.team == var_0) {
      self disableplayeruse(var_2);
    }
  }
}

_id_C491(var_0) {
  self endon("death");

  for(;;) {
    level waittill("removed_juggernaut", var_1);

    if(var_1.team == var_0) {
      self _meth_80E0(var_1);
    }
  }
}

givekillstreak(var_0, var_1) {
  var_2 = scripts\mp\killstreaks\killstreaks::_id_4057(var_0);
  scripts\mp\killstreaks\killstreaks::_id_1FC9(var_2);

  if(istrue(var_1)) {
    wait 0.1;
    self notify("ks_action_4");
  }
}

_id_2695() {
  level endon("game_ended");
  var_0 = game["music"]["cop_finalpush"].size;
  var_1 = randomint(var_0);

  foreach(var_3 in level.players) {
    var_3 setplayermusicstate(game["music"]["cop_finalpush"][var_1]);
  }

  wait 2.0;
  wait 16.0;
}

_id_2686(var_0) {
  if(!isDefined(level._id_41DC)) {
    return;
  }
  level endon("gameEnded");
  level endon("bomb_planted");
  self notify("bombZone_HoldTimer");
  self endon("bombZone_HoldTimer");
  var_1 = level._id_41DC._id_45BE;
  var_2 = scripts\mp\utility\game::_id_6BE2(level._id_41DC._id_45BE)[0];
  _id_07F9::_id_A8C5(level._id_41DC._id_A908, var_2);
  level._id_F21A = 0;

  if(var_0 > 0) {
    _id_F91A(var_0);
    wait(var_0);

    if(istrue(level._id_3C6A)) {
      var_2 = scripts\mp\utility\game::_id_6BE2(level._id_41DC._id_45BE)[0];
      var_3 = 0;

      for(;;) {
        if(!var_3) {
          var_3 = 1;
          _id_F916("overtime", level._id_41DC._id_E57B);
        }

        if(level._id_41DC._id_F396[var_2].size == 0) {
          break;
        }

        waitframe();
      }
    }
  }

  foreach(var_5 in level.players) {
    var_5 setplayermusicstate("mus_mp_cop_bombplant_end");
  }

  thread _id_07F8::_id_EBE8();
  var_7 = level._id_41DE;
  var_8 = level._id_41DC _id_07D6::_id_6C02();

  if(var_8 == game["attackers"]) {
    var_7--;
  } else {
    var_7++;
  }

  _id_FC44(var_7);
}

_id_265E(var_0, var_1, var_2) {
  if(level.gameended) {
    return;
  }
  if(var_1 == "explode") {
    self._id_265C = 1;
    level._id_41DC[[level._id_41DC._id_AAB5]]();
    scripts\mp\gamescore::_id_7001(var_2, 1, 0);
    _id_3A0D(var_2, game["end_reason"]["target_destroyed"]);
  } else {}
}

_id_C606() {
  _id_07D6::_id_D8D2(level._id_B1DA);
  _id_07D6::_id_D8E0("none");
  self._id_7C8C = "bomb_zone";
  self.useweapon = makeweapon("briefcase_bomb_mp");
  self._id_265C = undefined;
}

_id_3A0D(var_0, var_1) {
  level._id_4C4D = 1;
  var_2 = undefined;

  if(level.mapname == "mp_faridah") {
    var_2 = spawnStruct();

    if(var_0 == "allies") {
      var_2.origin = (-207, -4711, 211);
      var_2.angles = (7, 64, 0);
    } else if(var_0 == "axis") {
      var_2.origin = (1945, 4423, 670);
      var_2.angles = (15, 244, 0);
    } else {}
  }

  foreach(var_4 in level.players) {
    if(!isai(var_4)) {
      var_4 setclientomnvar("ui_objective_state", 0);
    }

    var_4 thread _id_B39B(var_2);
  }

  var_6 = game["teamScores"][var_0];
  var_7 = game["teamScores"][scripts\mp\utility\game::_id_6BE2(var_0)[0]];

  if(var_7 > var_6) {
    var_8 = var_7 - var_6 + 1;
    scripts\mp\gamescore::_id_7001(var_0, var_8, 0);
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
  wait 0.65;
  level notify("allow_bomb_explosion");
  wait 5.0;
  level notify("cmd_continue_game_end");
}

_id_4D46(var_0) {
  _id_4D43();
  scripts\mp\gametypes\obj_dom::_id_4D50(var_0);
  self._id_497A = 1;
  thread _id_FC65(var_0.team);
  _id_F916(var_0.team, self._id_E57B);

  if(var_0.team == game["attackers"]) {
    if(level._id_41DE == 0 || level._id_41DE == 4) {
      var_1 = _id_07D6::_id_6C02();

      if(var_0.team != var_1) {
        level thread scripts\mp\battlechatter_mp::_id_F759(var_0, _id_694B("capturing"));
        var_0 _id_6D20("planting");
      } else
        var_0 _id_6D20("defusing");
    } else
      level thread scripts\mp\battlechatter_mp::_id_F759(var_0, _id_694B("capturing"));
  }

  var_2 = scripts\mp\utility\game::_id_6BE2(var_0.team)[0];

  if(var_2 == _id_07D6::_id_6C02()) {
    _id_0A8D::_id_E775(_id_6E48(var_0.team, "enemy_cap"), var_2, 0);
  } else {
    _id_0A8D::_id_E775(_id_6E48(var_0.team, "enemy_sec"), var_2, 0);
  }

  foreach(var_0 in level.players) {
    _id_FC66(var_0);
  }
}

_id_4D4F(var_0) {
  if(istrue(level._id_B017)) {
    _id_F91B(0);
    self._id_8FA1 = gettime();
    self._id_5BC6 = 0;
  }

  scripts\mp\gametypes\obj_dom::_id_4D4F(var_0);
  var_1 = _id_07D6::_id_6C02();
  thread _id_FC65(var_1);

  foreach(var_3 in level.players) {
    _id_FC66(var_3);
  }

  level._id_FED4 = 0;
  var_5 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  thread scripts\mp\utility\print::_id_BD0C(var_1, var_5, undefined, undefined, "mp_dom_flag_captured", "mp_dom_flag_lost", var_0);

  if(level._id_3A10 == 2) {
    if(level._id_41DE == level._id_9E8D) {
      level._id_3A0E = var_1;
      level._id_3A0F = var_5;
      level scripts\mp\gamelogic::pausetimer();
    } else {
      level._id_5856 = level._id_5856 + 90;
      var_6 = scripts\mp\gamelogic::_id_6DE8();
      setgameendtime(gettime() + int(var_6));
    }
  }

  if(level._id_41DE == 0) {
    var_7 = level._id_A8E8["_b"] _id_07D6::_id_6C02();

    if(var_1 != var_7) {
      level._id_A8E8["_b"] _id_2691(var_0);
    } else {
      level._id_A8E8["_b"] _id_2690(var_0);
    }
  } else if(level._id_41DE == 4) {
    var_7 = level._id_A8E8["_a"] _id_07D6::_id_6C02();

    if(var_1 != var_7) {
      level._id_A8E8["_a"] _id_2691(var_0);
    } else {
      level._id_A8E8["_a"] _id_2690(var_0);
    }
  } else {
    thread _id_4D44(var_1, var_0);
    _id_DCE8(var_1, "cop_hold_friendly");
    _id_DCE8(var_5, "cop_hold_enemy");
  }

  if(self == level._id_41DC) {
    _id_F916("neutral", 0);
  }
}

_id_4D4A(var_0, var_1, var_2) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D51(var_0, var_1, var_2);
  var_3 = _id_07D6::_id_6C02();
  var_4 = scripts\engine\utility::ter_op(var_3 == "neutral", "idle", var_3);
  thread _id_FC65(var_4);

  if(level._id_3A10 == 2) {
    if(level._id_41DE == level._id_9E8D) {
      var_3 = _id_07D6::_id_6C02();
      _id_F916("neutral", 0);

      if(istrue(level._id_B017) && self._id_A8E1 != "0" && self._id_A8E1 != "4") {
        if(var_3 != "neutral") {
          _id_F91B(0);
          self._id_8FA1 = gettime();
          thread _id_4D44(var_3);
        }
      }
    }
  } else if(!var_2) {
    var_3 = _id_07D6::_id_6C02();
    _id_F916("neutral", 0);

    if(istrue(level._id_B017) && self._id_A8E1 != "0" && self._id_A8E1 != "4") {
      if(var_3 != "neutral") {
        _id_F91B(0);
        self._id_8FA1 = gettime();
        thread _id_4D44(var_3);
      }
    }
  }

  foreach(var_1 in level.players) {
    _id_FC66(var_1);
  }
}

_id_4D47() {
  if(self != level._id_41DC) {
    return;
  }
  _id_4D43();
  scripts\mp\gametypes\obj_dom::_id_4D47();
  thread _id_FC65("contested");
  var_0 = _id_07D6::_id_6C02();

  if(var_0 == "neutral") {
    if(level._id_3A10 == 2 && level._id_41DE == level._id_9E8D) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  _id_F916(var_0, 1);
  var_1 = var_0;

  if(var_0 == "neutral") {
    var_1 = self._id_37F6;
  }

  if(var_1 != "none") {
    _id_0A8D::_id_E775("cop_obj_contested", var_1, 0);
  }

  foreach(var_3 in level.players) {
    _id_FC66(var_3);
  }
}

_id_4D4C(var_0) {
  if(self != level._id_41DC) {
    return;
  }
  scripts\mp\gametypes\obj_dom::_id_4D4C(var_0);
  self._id_497A = 1;
  var_1 = _id_07D6::_id_6C02();

  if(var_1 == "neutral") {
    if(level._id_3A10 == 2 && level._id_41DE == level._id_9E8D) {
      level scripts\mp\gamelogic::resumetimer();
    }
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "neutral", "idle", var_1);
  thread _id_FC65(var_2);

  if(level._id_3A10 == 2) {
    if(level._id_41DE == level._id_9E8D) {
      if(var_1 != "neutral" && self._id_F396[scripts\mp\utility\game::_id_6BE2(var_1)[0]].size == 0) {
        _id_F91B(0);
        self._id_8FA1 = gettime();
        thread _id_4D44(var_1);
      }
    }
  } else if(istrue(level._id_B017) && level._id_41DE != 0 && level._id_41DE != 4) {
    if(var_1 != "neutral" && self._id_F396[scripts\mp\utility\game::_id_6BE2(var_1)[0]].size == 0) {
      _id_F91B(0);
      self._id_8FA1 = gettime();
      thread _id_4D44(var_1);
    }
  }

  _id_F916("neutral", 0);

  foreach(var_4 in level.players) {
    _id_FC66(var_4);
  }
}

_id_4D48() {
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_4AD1();
  _id_07D6::_id_C60A();
  _id_07D6::_id_C300();
  scripts\engine\utility::delaythread(0.1, ::_id_4AA5);
  thread _id_FC65("off");

  foreach(var_1 in level.players) {
    _id_FC66(var_1, 1);
  }
}

_id_4D49() {
  _id_07D6::_id_C579(1, 1);
  _id_07F9::_id_A8B1(self._id_A908, 1);
  _id_07F9::_id_A8B2(self._id_A908, 1);
  _id_07D6::_id_5260();
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_D61B(level._id_7C8A);

  if(istrue(level._id_B017)) {
    if(!isDefined(self._id_EF7A)) {
      self._id_EF7A = [];
    }

    self._id_EF7A["allies"] = self._id_79D4;
    self._id_EF7A["axis"] = self._id_79D4;
    self._id_5BC6 = 1;
    self._id_79D2 = undefined;
  }

  if(isDefined(self._id_45BE)) {
    _id_07D6::_id_D639(self._id_45BE);
    thread scripts\mp\gametypes\obj_dom::_id_FC64(self._id_45BE, 0);
    thread _id_FC65(self._id_45BE);
  } else {
    _id_07D6::_id_D639("neutral");
    thread scripts\mp\gametypes\obj_dom::_id_FC64("idle", 0);
    thread _id_FC65("idle");
  }

  if(level._id_41DE == 0 || level._id_41DE == 4) {
    thread _id_2695();
  }

  if(getdvarint("#x3d5540792cc3f54f1", 0) != 0) {
    scripts\mp\gametypes\bradley_spawner::_id_F75F(level._id_41DE);
  }

  foreach(var_1 in level.players) {
    _id_FC66(var_1);
  }
}

_id_4D45() {
  _id_0AA2::_id_B8F1("mp_combat_outpost_activateobj");
  var_0 = _id_07D6::_id_6C02();
  _id_F918(var_0);
  _id_F916("neutral", 0);
  _id_07D6::_id_15DF("enemy");
  thread _id_1FC4();
  level._id_5C3B = self._id_322D;

  if(self._id_F1E5 == 2) {
    if(level._id_3A10 == 1) {
      level._id_5C3B = 5.0;
    }

    _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  } else
    _id_07D6::_id_D61B(level._id_7C74);

  if(level._id_3A10 == 1) {
    if(level._id_41DE == 0 || level._id_41DE == 4) {
      thread _id_2686(self._id_79D4);
    }
  }
}

_id_268A(var_0) {
  scripts\mp\gametypes\obj_bombzone::_id_268A(var_0);
}

_id_268F(var_0, var_1, var_2) {
  scripts\mp\gametypes\obj_bombzone::_id_268F(var_0, var_1, var_2);
}

_id_2691(var_0) {
  var_1 = _id_07D6::_id_6C02();
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  _id_07F9::_id_A8C5(level._id_41DC._id_A908, var_1);
  _id_DCE8("all", "cop_planted");
  level._id_5C3B = 15.0;

  if(istrue(level._id_B013)) {
    if(!isDefined(level._id_22B9)) {
      level._id_22B9 = [];
      level._id_22B9["allies"] = level._id_2682;
      level._id_22B9["axis"] = level._id_2682;
    }

    level._id_2682 = level._id_22B9[var_1];
    level._id_8F99 = gettime();
  }

  scripts\mp\gametypes\obj_bombzone::_id_2691(var_0);
  var_3 = game["music"]["cop_bombplant"].size;
  var_4 = randomint(var_3);

  foreach(var_6 in level.players) {
    var_6 setplayermusicstate(game["music"]["cop_bombplant"][var_4]);
  }

  if(var_0.team == "allies") {
    level thread scripts\mp\battlechatter_mp::_id_F759(var_0, _id_694B("planted"));
  }

  if(0) {
    scripts\mp\gamescore::_id_7001(var_0.team, 1, 0);
  }

  _id_0A8D::_id_E775(_id_6E48(var_1, "bomb_planted"), var_1, 1);
  _id_0A8D::_id_E775(_id_6E48(var_2, "bomb_planted"), var_2, 1);

  if(isDefined(level._id_110E4)) {
    level._id_110E4 = int(level._id_110E4 - gettime());
  }

  if(level._id_3A10 == 1) {
    _id_F915();
  }

  _id_F918(var_0.team);
}

_id_2690(var_0) {
  if(!level._id_2663) {
    return;
  }
  _id_DCE8("all", "cop_defused");
  var_1 = _id_07D6::_id_6C02();
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];
  level._id_5C3B = 5.0;

  if(istrue(level._id_B013)) {
    level._id_22B9[var_1] = level._id_22B9[var_1] - (gettime() - level._id_8F99) / 1000;
  }

  level._id_267E = level._id_267E - 1;

  if(self._id_A8E1 == "_a") {
    level._id_19B0 = 0;
  } else {
    level._id_29EA = 0;
  }

  scripts\mp\gametypes\obj_bombzone::_id_2690(var_0);

  if(scripts\mp\utility\game::_id_6BE2(var_0.team)[0] == "allies") {
    var_3 = _id_6973(level._id_41DC.trigger.origin, scripts\mp\utility\game::_id_6BE2(var_0.team)[0]);

    if(isDefined(var_3)) {
      level thread scripts\mp\battlechatter_mp::_id_F759(var_3, _id_694B("defused"));
    }
  }

  _id_07D6::_id_D8E0("none");
  _id_0A8D::_id_E775(_id_6E48(var_1, "bomb_defused"), var_1, 1);
  _id_0A8D::_id_E775(_id_6E48(var_2, "bomb_defused"), var_2, 1);
  var_0 notify("bomb_defused" + self._id_A8E1);
  self notify("defused");
  _id_C606();

  if(isDefined(level._id_110E4)) {
    thread _id_2686(level._id_110E4 / 1000);
  }

  _id_F918(var_0.team);
}

_id_268D() {
  _id_07D6::_id_4AD1();
  _id_07D6::_id_15DF("none");
}

_id_268E() {
  _id_07D6::_id_5260();
  _id_07D6::_id_D8E0("any");
  _id_07D6::_id_15DF("none");
  _id_07D6::_id_D61B(level._id_7C8A);
}

_id_2689() {
  _id_0AA2::_id_B8F1("mp_combat_outpost_activateobj");
  _id_F918("neutral");
  _id_F916("neutral", 0);
  level._id_B1DA = self._id_322D;
  level._id_4644 = self._id_322D;
  _id_07D6::_id_D61B(level._id_7C4B, level._id_7C42);
  _id_07D6::_id_15DF("enemy");
  thread _id_2686(self._id_79D4);
}

_id_F91A(var_0) {
  level._id_110E4 = int(gettime() + 1000 * var_0);
  setomnvar("ui_hardpoint_timer", level._id_110E4);
}

_id_F915() {
  var_0 = int(gettime() + 1000 * level._id_2682);
  setomnvar("ui_hardpoint_timer", var_0);
}

_id_F91B(var_0) {
  setomnvar("ui_objective_timer_stopped", var_0);
}

_id_6C03(var_0) {
  var_1 = undefined;

  foreach(var_3 in level.players) {
    if(var_3.team == var_0) {
      return var_3;
    }
  }

  return var_1;
}

_id_F916(var_0, var_1) {
  var_2 = -1;

  if(istrue(level._id_82CF)) {
    if(var_1) {
      var_2 = -4;
    } else {
      var_2 = -5;
    }
  } else if(var_1)
    var_2 = -2;
  else {
    switch (var_0) {
      case "allies":
        var_2 = 2;
        break;
      case "axis":
        var_2 = 1;
        break;
      case "zone_activation_delay":
        var_2 = -3;
        break;
      case "overtime":
        var_2 = -4;
        break;
      case "zone_shift":
      default:
        break;
    }
  }

  setomnvar("ui_cmd_capture_team", var_2);
}

_id_F918(var_0) {
  var_1 = -1;

  switch (var_0) {
    case "allies":
      var_1 = 2;
      break;
    case "axis":
      var_1 = 1;
      break;
    case "zone_activation_delay":
      var_1 = -3;
      break;
    case "zone_shift":
    default:
      break;
  }

  setomnvar("ui_cmd_owner_team", var_1);
}

_id_F919() {
  for(;;) {
    if(isDefined(level._id_41DC)) {
      setomnvar("ui_cmd_capture_progress", level._id_41DC _id_07D6::_id_694C());
    } else {
      setomnvar("ui_cmd_capture_progress", 0);
    }

    waitframe();
  }
}

_id_F917() {
  self notify("ui_updateCMDHoldProgress");
  self endon("ui_updateCMDHoldProgress");

  for(;;) {
    if(isDefined(level._id_41DC) && isDefined(level._id_41DC._id_EF7A) && isDefined(level._id_41DC._id_79D4) && level._id_41DC._id_79D4 > 0) {
      setomnvar("ui_cmd_owner_progress_allies", 1.0 - level._id_41DC._id_EF7A["allies"] / level._id_41DC._id_79D4);
      setomnvar("ui_cmd_owner_progress_axis", 1.0 - level._id_41DC._id_EF7A["axis"] / level._id_41DC._id_79D4);
    } else {
      setomnvar("ui_cmd_owner_progress_allies", 0);
      setomnvar("ui_cmd_owner_progress_axis", 0);
    }

    waitframe();
  }
}

_id_69B1() {
  if(!isDefined(level._id_41DC)) {
    return 0.5;
  }

  var_0 = _id_6950(level._id_41DE);
  var_1 = 0.0;
  var_2 = level._id_41DC _id_07D6::_id_6C02();
  var_3 = 0.0;
  var_4 = 0.03;
  var_5 = 0.0;

  if(isDefined(level._id_0F10) && level._id_BC3B != level._id_41DE) {
    if(isDefined(level._id_41DC._id_45BE)) {
      var_1 = var_4;

      if(var_2 == "allies") {
        var_1 = var_1 * -1.0;
      }

      var_4 = var_4 * 2;
    }

    var_3 = 1.0;
    var_6 = gettime();
    var_7 = (var_6 - level._id_0F10) / (level._id_41DC._id_0F0F * 1000);
    var_5 = (abs(_id_6950(level._id_BC3B) - var_0) - var_4) * var_7;

    if(level._id_41DE < level._id_BC3B) {
      var_5 = var_5 * -1.0;
      var_4 = var_4 * -1.0;
    }

    var_0 = _id_6950(level._id_BC3B);
  } else {
    var_2 = level._id_41DC _id_07D6::_id_6C02();

    if(var_2 != "neutral") {
      var_1 = var_4;

      if(var_2 == "allies") {
        var_1 = var_1 * -1.0;
      }

      if(isDefined(level._id_41DC._id_37F6) && level._id_41DC._id_37F6 != "none") {
        if(level._id_41DC._id_37F6 != var_2) {
          var_4 = var_4 * 2;
          var_3 = level._id_41DC _id_07D6::_id_694C();

          if(level._id_41DC._id_37F6 == "allies") {
            var_3 = var_3 * -1.0;
          }
        }
      }
    } else {
      var_3 = level._id_41DC _id_07D6::_id_694C();

      if(isDefined(level._id_41DC._id_37F6) && level._id_41DC._id_37F6 != "none") {
        if(level._id_41DC._id_37F6 == "allies") {
          var_3 = var_3 * -1.0;
        }
      } else if(isDefined(level._id_41DC._id_8FAD)) {
        if(level._id_41DC._id_8FAD == "allies") {
          var_3 = var_3 * -1.0;
        }
      }
    }
  }

  return var_0 + var_1 + var_3 * var_4 + var_5;
}

_id_6950(var_0) {
  var_1 = 0.0;

  switch (var_0) {
    case 0:
      var_1 = 0.0;
      break;
    case 1:
      var_1 = 0.25;
      break;
    case 2:
      var_1 = 0.5;
      break;
    case 3:
      var_1 = 0.75;
      break;
    case 4:
      var_1 = 1.0;
      break;
  }

  return var_1;
}

_id_FD5D() {
  if(1) {
    scripts\mp\gamescore::_id_0CF2("allies", 0, 0);
    scripts\mp\gamescore::_id_0CF2("axis", 0, 0);
  }
}

_id_E314(var_0, var_1) {
  var_2 = level._id_8C8D;

  if(var_1 == "attacker" && var_2 != 1 && var_2 != 3) {
    return;
  }
  if(var_1 == "defender" && var_2 != 2 && var_2 != 3) {
    return;
  }
  if(!isDefined(level._id_8C2F)) {
    level._id_8C2F = [];
    level._id_8C2F["allies"] = [];
    level._id_8C2F["axis"] = [];
  }

  if(isDefined(level._id_8C2F[var_0][var_1])) {
    return;
  }
  var_3 = undefined;

  switch (level.mapname) {
    case "mp_faridah":
      if(var_1 == "attacker") {
        if(var_0 == "allies") {
          var_3 = (250, -2040, 215);
        } else {
          var_3 = (786, 2413, 260);
        }
      } else if(var_1 == "defender") {
        if(var_0 == "allies") {
          var_3 = (25, -4630, 10);
        } else {
          var_3 = (1480, 4375, -40);
        }
      }

      break;
    case "mp_anvil":
      if(var_1 == "attacker") {
        if(var_0 == "allies") {
          var_3 = (2775, 2375, 360);
        } else {
          var_3 = (-60, -260, 450);
        }
      } else if(var_1 == "defender") {
        if(var_0 == "allies") {
          var_3 = (-2680, -855, 250);
        } else {
          var_3 = (2365, 4360, 360);
        }
      }

      break;
  }

  if(isDefined(var_3)) {
    level._id_8C2F[var_0][var_1] = _id_6FAD(var_0, var_3, "juggernaut");
    level._id_8C2F[var_0][var_1] thread _id_C4F7(var_0, var_1);
  }
}

_id_C4F7(var_0, var_1) {
  level endon("game_ended");
  self waittill("death");
  level._id_8C2F[var_0][var_1] = undefined;
}

_id_6FA8() {
  if(!isPlayer(self)) {
    return 0;
  }

  if(istrue(self._id_88DF)) {
    return 0;
  }

  if(isDefined(self._id_9457)) {
    _id_0A6B::_id_FAB6();
  }

  _id_07EA::_id_D5E2(self, 500, 1, 0);
  self disableweaponpickup();
  scripts\mp\weapons::_id_D657(0);
  scripts\common\utility::_id_1562(0);

  if(scripts\mp\utility\perk::_hasperk("specialty_explosivebullets")) {
    scripts\mp\utility\perk::removeperk("specialty_explosivebullets");
  }

  scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_034C);
  scripts\cp_mp\utility\inventory_utility::_takeweapon(self._id_03B5);
  var_0 = "s4_ar_stango44";
  scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0);
  self givemaxammo(var_0);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(var_0);
  scripts\mp\teams::_id_D5C3();
  self._id_8C89 = newclienthudelem(self);
  self._id_8C89.x = 0;
  self._id_8C89.y = 0;
  self._id_8C89.alignx = "left";
  self._id_8C89.aligny = "top";
  self._id_8C89.horzalign = "fullscreen";
  self._id_8C89.vertalign = "fullscreen";
  self._id_8C89 setshader("gasmask_overlay_delta", 640, 480);
  self._id_8C89.sort = -10;
  self._id_8C89.archived = 1;
  self._id_8C89.alpha = 1.0;
  self.health = self.maxhealth;
  self._id_88DF = 1;
  self._id_A25F = 0.75;
  scripts\mp\utility\perk::_id_6FC2("specialty_scavenger");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  scripts\mp\utility\perk::_id_6FC2("specialty_sharp_focus");
  thread _id_8C7D();
  thread _id_8C8C();
  level notify("gained_juggernaut", self);
  return 1;
}

_id_8C7D() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("jugg_removed");

  for(;;) {
    wait 3.0;
  }
}

_id_8C8C() {
  self endon("disconnect");
  thread _id_C4D9();
  thread _id_C4DA();
  self waittill("should_remove_jugg");

  if(isDefined(self._id_9457)) {
    _id_0A6B::_id_FAB6();
  }

  self enableweaponpickup();
  scripts\mp\weapons::_id_D657(1);
  scripts\common\utility::_id_1562(1);
  self._id_8C89 destroy();
  scripts\cp_mp\utility\inventory_utility::_takeweapon("s4_ar_stango44");
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_034C);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(self._id_03B5);
  scripts\cp_mp\utility\inventory_utility::_switchtoweapon(self._id_034C);
  self._id_A25F = 1.0;
  scripts\mp\utility\perk::removeperk("specialty_scavenger");
  scripts\mp\utility\perk::removeperk("specialty_quickdraw");
  scripts\mp\utility\perk::removeperk("specialty_sharp_focus");
  self._id_88DF = 0;
  level notify("removed_juggernaut", self);
  self notify("jugg_removed");
}

_id_C4D9() {
  self endon("disconnect");
  self endon("jugg_removed");
  level waittill("game_ended");
  self notify("should_remove_jugg");
}

_id_C4DA() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("jugg_removed");
  scripts\engine\utility::_id_10882("death", "joined_team", "joined_spectators", "lost_juggernaut");
  self notify("should_remove_jugg");
}

_id_FC66(var_0, var_1) {
  if(!isDefined(self._id_A432)) {
    return;
  }
  var_2 = self._id_ADAE;
  var_3 = self._id_37F6;
  var_4 = var_0.team;
  var_5 = var_0 _meth_81D3();

  if(var_5) {
    var_4 = var_0 _meth_8154();
  }

  if(istrue(var_1)) {
    _id_78EE(var_0);
  } else if(istrue(self._id_E57B)) {
    _id_DC92(var_0);
  } else if(var_2 == "neutral") {
    if(var_3 != "none") {
      if(var_4 == var_3) {
        _id_DCAC(var_0);
      } else {
        _id_DC9E(var_0);
      }
    } else
      _id_DCC9(var_0);
  } else if(var_4 == var_2)
    _id_DCAC(var_0);
  else {
    _id_DC9E(var_0);
  }

  _id_FC26(var_0);
}

_id_FC26(var_0) {
  if(1) {
    return;
  }
  if(!isDefined(self._id_A432)) {
    return;
  }
  var_1 = _id_07D6::_id_695F();
  var_2 = var_0.team;
  var_3 = var_0 _meth_81D3();

  if(var_3) {
    var_2 = var_0 _meth_8154();
  }

  if(istrue(self._id_E57B)) {
    _id_78EF(var_0);
  } else if(var_1 == "none") {
    _id_78EF(var_0);
  } else if(var_2 == var_1) {
    _id_DCAD(var_0);
  } else {
    _id_DC9F(var_0);
  }
}

_id_DCC9(var_0) {
  foreach(var_2 in self._id_5FA3) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_540C) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_3BED) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_A432) {
    var_2 showtoplayer(var_0);
  }
}

_id_DCAC(var_0) {
  foreach(var_2 in self._id_5FA3) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self._id_540C) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_3BED) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_A432) {
    var_2 hidefromplayer(var_0);
  }
}

_id_DC9E(var_0) {
  foreach(var_2 in self._id_5FA3) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_540C) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self._id_3BED) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_A432) {
    var_2 hidefromplayer(var_0);
  }
}

_id_DC92(var_0) {
  foreach(var_2 in self._id_5FA3) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_540C) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_3BED) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self._id_A432) {
    var_2 hidefromplayer(var_0);
  }
}

_id_78EE(var_0) {
  foreach(var_2 in self._id_5FA3) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_540C) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_3BED) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_A432) {
    var_2 hidefromplayer(var_0);
  }
}

_id_DCAD(var_0) {
  foreach(var_2 in self._id_5FBA) {
    var_2 showtoplayer(var_0);
  }

  foreach(var_2 in self._id_5426) {
    var_2 hidefromplayer(var_0);
  }
}

_id_DC9F(var_0) {
  foreach(var_2 in self._id_5FBA) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_5426) {
    var_2 showtoplayer(var_0);
  }
}

_id_78EF(var_0) {
  foreach(var_2 in self._id_5FBA) {
    var_2 hidefromplayer(var_0);
  }

  foreach(var_2 in self._id_5426) {
    var_2 hidefromplayer(var_0);
  }
}

_id_FC67() {}

_id_19EE() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self _meth_840B();
}

_id_C533() {
  self _meth_840A();
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
  wait 1.0;
  var_2 = gettime();

  if(!isDefined(self._id_9046) || var_2 < self._id_9046 + 30000 || var_2 < level._id_90A3[self.team] + 5000) {
    return;
  }
  _id_0A8D::_id_DD6B(_id_6D2C());
  thread _id_B8D2(self, "plrresponse_affirm", "cop_affirm_2d", 2.5, 1);
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

_id_AAF6() {
  level waittill("game_ended");

  foreach(var_1 in level._id_A8E8) {
    var_1 _id_07D6::_id_D8E0("none");
  }
}

_id_B39B(var_0) {
  self setclientomnvar("ui_total_fade", 0);
  waitframe();
  var_1 = 10;
  var_2 = var_1;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    waitframe();
    self setclientomnvar("ui_total_fade", var_2 / var_1);
  }

  if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::_id_8ACE() && isDefined(var_0)) {
    var_3 = distance2dsquared(self.origin, var_0.origin);

    if(var_3 > 40000) {
      var_4 = self cloneplayer(0);
      var_4 startragdoll(1);
    }
  }

  thread scripts\mp\playerlogic::_id_E30E(var_0, "spectator");
  waitframe();
  var_1 = 4;
  var_2 = var_1;

  for(var_2 = var_1 - 1; var_2 >= 0; var_2--) {
    waitframe();
    self setclientomnvar("ui_total_fade", var_2 / var_1);
  }
}

_id_6D2C() {
  var_0 = "sitrep_" + level._id_41DE + "_" + level.mapname;
  return var_0;
}

_id_694B(var_0) {
  var_1 = "cop_obj_" + level._id_41DE + "_" + var_0 + "_" + level.mapname;
  return var_1;
}

_id_6D20(var_0) {
  var_1 = "";
  var_2 = "";
  var_3 = 0;

  switch (level._id_41DE) {
    case 0:
      if(var_0 == "planting") {
        var_1 = "arming_bomb";
        var_2 = "cop_arming_bomb_2d";
        var_3 = 1;
      } else if(var_0 == "defusing") {
        var_1 = "bomb_defusing";
        var_2 = "cop_bomb_defusing_2d";
        var_3 = 1;
      }

      break;
    case 1:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        if(self.team == "axis") {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        } else if(level.mapname == "mp_faridah") {
          var_1 = "objsecured_school";
          var_2 = "cop_school_captured_2d";
        } else {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 2:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        var_1 = "objsecured_generic";
        var_2 = "cop_generic_captured_2d";
      }

      break;
    case 3:
      if(var_0 == "capturing") {
        var_2 = "";
      } else if(var_0 == "captured") {
        if(level.mapname == "mp_faridah") {
          var_1 = "objsecured_warehouse";
          var_2 = "cop_warehouse_captured_2d";
        } else {
          var_1 = "objsecured_generic";
          var_2 = "cop_generic_captured_2d";
        }
      }

      break;
    case 4:
      if(var_0 == "planting") {
        var_1 = "arming_bomb";
        var_2 = "cop_arming_bomb_2d";
        var_3 = 1;
      } else if(var_0 == "defusing") {
        var_1 = "bomb_defusing";
        var_2 = "cop_bomb_defusing_2d";
        var_3 = 1;
      }

      break;
  }

  var_4 = 0;

  if(var_3 && !scripts\mp\battlechatter_mp::_id_CB08(var_2)) {
    scripts\mp\battlechatter_mp::_id_FC2A(var_2);
    thread _id_B8D2(self, var_1, var_2, 1.5);
  } else if(!var_3)
    thread _id_B8D2(self, var_1, var_2, 1.5);

  var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "afp1");
  }

  var_6 = "dx_mpp_" + var_5 + "_" + var_1;
  return _func_0142(var_6) / 1000;
}

_id_B8D2(var_0, var_1, var_2, var_3, var_4) {
  if(isai(self)) {
    return;
  }
  level endon("game_ended");
  self endon("death");

  if(isDefined(var_3)) {
    wait(var_3);
  }

  var_5 = scripts\engine\utility::ter_op(self.team == "allies", "usp1", "abp1");

  if(level.mapname == "mp_faridah") {
    var_5 = scripts\engine\utility::ter_op(var_0.team == "allies", "usp1", "afp1");
  }

  var_6 = "dx_mpp_" + var_5 + "_" + var_1;

  if(isDefined(var_4)) {
    var_7 = var_6;

    if(_func_0205(var_7)) {
      var_6 = var_7;
    }
  }

  var_0 _meth_8287(var_6, var_2, 2);
}

_id_6973(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level.players) {
    if(var_5.team == var_1 && scripts\mp\utility\player::isreallyalive(var_5)) {
      var_6 = distance2dsquared(var_5.origin, var_0);

      if(!isDefined(var_3) || var_6 < var_3) {
        var_2 = var_5;
        var_3 = var_6;
      }
    }
  }

  return var_2;
}

_id_4AD2() {
  level waittill("game_ended");

  if(isDefined(level._id_41DC) && isDefined(level._id_41DC._id_AAB5)) {
    level._id_41DC[[level._id_41DC._id_AAB5]]();
  }
}

_id_D855() {
  if(getdvarint("#x3c6ccb68378eed2df", 0) != 1) {
    return;
  }
  wait 2.0;
  var_0 = [];
  var_0[var_0.size] = _id_E2ED((350, -3580, -35), (0, -151, 0));
  var_0[var_0.size] = _id_E2ED((345, -3650, -35), (0, 140, 0));
  var_0[var_0.size] = _id_E2ED((235, -3655, -35), (0, 50, 0));
  var_0[var_0.size] = _id_E2ED((230, -3575, -35), (0, -40, 0));
  level._id_A8E8["0"]._id_CF26 = var_0;
  var_1 = [];
  var_1[var_1.size] = _id_E2ED((-457, -2006, 204), (0, 331, 0), 0);
  var_1[var_1.size] = _id_E2ED((-31, -1915, 192), (45, 48, 0), 0);
  var_1[var_1.size] = _id_E2ED((-319, -1706, 209), (0, 130, 0), 0);
  var_1[var_1.size] = _id_E2ED((-545, -1805, 207), (0, 130, 0), 0);
  var_1[var_1.size] = _id_E2ED((-302, -2137, 152), (0, 234, 0));
  level._id_A8E8["1"]._id_CF26 = var_1;
  var_2 = [];
  var_2[var_2.size] = _id_E2ED((420, -23, 17), (5, 208, 0));
  var_2[var_2.size] = _id_E2ED((458, 59, 109), (0, 342, 0), 0);
  var_2[var_2.size] = _id_E2ED((380, -267, 17), (0, 186, 0));
  var_2[var_2.size] = _id_E2ED((210, 126, 18), (5, 125, 0));
  var_2[var_2.size] = _id_E2ED((675, 118, 18), (0, 41, 0));
  var_2[var_2.size] = _id_E2ED((638, -180, 18), (5, 356, 0));
  var_2[var_2.size] = _id_E2ED((417, 105, 69), (75, 285, 0), 0);
  var_2[var_2.size] = _id_E2ED((426, -177, 17), (5, 73, 0), 0);
  var_2[var_2.size] = _id_E2ED((509, -116, 69), (55, 82, 0), 0);
  var_2[var_2.size] = _id_E2ED((331, 60, 63), (0, 309, 0), 0);
  var_2[var_2.size] = _id_E2ED((578, 65, 62), (40, 197, 0), 0);
  level._id_A8E8["2"]._id_CF26 = var_2;
  var_3 = [];
  var_3[var_3.size] = _id_E2ED((812, 2074, 222), (35, 326, 0), 0);
  var_3[var_3.size] = _id_E2ED((431, 1882, 241), (5, 86, 0), 0);
  var_3[var_3.size] = _id_E2ED((762, 2333, 226), (15, 345, 0), 0);
  var_3[var_3.size] = _id_E2ED((609, 1861, 223), (65, 339, 0), 0);
  var_3[var_3.size] = _id_E2ED((580, 2150, 212), (0, 272, 0), 0);
  level._id_A8E8["3"]._id_CF26 = var_3;
  var_4 = [];
  var_4[var_4.size] = _id_E2ED((1300, 3335, 12), (0, 40, 0));
  var_4[var_4.size] = _id_E2ED((1305, 3430, -2), (0, -47, 0));
  var_4[var_4.size] = _id_E2ED((1430, 3435, -3), (0, -135, 0));
  var_4[var_4.size] = _id_E2ED((1430, 3350, 3), (0, 140, 0));
  level._id_A8E8["4"]._id_CF26 = var_4;

  if(getdvarint("#x3cad5cd3cdc045287", 0) == 1) {
    thread _id_44BE();
  }
}

_id_E2ED(var_0, var_1, var_2) {
  var_3 = var_0;

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(var_2) {
    var_3 = scripts\engine\utility::_id_5000(var_0, 50, -200, (0, 0, 1));
  }

  var_4 = spawn("script_model", var_3 + (0, 0, 2));
  var_4.angles = var_1 + (0, 180, 0);
  var_4 setModel("cop_marker_scriptable");
  return var_4;
}

_id_FC65(var_0) {
  if(getdvarint("#x3c6ccb68378eed2df", 0) != 1) {
    return;
  }
  self notify("updateFlares");
  self endon("updateFlares");

  while(!isDefined(self._id_CF26)) {
    waitframe();
  }

  foreach(var_2 in self._id_CF26) {
    var_2 setscriptablepartstate("marker", var_0);
  }
}

_id_44BE() {
  var_0 = 0;

  for(;;) {
    var_1 = 0;

    switch (var_0) {
      case 0:
        var_1 = "allies";
        break;
      case 1:
        var_1 = "axis";
        break;
      case 2:
        var_1 = "contested";
        break;
      case 3:
        var_1 = "idle";
        break;
    }

    foreach(var_3 in level._id_A8E8) {
      if(!isDefined(var_3._id_CF26)) {
        continue;
      }
      foreach(var_5 in var_3._id_CF26) {
        var_5 setscriptablepartstate("marker", var_1);
      }
    }

    var_0++;

    if(var_0 > 3) {
      var_0 = 0;
    }

    wait 3.0;
  }
}

_id_9ABF(var_0) {
  switch (level.mapname) {
    case "mp_faridah":
      switch (self._id_A8E1) {
        case "0":
          self._id_7C73 = "_bombsite";
          break;
        case "1":
          self._id_7C73 = "_school";
          break;
        case "2":
          self._id_7C73 = "_clocktower";
          break;
        case "3":
          self._id_7C73 = "_warehouse";
          break;
        case "4":
          self._id_7C73 = "_bombsite";
          break;
        default:
          self._id_7C73 = "";
          break;
      }

      break;
    default:
      switch (self._id_A8E1) {
        case "0":
          self._id_7C73 = "_generic";
          break;
        case "1":
          self._id_7C73 = "_generic";
          break;
        case "2":
          self._id_7C73 = "_generic";
          break;
        case "3":
          self._id_7C73 = "_generic";
          break;
        case "4":
          self._id_7C73 = "_generic";
          break;
        default:
          self._id_7C73 = "";
          break;
      }

      break;
  }
}

_id_FCDE() {
  if(!isDefined(level._id_41DC._id_ABEB)) {
    return;
  }
  level notify("updateOOBTriggers");

  foreach(var_1 in level.players) {
    if(isDefined(level._id_41DC._id_ABEB["allies"])) {
      level._id_41DC._id_ABEB["allies"] thread _id_FCDF("axis");
    }

    if(isDefined(level._id_41DC._id_ABEB["axis"])) {
      level._id_41DC._id_ABEB["axis"] thread _id_FCDF("allies");
    }
  }
}

_id_FCDF(var_0) {
  self notify("updateOOBVisuals");
  self endon("updateOOBVisuals");

  while(!isDefined(self._id_10430)) {
    waitframe();
  }

  foreach(var_2 in self._id_10430) {
    for(var_3 = 0; var_3 < var_2._id_4F3B; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, var_0);
    }
  }

  level waittill("updateOOBTriggers");

  foreach(var_2 in self._id_10430) {
    for(var_3 = 0; var_3 < var_2._id_4F3B; var_3++) {
      var_2 setscriptablepartstate("chevron_" + var_3, "off");
    }
  }
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

_id_DCE8(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(var_0 == "all" || var_3.team == var_0) {
      var_3 thread scripts\mp\hud_message::showsplash(var_1);
    }
  }
}