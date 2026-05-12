/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 1267.gsc
*********************************************/

func_533A() {
  level thread func_791E();
  level thread func_533D();
  level thread func_5342();
}

func_791E() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread func_7920();
    var_00 thread func_791F();
    var_00 method_8628(0);
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_default", 0, 1);
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_init_mix", 0, 1);
    var_00 method_862A("mp_war_default");
  }
}

func_791F() {
  self endon("disconnect");
  var_00 = self;
  for(;;) {
    self waittill("spawned_player");
    var_00 method_8627("mp_pre_event_mix", 0);
    var_00 maps\mp\_audio_submixes::func_8A9F("mp_init_mix", 0);
    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_vehicle_turret", 0);
    waittillframeend;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_default", 0.1, 1);
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_init_mix", 0.1, 1);
    var_00 method_862A("mp_war_default");
  }
}

func_7920() {
  var_00 = self;
  var_00 waittill("spawned_player");
  if(maps\mp\_utility::func_3FA0("prematch_waitforplayers_done") == 0) {
    maps\mp\_utility::func_3FA5("prematch_waitforplayers_done");
  }

  var_01 = self.var_1A7;
  if(game["switchedsides"] == 1) {
    var_01 = maps\mp\_utility::func_45DE(var_01);
  }

  var_02 = isDefined(var_01) == 1 && var_01 == "allies" || var_01 == "axis";
  if(isDefined(level.var_771) == 1) {
    return;
  }

  if(isDefined(var_01) == 1 && var_02 == 1) {
    var_03 = 0;
    if(isDefined(level.var_54D0) && isDefined(level.var_54D0[var_01].var_9309) == 1) {
      var_04 = level.var_54D0[var_01].var_9309;
      var_05 = gettime();
      var_06 = var_05 - var_04;
      if(var_06 < 10000) {
        func_79CD(game["music"]["war_intro_" + var_01], var_00);
        var_03 = 1;
      }
    }

    if(var_03 == 0) {
      func_79CD(game["music"]["war_spawn_" + var_01], var_00);
    }
  }
}

func_A785() {
  while(!isDefined(game["music"]) || !isDefined(game["music"]["suspense"])) {
    wait 0.05;
  }

  if(game["switchedsides"]) {
    wait 0.05;
  }
}

func_533D() {
  func_A785();
  game["music"]["spawn_allies"] = "mp_war_null_music";
  game["music"]["spawn_axis"] = "mp_war_null_music";
  game["music"]["halftime"] = "mp_war_null_music";
  game["music"]["draw"] = "mp_war_null_music";
  game["music"]["winning_allies"] = "mp_war_null_music";
  game["music"]["winning_axis"] = "mp_war_null_music";
  game["music"]["losing_allies"] = "mp_war_null_music";
  game["music"]["losing_axis"] = "mp_war_null_music";
  game["music"]["victory_allies"] = "mp_war_null_music";
  game["music"]["victory_axis"] = "mp_war_null_music";
  game["music"]["defeat_allies"] = "mp_war_null_music";
  game["music"]["defeat_axis"] = "mp_war_null_music";
  game["music"]["halftime_allies"] = "mp_war_null_music";
  game["music"]["halftime_axis"] = "mp_war_null_music";
  game["music"]["war_intro_allies"] = "mp_war_intro_allies_01";
  game["music"]["war_intro_axis"] = "mp_war_intro_axis_01";
  game["music"]["war_spawn_allies"] = "mp_war_spawn_allies";
  game["music"]["war_spawn_axis"] = "mp_war_spawn_axis";
  game["music"]["war_victory_allies"] = "mp_war_victory_allies";
  game["music"]["war_victory_axis"] = "mp_war_victory_axis";
  game["music"]["war_defeat_allies"] = "mp_war_defeat_allies";
  game["music"]["war_defeat_axis"] = "mp_war_defeat_axis";
  game["music"]["objective_gained"] = "mp_war_objective_allies";
  game["music"]["objective_lost"] = "mp_war_objective_axis";
  game["music"]["stinger_pos"] = "mp_war_stinger_pos";
  game["music"]["stinger_neg"] = "mp_war_stinger_neg";
  game["music"]["objective_bomb_planted"] = "mp_war_stinger_pos";
  game["music"]["objective_bomb_defused"] = "mp_war_stinger_neg";
  game["music"]["vehicle_checkpoint_pos"] = "mp_war_stinger_pos";
  game["music"]["vehicle_checkpoint_neg"] = "mp_war_stinger_neg";
  game["music"]["flag_pickedup_pos"] = "mp_war_stinger_pos";
  game["music"]["flag_pickedup_neg"] = "mp_war_stinger_neg";
  game["music"]["flag_dropped_pos"] = "mp_war_stinger_pos";
  game["music"]["flag_dropped_neg"] = "mp_war_stinger_neg";
  game["music"]["flag_returned_pos"] = "mp_war_stinger_pos";
  game["music"]["flag_returned_neg"] = "mp_war_stinger_neg";
  game["music"]["boundary_warning"] = "mp_war_stinger_neg";
  if(isDefined(game["music"]["countdown"]) == 0) {
    game["music"]["countdown"] = "mp_war_countdown";
    game["music"]["countdown_offset"] = -470;
  }

  game["music"]["overtime_suspense_lp"] = "mp_war_overtime_suspense_lp";
  game["music"]["overtime_hit"] = "mp_war_overtime_hit";
  game["music"]["overtime_end_defeat"] = "mp_war_overtime_end_defeat";
  game["music"]["overtime_end_victory"] = "mp_war_overtime_end_victory";
  level thread func_79A7();
  level thread func_79AA();
  level thread func_79A8();
}

raidmusicsetcountdown(param_00, param_01) {
  var_02 = [];
  var_02["default"] = -470;
  var_02["action_02"] = 1550;
  var_02["action_04"] = 0;
  var_02["action_05"] = 900;
  var_02["epic"] = 250;
  var_02["urban_02a"] = 1900;
  var_02["urban_02b"] = 600;
  var_02["winter_01"] = -50;
  var_02["winter_02"] = -2090;
  var_03 = undefined;
  func_A785();
  if(isDefined(param_00) == 0) {
    var_03 = "mp_war_countdown";
    param_01 = -470;
  } else if(function_02A2(param_00) == 1) {
    if(param_00 < var_02.size) {
      var_04 = 0;
      foreach(var_06, param_01 in var_02) {
        if(var_04 == param_00) {
          var_03 = "mp_war_countdown_" + var_06;
          break;
        }

        var_04++;
      }
    } else {}
  } else if(common_scripts\utility::func_9467("mp_war_countdown", param_00) == 0 && function_0344("mp_war_countdown_" + param_00) == 1) {
    var_03 = "mp_war_countdown_" + param_00;
  } else if(param_00 == "") {
    game["music"]["countdown"] = undefined;
    game["music"]["countdown_offset"] = undefined;
    return;
  } else {
    var_03 = param_00;
  }

  if(isDefined(param_01) == 0) {
    param_01 = 0;
    if(isDefined(var_02[param_00]) == 1) {
      param_01 = var_02[param_00];
    }
  }

  if(param_01 != 0 && param_01 < 10 && param_01 > -10) {
    param_01 = int(param_01 * 1000);
  }

  if(isDefined(var_03) == 1 && function_0344(var_03) == 1) {
    game["music"]["countdown"] = var_03;
    game["music"]["countdown_offset"] = param_01;
  }
}

raidmusiconteam(param_00, param_01, param_02) {
  if(param_00 != "allies" && param_00 != "axis" && param_00 != "attackers" && param_00 != "defenders") {
    return;
  }

  if(isDefined(param_00) == 0 || isDefined(param_01) == 0) {
    return;
  }

  var_03 = undefined;
  var_04 = undefined;
  var_05 = undefined;
  var_06 = isDefined(game["switchedsides"]) == 1 && game["switchedsides"] == 1;
  if(var_06 == 1) {
    if(param_00 == "attackers" || param_00 == "defenders") {
      param_00 = game[param_00];
      var_03 = maps\mp\_utility::func_45DE(param_00);
    } else {
      var_03 = param_00;
      param_00 = maps\mp\_utility::func_45DE(var_03);
    }

    var_04 = game["music"][param_01];
    var_05 = game["music"][param_02];
  } else {
    if(param_00 == "attackers" || param_00 == "defenders") {
      param_00 = game[param_00];
    }

    var_03 = maps\mp\_utility::func_45DE(param_00);
    var_04 = game["music"][param_01];
    var_05 = game["music"][param_02];
  }

  if(isDefined(var_04)) {
    func_79CE(var_04, param_00);
  }

  if(isDefined(var_03) && isDefined(var_05)) {
    func_79CE(var_05, var_03);
  }
}

raidmusicobjectivecomplete() {
  var_00 = maps\mp\gametypes\_gamelogic::func_46E5();
  var_01 = isDefined(level.var_774);
  if(var_00 > 0 && var_01 == 0) {
    if(isDefined(level.var_771) && isDefined(level._warcountdownmusictime)) {
      var_02 = 0.333;
      func_79D0(level.var_771, var_02);
      level.var_771 = undefined;
      level._warcountdownmusictime = undefined;
    }

    var_03 = level.var_744A;
    raidmusiconteam("attackers", "objective_gained", "objective_lost");
    foreach(var_05 in var_03) {
      var_05 maps\mp\_audio_submixes::func_8A9D("mp_war_objective", 0.2);
    }

    maps\mp\gametypes\_hostmigration::func_A6F5(4);
    foreach(var_05 in var_03) {
      var_05 maps\mp\_audio_submixes::func_8A9F("mp_war_objective", 4);
    }
  }
}

raidmusiccountdownrestart() {
  var_00 = maps\mp\gametypes\_gamelogic::func_46E5();
  if(isDefined(game["music"]["countdown"])) {
    var_01 = 0;
    var_02 = game["music"]["countdown"];
    if(isDefined(game["music"]["countdown_offset"])) {
      var_01 = int(game["music"]["countdown_offset"]);
    }

    if(var_00 >= -5536 + var_01) {
      if(isDefined(level.var_771) && isDefined(level._warcountdownmusictime)) {
        var_03 = 0.333;
        func_79D0(level.var_771, var_03);
        level.var_771 = undefined;
        level._warcountdownmusictime = undefined;
        return;
      }

      return;
    }

    if(isDefined(level.var_771) && isDefined(level._warcountdownmusictime)) {
      var_03 = 0.333;
      func_79D0(level.var_771, var_03);
      level.var_771 = undefined;
      level._warcountdownmusictime = -1;
    }

    wait(7);
    var_00 = maps\mp\gametypes\_gamelogic::func_46E5();
    level.var_771 = func_79CE(var_02);
    level._warcountdownmusictime = var_00;
  }
}

func_79A7() {
  level endon("game_ended");
  for(;;) {
    var_00 = maps\mp\gametypes\_gamelogic::func_46E5();
    if(isDefined(game["music"]["countdown"])) {
      var_01 = 0;
      var_02 = game["music"]["countdown"];
      if(isDefined(game["music"]["countdown_offset"])) {
        var_01 = int(game["music"]["countdown_offset"]);
      }

      if(var_00 < -5536 + var_01 && var_00 > -6536 + var_01 && !isDefined(level._warcountdownmusictime)) {
        level._warcountdownmusictime = var_00;
        level.var_771 = func_79CE(var_02);
      }
    }

    if(var_00 <= 0 && isDefined(level._warcountdownmusictime)) {
      var_03 = 0.333;
      func_79D0(level.var_771, var_03);
      level.var_771 = undefined;
      level._warcountdownmusictime = undefined;
    }

    wait 0.05;
  }
}

func_79AB() {
  level endon("stop_overtime");
  var_00 = 10;
  var_01 = 0;
  var_02 = lib_04FF::func_4645();
  for(;;) {
    var_03 = lib_04FF::func_4645();
    var_04 = game["music"]["overtime_hit"];
    if(var_03 > var_02) {
      if(var_01 >= var_00) {
        func_79CE(var_04);
      }

      var_01 = 0;
    } else if(var_03 == var_02) {
      var_01 = var_01 + 1;
    }

    var_02 = var_03;
    wait 0.05;
  }
}

raidmusicovertimeplayer() {
  var_00 = game["music"]["overtime_suspense_lp"];
  var_01 = game["music"]["overtime_end_victory"];
  var_02 = game["music"]["overtime_end_defeat"];
  var_03 = 0.333;
  var_04 = 0.333;
  while(isDefined(level.var_774) == 1) {
    foreach(var_06 in level.var_744A) {
      var_07 = isDefined(var_06.var_776);
      var_06 maps\mp\_audio_submixes::func_8A9D("mp_war_overtime", 3);
      if(var_07 == 0) {
        var_06.var_776 = func_79CD([var_00, var_03], var_06);
      }
    }

    wait 0.05;
  }

  foreach(var_06 in level.var_744A) {
    var_07 = isDefined(var_06.var_776);
    if(var_07 == 1) {
      func_79D0(var_06.var_776, var_04);
      var_06.var_776 = undefined;
    }
  }

  maps\mp\gametypes\_hostmigration::func_A6F5(4.5);
  foreach(var_06 in level.var_744A) {
    var_06 maps\mp\_audio_submixes::func_8A9F("mp_war_overtime", 5);
  }
}

func_79AA() {
  for(;;) {
    level waittill("start_overtime");
    level.var_774 = 1;
    level thread raidmusicovertimeplayer();
    level thread func_79AB();
    level waittill("stop_overtime");
    waittillframeend;
    level.var_774 = undefined;
    var_00 = "defenders";
    var_01 = maps\mp\gametypes\_gamelogic::func_46E5() > 0;
    var_02 = level.var_79AE.var_8DB.size > 0;
    if(var_01 == 1 || var_02 == 0) {
      var_00 = "attackers";
    }

    raidmusiconteam(var_00, "overtime_end_victory", "overtime_end_defeat");
  }
}

func_79A8() {
  level waittill("game_ended");
  var_00 = isDefined(level.var_774);
  var_01 = maps\mp\gametypes\_gamelogic::func_46E5() <= 0;
  var_02 = 5;
  if(var_01 == 1 && var_00 == 0) {
    var_02 = 3;
  }

  maps\mp\_audio_submixes::func_8ABB(undefined, "mp_war_ending", var_02);
  maps\mp\gametypes\_hostmigration::func_A6F5(var_02);
  var_03 = lib_0502::func_797A();
  var_04 = undefined;
  var_05 = undefined;
  if(var_03 == "allies") {
    var_04 = "war_victory_allies";
    var_05 = "war_defeat_axis";
  } else if(var_03 == "axis") {
    var_04 = "war_victory_axis";
    var_05 = "war_defeat_allies";
  }

  if(isDefined(var_03) == 1 && isDefined(var_04) == 1) {
    level thread raidmusiconteam(var_03, var_04, var_05);
  }

  level waittill("game_end_vignette");
  maps\mp\_audio_submixes::func_8ABD(undefined, "mp_war_ending", 20);
}

func_5342() {
  level.var_777["plane_stuka"] = 130;
  level.var_777["tank_sherman"] = 8;
  level.var_777["tank_tiger"] = 8;
  level.var_777["truck_cckw"] = 6.666;
  level.var_777["truck_opel_blitz"] = 6.666;
  level._warvehicledopplerscale["plane_stuka"] = 16;
  level._warvehicledopplerscale["tank_sherman"] = 16 * level.var_777["tank_sherman"];
  level._warvehicledopplerscale["tank_tiger"] = 16 * level.var_777["tank_tiger"];
  level._warvehicledopplerscale["truck_cckw"] = 12 * level.var_777["truck_cckw"];
  level._warvehicledopplerscale["truck_opel_blitz"] = 12 * level.var_777["truck_opel_blitz"];
}

func_79F2(param_00) {
  var_01 = undefined;
  if(common_scripts\utility::func_9462(param_00.var_106, "bomber_stuka") >= 0) {
    var_01 = "plane_stuka";
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_sherman") >= 0) {
    var_01 = "tank_sherman";
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_king_tiger") > 0 || common_scripts\utility::func_9462(param_00.var_106, "tank_tiger") > 0) {
    var_01 = "tank_tiger";
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_cckw") >= 0) {
    var_01 = "truck_cckw";
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_opel_blitz") >= 0) {
    var_01 = "truck_opel_blitz";
  } else {}

  return var_01;
}

func_79F1(param_00) {
  var_01 = 8;
  if(common_scripts\utility::func_9462(param_00.var_106, "bomber_stuka") >= 0) {
    var_01 = level.var_777["plane_stuka"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_sherman") >= 0) {
    var_01 = level.var_777["tank_sherman"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_king_tiger") > 0 || common_scripts\utility::func_9462(param_00.var_106, "tank_tiger") > 0) {
    var_01 = level.var_777["tank_tiger"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_cckw") >= 0) {
    var_01 = level.var_777["truck_cckw"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_opel_blitz") >= 0) {
    var_01 = level.var_777["truck_opel_blitz"];
  } else {}

  return var_01;
}

raidvehiclegetdopplerscale(param_00) {
  var_01 = undefined;
  if(common_scripts\utility::func_9462(param_00.var_106, "bomber_stuka") >= 0) {
    var_01 = level._warvehicledopplerscale["plane_stuka"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_sherman") >= 0) {
    var_01 = level._warvehicledopplerscale["tank_sherman"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "tank_king_tiger") > 0 || common_scripts\utility::func_9462(param_00.var_106, "tank_tiger") > 0) {
    var_01 = level._warvehicledopplerscale["tank_tiger"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_cckw") >= 0) {
    var_01 = level._warvehicledopplerscale["truck_cckw"];
  } else if(common_scripts\utility::func_9462(param_00.var_106, "trans_opel_blitz") >= 0) {
    var_01 = level._warvehicledopplerscale["truck_opel_blitz"];
  } else {}

  return var_01;
}

func_79F6(param_00) {
  var_01 = param_00 getentitynumber();
  var_02 = func_79F2(param_00);
  var_03 = func_79F1(param_00);
  var_04 = raidvehiclegetdopplerscale(param_00);
  self method_85A7("WarModeStartVehicle", var_01, var_02, var_03, var_04);
}

func_79F7(param_00, param_01) {
  var_02 = param_00 getentitynumber();
  self method_85A7("WarModeStopVehicle", var_02, param_01);
}

snd_fullscalesubmix(param_00, param_01) {
  var_02 = int(param_01);
  foreach(var_04 in level.var_744A) {
    if(var_02 == 0) {
      var_04 maps\mp\_audio_submixes::func_8A9F("mp_war_full_scale", 0);
      continue;
    }

    var_04 maps\mp\_audio_submixes::func_8A9D("mp_war_full_scale", 0, 1);
  }

  return param_01;
}

snd_setcountdown(param_00, param_01) {
  var_02 = strtok(param_01, " ");
  var_03 = var_02[0];
  var_04 = var_02[1];
  raidmusicsetcountdown(var_03, var_04);
  var_05 = game["music"]["countdown"];
  var_06 = game["music"]["countdown_offset"];
  var_07 = "countdown alias: " + var_05 + " offset: " + var_06;
  iprintln(var_07);
  iprintlnbold(var_07);
  return param_01;
}

func_79CB(param_00, param_01) {
  return lib_02F0::func_8012("sndentity", param_00, param_01);
}

func_79CC(param_00, param_01) {
  var_02 = undefined;
  var_03 = undefined;
  var_04 = (0, 0, 0);
  if(isarray(param_00)) {
    var_02 = param_00[1];
    param_00 = param_00[0];
  }

  if(isarray(param_01)) {
    if(isDefined(param_01[1]) && function_0296(param_01[1])) {
      var_04 = param_01[1];
    } else if(isDefined(param_01[1]) && isstring(param_01[1])) {
      var_03 = param_01[1];
    }

    param_01 = param_01[0];
  }

  if(!function_0344(param_00)) {
    return;
  }

  if(!isDefined(param_01)) {
    return;
  }

  var_05 = (0, 0, 0);
  if(isDefined(var_03)) {
    var_06 = param_01 method_8445(var_03);
    if(var_06 >= 0) {} else {
      var_03 = undefined;
    }
  }

  return lib_02F0::func_8013("sndentity", param_00, param_01, var_03, var_04, var_02);
}

func_79CF(param_00, param_01, param_02) {
  return func_79CC(param_00, [param_01, param_02]);
}

func_79CD(param_00, param_01) {
  var_02 = undefined;
  if(isarray(param_00)) {
    var_02 = param_00[1];
    param_00 = param_00[0];
  }

  return lib_02F0::func_8013("clientsnd", param_00, param_01, undefined, undefined, var_02, [param_01]);
}

func_79CE(param_00, param_01, param_02) {
  var_03 = [];
  if(level.var_910F) {
    if(isDefined(level.var_744A[0])) {
      var_03[var_03.size] = func_79CD(param_00, level.var_744A[0]);
    }
  } else if(isDefined(param_01)) {
    if(isDefined(param_02)) {
      for(var_04 = 0; var_04 < level.var_744A.size; var_04++) {
        var_05 = level.var_744A[var_04];
        if(var_05 issplitscreenplayer() && !var_05 method_82ED()) {
          continue;
        }

        if(isDefined(var_05.var_12C["team"]) && var_05.var_12C["team"] == param_01 && !maps\mp\_utility::func_56E0(var_05, param_02)) {
          var_03[var_03.size] = func_79CD(param_00, var_05);
        }
      }
    } else {
      for(var_04 = 0; var_04 < level.var_744A.size; var_04++) {
        var_05 = level.var_744A[var_04];
        if(var_05 issplitscreenplayer() && !var_05 method_82ED()) {
          continue;
        }

        if(isDefined(var_05.var_12C["team"]) && var_05.var_12C["team"] == param_01) {
          var_03[var_03.size] = func_79CD(param_00, var_05);
        }
      }
    }
  } else if(isDefined(var_04)) {
    for(var_04 = 0; var_04 < level.var_744A.size; var_04++) {
      var_05 = level.var_744A[var_04];
      if(var_05 issplitscreenplayer() && !var_05 method_82ED()) {
        continue;
      }

      if(!maps\mp\_utility::func_56E0(var_05, param_02)) {
        var_03[var_03.size] = func_79CD(param_00, var_05);
      }
    }
  } else {
    for(var_04 = 0; var_04 < level.var_744A.size; var_04++) {
      var_05 = level.var_744A[var_04];
      if(var_05 issplitscreenplayer() && !var_05 method_82ED()) {
        continue;
      }

      var_03[var_03.size] = func_79CD(param_00, var_05);
    }
  }

  if(var_03.size == 0) {
    return undefined;
  }

  return var_03;
}

func_79D0(param_00, param_01) {
  lib_02F0::func_800E(param_00, param_01);
}