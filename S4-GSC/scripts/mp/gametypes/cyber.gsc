/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cyber.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "blocker";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 3, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 150);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 4);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2CE(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2CF(scripts\mp\utility\game::getgametype(), 4);
  }

  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_A543 = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_AAA3 = ::_id_AAA3;
  level._id_AB47 = ::_id_AB47;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB3F = ::_id_AB3F;
  level._id_60D0 = scripts\mp\utility\game::_id_899A;
  level._id_AAD9 = ::_id_AAD9;
  level._id_C650 = scripts\mp\gametypes\obj_bombzone::_id_C650;
  level._id_15BE = 0;
  level._id_2663 = 0;
  level._id_2665 = undefined;
  level._id_265C = 0;
  game["canScoreOnTie"] = 1;
  game["dialog"]["gametype"] = "gametype_cyberattack";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  if(!isDefined(game["roundsPlayed"])) {
    var_1 = "boost_cyberattack";
  } else {
    var_1 = "boost_cyberattack_short";
  }

  game["dialog"]["offense_obj"] = var_1;
  game["dialog"]["defense_obj"] = var_1;
  game["dialog"]["emppickup_friendly"] = "emppickup_friendly";
  game["dialog"]["emppickup_friendly_first"] = "emppickup_friendly_first";
  game["dialog"]["emppickup_enemy"] = "emppickup_enemy";
  game["dialog"]["empdefused_friendly"] = "empdefused_friendly";
  game["dialog"]["empdefused_final_friendly"] = "empdefused_final_friendly";
  game["dialog"]["empdefused_enemy"] = "empdefused_enemy";
  game["dialog"]["empdefused_final_enemy"] = "empdefused_final_enemy";
  game["dialog"]["empplanted_friendly"] = "empplanted_friendly";
  game["dialog"]["empplanted_enemy"] = "empplanted_enemy";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_taken"] = "null";
  setomnvar("ui_bomb_carrier", -1);
  setomnvar("ui_bomb_owner_team", -1);
  setomnvar("ui_bomb_interacting", 0);
  setomnvar("ui_bomb_timer_endtime_a", 0);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3fdb2e786ce73405e", getmatchrulesdata("cyberData", "empSpawn"));
  setdynamicdvar("#x3619c9e4d6e81d2a4", getmatchrulesdata("cyberData", "radarPingTime"));
  setdynamicdvar("#x34dea0d96525bf844", getmatchrulesdata("cyberData", "persBombTimer"));
  setdynamicdvar("#x3f3ebdf6cb5d759d7", getmatchrulesdata("cyberData", "detonateScore"));
  setdynamicdvar("#x3dd9319874c24fccd", getmatchrulesdata("commonOption", "enemyDeathLoc"));
  setdynamicdvar("#x3c19dfddaad1d6f2c", getmatchrulesdata("bombData", "bombTimer"));
  setdynamicdvar("#x3542f692011a98035", getmatchrulesdata("bombData", "plantTime"));
  setdynamicdvar("#x3edb46eeb444e8f00", getmatchrulesdata("bombData", "defuseTime"));
  setdynamicdvar("#x333d9bb039d50b838", getmatchrulesdata("bombData", "multiBomb"));
  setdynamicdvar("#x341cd51169b05d8ee", getmatchrulesdata("carryData", "showEnemyCarrier"));
  setdynamicdvar("#x3d606cdca26b510e1", getmatchrulesdata("carryData", "idleResetTime"));
  setdynamicdvar("#x35c5340d264aa0c4e", getmatchrulesdata("carryData", "pickupTime"));
  setdynamicdvar("#x3450b23976693df3", 0);
  scripts\mp\utility\game::_id_C25D("cyber", 0);
}

_id_10974() {
  _id_07D1::_id_60C2("prematch_done");
  level._id_AD53 = 1;
}

_id_AB7F() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
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

  setclientnamemode("manual_change");
  level._effect["emp_detonation"] = loadfx("vfx/iw8_mp/equipment/emp/vfx_emp_main_blast.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::_id_D61C(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::_id_D61C(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  _id_429B();
  _id_8294();
  thread _id_E6E8();
  thread _id_10974();
  _id_D8C5();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_51C0 = scripts\mp\utility\dvars::_id_509C("empSpawn", 0, 0, 4);
  level._id_BF14 = 4;
  level._id_B00D = scripts\mp\utility\dvars::_id_509C("persBombTimer", 0, 0, 1);
  level._id_48CF = scripts\mp\utility\dvars::_id_509C("detonateScore", 1, 0, 5);
  level._id_2682 = scripts\mp\utility\dvars::_id_509A("bombtimer", 30, 1, 300);
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 1, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 1, 0, 20);
  level._id_A2F7 = scripts\mp\utility\dvars::_id_509C("multibomb", 0, 0, 1);
  level._id_DCA0 = scripts\mp\utility\dvars::_id_509C("showEnemyCarrier", 5, 0, 6);
  level._id_7CD0 = scripts\mp\utility\dvars::_id_509A("idleResetTime", 0, 0, 60);
  level._id_B0B3 = scripts\mp\utility\dvars::_id_509A("pickupTime", 0, 0, 10);
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_1136(game["attackers"], "mp_cyber_spawn_allies");
  _id_0817::_id_1136(game["defenders"], "mp_cyber_spawn_axis");
  var_0 = _id_0817::_id_6D4E("mp_cyber_spawn_allies");
  var_1 = _id_0817::_id_6D4E("mp_cyber_spawn_axis");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_ctf_spawn");
  _id_0817::_id_1136("axis", "mp_ctf_spawn");

  if(scripts\mp\utility\game::_id_6A65() != 1) {
    _id_1D26();
    level._id_429D["allies"] = "allies";
    level._id_429D["axis"] = "axis";
    _id_0817::_id_C2B9("allies", level._id_EFAB["allies"]);
    _id_0817::_id_C2B9("axis", level._id_EFAB["axis"]);
    _id_0817::_id_C2B9("neutral", level._id_EFAB["neutral"]);
  }

  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  _id_0817::_id_D461("StartSpawn", "Crit_Default");
  var_0 = self.pers["team"];

  if(scripts\mp\utility\game::_id_6A65() != 1) {
    if(_id_0817::_id_DC06()) {
      if(var_0 == game["attackers"]) {
        var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
      } else {
        var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
      }
    } else
      var_1 = _id_0817::_id_6D4A(self, var_0, level._id_429D[var_0], "neutral");
  } else if(var_0 == game["attackers"])
    var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
  else {
    var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
  }

  return var_1;
}

_id_1D26() {
  level._id_E32D = "mp_ctf_spawn";
  var_0 = _id_0817::_id_6D4E(level._id_E32D);
  var_1 = _id_0817::_id_8974();
  level._id_EFAB["axis"] = [];
  level._id_EFAB["allies"] = [];
  level._id_EFAB["neutral"] = [];

  if(level._id_A8E8.size == 2) {
    var_2 = level._id_A8E8["axis"];
    var_3 = level._id_A8E8["allies"];
    var_4 = (var_2._id_4140[0], var_2._id_4140[1], 0);
    var_5 = (var_3._id_4140[0], var_3._id_4140[1], 0);
    var_6 = var_5 - var_4;
    var_7 = _func_0133(var_6);

    foreach(var_9 in var_0) {
      var_10 = (var_9.origin[0], var_9.origin[1], 0);
      var_11 = var_10 - var_4;
      var_12 = vectordot(var_11, var_6);
      var_13 = var_12 / (var_7 * var_7);

      if(var_13 < 0.33) {
        var_9._id_EF64 = var_2._id_ADAE;
        level._id_EFAB[var_9._id_EF64][level._id_EFAB[var_9._id_EF64].size] = var_9;
        continue;
      }

      if(var_13 > 0.67) {
        var_9._id_EF64 = var_3._id_ADAE;
        level._id_EFAB[var_9._id_EF64][level._id_EFAB[var_9._id_EF64].size] = var_9;
        continue;
      }

      var_14 = undefined;
      var_15 = undefined;

      if(var_1) {
        var_14 = _func_00C4(var_9.origin, var_2._id_4140, 999999);
      }

      if(isDefined(var_14) && var_14 != -1) {
        var_15 = _func_00C4(var_9.origin, var_3._id_4140, 999999);
      }

      if(!isDefined(var_15) || var_15 == -1) {
        var_14 = distance2d(var_2._id_4140, var_9.origin);
        var_15 = distance2d(var_3._id_4140, var_9.origin);
      }

      var_16 = max(var_14, var_15);
      var_17 = min(var_14, var_15);
      var_18 = var_17 / var_16;

      if(var_18 > 0.5) {
        level._id_EFAB["neutral"][level._id_EFAB["neutral"].size] = var_9;
      }
    }
  } else {
    foreach(var_9 in var_0) {
      var_9._id_EF64 = _id_6B71(var_9);

      if(var_9._id_EF64 == "axis") {
        level._id_EFAB["axis"][level._id_EFAB["axis"].size] = var_9;
        continue;
      }

      level._id_EFAB["allies"][level._id_EFAB["allies"].size] = var_9;
    }
  }
}

_id_6B71(var_0) {
  var_1 = _id_0817::_id_8974();
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in level._id_A8E8) {
    var_6 = undefined;

    if(var_1) {
      var_6 = _func_00C4(var_0.origin, var_5._id_4140, 999999);
    }

    if(!isDefined(var_6) || var_6 == -1) {
      var_6 = distancesquared(var_5._id_4140, var_0.origin);
    }

    if(!isDefined(var_2) || var_6 < var_3) {
      var_2 = var_5;
      var_3 = var_6;
    }
  }

  return scripts\mp\utility\game::_id_6BE2(var_2._id_ADAE)[0];
}

_id_429B() {
  var_0 = getEntArray("cyber_emp_pickup_trig", "targetname");

  if(var_0.size == 0) {
    scripts\engine\utility::_id_5598("No cyber_emp_pickup_trig triggers found in map. Please bug this to the level designer.");
    return;
  }

  if(level._id_51C0 == 3) {
    if(isDefined(game["empSpawn"])) {
      var_1 = [0, 1, 2];
      var_1 = scripts\engine\utility::array_remove(var_1, game["empSpawn"]);
      level._id_51C0 = scripts\engine\utility::random(var_1);
      game["empSpawn"] = level._id_51C0;
    } else {
      level._id_51C0 = randomintrange(0, 3);
      game["empSpawn"] = level._id_51C0;
    }
  }

  if(level._id_51C0 == 4) {
    if(isDefined(game["empSpawn"])) {
      level._id_51C0 = game["empSpawn"] + 1;

      if(level._id_51C0 == 3) {
        level._id_51C0 = 0;
      }

      game["empSpawn"] = level._id_51C0;
    } else {
      level._id_51C0 = 0;
      game["empSpawn"] = level._id_51C0;
    }
  }

  var_2 = var_0[level._id_51C0];
  var_3 = getEntArray("cyber_emp", "targetname");
  var_4[0] = var_3[level._id_51C0];

  if(!isDefined(var_4[0])) {
    scripts\engine\utility::_id_5598("No cyber_emp script_model found in map. Please bug this to the level designer.");
    return;
  }

  var_4[0] setModel("offhand_wm_emp");
  var_4[0].origin = var_4[0].origin;
  var_5 = var_4[0].origin + (0, 0, 32);
  var_6 = var_4[0].origin + (0, 0, -100);
  var_7 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 1, 1, 1);
  var_8 = [var_4[0]];
  var_9 = scripts\engine\trace::ray_trace(var_5, var_6, var_8, var_7);

  if(var_9["fraction"] < 1) {
    var_4[0].origin = var_9["position"] + (0, 0, 2);
  }

  var_4[0].angles = vectortoangles(var_9["normal"]) + (180, 0, 0);

  for(var_10 = 0; var_10 < var_3.size; var_10++) {
    if(var_10 == level._id_51C0) {
      continue;
    }
    var_3[var_10] delete();
  }

  var_2 _meth_80DB();
  var_2 linkto(var_4[0]);
  var_2._id_A51C = 1;
  var_2._id_9514 = 1;
  var_2._id_2323 = var_2.origin;
  var_2._id_A51C = 1;

  if(!level._id_A2F7) {
    level._id_429C = _id_07D6::_id_3FA8("neutral", var_2, var_4, (0, 0, 16), undefined, 1);
    level._id_429C._id_316A = 1;
    level._id_429C._id_E57B = 0;
    level._id_429C._id_10A20 = 1;
    level._id_429C _id_07D6::_id_15DF("any");
    level._id_429C._id_4143 = 0;
    level._id_429C._id_FEE7 = 0.05;
    level._id_429C._id_FEB1 = 1;
    level._id_429C._id_7C8C = "";
    level._id_429C._id_56E2 = 0;
    level._id_429C._id_DDC9 = 1;
    level._id_429C._id_DDB5 = 1;
    level._id_429C._id_ABCB = ::_id_51C3;
    level._id_429C.trigger setcursorhint("HINT_NOICON");
    level._id_429C.trigger sethintstring(&"MP/EMP_PICKUP_USE");
    level._id_429C.trigger _meth_83A1(-300);
    level._id_429C _id_07D6::_id_D8D2(level._id_429C._id_FEE7);
    level._id_429C _id_07D6::_id_D8E3(0);
    level._id_429C._id_15E2 = 1;
    level._id_429C._id_AB4D = ::_id_AB4D;
    level._id_429C._id_AAB9 = ::_id_AAB9;
    level._id_429C._id_5BD9 = 1;
    level thread _id_51BF();
    level._id_2679 = level._id_429C._id_10430[0].origin;
    level._id_2678 = level._id_429C._id_10430[0].angles;
    level._id_429C._id_1042D = (0, 0, 2);
  } else {
    var_2 delete();
    var_4[0] delete();
  }

  if(!isDefined(getent("cyber_empzone_axis", "targetname"))) {
    scripts\engine\utility::_id_5598("No cyber_empzone_axis trigger found in map. Please bug this to the level designer.");
    return;
  }

  if(!isDefined(getent("cyber_empzone_allies", "targetname"))) {
    scripts\engine\utility::_id_5598("No cyber_empzone_allies trigger found in map. Please bug this to the level designer.");
    return;
  }

  if(!isDefined(getent("cyber_emp_defuse_axis", "targetname"))) {
    scripts\engine\utility::_id_5598("No cyber_emp_defuse_axis trigger found in map. Please bug this to the level designer.");
    return;
  }

  if(!isDefined(getent("cyber_emp_defuse_allies", "targetname"))) {
    scripts\engine\utility::_id_5598("No cyber_emp_defuse_allies trigger found in map. Please bug this to the level designer.");
    return;
  }

  if(game["switchedsides"]) {
    level._id_A8E8["allies"] = _id_3F9A("allies", getent("cyber_empzone_axis", "targetname"), getent("cyber_emp_defuse_axis", "targetname"));
    level._id_A8E8["axis"] = _id_3F9A("axis", getent("cyber_empzone_allies", "targetname"), getent("cyber_emp_defuse_allies", "targetname"));
  } else {
    level._id_A8E8["allies"] = _id_3F9A("allies", getent("cyber_empzone_allies", "targetname"), getent("cyber_emp_defuse_allies", "targetname"));
    level._id_A8E8["axis"] = _id_3F9A("axis", getent("cyber_empzone_axis", "targetname"), getent("cyber_emp_defuse_axis", "targetname"));
  }

  level notify("enable_player_usability");
  level._id_A8E8["axis"] thread _id_4351();
  level._id_A8E8["allies"] thread _id_4351();

  if(level.mapname == "mp_hackney_yard") {
    thread _id_4865();
  }
}

_id_E6E8() {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    level scripts\engine\utility::waittill_any_2("prematch_done", "start_mode_setup");
  }

  level._id_A8E8["allies"] _id_07D6::_id_C579(1, 1);
  level._id_A8E8["allies"] _id_07D6::_id_D61B("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level._id_A8E8["allies"] _id_07D6::_id_D8E0("any");
  level._id_A8E8["axis"] _id_07D6::_id_C579(1, 1);
  level._id_A8E8["axis"] _id_07D6::_id_D61B("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  level._id_A8E8["axis"] _id_07D6::_id_D8E0("any");
  level thread _id_78ED();
  level._id_429C _id_07D6::_id_C579(1, 1);
  level._id_429C _id_07D6::_id_D61B("icon_waypoint_emp");
  level._id_429C _id_07D6::_id_D8E0("any");

  if(isDefined(level._id_429C._id_10430[0])) {
    level._id_429C._id_10430[0] scripts\mp\gametypes\obj_bombzone::_id_D713("neutral");
    level._id_429C._id_10430[0] setasgametypeobjective();
  }

  _id_07F9::_id_A8B1(level._id_429C._id_A908, 0);
  _id_07F9::_id_A8B2(level._id_429C._id_A908, 0);
  _func_0401(level._id_429C._id_A908, 1);
  var_0 = _id_07F9::_id_C57D(99);
  level._id_429C._id_B0E1 = var_0;
  _id_07F9::_id_A867(var_0, "done", level._id_429C.origin);
  level._id_429C _id_07D6::_id_D8E0("none", var_0);
  _func_0182(var_0, undefined);
  level._id_429C _id_07D6::_id_D61B("icon_waypoint_escort_emp", "waypoint_capture_kill", var_0);
  _id_D4B6();
}

_id_78ED() {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    level waittill("prematch_done");
  }

  _id_07F9::_id_A8B1(level._id_A8E8["allies"]._id_A908, 0);
  _id_07F9::_id_A8B2(level._id_A8E8["allies"]._id_A908, 0);
  _id_07F9::_id_A8C1(level._id_A8E8["allies"]._id_A908, 1);
  _id_07F9::_id_A8B1(level._id_A8E8["axis"]._id_A908, 0);
  _id_07F9::_id_A8B2(level._id_A8E8["axis"]._id_A908, 0);
  _id_07F9::_id_A8C1(level._id_A8E8["axis"]._id_A908, 1);
  level._id_A8E8["allies"] _id_07D6::_id_D8E0("none");
  level._id_A8E8["axis"] _id_07D6::_id_D8E0("none");
}

_id_51C3(var_0) {}

_id_3F9A(var_0, var_1, var_2) {
  var_3 = getEntArray(var_1.target, "targetname");
  var_3[0].origin = var_1.origin;
  var_4 = _id_07D6::_id_406E(var_0, var_1, var_3, (0, 0, 64), undefined, 1);
  var_4._id_ABCB = ::_id_ABCB;
  var_4._id_AA79 = ::_id_AA79;
  var_4._id_AAC2 = ::_id_AAC2;
  var_4._id_AA80 = ::_id_AA80;
  var_4.useweapon = makeweapon("emp_bomb_mp");
  var_4._id_7C8C = "bomb_zone";
  var_4.trigger _meth_83A1(-300);
  var_4.trigger setuseholdduration("duration_none");
  var_4.trigger _meth_84D1(1);
  var_4._id_2663 = 0;
  var_4._id_265C = undefined;
  var_4 _id_07D6::_id_D8D2(level._id_B1DA);
  var_4 _id_07D6::_id_D8E3(0);
  var_4._id_A8E1 = "_" + var_0;
  var_4.label = var_4._id_A8E1;
  var_4 _id_C605(1, undefined, 1);
  var_4 _id_07D6::_id_D8D1(&"MP/PLANTING_EXPLOSIVE");
  var_4 _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EXPLOSIVES");

  for(var_5 = 0; var_5 < var_3.size; var_5++) {
    if(isDefined(var_3[var_5]._id_0397)) {
      var_4._id_57CB = var_3[var_5]._id_0397;
      var_3[var_5] thread _id_D886(var_4);
      break;
    }
  }

  var_4._id_A6C9 = spawn("trigger_radius", var_4.trigger.origin, 0, 140, 100);
  var_4._id_4645 = var_2;
  return var_4;
}

_id_D886(var_0) {
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 rotateyaw(-45, 0.05);
  waitframe();
  var_2 = undefined;
  var_3 = self.origin + (0, 0, 45);
  var_4 = self.origin + anglesToForward(var_1.angles) * 100 + (0, 0, 128);
  var_5 = ["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_vehicle"];
  var_6 = physics_createcontents(var_5);
  var_7 = scripts\engine\trace::ray_trace(var_3, var_4, self, var_6);
  var_2 = var_7["position"];
  self.killcament = spawn("script_model", var_2);
  self.killcament _meth_8375("explosive");
  var_0._id_8D65 = self.killcament getentitynumber();
  var_1 delete();
}

_id_51BF() {
  level endon("game_ended");

  for(;;) {
    level waittill("bomb_pickup");

    if(level._id_429C._id_32D5.team == "allies") {
      level._id_A8E8["axis"] _id_D873();
    } else {
      level._id_A8E8["allies"] _id_D873();
    }

    waitframe();
  }
}

_id_4351() {
  var_0 = scripts\engine\utility::_id_E1E9(self.trigger.origin, self.trigger.angles);
  var_0 thread scripts\engine\utility::_id_B278("data_center_cyber_lp");
  level waittill("emp_detonated");
  var_0 _meth_83F8("data_center_cyber_lp");
  waitframe();
  var_0 delete();
}

_id_AA79(var_0) {
  if(!_id_07D6::_id_886F(var_0.pers["team"]) && !level._id_2663) {
    var_0._id_8986 = 1;
    setomnvar("ui_bomb_interacting", 1);
    _id_07D6::_id_D61B("icon_waypoint_defend_empsite", "icon_waypoint_emp_planting");
  } else {
    var_0._id_87F7 = 1;
    setomnvar("ui_bomb_interacting", 3);
    scripts\mp\utility\game::_id_D5FA(2, var_0.team, var_0 getentitynumber());
    _id_07D6::_id_D61B("icon_waypoint_defend_empsite_nt", "icon_waypoint_emp_defusing");
    _id_07F9::_id_A8C9(self._id_BF19, var_0.team);
  }

  var_0 thread _id_15B2(0);

  if(level._id_2663 && !_id_07D6::_id_886F(var_0.pers["team"])) {
    var_0 scripts\mp\bots\bots_util::_id_A66D("defuse");
    var_0._id_87F7 = 1;
    setomnvar("ui_bomb_interacting", 3);
    setomnvar("ui_bomb_defuser", var_0 getentitynumber());

    if(isDefined(level._id_429C._id_10430[0])) {
      level._id_429C._id_10430[0] hide();
    }

    var_0 thread _id_E6FD("briefcase_bomb_defuse_mp", "weap_suitcase_defuse_button");
  }
}

_id_15B2(var_0) {
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\mp\utility\player::_id_1543(var_0);

  if(var_0) {
    scripts\engine\utility::_id_108A7(0.8, "bomb_allow_offhands");
    scripts\common\utility::_id_1554(var_0);
    scripts\common\utility::_id_1553(var_0);
  } else {
    scripts\common\utility::_id_1554(var_0);
    scripts\common\utility::_id_1553(var_0);
  }

  scripts\common\utility::_id_1562(var_0);
}

_id_AAC2(var_0, var_1, var_2) {
  var_3 = self._id_A908;
  _id_07F9::_id_A8B4(var_3, 0);
  _id_07F9::_id_A8C4(var_3, 0);

  if(!var_2) {
    if(var_1._id_87F7) {
      _id_07D6::_id_D61B("icon_waypoint_defuse_empsite_nt", "icon_waypoint_defend_empsite_nt");
    } else {
      _id_07D6::_id_D61B("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
    }

    if(isDefined(self._id_BF19)) {
      _id_07F9::_id_A8C8(self._id_BF19, var_1.team);
    }

    var_1 _id_0A95::_id_EC3C();
  }

  var_1._id_8986 = 0;
  var_1._id_87F7 = 0;
  setomnvar("ui_bomb_defuser", -1);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 thread _id_15B2(1);
  var_1._id_2668 = undefined;

  if(isPlayer(var_1)) {
    var_1 setclientomnvar("ui_objective_state", 0);
    var_1._id_F90B = undefined;
  }

  if(!_id_07D6::_id_886F(var_1.pers["team"])) {
    if(isDefined(level._id_429C) && !var_2) {
      level._id_429C._id_10430[0] show();
    }
  }
}

_id_E6FD(var_0, var_1) {
  self endon("death");
  self endon("stopNpcBombSound");

  if(scripts\mp\utility\game::isanymlgmatch() || istrue(level._id_DD44) || scripts\mp\utility\perk::_hasperk("specialty_engineer")) {
    self _meth_84A8("silent_plant", "on");
    return;
  }

  for(;;) {
    self waittill("weapon_change", var_2);

    if(var_2.basename == var_0) {
      break;
    }
  }

  self playsoundtoteam(var_1, self.team, self);
  var_3 = scripts\mp\utility\game::_id_6BE2(self.team)[0];
  self playsoundtoteam(var_1, var_3);
  self waittill("weapon_change");
  self notify("stopNpcBombSound");
}

_id_AB4D(var_0, var_1, var_2) {
  level notify("bomb_pickup");
  var_3 = var_0 getcurrentprimaryweapon();

  if(isDefined(var_3.basename) && var_3.basename == "iw8_lm_dblmg_mp") {
    var_0 notify("switched_from_minigun");
  }

  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon("iw8_cyberemp_mp");

  if(!istrue(var_2) && !var_0 scripts\mp\utility\killstreak::_id_88DF() && !isbot(var_0)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate("iw8_cyberemp_mp");
  }

  var_0 thread _id_51BB();
  setomnvar("ui_bomb_carrier", var_0 getentitynumber());
  var_0 setclientomnvar("ui_emp_carrier_hud", 1);
  scripts\mp\utility\game::_id_D5FA(16, var_0.team, var_0 getentitynumber());

  if(self._id_5BD9) {
    var_0 thread _id_0A9F::_id_7003("emp_grab");
  }

  level._id_FED4 = 0;
  var_4 = var_0.pers["team"];

  if(var_4 == "allies") {
    var_5 = "axis";
  } else {
    var_5 = "allies";
  }

  var_0._id_8783 = 1;

  if(level.codcasterenabled) {
    var_0 _meth_80CB(1);
  }

  if(!isDefined(var_2)) {
    if(self._id_5BD9) {
      var_6 = "emppickup_friendly_first";
      self._id_5BD9 = 0;
    } else
      var_6 = "emppickup_friendly";

    _id_0A8D::_id_9136(var_6, var_4, "bomb");
    _id_0A8D::_id_9136("emppickup_enemy", var_5, "bomb");
    _id_0AA2::_id_B8F1(game["bomb_recovered_sound"], var_4);
    var_7 = scripts\mp\utility\teams::_id_6DCA(var_0.team, "players");
    level thread scripts\mp\hud_message::_id_A6B6("emp_pickup", "emp_pickup_enemy", var_0.team, var_7);
    var_0 thread scripts\mp\hud_message::showsplash("emp_pickup");
    level thread scripts\mp\hud_util::_id_EF8D("callout_emppickup", var_0, var_0.team, undefined, 1);
  }

  level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 5, 6, var_0, 2);
  self._id_A97E = (0, 0, 75);
  _id_07D6::_id_D639(var_4);
  _id_07D6::_id_15DF("none");

  if(isDefined(level._id_DCA0)) {
    if(level._id_DCA0 == 0) {
      _id_07D6::_id_D8E0("friendly");
      _func_016B(self._id_B0E1, "done");
    } else {
      _id_07D6::_id_D8E0("friendly");
      _func_016B(self._id_B0E1, "current");
      _id_07D6::_id_FC3A("enemy", self._id_B0E1);
      _func_015D(self._id_B0E1, "icon_waypoint_kill");
    }
  }

  _id_07D6::_id_D61B("icon_waypoint_escort_emp", "waypoint_capture_kill");
  level._id_A8E8[var_4] _id_07D6::_id_D8E0("none");
  level._id_A8E8[var_5] _id_07D6::_id_D8E0("any");
  _id_07F9::_id_A8C1(level._id_A8E8["allies"]._id_A908, 0);
  _id_07F9::_id_A8C1(level._id_A8E8["axis"]._id_A908, 0);
  var_8 = spawnStruct();
  var_8.player = var_0;
  var_8._id_56B9 = "pickup";
  var_8._id_033E = var_0.origin;
  _id_06E2::_id_4C2A("callback_on_game_event", var_8);
}

_id_AAB9(var_0) {
  setomnvar("ui_bomb_carrier", -1);

  if(level._id_2663) {
    _id_07D6::_id_D639(var_0.team);
    _id_07D6::_id_15DF("none");
  } else {
    foreach(var_2 in level._id_A8E8) {
      var_2 _id_C605(1);
    }

    _id_07D6::_id_15DF("any");
    _id_07D6::_id_D61B("icon_waypoint_emp", "icon_waypoint_emp");
    _id_07D6::_id_D639("neutral");
    _id_07D6::_id_D8E0("any");

    if(isDefined(var_0)) {
      scripts\mp\utility\print::_id_BD1A(&"MP/EXPLOSIVES_DROPPED_BY", _id_07D6::_id_6C02(), var_0);
    }

    _id_0AA2::_id_B8F1(game["bomb_dropped_sound"], _id_07D6::_id_6C02());
    level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 1, 1);

    if(level._id_7CD0 > 0) {
      thread _id_C790();
    }
  }
}

_id_C790() {
  level endon("bomb_pickup");
  var_0 = 0.0;

  while(var_0 < level._id_7CD0) {
    waitframe();

    if(self._id_ADAE == "neutral") {
      var_0 = var_0 + level._id_5F3A;
    }
  }

  foreach(var_2 in level._id_EF89) {
    _id_0AA2::_id_B8F1(game["bomb_dropped_sound"], var_2);
  }

  _id_07D6::_id_C797();
}

_id_ABCB(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = scripts\mp\utility\game::_id_6BE2(var_1)[0];

  if(!_id_07D6::_id_886F(var_0.pers["team"]) && !level._id_2663) {
    level thread _id_51B4(0);
    setomnvar("ui_bomb_timer_endtime_a", int(scripts\mp\gamelogic::_id_6DE8()) + gettime());
    level notify("bomb_planted");
    var_0 notify("bomb_planted");
    var_0 notify("objective", "plant");
    var_0 playSound("mp_bomb_plant");
    scripts\mp\utility\game::_id_D5FA(15, var_0.team, var_0 getentitynumber());
    var_3 = [];
    var_3[var_3.size] = var_0;
    level thread scripts\mp\hud_message::_id_A6B6("emp_planted", "emp_planted_enemy", var_0.team, var_3);
    var_0 thread scripts\mp\hud_message::showsplash("emp_planted", scripts\mp\rank::getscoreinfovalue("plant"));
    level thread scripts\mp\hud_util::_id_EF8D("callout_empplanted", var_0, undefined, undefined, 1);
    level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 4, 3);
    var_0 setclientomnvar("ui_emp_carrier_hud", 0);
    _id_0A8D::_id_9136("empplanted_friendly", var_1);
    var_0 playsoundtoteam("mp_bombplaced_friendly", var_1);
    _id_0A8D::_id_9136("empplanted_enemy", var_2);
    var_0 playsoundtoteam("mp_bombplaced_enemy", var_2);
    var_0 thread _id_0A9F::_id_7003("plant");
    var_0 _id_07BC::_id_AB57();
    var_4 = spawnStruct();
    var_4.player = var_0;
    var_4._id_56B9 = "plant";
    var_4._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_4);
    var_0._id_2666 = gettime();
    var_0 scripts\mp\utility\stats::_id_7DAE("plants", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "plants", var_0.pers["plants"]);
    var_0 scripts\mp\utility\stats::_id_D550(var_0.pers["plants"]);
    var_0 _id_0798::_id_110E();
    level._id_2663 = 1;
    level thread _id_2663(self, var_0.pers["team"]);
    level._id_2661 = var_0;
    level._id_2661._id_8783 = 0;

    if(level.codcasterenabled) {
      var_0 _meth_80CB(0);
    }

    level._id_429C _id_07D6::_id_D537();
    level._id_429C _id_07D6::_id_15DF("none");
    level._id_429C _id_07D6::_id_D8E0("none");
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon("iw8_cyberemp_mp");
    var_0 _id_0A95::_id_EC3C();
    self.useweapon = makeweapon("emp_defuse_mp");
    _id_D872(self, var_0);
  } else {
    var_0 notify("bomb_defused");
    var_0 notify("objective", "defuse");
    var_5 = 0;

    if(scripts\mp\utility\teams::_id_69FB(var_0.team, 1) == 0) {
      var_5 = 1;
    }

    if(var_5) {
      var_6 = "empdefused_final_friendly";
      var_7 = "empdefused_final_enemy";
    } else {
      var_6 = "empdefused_friendly";
      var_7 = "empdefused_enemy";
    }

    _id_0A8D::_id_9136(var_6, var_1);
    _id_0A8D::_id_9136(var_7, var_2);
    var_3 = [];
    var_3[var_3.size] = var_0;
    level thread scripts\mp\hud_message::_id_A6B6("emp_defuse", "emp_defuse_enemy", var_0.team, var_3);
    level thread scripts\mp\hud_util::_id_EF8D("callout_empdefused", var_0, undefined, undefined, 1);
    level thread scripts\mp\hud_message::_id_FCBF(var_0.team, 5, 6, var_0, 2);

    if(isDefined(level._id_2661) && level._id_2661._id_2666 + 3000 + level._id_4644 * 1000 > gettime() && scripts\mp\utility\player::isreallyalive(level._id_2661)) {
      var_0 thread scripts\mp\rank::_id_CC00("ninja_defuse");
      var_0 thread scripts\mp\hud_message::showsplash("ninja_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
    } else {
      var_0 thread scripts\mp\rank::_id_CC00("defuse");
      var_0 thread scripts\mp\hud_message::showsplash("emp_defuse", scripts\mp\rank::getscoreinfovalue("defuse"));
    }

    var_0 thread _id_07B1::_id_6FB9("mode_sd_defuse");
    var_0 scripts\mp\utility\stats::_id_7DAE("defuses", 1);
    var_0 scripts\mp\persistence::_id_E770("round", "defuses", var_0.pers["defuses"]);
    var_0 _id_07BC::_id_AAAC();
    var_4 = spawnStruct();
    var_4.player = var_0;
    var_4._id_56B9 = "defuse";
    var_4._id_033E = var_0.origin;
    _id_06E2::_id_4C2A("callback_on_game_event", var_4);
    level._id_2663 = 0;
    level thread _id_2635(self);
    _id_C605(1, var_0);

    if(var_5) {
      wait 3;
    }

    level._id_429C _id_07D6::_id_15DF("any");
    level._id_429C _id_07D6::_id_D650(var_0, 0, 1);
  }
}

_id_51B4(var_0, var_1) {
  foreach(var_3 in level.players) {
    var_3 _meth_830E(1);

    if(istrue(var_0)) {
      var_3 _meth_827A("artillery_rumble", var_3.origin);
    }
  }

  if(!istrue(var_1)) {
    wait 1;

    foreach(var_3 in level.players) {
      var_3 _meth_830E(0);
    }
  }
}

_id_C605(var_0, var_1, var_2) {
  if(!var_0) {
    _id_07D6::_id_D61B("icon_waypoint_planted_empsite", "icon_waypoint_target_empsite");
    _id_07D6::_id_D8E0("any");
  } else {
    if(istrue(var_2)) {
      return;
    }
    if(isDefined(var_1)) {
      self._id_ADAE = var_1.team;
    }

    self._id_7C8C = "bomb_zone";
    _id_07D6::_id_15DF("none");
    _id_07D6::_id_D8E0("none");
    _id_07F9::_id_A8C1(level._id_A8E8["allies"]._id_A908, 1);
    _id_07F9::_id_A8C1(level._id_A8E8["axis"]._id_A908, 1);
    return;
  }
}

_id_D873() {
  self.trigger _meth_80E0(level._id_429C._id_32D5);
  _id_07D6::_id_15DF("enemy");
  _id_07D6::_id_D8D2(level._id_B1DA);
  _id_07D6::_id_D8D1(&"MP/PLANTING_EXPLOSIVE");
  _id_07D6::_id_D8D0(&"MP/HOLD_TO_PLANT_EMP");
  _id_07D6::_id_D5C5(level._id_429C);
  self.useweapon = makeweapon("emp_bomb_mp");
  _id_07D6::_id_D61B("icon_waypoint_defend_empsite", "icon_waypoint_target_empsite");
  self._id_2663 = 0;
}

_id_D872(var_0, var_1) {
  self.trigger _meth_83A1(-300);
  self._id_ADAE = var_1.team;
  _id_07D6::_id_15DF("enemy");
  _id_07D6::_id_D8D2(level._id_4644);
  _id_07D6::_id_D8D1(&"MP/DEFUSING_EXPLOSIVE");
  _id_07D6::_id_D8D0(&"MP/HOLD_TO_DEFUSE_EMP");
  _id_07D6::_id_D5C5(undefined);
  _id_07D6::_id_D61B("icon_waypoint_defend_empsite_nt", "icon_waypoint_defuse_empsite_nt");
  thread scripts\mp\gametypes\obj_bombzone::_id_2675(var_1.team, "icon_waypoint_planted_empsite", "icon_waypoint_defuse_empsite");
  _id_07D6::_id_D8E0("any", self._id_BF19);
  self._id_7C8C = "defuse_object";
  self._id_2663 = 1;
  var_2 = scripts\mp\utility\teams::_id_6A01(var_1.team);
  var_3 = var_2[0];

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_3, "players")) {
    self.trigger _meth_80E0(var_5);
  }
}

_id_2635(var_0) {
  scripts\mp\gamelogic::resumetimer();
  level._id_F21A = 0;
  level._id_CC0B = 0;
  var_0._id_2663 = 0;
  setomnvar("ui_bomb_owner_team", -1);
  level thread[[level._id_FC75]]();
  var_0._id_10430[0] scripts\mp\gamelogic::_id_E943();
  level notify("bomb_defused");
}

_id_AA80(var_0) {}

_id_2663(var_0, var_1) {
  level endon("overtime");
  scripts\mp\gamelogic::pausetimer();
  setomnvar("ui_match_timer_stopped", 0);
  level._id_2665 = var_1;
  level._id_F21A = 1;
  level._id_CC0B = 1;

  if(isDefined(var_1)) {
    if(var_1 == "allies") {
      setomnvar("ui_bomb_owner_team", 2);
    } else {
      setomnvar("ui_bomb_owner_team", 1);
    }
  }

  setgameendtime(int(gettime() + level._id_2682 * 1000));
  var_0._id_10430[0] thread scripts\mp\gamelogic::_id_B901();
  var_2 = gettime();
  thread _id_261D();
  thread _id_261E(var_0._id_10430[0].origin);
  _id_2683();
  var_0._id_10430[0] scripts\mp\gamelogic::_id_E943();

  if(!level._id_2663) {
    if(level._id_B00D) {
      var_3 = (gettime() - var_2) / 1000;
      level._id_2682 = level._id_2682 - var_3;
    }

    return;
  }

  var_4 = var_0._id_10430[0].origin;
  level._id_265C = 1;
  setDvar("#x38e356d04714e7f2c", "BombExploded");

  if(isDefined(level._id_2661)) {
    var_0._id_10430[0] radiusdamage(var_4, 512, 1, 1, level._id_2661, "MOD_EXPLOSIVE", "bomb_site_mp");
    level._id_2661 scripts\mp\utility\stats::_id_7DAE("destructions", 1);
    level._id_2661 scripts\mp\persistence::_id_E770("round", "destructions", level._id_2661.pers["destructions"]);
  } else
    var_0._id_10430[0] radiusdamage(var_4, 512, 1, 1, undefined, "MOD_EXPLOSIVE", "bomb_site_mp");

  var_5 = randomfloat(360);
  playsoundatpos(var_4, "exp_cyber_emp_close");
  var_6 = var_0._id_10430[0] gettagorigin("tag_origin");
  var_7 = spawnfx(level._effect["emp_detonation"], var_6, (0, 0, 1), (cos(var_5), sin(var_5), 0));
  triggerfx(var_7);
  earthquake(0.6, 1.5, var_4, 10000);
  level thread _id_51B4(1, 1);
  level notify("emp_detonated");

  foreach(var_9 in level._id_A8E8) {
    var_9 notify("disabled");
    var_9.trigger scripts\mp\utility\usability::_id_D46B();
  }

  if(game["switchedsides"]) {
    var_0._id_57CB = 200;
  } else {
    var_0._id_57CB = 201;
  }

  if(isDefined(var_0._id_57CB)) {
    scripts\engine\utility::_id_57BA(var_0._id_57CB);
  }

  var_0._id_2663 = 0;
  level._id_429C _id_07D6::_id_D8E0("none");
  level._id_A8E8["allies"] _id_07D6::_id_D8E0("none");
  level._id_A8E8["axis"] _id_07D6::_id_D8E0("none");
  _id_07F9::_id_A8C1(level._id_A8E8["allies"]._id_A908, 0);
  _id_07F9::_id_A8C1(level._id_A8E8["axis"]._id_A908, 0);
  setgameendtime(0);
  level._id_CC0B = 1;

  if(isDefined(level._id_2661)) {
    level thread scripts\mp\hud_util::_id_EF8D("callout_destroyed_cyberbombsite", level._id_2661);
  }

  var_0 _id_07D6::_id_C300();

  if(istrue(level._id_A737)) {
    return;
  }
  wait 3;
  thread scripts\mp\gamelogic::_id_52F7(var_1, game["end_reason"]["target_destroyed"], undefined, undefined, level._id_48CF);
}

_id_2683() {
  level endon("bomb_defused");
  level endon("overtime_ended");
  var_0 = int(level._id_2682 * 1000 + gettime());
  setomnvar("ui_bomb_timer_endtime", var_0);
  level thread _id_7458(var_0);
  scripts\mp\hostmigration::_id_1084E(level._id_2682);
}

_id_261D() {}

_id_261E(var_0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  wait(max(level._id_2682 - 2, 0.1));
  playsoundatpos(var_0, "exp_cyber_emp_preexplode");
}

_id_7458(var_0) {
  level endon("bomb_defused");
  level endon("overtime_ended");
  level endon("game_ended");
  level endon("disconnect");
  level waittill("host_migration_begin");
  var_1 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_1 > 0) {
    setomnvar("ui_bomb_timer_endtime", var_0 + var_1);
  }
}

_id_AD74(var_0) {
  level endon("game_ended");
  level._id_82D1 = 1;
  wait 5.0;
  level._id_4AE8 = 1;
}

_id_6FAE() {
  self endon("death_or_disconnect");
  level endon("game_ended");
  scripts\mp\utility\player::_id_10968(3);
  level thread scripts\mp\battlechatter_mp::_id_F759(self, "inform_last_one");
  var_0 = scripts\mp\utility\game::_id_6BE2(self.pers["team"])[0];
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastteammemberalive", self, self.pers["team"]);
  level thread scripts\mp\hud_util::_id_EF8D("callout_lastenemyalive", self, var_0);
  level notify("last_alive", self);
}

_id_ABC0() {
  if(level._id_265C) {
    return;
  }
  _id_841C();
  thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["cyber_tie"]);
}

_id_ABA4() {
  self setclientomnvar("ui_securing", 0);
  self setclientomnvar("ui_securing_progress", 0);
  self setclientomnvar("ui_match_status_hint_text", -1);

  if(level._id_A2F7) {
    self setclientomnvar("ui_emp_carrier_hud", 1);
  } else {
    self setclientomnvar("ui_emp_carrier_hud", 0);
    thread _id_FC17();
  }

  self._id_8986 = 0;
  self._id_87F7 = 0;
  self._id_8783 = 0;

  if(scripts\mp\utility\game::_id_82D1() && !isDefined(self._id_ACA0)) {
    thread _id_BD1B();
  }

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::_id_D550(self.pers["plants"]);
  }

  if(isDefined(self.pers["rescues"])) {
    scripts\mp\utility\stats::_id_D551(self.pers["rescues"]);
  }

  thread _id_FCC2();
}

_id_FC17() {
  if(!isDefined(level._id_A8E8)) {
    level waittill("enable_player_usability");
  }

  foreach(var_1 in level._id_A8E8) {
    if(var_1._id_2663 == 0) {
      var_1.trigger disableplayeruse(self);
    }
  }
}

_id_FCC2() {
  if(level._id_2663) {
    if(isDefined(level._id_2665) && level._id_2665 == self.team) {
      self setclientomnvar("ui_match_status_hint_text", 4);
    } else {
      self setclientomnvar("ui_match_status_hint_text", 3);
    }
  } else if(isDefined(level._id_429C) && isDefined(level._id_429C._id_32D5)) {
    if(level._id_429C._id_32D5.team == self.team) {
      if(level._id_429C._id_32D5 == self) {
        self setclientomnvar("ui_match_status_hint_text", 2);
      } else {
        self setclientomnvar("ui_match_status_hint_text", 5);
      }
    } else
      self setclientomnvar("ui_match_status_hint_text", 6);
  } else
    self setclientomnvar("ui_match_status_hint_text", 1);
}

_id_841C() {
  foreach(var_1 in level.players) {
    if(istrue(var_1._id_8986) && isDefined(var_1._id_9020)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_1._id_9020);
      break;
    }
  }
}

_id_AAA3(var_0) {
  _id_841C();

  if(level._id_265C > 0 && !level._id_BA49) {
    return;
  }
  if(var_0 == "all") {
    if(level._id_2663) {
      var_1 = scripts\mp\utility\game::_id_6BE2(level._id_2665)[0];
      thread scripts\mp\gamelogic::_id_52F7(level._id_2665, game["end_reason"][tolower(game[var_1]) + "_eliminated"], undefined, undefined, level._id_48CF);
    } else
      thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["tie"]);
  } else if(level._id_2663) {
    if(var_0 != level._id_2665) {
      thread scripts\mp\gamelogic::_id_52F7(level._id_2665, game["end_reason"][tolower(game[var_0]) + "_eliminated"], undefined, undefined, level._id_48CF);
    } else {
      return;
    }
  } else if(var_0 == game["attackers"])
    level thread scripts\mp\gamelogic::_id_52F7(game["defenders"], game["end_reason"][tolower(game[game["attackers"]]) + "_eliminated"]);
  else if(var_0 == game["defenders"]) {
    level thread scripts\mp\gamelogic::_id_52F7(game["attackers"], game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
  }
}

_id_AB47(var_0) {
  if(level._id_265C > 0) {
    return;
  }
  var_1 = scripts\mp\utility\game::_id_6AF7(var_0);

  if(isDefined(var_1)) {
    var_1._id_9075 = 1;
    var_1 thread _id_6FAE();
  }
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_emp_carrier_hud", 0);
  thread _id_34DE();

  if(!isPlayer(var_1) || var_1.team == self.team) {
    return;
  }
  if(self._id_8783 && level.codcasterenabled) {
    self _meth_80CB(0);
  }

  _id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

_id_34DE() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
    level._id_E3E2[game["attackers"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
    level._id_E3E2[game["defenders"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  }
}

_id_BD1B() {
  self endon("disconnect");
  wait 0.25;
  self._id_ACA0 = 1;
}

_id_1FC6(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = 0;
  var_11 = 0;
  var_12 = 0;
  var_13 = self;
  var_14 = var_13.origin;
  var_15 = var_1.origin;
  var_16 = 0;

  if(isDefined(var_0)) {
    var_15 = var_0.origin;
    var_16 = var_0 == var_1;
  }

  if(isDefined(level._id_429C._id_32D5)) {
    if(isDefined(var_1) && isPlayer(var_1) && var_1.pers["team"] != var_13.pers["team"]) {
      if(isDefined(var_1._id_8783) && var_16 && isDefined(var_4) && var_4.basename == "iw8_cyberemp_mp") {
        var_1 thread scripts\mp\rank::_id_CC00("emp_carrier_kill");
        var_1 thread _id_07B1::_id_6FB9("mode_cyber_kill_with_emp");
      } else if(istrue(var_13._id_8783)) {
        var_13._id_8783 = 0;

        if(istrue(var_13._id_DC9C)) {
          var_13 scripts\mp\utility\player::_id_7908();
        }

        var_1 thread scripts\mp\rank::_id_CC00("killed_emp_carrier");
        var_1 thread _id_07B1::_id_6FB9("mode_cyber_kill_carrier");
      }

      if(var_1.pers["team"] == level._id_429C._id_ADAE && var_1 != level._id_429C._id_32D5) {
        var_17 = distancesquared(level._id_429C._id_32D5.origin, var_15);

        if(var_17 < 105625) {
          var_1 thread scripts\mp\rank::_id_CC00("defend");
          var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
          var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
          var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
        }
      }
    }
  }

  foreach(var_19 in level._id_A8E8) {
    if(istrue(var_19.trigger._id_F5E0)) {
      continue;
    }
    var_20 = var_19 _id_07D6::_id_6C02();

    if(var_20 != var_1.team) {
      var_21 = _id_4BBA(var_19.trigger, var_15, var_14);

      if(var_21) {
        var_11 = 1;
        var_1 thread scripts\mp\rank::_id_CC00("assault");
        var_1 thread _id_07B1::_id_6FB9("mode_x_assault");
        var_19 notify("assault", var_1);
        continue;
      }
    } else {
      var_22 = _id_4BBA(var_19.trigger, var_15, var_14);

      if(var_22) {
        var_12 = 1;
        var_1 thread scripts\mp\rank::_id_CC00("defend");
        var_1 thread _id_07B1::_id_6FB9("mode_x_defend");
        var_19 notify("defend", var_1);
        var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
        var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
        continue;
      }
    }
  }
}

_id_4BBA(var_0, var_1, var_2) {
  var_3 = distancesquared(var_0.origin, var_1);
  var_4 = distancesquared(var_0.origin, var_2);

  if(var_3 < 105625 || var_4 < 105625) {
    if(!isDefined(var_0._id_9FF8)) {
      return 1;
    } else if(var_1[2] - var_0.origin[2] < 100 || var_2[2] - var_0.origin[2] < 100) {
      return 1;
    } else {
      return 0;
    }
  } else
    return 0;
}

_id_51BB() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  self._id_BF14 = gettime();
  self._id_A4CA = self._id_BF14;
  thread _id_10DDE();

  for(;;) {
    if(self._id_0132.basename == "iw8_cyberemp_mp") {
      while(self._id_0132.basename == "iw8_cyberemp_mp" && gettime() > self._id_A4CA) {
        _func_0253(self);
        self._id_BF14 = gettime();
        self._id_A4CA = gettime() + level._id_BF14 * 1000;
        thread _id_107E0();
        self waittill("radar_check");
      }
    }

    waitframe();
  }
}

_id_10DDE() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self._id_DC9C = 0;

  for(;;) {
    if(self._id_0132.basename == "iw8_cyberemp_mp") {
      if(!istrue(self._id_DC9C)) {
        scripts\mp\utility\player::_id_DCC4();
        self._id_DC9C = 1;
      }
    } else if(istrue(self._id_DC9C)) {
      scripts\mp\utility\player::_id_7908();
      self._id_DC9C = 0;
    }

    waitframe();
  }
}

_id_107E0() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("bomb_planted");
  self endon("last_stand_start");
  var_0 = gettime() + level._id_BF14 * 1000;

  while(gettime() < var_0) {
    if(self == level._id_429C._id_32D5 && self._id_0132.basename == "iw8_cyberemp_mp") {
      waitframe();
      continue;
    }

    break;
  }

  self notify("radar_check");
}

_id_19C6() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self.pers["gamemodeLoadout"] = level._id_429A[self.team];
  _id_0A18::_id_E346(self.origin, self.angles);
  self._id_60C7 = self.class;
  self.pers["class"] = "gamemode";
  self.pers["lastClass"] = "gamemode";
  self.class = "gamemode";
  self._id_8FAF = "gamemode";
  self notify("faux_spawn");
  self._id_60D9 = 1;
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
}

_id_C47B() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  self notify("lost_juggernaut");
  waitframe();
  self.pers["gamemodeLoadout"] = undefined;
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
}

_id_D4B6() {
  if(isDefined(level._id_DCA0)) {
    switch (level._id_DCA0) {
      case 0:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 0.0;
        break;
      case 1:
        level._id_429C._id_A90C = 0;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 0.05;
        break;
      case 2:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 1.0;
        break;
      case 3:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 1.5;
        break;
      case 4:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 2.0;
        break;
      case 5:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 3.0;
        break;
      case 6:
        level._id_429C._id_A90C = 1;
        level._id_429C._id_A90B = 0;
        level._id_429C._id_A912 = 4.0;
        break;
    }
  } else {
    level._id_429C._id_A90C = 1;
    level._id_429C._id_A90B = 0;
    level._id_429C._id_A912 = 3.0;
  }
}

_id_AAD9() {
  level._id_429C _id_07D6::_id_C300();

  if(isDefined(level._id_429C._id_32D5)) {
    foreach(var_1 in level._id_A8E8) {
      if(var_1._id_2663 == 0) {
        var_1.trigger disableplayeruse(level._id_429C._id_32D5);
      }
    }
  }

  level._id_429C.trigger delete();
  level._id_429C._id_10430[0] delete();
}

_id_51B6() {
  level endon("game_ended");
  level waittill("emp_detonated");

  for(;;) {
    foreach(var_1 in level._id_51B5) {
      var_1._id_EC36 = "off";
      _id_743E(var_1);
    }

    wait 0.1;

    foreach(var_1 in level._id_51B5) {
      var_1._id_EC36 = "on";
      _id_743E(var_1);
    }

    wait 0.15;

    foreach(var_1 in level._id_51B5) {
      var_1._id_EC36 = "off";
      _id_743E(var_1);
    }

    wait 0.1;

    foreach(var_1 in level._id_51B5) {
      var_1._id_EC36 = "on";
      _id_743E(var_1, 0.05);
    }

    wait 0.5;

    foreach(var_1 in level._id_51B5) {
      var_1._id_EC36 = "off";
      _id_743E(var_1);
    }

    wait 10;
  }
}

_id_4865() {
  level endon("game_ended");
  level waittill("emp_detonated");
  var_0 = getEntArray("destructibleTVs", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_3 = getscriptablearray(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      var_5 setscriptablepartstate("tv", "dead");
      waitframe();
    }
  }
}

_id_743E(var_0, var_1) {
  var_2 = 0.2;

  if(isDefined(var_1)) {
    var_2 = var_1;
  }

  if(var_0._id_EC36 == "on") {
    self notify("masterSwitch_on");

    if(!var_0._id_94AE) {
      foreach(var_4 in var_0._id_949B) {
        var_4 thread _id_07F5::_id_9496(randomfloat(var_2));
      }

      thread _id_07F5::_id_AB46(var_0._id_9FDF, "on");
      var_0._id_94AE = 1;
    }
  } else if(var_0._id_EC36 == "off") {
    if(var_0._id_94AE) {
      level _id_07F5::_id_9495(var_0._id_949B);
      thread _id_07F5::_id_AB46(var_0._id_9FDF, "off");
      var_0._id_94AE = 0;
    }

    if(isDefined(self._id_CE18) && self._id_CE18 == "motion") {
      var_0._id_EC36 = "motion";
    }

    self notify("lights_off");
  }
}

_id_D8C5() {
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_emp", 2, "neutral", "MP_INGAME_ONLY/OBJ_EMP_CAPS", "hud_icon_cyber_bomb", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_escort_emp", 1, "friendly", "MP_INGAME_ONLY/OBJ_ESCORT_CAPS", "hud_icon_cyber_bomb", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_defend_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_target_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_ATTACK_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_planted_empsite", 0, "friendly", "MP_INGAME_ONLY/OBJ_DEFEND_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_defuse_empsite", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSE_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_emp_planting", 0, "enemy", "MP_INGAME_ONLY/OBJ_PLANTING_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_emp_defusing", 0, "enemy", "MP_INGAME_ONLY/OBJ_DEFUSING_CAPS", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_defend_empsite_nt", 0, "friendly", "", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("icon_waypoint_defuse_empsite_nt", 0, "enemy", "", "icon_waypoint_cyber_bombsite", 0);
  scripts\mp\gamelogic::_id_D8E5("mlg_icon_waypoint_emp_planted", 0, "neutral", "", "icon_minimap_objective_codcaster_bomb", 0);
}